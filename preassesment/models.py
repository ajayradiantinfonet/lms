from django.db import models

# Create your models here.
from customadmin.models import Topic,SubTopic
from django.contrib.auth.models import User
from django.utils import timezone
from datetime import datetime
import pytz
import collections
import io
from django.forms import model_to_dict
try:
	from StringIO import StringIO as string_io
except ImportError:
	from io import BytesIO as string_io
import tempfile
from textwrap import dedent
from ast import literal_eval
import pandas as pd
import ruamel.yaml
from ruamel.yaml.scalarstring import PreservedScalarString
from ruamel.yaml.comments import CommentedMap
import uuid
import os
import shutil
from textwrap import dedent
from django.conf import settings

question_types = (
		(None, 'Select Question Type'),
		("mcq", "Single Correct Choice"),
		("mcc", "Multiple Correct Choices"),
		#("upload", "Assignment Upload"),
		#("arrange", "Arrange in Correct Order"),

	)

legend_display_types = {
		"mcq": {"label": "Objective Type"},
		"mcc": {"label": "Objective Type"},
		
		"upload": {"label": "Upload"},
		"arrange": {"label": "Objective Type"},
	}

attempts = [(i, i) for i in range(1, 6)]
attempts.append((-1, 'Infinite'))

def write_templates_to_zip(zipfile, template_path, data, filename, filepath):
	rendered_template = render_template(template_path, data)
	zipfile.writestr(os.sep.join((filepath, "{0}.html".format(filename))),
			str(rendered_template))


def render_template(template_path, data=None):
	with open(template_path) as f:
		template_data = f.read()
		template = Template(template_data)
		context = Context(data)
		render = template.render(context)
	return render


def dict_to_yaml(dictionary):
	for k, v in dictionary.items():
		if isinstance(v, list):
			for nested_v in v:
				if isinstance(nested_v, dict):
					dict_to_yaml(nested_v)
		elif v and isinstance(v, str):
			dictionary[k] = PreservedScalarString(v)
	return ruamel.yaml.round_trip_dump(dictionary, explicit_start=True,
									   default_flow_style=False,
									   allow_unicode=True,
									   )


# class CustomDateTime(models.Model):
# 	created_at= models.DateTimeField(auto_now_add=True)
# 	updated_at = models.DateTimeField(default=timezone.now)

from customadmin.models import Courses

class AssesmentsManager(models.Manager):
	def get_active_quizzes(self):
		return self.filter(active=True, is_trial=False)

	def create_trial_quiz(self, user):
		"""Creates a trial quiz for testing questions"""
		trial_quiz = self.create(
			duration=1000, description="trial_questions",
			is_trial=True, time_between_attempts=0, creator=user
			)
		return trial_quiz

	def create_trial_from_quiz(self, original_quiz_id, user, godmode,
							   course_id):
		"""Creates a trial quiz from existing quiz"""
		trial_course_name = "Trial_course_for_course_{0}_{1}".format(
			course_id, "godmode" if godmode else "usermode")
		trial_quiz_name = "Trial_orig_id_{0}_{1}".format(
			original_quiz_id,
			"godmode" if godmode else "usermode"
		)

		trial_course = Courses.objects.filter(name=trial_course_name)
		if trial_course.exists():
			trial_course = trial_course.get(name=trial_course_name)
		else:
			trial_course = Courses.objects.create(
				name=trial_course_name,about='fff',duration='12:05',author = user)

			print(trial_course)

		# Get or create Trial Quiz for usermode/godmode
		if self.filter(description=trial_quiz_name).exists():
			trial_quiz = self.get(description=trial_quiz_name)

		else:
			trial_quiz = self.get(id=original_quiz_id)
			trial_quiz.user = user
			trial_quiz.pk = None
			trial_quiz.description = trial_quiz_name
			trial_quiz.is_trial = True
			trial_quiz.prerequisite = None
			if godmode:
				trial_quiz.time_between_attempts = 0
				trial_quiz.duration = 1000
				trial_quiz.attempts_allowed = -1
				trial_quiz.active = True
				trial_quiz.start_date_time = timezone.now()
				trial_quiz.end_date_time = datetime(
					2199, 1, 1, 0, 0, 0, 0, tzinfo=pytz.utc
				)
			trial_quiz.save()

		return trial_quiz, trial_course, trial_learning_module



