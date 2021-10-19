# from django.shortadd_quizuts import render
import os
import csv
from django.http import HttpResponse, JsonResponse, HttpResponseRedirect
from django.contrib.auth import login, logout, authenticate
from django.shortcuts import render, get_object_or_404, redirect
from django.template import Context, Template, loader
from django.http import Http404
from django.db.models import Max, Q, F
from django.db import models
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import Group
from django.contrib.contenttypes.models import ContentType
from django.forms.models import inlineformset_factory
from django.forms import fields
from django.utils import timezone
from django.core.exceptions import (
	MultipleObjectsReturned, ObjectDoesNotExist
)
from django.core.paginator import Paginator
from .forms import (QuestionForm,FileForm,QuestionFilterForm,
QuestionPaperForm,
UploadFileForm,QuizForm)
from django.contrib import messages
# Create your views here.

from .models import FileUpload,Question,QuestionSet,Quiz
from django.conf import settings

from django.shortcuts import reverse

from customadmin.models import Courses
import collections
from textwrap import dedent
from django.forms.models import model_to_dict

URL_ROOT = ''

def my_render_to_response(request, template, context=None, **kwargs):
	"""Overridden render_to_response.
	"""
	if context is None:
		context = {'URL_ROOT': settings.BASE_DIR}
	else:
		context['URL_ROOT'] = settings.BASE_DIR
	return render(request, template, context, **kwargs)


def my_redirect(url):
	"""An overridden redirect to deal with URL_ROOT-ing. See settings.py
	for details."""
	return redirect(URL_ROOT + url)


from django.conf import settings

def add_quiz(request,course_id=None,topic_id=None,quiz_id=None):
	"""To add a new quiz in the database.
	Create a new quiz and store it."""
	user = request.user
	nextval=request.GET.get('next',None)
	initial ={}
	if topic_id is not None:
		initial['topicid']=topic_id

	#print('quiz id',quiz_id)
	context = {}
	if quiz_id:
		quiz = get_object_or_404(Quiz, pk=quiz_id)
		context['desc'] = 'Edit Quiz'
		#if quiz.creator != user and not course_id:
			#raise Http404('This quiz does not belong to you')
	else:
		quiz = None
		context['desc'] = 'Add Quiz'
	
	if request.method == "POST":
		nextval = request.POST.get('next',False)
		form = QuizForm(request.POST, instance=quiz,initial=initial)
		if form.is_valid():
			if quiz is None:
				form.instance.creator = user
				
			else:
				pass
			added_quiz = form.save()
				#added_quiz = form.save()
				#order = module.get_unit_order("quiz", quiz)
			from customadmin.models import Activities
			ac,created=Activities.objects.get_or_create(activity_type='quiz',activity_name=added_quiz.description,
					author_id=request.user.id,topic_id=added_quiz.topic_id,content_id=added_quiz.id)

			messages.success(request, "Quiz saved successfully")
			return HttpResponseRedirect(reverse_lazy('assesment:all_quiz'))

			if nextval:
				# return HttpResponseRedirect(settings.EXTRA_URL+nextval.replace("$",'#'))
				return HttpResponseRedirect(reverse_lazy('assesment:all_quiz'))
			return redirect(reverse("assesment:add_quiz"))
	else:
		form = QuizForm(instance=quiz,initial=initial)
	context["form"] = form
	if nextval is not None:
		context['next'] = nextval

	return my_render_to_response(request, 'assesment/add_quiz.html', context)


from .forms import QuestionOptionForm
@login_required
def add_question(request, question_id=None):
	user = request.user
	#test_case_type = None

	if question_id is not None:
		question = Question.objects.get(id=question_id)
		uploaded_files = FileUpload.objects.filter(question_id=question.id)
	else:
		question = None
		uploaded_files = []

	if request.method == 'POST':
		qform = QuestionForm(request.POST, instance=question)
		opt=QuestionOptionForm(request.POST)
		fileform = FileForm(request.POST, request.FILES)
		remove_files_id = request.POST.getlist('clear')
		added_files = request.FILES.getlist('file_field')
		extract_files_id = request.POST.getlist('extract')
		hide_files_id = request.POST.getlist('hide')
		if remove_files_id:
			files = FileUpload.objects.filter(id__in=remove_files_id)
			for file in files:
				file.remove()
		if extract_files_id:
			files = FileUpload.objects.filter(id__in=extract_files_id)
			for file in files:
				file.set_extract_status()
		if hide_files_id:
			files = FileUpload.objects.filter(id__in=hide_files_id)
			for file in files:
				file.toggle_hide_status()
		formsets = []
		
		if qform.is_valid():
			question = qform.save(commit=False)
			question.user = user
			question.save()
			# many-to-many field save function used to save the tags
			if added_files:
				for file in added_files:
					FileUpload.objects.get_or_create(
						question=question, file=file
					)
			qform.save_m2m()
			for formset in formsets:
				if formset.is_valid():
					formset.save()
			#test_case_type = request.POST.get('case_type', None)
			uploaded_files = FileUpload.objects.filter(question_id=question.id)
			if opt.is_valid():
				o=opt.save(commit=False)
				o.question=question
				o.save()
			messages.success(request, "Question saved successfully")
		else:
			context = {
				'qform': qform,
				'fileform': fileform,
				'question': question,
				'formsets': formsets,
				'uploaded_files': uploaded_files
			}
			messages.warning(request, "Unable to save the question")
			return render(request, "assesment/addquestion.html", context)

	qform = QuestionForm(instance=question)
	option_form=QuestionOptionForm()
	fileform = FileForm()
	formsets = []
	
	context = {'qform': qform,'form1':option_form, 'fileform': fileform, 'question': question,
			   'formsets': formsets, 'uploaded_files': uploaded_files}
	#if question is not None:
		#context["testcase_options"] = question.get_test_case_options()
	return render(request, "assesment/addquestion.html", context)