class Assesments(models.Model):
	topics = models.ForeignKey(Topic,null=True,
		on_delete=models.CASCADE,related_name='assesment_topics')
	#topic=models.CharField(max_length=125)
	#subtopic = models.ForeignKey(SubTopic,on_delete=models.CASCADE)
	name= models.CharField(max_length=125)
	about = models.CharField(max_length=125)
	creator = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE,related_name='assesment_author')
	start_date_time = models.DateTimeField(
		"Start Date and Time of the quiz",
		default=timezone.now,
		null=True
	)

	# The end date and time of the quiz
	end_date_time = models.DateTimeField(
		"End Date and Time of the quiz",
		default=datetime(
			2199, 1, 1,
			tzinfo=pytz.timezone(timezone.get_current_timezone_name())
		),
		null=True
	)
	duration = models.IntegerField("Duration of quiz in minutes",null=False, default=20)
	active = models.BooleanField(default=True)
	description = models.CharField(max_length=256,null=True)
	pass_criteria = models.FloatField("Passing percentage", default=40)
	attempts_allowed = models.IntegerField(default=1, choices=attempts)
	time_between_attempts = models.FloatField(
		"Time Between Quiz Attempts in hours", default=0.0
	)
	is_trial = models.BooleanField(default=False)
	instructions = models.TextField('Instructions for Students',								default=None, blank=True, null=True)
	view_answerpaper = models.BooleanField('Allow student to view their answer\
											paper', default=False)
	allow_skip = models.BooleanField("Allow students to skip questions",
									 default=True)
	weightage = models.FloatField(help_text='Will be considered as percentage',
								  default=100)
	is_exercise = models.BooleanField(default=False)


	objects = AssesmentsManager()

	def __str__(self):
		desc = self.description or 'Quiz'
		return '%s: on %s for %d minutes' % (desc, self.start_date_time,
											 self.duration)
	def get_total_students(self,course):
		pass

	def get_passed_students(self, course):
		pass

	def get_failed_students(self, course):
		pass

	def _create_quiz_copy(self, user):
		pass

	def _add_quiz_to_zip(self, next_unit, module, course, zip_file, path):
		quiz_name = self.description.replace(" ", "_")
		course_name = course.name.replace(" ", "_")
		module_name = module.name.replace(" ", "_")
		sub_folder_name = os.sep.join((
			course_name, module_name, quiz_name
			))
		unit_file_path = os.sep.join((
			path, "templates", "yaksh", "download_course_templates",
			"quiz.html"
			))
		quiz_data = {"course": course, "module": module,
					 "quiz": self, "next_unit": next_unit}

		write_templates_to_zip(zip_file, unit_file_path, quiz_data,
							   quiz_name, sub_folder_name)

	class Meta:
		managed=True




q_type=(('optional','optional'),('subjective','subjective'))


class QuizManager(models.Manager):
	def get_active_quizzes(self):
		return self.filter(active=True, is_trial=False)


from customadmin.models import Topic,CoursesEndUser
###############################################################################
class Quiz(models.Model):
	"""A quiz that students will participate in. One can think of this
	as the "examination" event.
	"""


	course = models.ForeignKey(CoursesEndUser,on_delete=models.CASCADE,null=True)
	topic = models.ForeignKey(Topic,on_delete=models.CASCADE,null=True)
	# This is always in minutes.

	# name of quiz
	name = models.CharField(max_length=256, default=None)

	# Description of quiz.
	description = models.TextField("Description",default=None, blank=True, null=True)


	duration = models.IntegerField("Duration of quiz in minutes", default=20)

	# Is the quiz active. The admin should deactivate the quiz once it is
	# complete.
	active = models.BooleanField(default=True)

	


	# Mininum passing percentage condition.
	pass_criteria = models.FloatField("Passing percentage", default=40)

	# Number of attempts for the quiz
	attempts_allowed = models.IntegerField(default=1, choices=attempts)


	time_between_attempts = models.FloatField(
		"Time Between Quiz Attempts in minutes", default=0.0, null=True
	)

	# is_trial = models.BooleanField(default=False)



	allow_skip = models.BooleanField("Allow students to skip questions",
									 default=True)


	instructions = models.TextField('Instructions for Students',
									default=None, blank=True, null=True)

	# view_answerpaper = models.BooleanField('Allow student to view their answer\
	# 										paper', default=False)

	
	# weightage = models.FloatField(help_text='Will be considered as percentage',
	# 							  default=100)

	is_exercise = models.BooleanField(default=False)

	creator = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, on_delete=models.CASCADE)

	objects = QuizManager()

	class Meta:
		verbose_name_plural = "Quizzes"

	def is_expired(self):
		return False
		#return not self.start_date_time <= timezone.now() < self.end_date_time


	def get_total_students(self, course):
		try:
			qp = self.questionpaper_set.get().id
		except QuestionPaper.DoesNotExist:
			qp = None
		return AnswerPaper.objects.filter(
				question_paper=qp,
				course=course
			).values_list("user", flat=True).distinct().count()

	def get_passed_students(self, course):
		try:
			qp = self.questionpaper_set.get().id
		except QuestionPaper.DoesNotExist:
			qp = None
		return AnswerPaper.objects.filter(
				question_paper=qp,
				course=course, passed=True
			).values_list("user", flat=True).distinct().count()

	def get_failed_students(self, course):
		try:
			qp = self.questionpaper_set.get().id
		except QuestionPaper.DoesNotExist:
			qp = None
		return AnswerPaper.objects.filter(
				question_paper=qp,
				course=course, passed=False
			).values_list("user", flat=True).distinct().count()

	def get_answerpaper_status(self, user, course):
		try:
			qp = self.questionpaper_set.get().id
		except QuestionPaper.DoesNotExist:
			qp = None
		ans_ppr = AnswerPaper.objects.filter(
			user_id=user.id, course_id=course.id, question_paper_id=qp
		).order_by("-attempt_number")
		if ans_ppr.exists():
			status = ans_ppr.first().status
		else:
			status = "not attempted"
		return status

	def get_answerpaper_passing_status(self, user, course):
		try:
			qp = self.questionpaper_set.get().id
		except QuestionPaper.DoesNotExist:
			qp = None
		ans_ppr = AnswerPaper.objects.filter(
			user_id=user.id, course_id=course.id, question_paper_id=qp
		).order_by("-attempt_number")
		if ans_ppr.exists():
			return any([paper.passed for paper in ans_ppr])
		return False


	def __str__(self):
		desc = self.description or 'Quiz'
		return '%s:  for %d minutes' % (desc,self.duration)