from .models import Assesments,QuestionPaper
def test_mode(user, godmode=False, questions_list=None, assesment_id=None,
			  course_id=None):

	trial_course=None
	module=None
	if questions_list is not None:
		trial_course = Courses.objects.create_trial_course(user)
		print('trial_quiz',trial_course.id)
		trial_assesment = Assesments.objects.create_trial_quiz(user)
		print('assesment created' ,trial_assesment.id)
		trial_questionpaper = QuestionPaper.objects. \
			create_trial_paper_to_test_questions(
				trial_assesment, questions_list
			)
		print('trial_questionpaper',trial_questionpaper.id)

	else:
		trial_quiz, trial_course, module = Assesments.objects.create_trial_from_quiz(
			quiz_id, user, godmode, 11
		)

		print(trial_quiz)
		trial_questionpaper = QuestionPaper.objects. \
			create_trial_paper_to_test_quiz(
				trial_quiz, quiz_id
			)
	return trial_questionpaper, trial_course, module


@login_required
def test_question(request, question_id):
	user = request.user
	print(question_id)


	trial_paper, trial_course, trial_module = test_mode(
					user, False, [question_id], None)
	trial_paper.update_total_marks()
	trial_paper.save()

	#print("dddddddddddddddddddddddddddddd")
	#print(trial_course.id)
	return my_redirect(
		reverse("assesment:start_quiz",
				args=[1, 0, trial_paper.id, trial_course.id]
				)
			)



def _update_paper(request, uid, result):
	new_answer = Answer.objects.get(id=uid)
	current_question = new_answer.question
	paper = new_answer.answerpaper_set.first()

	if result.get('success'):
		new_answer.marks = (current_question.points * result['weight'] /
							current_question.get_maximum_test_case_weight()) \
			# if current_question.partial_grading and \
			# current_question.type == 'code' or \
			# current_question.type == 'upload' else current_question.points
		new_answer.correct = result.get('success')
		error_message = None
		new_answer.error = json.dumps(result.get('error'))
		next_question = paper.add_completed_question(current_question.id)
	else:
		error_message = None
		next_question=paper.add_completed_question(current_question.id)
	new_answer.save()
	paper.update_marks('inprogress')
	paper.set_end_time(timezone.now())
	return next_question, error_message, paper

from django.conf import settings
from .models import QuestionOption
@login_required
def show_question(request, question, paper, error_message=None,
				  notification=None, course_id=None, module_id=None,
				  previous_question=None):
	quiz = paper.question_paper.quiz
	quiz_type = 'Exam'
	can_skip = False
	assignment_files = []
	delay_time=None
	if previous_question:
		delay_time = paper.time_left_on_question(previous_question)
	else:
		if question is None:
			return HttpResponse("No questions in this quiz")
		delay_time = paper.time_left_on_question(question)

	if previous_question and quiz.is_exercise:
		if (delay_time <= 0 or previous_question in
				paper.questions_answered.all()):
			can_skip = True
		question = previous_question
	if not question:
		print("all question has been ")
		msg = 'Congratulations!  You have successfully completed the quiz.'
		return complete(
			request, msg, paper.attempt_number, paper.question_paper.id,
			course_id=course_id, module_id=module_id
		)
	if not quiz.active and not paper.is_special:
		reason = 'The quiz has been deactivated!'
		return complete(
			request, reason, paper.attempt_number, paper.question_paper.id,
			course_id=course_id, module_id=module_id
		)
	if not quiz.is_exercise:
		if paper.time_left() <= 0:
			reason = 'Your time is up!'
			return complete(
				request, reason, paper.attempt_number, paper.question_paper.id,
				course_id, module_id=module_id
			)
	else:
		quiz_type = 'Exercise'
	if question in paper.questions_answered.all():
		print('question_answered',paper.questions_answered.all())
		notification = (
			'You have already attempted this question successfully'
			if question.type == "code" else
			'You have already attempted this question'

			
		)
		question_given_answer = None
	if question.type in ['mcc', 'mcq', 'arrange']:
		pass
		#test_cases = question.get_ordered_test_cases(paper)
	else:
		pass
		#test_cases = question.get_test_cases()
	if question.type == 'upload':
		assignment_files = AssignmentUpload.objects.filter(
							assignmentQuestion_id=question.id,
							course_id=course_id,
							user=request.user,
							question_paper_id=paper.question_paper_id
						)
	files = FileUpload.objects.filter(question_id=question.id, hide=False)
	#course = Courses.objects.get(id=course_id)
	#module = courses.learning_module.get(id=module_id)
	#all_modules = course.get_learning_modules()

	#check answer is given 
	l_dict={}
	try:
		qo=QuestionOption.objects.get(question=question)
		#from django.forms.model import model_to_dict
		#print(qo.__dict__)
		for key,value in qo.__dict__.items():
			if key=="_state" or key=="_foreign_key_cache" or key=="id" \
				or key=="question_id":
				continue
			else:
				l_dict[key]=value

		#qo_list=qo.__dict__
		#print(l_dict)

	except:
		print("no options for this question",question.id)

	context = {
		'question': question,
		'l_dict' : l_dict,
		'extra_url':settings.EXTRA_URL,
		#'option_a' :qo.option_a,
		#'option_b':qo.option_b, 
		'paper': paper,
		'questionpaper_id':paper.question_paper.id,
		'quiz': quiz,
		'error_message': error_message,
		#'test_cases': test_cases,
		'files': files,
		'notification': notification,
		#'last_attempt': question.snippet.encode('unicode-escape'),
		#'course': course,
		#'module': module,
		'can_skip': can_skip,
		'delay_time': delay_time,
		'quiz_type': quiz_type,
		#'all_modules': all_modules,
		'assignment_files': assignment_files,
	}


	answers = paper.get_previous_answers(question)
	if answers:
		last_attempt = answers[0].answer
		if last_attempt:
			context['last_attempt'] = last_attempt.split(',')

			#context['last_attempt'] = last_attempt.encode('unicode-escape')
	#print("here")
	print(context)
	return my_render_to_response(request, 'assesment/questions.html', context)


from .models import QuestionOption
@login_required
def show_question_api(request, question, paper, error_message=None,
				  notification=None, course_id=None, module_id=None,
				  previous_question=None):
	quiz = paper.question_paper.quiz
	quiz_type = 'Exam'
	can_skip = False
	assignment_files = []
	delay_time=None
	if previous_question:
		delay_time = paper.time_left_on_question(previous_question)
	else:
		if question is None:
			return HttpResponse("No questions in this quiz")
		delay_time = paper.time_left_on_question(question)

	if previous_question and quiz.is_exercise:
		if (delay_time <= 0 or previous_question in
				paper.questions_answered.all()):
			can_skip = True
		question = previous_question
	if not question:
		print("all question has been ")
		msg = 'Congratulations!  You have successfully completed the quiz.'
		return complete(
			request, msg, paper.attempt_number, paper.question_paper.id,
			course_id=course_id, module_id=module_id
		)
	if not quiz.active and not paper.is_special:
		reason = 'The quiz has been deactivated!'
		return complete(
			request, reason, paper.attempt_number, paper.question_paper.id,
			course_id=course_id, module_id=module_id
		)
	if not quiz.is_exercise:
		if paper.time_left() <= 0:
			reason = 'Your time is up!'
			return complete(
				request, reason, paper.attempt_number, paper.question_paper.id,
				course_id, module_id=module_id
			)
	else:
		quiz_type = 'Exercise'
	if question in paper.questions_answered.all():
		notification = (
			'You have already attempted this question successfully'
			if question.type == "code" else
			'You have already attempted this question'
		)
	if question.type in ['mcc', 'mcq', 'arrange']:
		pass
		#test_cases = question.get_ordered_test_cases(paper)
	else:
		pass
		#test_cases = question.get_test_cases()
	if question.type == 'upload':
		assignment_files = AssignmentUpload.objects.filter(
							assignmentQuestion_id=question.id,
							course_id=course_id,
							user=request.user,
							question_paper_id=paper.question_paper_id
						)
	files = FileUpload.objects.filter(question_id=question.id, hide=False)
	#course = Courses.objects.get(id=course_id)
	#module = courses.learning_module.get(id=module_id)
	#all_modules = course.get_learning_modules()
	try:
		qo=QuestionOption.objects.get(question=question)
	except:
		print("no options for this question",question.id)
	question_paper_id = paper.question_paper.id
	quest_paper = model_to_dict(paper)
	q2 = quest_paper.pop('questions', False)
	q3 = quest_paper.pop('questions_unanswered', False)
	if q2:
		x = list()
		for z in q2:
			x.append(model_to_dict(z))
		quest_paper['questions'] = x
	if q3:
		y = list()
		for z in q3:
			y.append(model_to_dict(z))
		quest_paper['questions_unanswered'] = y
	# quest_paper['quiz'] = model_to_dict(Quiz.objects.get(id=quest_paper.__getitem__("quiz")))
	print(quest_paper)
	context = {
		'question': model_to_dict(question),
		'options' : model_to_dict(qo),
		'option_a' :qo.option_a,
		'option_b':qo.option_b,
		'paper': quest_paper,
		'questionpaper_id': question_paper_id,
		'quiz': model_to_dict(quiz),
		'error_message': error_message,
		#'test_cases': test_cases,
		#'files': model_to_dict(files),
		'notification': notification,
		#'last_attempt': question.snippet.encode('unicode-escape'),
		#'course': course,
		#'module': module,
		'can_skip': can_skip,
		'delay_time': delay_time,
		'quiz_type': quiz_type,
		#'all_modules': all_modules,
		'assignment_files': assignment_files,
	}


	answers = paper.get_previous_answers(question)
	if answers:
		last_attempt = answers[0].answer
		if last_attempt:
			context['last_attempt'] = last_attempt
			#context['last_attempt'] = last_attempt.encode('unicode-escape')
	#print("here")
	print(context)
	# return my_render_to_response(request, 'assesment/questions.html', context)
	return  JsonResponse(context)