class Question(models.Model):
	question_name = models.CharField(max_length=256 , default=None)
	description = models.TextField(null=True)
	points = models.FloatField(default=1.0)
	#language = models.CharField(max_length=24,choices=languages)
	topic = models.CharField(max_length=50, blank=True, null=True)
	type = models.CharField(max_length=24,choices=question_types,
		default=question_types[0][0])

	active = models.BooleanField(default=True)

	user = models.ForeignKey(settings.AUTH_USER_MODEL, related_name="user",
							 on_delete=models.CASCADE)


	#partial_grading = models.BooleanField(default=False)

	#grade_assignment_upload = models.BooleanField(default=False)

	min_time = models.IntegerField("time in minutes", default=0)

	solution = models.TextField(blank=False,null=False)

	#content = GenericRelation("TableOfContents")

	


	def _add_and_get_files(self, zip_file):
		files = FileUpload.objects.filter(question=self)
		files_list = []
		for f in files:
			zip_file.write(f.file.path, os.path.join("additional_files",
													 os.path.basename(
														f.file.path
														)
													 )
						   )
			files_list.append(((os.path.basename(f.file.path)), f.extract))
		return files_list

	def _add_files_to_db(self, file_names, path):
		for file_name, extract in file_names:
			q_file = glob.glob(os.path.join(path, "**", file_name))[0]
			if os.path.exists(q_file):
				que_file = open(q_file, 'rb')
				# Converting to Python file object with
				# some Django-specific additions
				django_file = File(que_file)
				file_upload = FileUpload()
				file_upload.question = self
				file_upload.extract = extract
				file_upload.file.save(file_name, django_file, save=True)

	def _add_yaml_to_zip(self, zip_file, q_dict, path_to_file=None):
		tmp_file_path = tempfile.mkdtemp()
		yaml_path = os.path.join(tmp_file_path, "questions_dump.yaml")
		for elem in q_dict:
			relevant_dict = CommentedMap()
			relevant_dict['summary'] = elem.pop('summary')
			relevant_dict['type'] = elem.pop('type')
			#relevant_dict['language'] = elem.pop('language')
			relevant_dict['description'] = elem.pop('description')
			relevant_dict['points'] = elem.pop('points')
			#relevant_dict['testcase'] = elem.pop('testcase')
			relevant_dict.update(CommentedMap(sorted(elem.items(),
													 key=lambda x: x[0]
													 ))
								 )

			yaml_block = dict_to_yaml(relevant_dict)
			with open(yaml_path, "a") as yaml_file:
				yaml_file.write(yaml_block)
		zip_file.write(yaml_path, os.path.basename(yaml_path))
		zip_file.close()
		shutil.rmtree(tmp_file_path)

	def read_yaml(self, file_path, user, files=None):
		msg = "Failed to upload Questions"
		for ext in ["yaml", "yml"]:
			for yaml_file in glob.glob(os.path.join(file_path,
													"*.{0}".format(ext)
													)):
				if os.path.exists(yaml_file):
					with open(yaml_file, 'r') as q_file:
						questions_list = q_file.read()
						msg = self.load_questions(questions_list, user,
												  file_path, files
												  )

		if files:
			delete_files(files, file_path)
		return msg



##############################################################################


class QuestionOption(models.Model):
	option_a = models.CharField(max_length=125,null=True,default=None)
	option_b = models.CharField(max_length=125,null=False,default=None)
	option_c= models.CharField(max_length=125,null=True,default=None)
	option_d=models.CharField(max_length=125,null=True,default=None)
	option_e=models.CharField(max_length=125,null=False,default=None)
	question=models.ForeignKey(Question,on_delete=models.CASCADE)