from .models import QuestionOption
@login_required
def show_next_question_api(request, question, paper, error_message=None,
				  notification=None, course_id=None, module_id=None,
				  previous_question=None):
	quiz = paper.question_paper.quiz
	quiz_type = 'Exam'
	can_skip = False
	assignment_files = []
	delay_time=None
	if previous_question:
		delay_time = paper.time_left_on_question(previous_question)
	else:
		if question is None:
			return JsonResponse({"status":3, "q_act":False,"q_count": 0 ,"message":"No questions in this quiz"})
		delay_time = paper.time_left_on_question(question)

	if previous_question and quiz.is_exercise:
		if (delay_time <= 0 or previous_question in
				paper.questions_answered.all()):
			can_skip = True
		question = previous_question
	if not question:
		print("all question has been ")
		msg = 'Congratulations!  You have successfully completed the quiz.'
		# return complete(
		# 	request, msg, paper.attempt_number, paper.question_paper.id,
		# 	course_id=course_id, module_id=module_id
		# )
		return JsonResponse({"status":4, "q_act":False, "q_count": 0, "message": msg})
	if not quiz.active and not paper.is_special:
		reason = 'The quiz has been deactivated!'
		# return complete(
		# 	request, reason, paper.attempt_number, paper.question_paper.id,
		# 	course_id=course_id, module_id=module_id
		# )
		return JsonResponse({"status":5, "q_act":False, "q_count": 0, "message": reason})
	if not quiz.is_exercise:
		if paper.time_left() <= 0:
			reason = 'Your time is up!'
			# return complete(
			# 	request, reason, paper.attempt_number, paper.question_paper.id,
			# 	course_id, module_id=module_id
			# )
			return JsonResponse({"status":6, "q_act":False, "q_count": 0, "message": reason})
	else:
		quiz_type = 'Exercise'
	if question in paper.questions_answered.all():
		notification = (
			'You have already attempted this question successfully'
			if question.type == "code" else
			'You have already attempted this question'
		)
	if question.type in ['mcc', 'mcq', 'arrange']:
		pass
		#test_cases = question.get_ordered_test_cases(paper)
	else:
		pass
		#test_cases = question.get_test_cases()
	if question.type == 'upload':
		assignment_files = AssignmentUpload.objects.filter(
							assignmentQuestion_id=question.id,
							course_id=course_id,
							user=request.user,
							question_paper_id=paper.question_paper_id
						)
	files = FileUpload.objects.filter(question_id=question.id, hide=False)
	#course = Courses.objects.get(id=course_id)
	#module = courses.learning_module.get(id=module_id)
	#all_modules = course.get_learning_modules()
	try:
		qo=QuestionOption.objects.get(question=question)
	except:
		print("no options for this question",question.id)
	question_paper_id = paper.question_paper.id
	quest_paper = model_to_dict(paper)
	q2 = quest_paper.pop('questions', False)
	q3 = quest_paper.pop('questions_unanswered', False)
	if q2:
		x = list()
		for z in q2:
			q = model_to_dict(z)
			e = q.pop('solution', False)
			x.append(q)
		quest_paper['questions'] = x
	else:
		quest_paper['questions'] = False
	if q3:
		y = list()
		for z in q3:
			q = model_to_dict(z)
			e = q.pop('solution', False)
			y.append(q)
		quest_paper['questions_unanswered'] = y
	else:
		quest_paper['questions_unanswered'] = False
	# quest_paper['quiz'] = model_to_dict(Quiz.objects.get(id=quest_paper.__getitem__("quiz")))
	qp = {
		#"id": quest_paper.__getitem__("id"),
		"question_paper": quest_paper.__getitem__("question_paper"),
		"attempt_number": quest_paper.__getitem__("attempt_number"),
		"start_time": quest_paper.__getitem__("start_time"),
		"end_time": quest_paper.__getitem__("end_time"),
		"comments": quest_paper.__getitem__("comments"),
		"marks_obtained": quest_paper.__getitem__("marks_obtained"),
		"percent": quest_paper.__getitem__("percent"),
		"status": quest_paper.__getitem__("status"),
		"questions_order": quest_paper.__getitem__("questions_order"),
		"extra_time": quest_paper.__getitem__("extra_time"),
		"is_special": quest_paper.__getitem__("is_special"),
		"questions": quest_paper.__getitem__("questions"),
		"questions_unanswered": quest_paper.__getitem__("questions_unanswered"),
	}
	context = {
		'question': model_to_dict(question),
		'options' : model_to_dict(qo),
		'option_a' :qo.option_a,
		'option_b':qo.option_b,
		'paper': qp,
		'questionpaper_id': question_paper_id,
		'quiz': model_to_dict(quiz),
		'error_message': error_message,
		#'test_cases': test_cases,
		#'files': model_to_dict(files),
		'notification': notification,
		#'last_attempt': question.snippet.encode('unicode-escape'),
		#'course': course,
		#'module': module,
		'can_skip': can_skip,
		'delay_time': delay_time,
		'quiz_type': quiz_type,
		#'all_modules': all_modules,
		'assignment_files': assignment_files,
		"status": 1,
		"q_act": True
	}


	answers = paper.get_previous_answers(question)
	if answers:
		last_attempt = answers[0].answer
		if last_attempt:
			context['last_attempt'] = last_attempt
			#context['last_attempt'] = last_attempt.encode('unicode-escape')
	#print("here")
	print(context)
	# return my_render_to_response(request, 'assesment/questions.html', context)
	return  JsonResponse(context)



@login_required
def get_next_question(request,answerpaperid,userid,questionid):
	if answerpaperid is not None:
		answerpaper=AnswerPaper.objects.get(id=answerpaperid)
		return HttpResponse((answerpaper.next_question(questionid)).id)
	else:
		return HttpResponse("error")

@login_required
def complete(request, reason=None, attempt_num=None, questionpaper_id=None,
			 course_id=None, module_id=None):
	user = request.user
	if questionpaper_id is None:
		message = reason or ("An Unexpected Error occurred. Please "
							 "contact your instructor/administrator."
							 )
		context = {'message': message}
		return my_render_to_response(request, 'assesment/complete.html', context)
	else:
		q_paper = QuestionPaper.objects.get(id=questionpaper_id)
		paper = AnswerPaper.objects.get(
			user=user, question_paper=q_paper,
			attempt_number=attempt_num,
			#course_id=course_id
		)
		#course = Course.objects.get(id=course_id)
		#learning_module = course.learning_module.get(id=module_id)
		#learning_unit = learning_module.learning_unit.get(quiz=q_paper.quiz)

		paper.update_marks()
		paper.set_end_time(timezone.now())
		message = reason or "Quiz has been submitted"
		context = {'message': message, 'paper': paper,
				   #'module_id': learning_module.id,
				   #'course_id': course_id, 'learning_unit': learning_unit
				   }
		#if is_moderator(user):
			#context['user'] = "moderator"
		return my_render_to_response(request, 'assesment/complete.html', context)