###############################################################################
class FileUpload(models.Model):
	file = models.FileField(upload_to='question_file', blank=True)
	question = models.ForeignKey(Question, related_name="question",
								 on_delete=models.CASCADE)
	extract = models.BooleanField(default=False)
	hide = models.BooleanField(default=False)

	def remove(self):
		if os.path.exists(self.file.path):
			os.remove(self.file.path)
			if os.listdir(os.path.dirname(self.file.path)) == []:
				os.rmdir(os.path.dirname(self.file.path))
		self.delete()

	def set_extract_status(self):
		if self.extract:
			self.extract = False
		else:
			self.extract = True
		self.save()

	def toggle_hide_status(self):
		if self.hide:
			self.hide = False
		else:
			self.hide = True
		self.save()

	def get_filename(self):
		return os.path.basename(self.file.name)


class Answer(models.Model):
	question = models.ForeignKey(Question, on_delete=models.CASCADE)
	answer = models.TextField(null=True, blank=True)
	#error_message show if error occur while auto checking
	error = models.TextField()
	# Marks obtained for the answer. This can be changed by the teacher
	# grading is manual.
	marks = models.FloatField(default=0.0)
	correct = models.BooleanField(default=False)
	skipped = models.BooleanField(default=False)

	comment = models.TextField(null=True, blank=True)

	def set_marks(self, marks):
		if marks > self.question.points:
			self.marks = self.question.points
		else:
			self.marks = marks

	def set_comment(self, comments):
		self.comment = comments

	def __str__(self):
		return "Answer for question {0}".format(self.question.question_name)


class QuestionPaperManager(models.Manager):

	def _create_trial_from_questionpaper(self, original_quiz_id):
		"""Creates a copy of the original questionpaper"""
		trial_questionpaper = self.get(quiz_id=original_quiz_id)
		fixed_ques = trial_questionpaper.get_ordered_questions()
		trial_questions = {"fixed_questions": fixed_ques,
						   "random_questions": trial_questionpaper
						   .random_questions.all()
						   }
		trial_questionpaper.pk = None
		trial_questionpaper.save()
		return trial_questionpaper, trial_questions

	def create_trial_paper_to_test_questions(self, trial_quiz,
											 questions_list):
		"""Creates a trial question paper to test selected questions"""
		if questions_list is not None:
			trial_questionpaper = self.create(quiz=trial_quiz,
											  total_marks=10,
											  )
			trial_questionpaper.fixed_question_order = ",".join(questions_list)
			trial_questionpaper.fixed_questions.add(*questions_list)
			return trial_questionpaper

	def create_trial_paper_to_test_quiz(self, trial_quiz, original_quiz_id):
		"""Creates a trial question paper to test quiz."""
		trial_quiz.questionpaper_set.all().delete()
		trial_questionpaper, trial_questions = \
			self._create_trial_from_questionpaper(original_quiz_id)
		trial_questionpaper.quiz = trial_quiz
		trial_questionpaper.fixed_questions\
			.add(*trial_questions["fixed_questions"])
		trial_questionpaper.random_questions\
			.add(*trial_questions["random_questions"])
		trial_questionpaper.save()
		return trial_questionpaper

from datetime import timedelta