@login_required
def complete_api(request, reason=None, attempt_num=None, questionpaper_id=None,
			 course_id=None, module_id=None):
	user = request.user
	if questionpaper_id is None:
		message = reason or ("An Unexpected Error occurred. Please "
							 "contact your instructor/administrator."
							 )
		context = {'message': message}
		#return my_render_to_response(request, 'assesment/complete.html', context)
		return JsonResponse({"status": 2, "q_comp": False, "q_count": 0, "message": message})
	else:
		q_paper = QuestionPaper.objects.get(id=questionpaper_id)
		paper = AnswerPaper.objects.get(
			user=user, question_paper=q_paper,
			attempt_number=attempt_num,
			#course_id=course_id
		)
		#course = Course.objects.get(id=course_id)
		#learning_module = course.learning_module.get(id=module_id)
		#learning_unit = learning_module.learning_unit.get(quiz=q_paper.quiz)

		paper.update_marks()
		paper.set_end_time(timezone.now())
		message = reason or "Quiz has been submitted"
		#context = {'message': message, 'paper': paper,
				   #'module_id': learning_module.id,
				   #'course_id': course_id, 'learning_unit': learning_unit
		#		   }
		quest_paper = model_to_dict(paper)
		q2 = quest_paper.pop('questions', False)
		q3 = quest_paper.pop('questions_unanswered', False)
		q4 = quest_paper.pop('questions_answered', False)
		q5 = quest_paper.pop('answers', False)
		if q2:
			x = list()
			for z in q2:
				q = model_to_dict(z)
				e = q.pop('solution', False)
				x.append(q)
			quest_paper['questions'] = x
		else:
			quest_paper['questions'] = False
		if q3:
			y = list()
			for z in q3:
				q = model_to_dict(z)
				e = q.pop('solution', False)
				y.append(q)
			quest_paper['questions_unanswered'] = y
		else:
			quest_paper['questions_unanswered'] = False
		if q4:
			y = list()
			for z in q4:
				q = model_to_dict(z)
				e = q.pop('solution', False)
				y.append(q)
			quest_paper['questions_answered'] = y
		else:
			quest_paper['questions_answered'] = False
		if q5:
			y = list()
			for z in q5:
				q = model_to_dict(z)
				e = q.pop('solution', False)
				y.append(q)
			quest_paper['answers'] = y
		else:
			quest_paper['answers'] = False
		#print(quest_paper)

		act=Activities.objects.get(content_id=paper.question_paper.quiz.id,
					activity_type='quiz')
		#print(act,"jhjhjhjhjhjhjhhjhjjh")
		TopicWiseAnswerpaper.objects.filter(activity_id=act.id,user=request.user).update(is_completed=1)
		#print("khkhkhkkhkhkhkh")
		ac=open_next(request.user,act.topic.id,None)
		import json
		print(ac)
		if ac is not None:
			activity=json.loads(ac).get('activity',False)
		if activity:
			d={"status": 1, "q_comp": True, 'paper': quest_paper, "q_count": 0,
				"message": message,"activity":activity}
		else:
			d={"status": 1, "q_comp": True, 'paper': quest_paper, "q_count": 0,
				"message": message}

		#print("mhmhmhmhmhmhmhmh")
		#if is_moderator(user):
			#context['user'] = "moderator"
		#return my_render_to_response(request, 'assesment/complete.html', context)
		return JsonResponse(d)


@login_required
def view_answerpaper(request, questionpaper_id, course_id):
	user = request.user
	quiz = get_object_or_404(QuestionPaper, pk=questionpaper_id).quiz
	if True:
		import json
		data = AnswerPaper.objects.get_user_data(user, questionpaper_id,
												 course_id)

		has_user_assignments=False
		context = {'data': data, 'quiz': quiz, 
					#'course_id': course.id,
				   "has_user_assignments": has_user_assignments}
		return my_render_to_response(
			request, 'assesment/view_answerpaper.html', context
		)
	else:
		return HttpResponse("Problem with answer papaer")
		#return my_redirect('/assesment/quizzes/')




from .models import AnswerPaper
@login_required
def quit(request, reason=None, attempt_num=None, questionpaper_id=None,
		 course_id=None, module_id=None):

	paper = get_object_or_404(
		AnswerPaper, user=request.user, attempt_number=attempt_num,
		question_paper=questionpaper_id
	)
	context = {'paper': paper, 'message': reason, 'course_id': course_id,
			   'module_id': module_id}
	return my_render_to_response(request, 'assesment/yaksh/quit.html', context)


from .models import Answer
import json
@login_required
def check(request, q_id, attempt_num=None, questionpaper_id=None,
		  course_id=None, module_id=None):
	"""Checks the answers of the user for particular question"""
	user = request.user
	paper = get_object_or_404(
		AnswerPaper,
		user=request.user,
		attempt_number=attempt_num,
		question_paper=questionpaper_id,
		#course_id=course_id
	)
	current_question = get_object_or_404(Question, pk=q_id)
	#print(current_question)

	if request.method == 'POST':
		if (paper.time_left() <= -10 or paper.status == "completed"):
			reason = 'Your time is up!'
			return complete(
				request, reason, paper.attempt_number, paper.question_paper.id,
				course_id, module_id=module_id
			)
		if current_question.type == 'mcq':
			user_answer = request.POST.get('answer')
		elif current_question.type =="mcc":
			user_answer = request.POST.getlist('answer')
			#print('mccc',user_answer)
		else:
			user_answer = request.POST.get('answer')


		if not str(user_answer):
			msg = "Please submit a valid answer."
			return show_question(
				request, current_question, paper, notification=msg,
				course_id=course_id, module_id=module_id,
				previous_question=current_question
			)
		if current_question in paper.get_questions_answered()\
				and current_question.type not in ['code', 'upload']:
			#print("here")
			new_answer = paper.get_latest_answer(current_question.id)
			print(new_answer.answer,user_answer)

			new_answer.answer = ','.join(user_answer)
			#new_answer.correct = False
			#print(new_answer)
			#print("yy")
		else:
			new_answer = Answer(
				question=current_question, answer=user_answer,
				correct=False, error=json.dumps([])
			)
			#print(new_answer)

		new_answer.save()
		uid = new_answer.id
		paper.answers.add(new_answer)
		# If we were not skipped, we were asked to check.  For any non-mcq
		# questions, 
		json_data = current_question.consolidate_answer_data(
			user_answer, user) if current_question.type == 'code' or \
			current_question.type == 'upload' else None

		#print("dhdhhdhd",json_data)
		result = paper.validate_answer(
			user_answer, current_question, json_data, uid
		)
		#print(result)
		if current_question.type in ['code', 'upload']:
			if (paper.time_left() <= 0 and not
					paper.question_paper.quiz.is_exercise):
				url = '{0}:{1}'.format(SERVER_HOST_NAME, SERVER_POOL_PORT)
				result_details = get_result_from_code_server(url, uid,
															 block=True)
				result = json.loads(result_details.get('result'))
				next_question, error_message, paper = _update_paper(
					request, uid, result)
				return show_question(request, next_question, paper,
									 error_message, course_id=course_id,
									 module_id=module_id,
									 previous_question=current_question)
			else:
				return JsonResponse(result)
		else:
			#print("fhfh")
			next_question, error_message, paper = _update_paper(
				request, uid, result)
			#print(next_question)
			return show_question(request, next_question, paper, error_message,
								 course_id=course_id, module_id=module_id,
								 previous_question=current_question)
	else:
		return show_question(request, current_question, paper,
							 course_id=course_id, module_id=module_id,
							 previous_question=current_question)