class QuestionPaper(models.Model):
	quiz = models.ForeignKey(Quiz, on_delete=models.CASCADE)
	fixed_questions = models.ManyToManyField(Question)
	random_questions = models.ManyToManyField("QuestionSet")
	shuffle_questions = models.BooleanField(default=False, blank=False)
	total_marks = models.FloatField(default=0.0, blank=True)
	fixed_question_order = models.TextField(blank=True)
	#shuffle_testcases = models.BooleanField("Shuffle testcase for each user",
											#default=True
											#)

	objects = QuestionPaperManager()

	def get_question_bank(self):
		''' Gets all the questions in the question paper'''
		questions = list(self.fixed_questions.all())
		for random_set in self.random_questions.all():
			questions += list(random_set.questions.all())
		return questions

	# def _create_duplicate_questionpaper(self, quiz):
	# 	new_questionpaper = QuestionPaper.objects.create(
	# 		quiz=quiz, shuffle_questions=self.shuffle_questions,
	# 		total_marks=self.total_marks,
	# 		fixed_question_order=self.fixed_question_order
	# 	)
	# 	new_questionpaper.fixed_questions.add(*self.fixed_questions.all())
	# 	new_questionpaper.random_questions.add(*self.random_questions.all())

	# 	return new_questionpaper

	def update_total_marks(self):
		""" Updates the total marks for the Question Paper"""
		marks = 0.0
		questions = self.fixed_questions.all()
		for question in questions:
			marks += question.points
		for question_set in self.random_questions.all():
			question_set.marks = question_set.questions.first().points
			question_set.save()
			marks += question_set.marks * question_set.num_questions
		self.total_marks = marks
		self.save()

	def _get_questions_for_answerpaper(self):
		""" Returns fixed and random questions for the answer paper"""
		questions = self.get_ordered_questions()
		for question_set in self.random_questions.all():
			questions += question_set.get_random_questions()
		#if self.shuffle_questions:
			#all_questions = self.get_shuffled_questions(questions)
		#else:
			#all_questions
		all_questions = questions
		return all_questions

	def make_answerpaper(self, user, ip, attempt_num, course_id, special=False):
		"""Creates an answer paper for the user to attempt the quiz"""
		try:
			ans_paper = AnswerPaper.objects.get(user=user,
												attempt_number=attempt_num,
												question_paper=self,
												#course_id=course_id
												)
		except AnswerPaper.DoesNotExist:
			ans_paper = AnswerPaper(
				user=user,
				user_ip=ip,
				attempt_number=attempt_num,
				#course_id=course_id
			)
			ans_paper.start_time = timezone.now()
			ans_paper.end_time = ans_paper.start_time + \
				timedelta(minutes=self.quiz.duration)
			ans_paper.question_paper = self
			ans_paper.is_special = special
			ans_paper.save()
			questions = self._get_questions_for_answerpaper()
			ans_paper.questions.add(*questions)
			question_ids = []
			for question in questions:
				question_ids.append(str(question.id))

			ans_paper.questions_order = ",".join(question_ids)
			ans_paper.save()
			ans_paper.questions_unanswered.add(*questions)
		return ans_paper

	def _is_attempt_allowed(self, user, course_id):
		attempts = AnswerPaper.objects.get_total_attempt(questionpaper=self,
														 user=user,
														 course_id=course_id)
		attempts_allowed = attempts < self.quiz.attempts_allowed
		infinite_attempts = self.quiz.attempts_allowed == -1
		return attempts_allowed or infinite_attempts

	def can_attempt_now(self, user, course_id):
		if self._is_attempt_allowed(user, course_id):
			last_attempt = AnswerPaper.objects.get_user_last_attempt(
				user=user, questionpaper=self, course_id=course_id
			)
			if last_attempt:
				time_lag = (timezone.now() - last_attempt.start_time)
				time_lag = time_lag.total_seconds()/3600
				can_attempt = time_lag >= self.quiz.time_between_attempts
				msg = "You cannot start the next attempt for this quiz before"\
					"{0} hour(s)".format(self.quiz.time_between_attempts) \
					if not can_attempt else None
				return can_attempt, msg
			else:
				return True, None
		else:
			msg = "You cannot attempt {0} quiz more than {1} time(s)".format(
				self.quiz.description, self.quiz.attempts_allowed
			)
			return False, msg


	def get_ordered_questions(self):
		ques = []
		print("fff",self.fixed_question_order)
		if self.fixed_question_order:
			que_order = self.fixed_question_order.split(',')
			for que_id in que_order:
				ques.append(self.fixed_questions.get(id=que_id))
		else:
			ques = list(self.fixed_questions.all())
		return ques

	def get_shuffled_questions(self, questions):
		"""Get shuffled questions if auto suffle is enabled"""
		random.shuffle(questions)
		return questions

	def has_questions(self):
		questions = self.get_ordered_questions() + \
					list(self.random_questions.all())
		return len(questions) > 0

	def __str__(self):
		return "Question Paper for " + self.quiz.description


###############################################################################
class QuestionSet(models.Model):
	# Marks of each question of a particular Question Set
	
	marks = models.FloatField()
	# Number of questions to be fetched for the quiz.
	num_questions = models.IntegerField()
	# Set of questions for sampling randomly.
	questions = models.ManyToManyField(Question)
	def get_random_questions(self):
		""" Returns random questions from set of questions"""
		return sample(list(self.questions.all()), self.num_questions)




test_status = (
				('inprogress', 'Inprogress'),
				('completed', 'Completed'),
			  )