@login_required
def check_and_next_api(request, q_id, attempt_num=None, questionpaper_id=None,
		  course_id=None, module_id=None):
	"""Checks the answers of the user for particular question"""
	user = request.user
	paper = get_object_or_404(
		AnswerPaper,
		user=request.user,
		attempt_number=attempt_num,
		question_paper=questionpaper_id,
		#course_id=course_id
	)
	current_question = get_object_or_404(Question, pk=q_id)
	#print(current_question)

	if request.method == 'POST':
		if (paper.time_left() <= -10 or paper.status == "completed"):
			reason = 'Your time is up!'
			# return complete(
			# 	request, reason, paper.attempt_number, paper.question_paper.id,
			# 	course_id, module_id=module_id
			# )
			return JsonResponse({"status":4, "q_act":False, "q_count": 0, "message": reason})

		if current_question.type == 'mcq':
			user_answer = request.POST.get('answer')
		else:
			user_answer = request.POST.get('answer')

		if not str(user_answer):
			msg = "Please submit a valid answer."
			# return show_question(
			# 	request, current_question, paper, notification=msg,
			# 	course_id=course_id, module_id=module_id,
			# 	previous_question=current_question
			# )
			return show_next_question_api(
				request, current_question, paper, notification=msg,
				course_id=course_id, module_id=module_id,
				previous_question=current_question
			)

		if current_question in paper.get_questions_answered()\
				and current_question.type not in ['code', 'upload']:
			#print("here")
			new_answer = paper.get_latest_answer(current_question.id)
			print(new_answer.answer,user_answer)
			new_answer.answer = user_answer
			#new_answer.correct = False
			#print(new_answer)
			#print("yy")
		else:
			new_answer = Answer(
				question=current_question, answer=user_answer,
				correct=False, error=json.dumps([])
			)
			#print(new_answer)

		new_answer.save()
		uid = new_answer.id
		paper.answers.add(new_answer)
		# If we were not skipped, we were asked to check.  For any non-mcq
		# questions,
		json_data = current_question.consolidate_answer_data(
			user_answer, user) if current_question.type == 'code' or \
			current_question.type == 'upload' else None

		#print("dhdhhdhd",json_data)
		result = paper.validate_answer(
			user_answer, current_question, json_data, uid
		)
		#print(result)
		if current_question.type in ['code', 'upload']:
			if (paper.time_left() <= 0 and not
					paper.question_paper.quiz.is_exercise):
				url = '{0}:{1}'.format(SERVER_HOST_NAME, SERVER_POOL_PORT)
				result_details = get_result_from_code_server(url, uid,
															 block=True)
				result = json.loads(result_details.get('result'))
				next_question, error_message, paper = _update_paper(
					request, uid, result)
				# return show_question(request, next_question, paper,
				# 					 error_message, course_id=course_id,
				# 					 module_id=module_id,
				# 					 previous_question=current_question)
				return show_next_question_api(request, next_question, paper,
									 error_message, course_id=course_id,
									 module_id=module_id,
									 previous_question=current_question)

			else:
				return JsonResponse(result)
		else:
			#print("fhfh")
			next_question, error_message, paper = _update_paper(
				request, uid, result)
			#print(next_question)
			# return show_question(request, next_question, paper, error_message,
			# 					 course_id=course_id, module_id=module_id,
			# 					 previous_question=current_question)
			return show_next_question_api(request, next_question, paper, error_message,
								 course_id=course_id, module_id=module_id,
								 previous_question=current_question)

	else:
		return show_next_question_api(request, current_question, paper,
							 course_id=course_id, module_id=module_id,
							 previous_question=current_question)