##########################################################################
class AnswerPaperManager(models.Manager):
	def get_all_questions(self, questionpaper_id, attempt_number, course_id,
						  status='completed'):
		''' Return a dict of question id as key and count as value'''
		papers = self.filter(question_paper_id=questionpaper_id,
							 course_id=course_id,
							 attempt_number=attempt_number, status=status)
		all_questions = list()
		questions = list()
		for paper in papers:
			all_questions += paper.get_questions()
		for question in all_questions:
			questions.append(question.id)
		return Counter(questions)

	def get_all_questions_answered(self, questionpaper_id, attempt_number,
								   course_id, status='completed'):
		''' Return a dict of answered question id as key and count as value'''
		papers = self.filter(question_paper_id=questionpaper_id,
							 course_id=course_id,
							 attempt_number=attempt_number, status=status)
		questions_answered = list()
		for paper in papers:
			for question in filter(None, paper.get_questions_answered()):
				if paper.is_answer_correct(question):
					questions_answered.append(question.id)
		return Counter(questions_answered)

	def get_attempt_numbers(self, questionpaper_id, course_id,
							status='completed'):
		''' Return list of attempt numbers'''
		attempt_numbers = self.filter(
			question_paper_id=questionpaper_id, status=status,
			course_id=course_id
		).values_list('attempt_number', flat=True).distinct()
		return attempt_numbers

	def has_attempt(self, questionpaper_id, attempt_number, course_id,
					status='completed'):
		''' Whether question paper is attempted'''
		return self.filter(
			question_paper_id=questionpaper_id,
			attempt_number=attempt_number, status=status,
			course_id=course_id
		).exists()

	def get_count(self, questionpaper_id, attempt_number, course_id,
				  status='completed'):
		''' Return count of answerpapers for a specfic question paper
			and attempt number'''
		return self.filter(
			question_paper_id=questionpaper_id,
			attempt_number=attempt_number, status=status,
			course_id=course_id
		).count()

	def get_question_statistics(self, questionpaper_id, attempt_number,
								course_id, status='completed'):
		''' Return dict with question object as key and list as value
			The list contains two value, first the number of times a question
			was answered correctly, and second the number of times a question
			appeared in a quiz'''
		question_stats = {}
		questions_answered = self.get_all_questions_answered(questionpaper_id,
															 attempt_number,
															 course_id)
		questions = self.get_all_questions(questionpaper_id, attempt_number,
										   course_id)
		all_questions = Question.objects.filter(
				id__in=set(questions),
				active=True
			).order_by('type')
		for question in all_questions:
			if question.id in questions_answered:
				question_stats[question] = [questions_answered[question.id],
											questions[question.id]]
			else:
				question_stats[question] = [0, questions[question.id]]
		return question_stats

	def _get_answerpapers_for_quiz(self, questionpaper_id, course_id,
								   status=False):
		if not status:
			return self.filter(question_paper_id__in=questionpaper_id,
							   course_id=course_id)
		else:
			return self.filter(question_paper_id__in=questionpaper_id,
							   course_id=course_id,
							   status="completed")

	def _get_answerpapers_users(self, answerpapers):
		return answerpapers.values_list('user', flat=True).distinct()

	def get_latest_attempts(self, questionpaper_id, course_id):
		papers = self._get_answerpapers_for_quiz(questionpaper_id, course_id)
		users = self._get_answerpapers_users(papers)
		latest_attempts = []
		for user in users:
			latest_attempts.append(self._get_latest_attempt(papers, user))
		return latest_attempts

	def _get_latest_attempt(self, answerpapers, user_id):
		return answerpapers.filter(
			user_id=user_id
		).order_by('-attempt_number')[0]

	def get_user_last_attempt(self, questionpaper, user, course_id):
		attempts = self.filter(question_paper=questionpaper,
							   user=user,
							   course_id=course_id).order_by('-attempt_number')
		if attempts:
			return attempts[0]

	def get_user_answerpapers(self, user):
		return self.filter(user=user)

	def get_total_attempt(self, questionpaper, user, course_id):
		return self.filter(question_paper=questionpaper, user=user,
						   course_id=course_id).count()

	def get_users_for_questionpaper(self, questionpaper_id, course_id):
		return self._get_answerpapers_for_quiz(questionpaper_id, course_id,
											   status=True)\
			.values("user__id", "user__first_name", "user__last_name")\
			.order_by("user__first_name")\
			.distinct()

	def get_user_all_attempts(self, questionpaper, user, course_id):
		return self.filter(question_paper_id__in=questionpaper, user_id=user,
						   course_id=course_id)\
							.order_by('-attempt_number')

	def get_user_data(self, user, questionpaper_id, course_id,
					  attempt_number=None):
		if attempt_number is not None:
			papers = self.filter(user_id=user.id,
								 question_paper_id__in=questionpaper_id,
								 #course_id=course_id,
								 attempt_number=attempt_number)
		else:
			papers = self.filter(
				user=user, question_paper_id=questionpaper_id,
				#course_id=course_id
			).order_by("-attempt_number")
		data = {}
		profile = user.profile if hasattr(user, 'profile') else None
		data['user'] = user
		data['profile'] = profile
		data['papers'] = papers
		data['questionpaperid'] = questionpaper_id
		return data

	def get_user_best_of_attempts_marks(self, quiz, user_id, course_id):
		best_attempt = 0.0
		papers = self.filter(question_paper__quiz_id=quiz.id,
							 course_id=course_id,
							 user=user_id).values("marks_obtained")
		if papers:
			best_attempt = max([marks["marks_obtained"] for marks in papers])
		return best_attempt



SERVER_POOL_PORT =55555

class AnswerPaper(models.Model):
	user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)

	questions = models.ManyToManyField(Question, related_name='questions')
	question_paper = models.ForeignKey(QuestionPaper, on_delete=models.CASCADE)
	attempt_number = models.IntegerField()

	start_time = models.DateTimeField()

	end_time = models.DateTimeField()

	user_ip = models.CharField(max_length=15)

	questions_unanswered = models.ManyToManyField(
		Question, related_name='questions_unanswered'
	)

	questions_answered = models.ManyToManyField(
		Question, related_name='questions_answered'
	)

	answers = models.ManyToManyField(Answer)

	comments = models.TextField()

	marks_obtained = models.FloatField(null=True, default=0.0)

	percent = models.FloatField(null=True, default=0.0)

	passed = models.BooleanField(default=False)

	status = models.CharField(
		max_length=20, choices=test_status,
		default='inprogress'
	)

	questions_order = models.TextField(blank=True, default='')

	extra_time = models.FloatField('Additional time in mins', default=0.0)

	is_special = models.BooleanField(default=False)

	objects = AnswerPaperManager()

	class Meta:
		unique_together = ('user', 'question_paper',
						   'attempt_number',
						   )

	def get_per_question_score(self, question_id):
		questions = self.get_questions().values_list('id', flat=True)
		if question_id not in questions:
			return 'NA'
		answer = self.get_latest_answer(question_id)
		if answer:
			return answer.marks
		else:
			return 0

	def current_question(self):
		"""Returns the current active question to display."""
		unanswered_questions = self.questions_unanswered.all()
		if unanswered_questions.exists():
			cur_question = self.get_current_question(unanswered_questions)
		else:
			cur_question = self.get_current_question(self.questions.all())
		return cur_question

	def get_current_question(self, questions):
		if self.questions_order:
			available_question_ids = questions.values_list('id', flat=True)
			ordered_question_ids = [int(q)
									for q in self.questions_order.split(',')]
			for qid in ordered_question_ids:
				if qid in available_question_ids:
					return questions.get(id=qid)
		return questions.first()

	def questions_left(self):
		"""Returns the number of questions left."""
		return self.questions_unanswered.count()

	def add_completed_question(self, question_id):
		"""
			Adds the completed question to the list of answered
			questions and returns the next question.
		"""
		if question_id not in self.questions_answered.all():
			self.questions_answered.add(question_id)
		self.questions_unanswered.remove(question_id)

		return self.next_question(question_id)

	def next_question(self, question_id):
		"""
			Skips the current question and returns the next sequentially
			 available question.
		"""
		if self.questions_order:
			all_questions = [
				int(q_id) for q_id in self.questions_order.split(',')
			]
		else:
			all_questions = list(self.questions.all().values_list(
				'id', flat=True))
		if len(all_questions) == 0:
			return None
		try:
			index = all_questions.index(int(question_id))
			next_id = all_questions[index+1]
		except (ValueError, IndexError):
			next_id = all_questions[0]
		return self.questions.get(id=next_id)

	def get_all_ordered_questions(self):
		"""Get all questions in a specific order for answerpaper"""
		if self.questions_order:
			que_ids = [int(q_id) for q_id in self.questions_order.split(',')]
			questions = [self.questions.get(id=que_id)
						 for que_id in que_ids]
		else:
			questions = list(self.questions.all())
		return questions

	def set_extra_time(self, time=0):
		now = timezone.now()
		self.extra_time += time
		if self.status == 'completed' and self.end_time < now:
			self.extra_time = time
			quiz_time = self.question_paper.quiz.duration
			self.start_time = now - timezone.timedelta(minutes=quiz_time)
			self.end_time = now + timezone.timedelta(minutes=time)
			self.status = 'inprogress'
		self.save()

	def time_left(self):
		"""Return the time remaining for the user in seconds."""
		secs = self._get_total_seconds()
		extra_time = self.extra_time * 60
		total = self.question_paper.quiz.duration*60.0
		remain = max(total - (secs - extra_time), 0)
		return int(remain)

	def time_left_on_question(self, question):
		secs = self._get_total_seconds()
		total = question.min_time*60.0
		remain = max(total - secs, 0)
		return int(remain)

	def _get_total_seconds(self):
		dt = timezone.now() - self.start_time
		try:
			secs = dt.total_seconds()
		except AttributeError:
			# total_seconds is new in Python 2.7. :(
			secs = dt.seconds + dt.days*24*3600
		return secs

	def _update_marks_obtained(self):
		"""Updates the total marks earned by student for this paper."""
		marks = 0
		for question in self.questions.all():
			marks_list = [a.marks
						  for a in self.answers.filter(question=question)]
			max_marks = max(marks_list) if marks_list else 0.0
			marks += max_marks
		self.marks_obtained = marks

	def _update_percent(self):
		"""Updates the percent gained by the student for this paper."""
		total_marks = self.question_paper.total_marks
		if self.marks_obtained is not None:
			percent = self.marks_obtained/total_marks*100
			self.percent = round(percent, 2)

	def _update_passed(self):
		"""
			Checks whether student passed or failed, as per the quiz
			passing criteria.
		"""
		if self.percent is not None:
			if self.percent >= self.question_paper.quiz.pass_criteria:
				self.passed = True
			else:
				self.passed = False

	def _update_status(self, state):
		""" Sets status as inprogress or completed """
		self.status = state

	def update_marks(self, state='completed'):
		self._update_marks_obtained()
		self._update_percent()
		self._update_passed()
		self._update_status(state)
		self.save()

	def set_end_time(self, datetime):
		""" Sets end time """
		self.end_time = datetime
		self.save()

	def get_answer_comment(self, question_id):
		answer = self.answers.filter(question_id=question_id).last()
		if answer:
			return answer.comment

	def get_question_answers(self):
		"""
			Return a dictionary with keys as questions and a list of the
			corresponding answers.
		"""
		q_a = {}
		import json
		for answer in self.answers.all():
			question = answer.question
			if question in q_a:
				q_a[question].append({
					'answer': answer,
					'error_list': [e for e in json.loads(answer.error)]
				})
			else:
				q_a[question] = [{
					'answer': answer,
					'error_list': [e for e in json.loads(answer.error)]
				}]

		q_a.update(
			{ q: [] for q in self.questions_unanswered.all() }
		)

		for question, answers in q_a.items():
			answers = q_a[question]
			if answers:
				q_a[question].append({
					'marks': max([
						answer['answer'].marks
						for answer in answers
						if question == answer['answer'].question
					]),
				})
			else:
				q_a[question].append({
					'marks': 0.0,
				})

		return q_a

	def get_latest_answer(self, question_id):
		return self.answers.filter(question=question_id).order_by("id").last()

	def get_questions(self):
		return self.questions.filter(active=True)

	def get_questions_answered(self):
		return self.questions_answered.all().distinct()

	def get_questions_unanswered(self):
		return self.questions_unanswered.all()

	def is_answer_correct(self, question_id):
		''' Return marks of a question answered'''
		return self.answers.filter(question_id=question_id,
								   correct=True).exists()

	def is_attempt_inprogress(self):
		if self.status == 'inprogress':
			return self.time_left() > 0

	def get_previous_answers(self, question):
		return self.answers.filter(question=question).order_by('-id')

	def get_categorized_question_indices(self):
		category_question_map = collections.defaultdict(list)
		for index, question in enumerate(self.get_all_ordered_questions(), 1):
			question_category = legend_display_types.get(question.type)
			if question_category:
				category_question_map[
					question_category["label"]
				].append(index)
		return dict(category_question_map)

	def validate_answer(self, user_answer, question, json_data=None, uid=None,
						server_port=SERVER_POOL_PORT):

		result = {'success': False, 'error': ['Incorrect answer'],
				  'weight': 0.0}
		return result

	def regrade(self, question_id, server_port=SERVER_POOL_PORT):
		try:
			question = self.questions.get(id=question_id)
			msg = 'User: {0}; Quiz: {1}; Question: {2}.\n'.format(
					self.user, self.question_paper.quiz.description, question)
		except Question.DoesNotExist:
			msg = 'User: {0}; Quiz: {1} Question id: {2}.\n'.format(
				self.user, self.question_paper.quiz.description,
				question_id
			)
			return False, msg + 'Question not in the answer paper.'
		user_answer = self.answers.filter(question=question).last()
		if not user_answer:
			return False, msg + 'Did not answer.'
		if question.type in ['mcc', 'arrange']:
			try:
				answer = literal_eval(user_answer.answer)
				if type(answer) is not list:
					return (False,
							msg + '{0} answer not a list.'.format(
															question.type
															)
							)
			except Exception:
				return (False,
						msg + '{0} answer submission error'.format(
															 question.type
															 )
						)
		else:
			answer = user_answer.answer
		json_data = question.consolidate_answer_data(answer) \
			if question.type == 'code' else None
		result = self.validate_answer(answer, question,
									  json_data, user_answer.id,
									  server_port=server_port
									  )
		if question.type == "code":
			url = '{0}:{1}'.format(SERVER_HOST_NAME, server_port)
			check_result = get_result_from_code_server(url, result['uid'],
													   block=True
													   )
			result = json.loads(check_result.get('result'))
		user_answer.correct = result.get('success')
		user_answer.error = json.dumps(result.get('error'))
		if result.get('success'):
			if question.partial_grading and question.type == 'code':
				max_weight = question.get_maximum_test_case_weight()
				factor = result['weight']/max_weight
				user_answer.marks = question.points * factor
			else:
				user_answer.marks = question.points
		else:
			if question.partial_grading and question.type == 'code':
				max_weight = question.get_maximum_test_case_weight()
				factor = result['weight']/max_weight
				user_answer.marks = question.points * factor
			else:
				user_answer.marks = 0
		user_answer.save()
		self.update_marks('completed')
		return True, msg

	def __str__(self):
		u = self.user
		q = self.question_paper.quiz
		return u'AnswerPaper paper of {0} {1} for quiz {2}'\
			   .format(u.first_name, u.last_name, q.description)