from customadmin.models import Activities,TopicWiseAnswerpaper
from userlms.views import open_next
@login_required
def start(request, questionpaper_id=None, attempt_num=None, course_id=None,
		  module_id=None):
	"""Check the user cedentials and if any quiz is available,
	start the exam."""
	user = request.user
	# check conditions
	#print(questionpaper_id)
	try:
		#q=Quiz.objects.get(id=questionpaper_id)
		quest_paper = QuestionPaper.objects.get(id=questionpaper_id)
		#print('question paper is ',quest_paper)
		if attempt_num is None and not quest_paper.quiz.is_exercise:
			# print('early redirecting')
			#user = model_to_dict(user)
			#print(user)
			n = {
				"id" : user.id,
				"first_name": user.first_name,
				"username" : user.username
			}
			#if len(user.groups) > 0:
				#user.pop('groups')
			# p = user.pop('password', False)
			quest_paper = model_to_dict(quest_paper)
			q2 = quest_paper.pop('fixed_questions', False)
			x = list()
			for z in q2:
				x.append(model_to_dict(z))
			quest_paper['fixed_questions'] = x
			quest_paper['quiz'] = model_to_dict(Quiz.objects.get(id=quest_paper.__getitem__("quiz")))
			#q3 = user.pop('date_joined', False)
			#q4 = user.pop('last_login', False)

			#print(quest_paper)
			context = {
				'user': n,
				'questionpaper': quest_paper,
				'attempt_num': 0,
				'assessment_start_url': "/assesment/start/0/0/"+str(quest_paper.__getitem__("id"))+"/0/",
				'course': 'dd',
				'module': None,
			}	
			#print("fgfgfggfgfgfg")
			# if is_moderator(user):
			#     context["status"] = "moderator"
			return JsonResponse(context)#my_render_to_response(request, 'assesment/intro.html', context)
		else:
			print("show question")
			ip = request.META['REMOTE_ADDR']
			# if not hasattr(user, 'profile'):
			#     msg = 'You do not have a profile and cannot take the quiz!'
			#     raise Http404(msg)
			#new_paper = quest_paper.make_answerpaper(user, ip, attempt_number,course_id)
			new_paper = quest_paper.make_answerpaper(user, ip, 1,None)
			print('answer paper is ',new_paper)
			if new_paper.status == 'inprogress':
			#if True:
				# return show_question(
				# 	request, new_paper.current_question(),
				# 	new_paper, course_id=course_id,
				# 	module_id=module_id, previous_question=None
				# )
				return show_next_question_api(
					request, new_paper.current_question(),
					new_paper, course_id=course_id,
					module_id=module_id, previous_question=None
				)

			else:
				act=Activities.objects.get(content_id=new_paper.question_paper.quiz.id,
					activity_type='quiz')

				TopicWiseAnswerpaper.objects.filter(activity_id=act.id,user=request.user).update(is_completed=1)
				#print(act,'kkkkkkkkkkkkkkkkkkkkkkkk')
				ac=open_next(request.user,act.topic.id,None)
				print('djddjjddj',ac)
				msg = 'You have already finished the quiz!'
				import json
				if ac is not None:
					activity=json.loads(ac).get('activity',False)
				if activity :
					d={"status":2, "q_act":False,"message": msg,"activity":activity}
				else: d={"status":2, "q_act":False,"message": msg}
				
				return JsonResponse(d)
			#print(quest_paper)
	except QuestionPaper.DoesNotExist:
		msg = 'Quiz not found, please contact your '\
			'instructor/administrator.'

	



@login_required
def skip(request, q_id, next_q=None, attempt_num=None, module_id=None,questionpaper_id=None,
		 course_id=None):
	print(course_id)
	print(questionpaper_id)
	# paper = get_object_or_404(
	# 	AnswerPaper, user=request.user, attempt_number=attempt_num,
	# 	question_paper=questionpaper_id, course_id=course_id
	# )
	paper = get_object_or_404(
		AnswerPaper, user=request.user, attempt_number=attempt_num,
		question_paper=questionpaper_id
	)
	question = get_object_or_404(Question, pk=q_id)

	if paper.question_paper.quiz.is_exercise:
		paper.start_time = timezone.now()
		paper.save()

	if request.method == 'POST' and question.type == 'code':
		if not paper.answers.filter(question=question,correct=True).exists():
			user_code = request.POST.get('answer')
			new_answer = Answer(
				question=question, answer=user_code,
				correct=False, skipped=True,
				error=json.dumps([])
			)
			new_answer.save()
			paper.answers.add(new_answer)
	if next_q is not None:
		next_q = get_object_or_404(Question, pk=next_q)
	else:
		next_q = paper.next_question(q_id)
	return show_question(request, next_q, paper, course_id=course_id,
						 module_id=module_id)

from django.views.generic.list import ListView

class AllQuiz(ListView):
	model = Quiz
	template_name = 'assesment/all_quiz.html'
	context_object_name = 'quiz_list'

	



@login_required
def show_all_questions(request):
	"""Show a list of all the questions currently in the database."""
	user = request.user
	context = {}
	message = None

	if request.method == 'POST':
		if request.POST.get('delete') == 'delete':
			data = request.POST.getlist('question')
			if data is not None:
				questions = Question.objects.filter(
					id__in=data, user_id=user.id, active=True)
				for question in questions:
					question.active = False
					question.save()
			message = "Questions deleted successfully"

		if request.POST.get('upload') == 'upload':
			form = UploadFileForm(request.POST, request.FILES)
			if form.is_valid():
				questions_file = request.FILES['file']
				file_extension = questions_file.name.split('.')[-1]
				ques = Question()
				if file_extension == "zip":
					files, extract_path = extract_files(questions_file)
					message = ques.read_yaml(extract_path, user, files)
				elif file_extension in ["yaml", "yml"]:
					questions = questions_file.read()
					message = ques.load_questions(questions, user)
				else:
					message = "Please Upload a ZIP file or YAML file"

		if request.POST.get('download') == 'download':
			question_ids = request.POST.getlist('question')
			if question_ids:
				question = Question()
				zip_file = question.dump_questions(question_ids, user)
				response = HttpResponse(content_type='application/zip')
				response['Content-Disposition'] = dedent(
					'''attachment; filename={0}_questions.zip'''.format(user)
				)
				zip_file.seek(0)
				response.write(zip_file.read())
				return response
			else:
				message = "Please select atleast one question to download"

		if request.POST.get('test') == 'test':
			question_ids = request.POST.getlist("question")
			if question_ids:
				print(question_ids)
				trial_paper, trial_course, trial_module = test_mode(
					user, False, question_ids, None)
				trial_paper.update_total_marks()
				trial_paper.save()
				return my_redirect(
					reverse("assesment:start_quiz",
							#args=[1, trial_module.id, trial_paper.id,
								  #trial_course.id]
							args=[1,0,trial_paper.id,trial_course.id]
						)
					)
			else:
				message = "Please select atleast one question to test"

	questions = Question.objects.get_queryset().filter(
				user_id=user.id, active=True).order_by('-id')
	form = QuestionFilterForm(user=user)
	#user_tags = questions.values_list('tags', flat=True).distinct()
	#all_tags = Tag.objects.filter(id__in=user_tags)
	upload_form = UploadFileForm()
	paginator = Paginator(questions, 30)
	page = request.GET.get('page')
	questions = paginator.get_page(page)
	context['objects'] = questions
	#context['all_tags'] = all_tags
	context['form'] = form
	context['upload_form'] = upload_form

	messages.info(request, message)
	return my_render_to_response(request, 'assesment/showquestions.html', context)



def _get_questions(user,question_type,marks):
	print("value from filter",marks,question_type)
	if question_type is None and marks is None:
		return None
	if question_type is not None and question_type!='' and marks is not None and marks!='':
		questions = Question.objects.filter(
			type=question_type,
			user=user,
			active=True,
			points=marks,
		)
		return questions
	if question_type is not None and question_type!='':
		questions = Question.objects.filter(
			type=question_type,
			user=user,
			active=True
		)
		return questions
	if marks is not None and marks!='':
		questions=Question.objects.filter(
				user=user,
				active=True,points=marks
		)
		return questions

def _remove_already_present(questionpaper_id, questions):
	if questionpaper_id is None:
		return questions
	questionpaper = QuestionPaper.objects.get(pk=questionpaper_id)
	questions = questions.exclude(
		id__in=questionpaper.fixed_questions.values_list('id', flat=True))
	for random_set in questionpaper.random_questions.all():
		questions = questions.exclude(
			id__in=random_set.questions.values_list('id', flat=True))
	return questions


def _get_questions_from_tags(question_tags, user, active=True, questions=None):
	search_tags = []
	for tags in question_tags:
		search_tags.extend(re.split('[; |, |\*|\n]', tags))
	if questions:
		search = questions.filter(tags__name__in=search_tags)
	else:
		search = Question.objects.get_queryset().filter(
			tags__name__in=search_tags, user=user, active=active).distinct()
	return search


from django.urls import reverse_lazy
#def design_questionpaper(request, course_id, quiz_id, questionpaper_id=None):
def design_questionpaper(request,  quiz_id, questionpaper_id=None):
	user = request.user
	if quiz_id:
		quiz = get_object_or_404(Quiz, pk=quiz_id)
		#if quiz.creator!=user:
		#if quiz.creator != user and not course_id:
			#raise Http404('This quiz does not belong to you')
	filter_form = QuestionFilterForm(user=user)
	questions = Question.objects.all()
	marks = None
	state = None
	if questionpaper_id is None:
		question_paper = QuestionPaper.objects.get_or_create(
			quiz_id=quiz_id)[0]
	else:
		question_paper = get_object_or_404(QuestionPaper, id=questionpaper_id,
										   quiz_id=quiz_id)
	questionpaper_id = question_paper.id
	print('question paper id',questionpaper_id)
	qpaper_form = QuestionPaperForm(instance=question_paper)

	if request.method == 'POST':
		filter_form = QuestionFilterForm(request.POST, user=user)
		qpaper_form = QuestionPaperForm(request.POST, instance=question_paper)
		question_type = request.POST.get('question_type', None)
		marks = request.POST.get('marks', None)
		state = request.POST.get('is_active', None)
		#tags = request.POST.get('question_tags', None)
		if 'add-fixed' in request.POST:
			question_ids = request.POST.get('checked_ques', None)
			print('question ids while saving question into questionpaper',question_ids)
			if question_ids:
				print('fixed question order is',question_paper.fixed_question_order)
				if question_paper.fixed_question_order:
					ques_order = (
						question_paper.fixed_question_order.split(",") +
						question_ids.split(",")
					)
					questions_order = ",".join(ques_order)
				else:
					questions_order = question_ids
				questions = Question.objects.filter(
					id__in=question_ids.split(',')
				)
				print('selected queestion',questions)
				question_paper.fixed_question_order = questions_order
				question_paper.save()
				question_paper.fixed_questions.add(*questions)
				messages.success(request, "Questions added successfully")
				return redirect(
					'assesment:designquestionpaper',
					#course_id=course_id,
					quiz_id=quiz_id,
					questionpaper_id=questionpaper_id
				)
			else:
				messages.warning(request, "Please select atleast one question")

		if 'remove-fixed' in request.POST:
			question_ids = request.POST.getlist('added-questions', None)
			if question_ids:
				if question_paper.fixed_question_order:
					que_order = question_paper.fixed_question_order.split(",")
					for qid in question_ids:
						que_order.remove(qid)
					if que_order:
						question_paper.fixed_question_order = ",".join(
							que_order)
					else:
						question_paper.fixed_question_order = ""
					question_paper.save()
				question_paper.fixed_questions.remove(*question_ids)
				messages.success(request, "Questions removed successfully")
				return redirect(
					'assesment:designquestionpaper',
					quiz_id=quiz_id,
					questionpaper_id=questionpaper_id
				)
			else:
				messages.warning(request, "Please select atleast one question")

		if 'save' in request.POST or 'back' in request.POST:
			messages.success(request, "Question Paper saved successfully")
			return HttpResponseRedirect(reverse_lazy("customadmin:all_course_user"))

		all_question=[]
		print('question type ',question_type)
		# if marks :
		questions=_get_questions(user,question_type,marks)
		# 	questions = _get_questions(user,question_type,marks)
		# if question_type:
		# 	questions = _get_questions(user,question_type,None)
		# 	print('questionssss',questions)
		if questions:
			questions = _remove_already_present(questionpaper_id, questions)

	question_paper.update_total_marks()
	question_paper.save()
	#random_sets = question_paper.random_questions.all()
	fixed_questions = question_paper.get_ordered_questions()
	context = {
		'qpaper_form': qpaper_form,
		'filter_form': filter_form,
		'qpaper': question_paper,
		'questions': questions,
		'fixed_questions': fixed_questions,
		'state': state,
	}

	return my_render_to_response(
		request, 'assesment/design_questionpaper.html', context
	)





