#-*- coding: utf-8 -*-
from django.urls import reverse
from django.http import HttpResponseRedirect,HttpResponse
from django.shortcuts import get_object_or_404, render
from django.views import generic

from .models import Choice, Poll,PollQuestion,PollAnswer
from django.contrib.auth.models import User
import logging


logger=logging.getLogger('django')
import json




def get_poll_analytics(request):
	if request.method=="POST":
		try:
			question_id=request.POST.get('question_id',False)
			poll_id= request.POST.get('poll_id',False)
			logger.info(poll_id)
			if poll_id:
				#pq=PollQuestion.objects.get(id=question_id)
				#logger.info(pq)
				p=Poll.objects.get(id=poll_id)
				logger.info(p)
				l=[]
				option1_total_count=0
				option2_total_count=0
				option3_total_count=0
				option4_total_count=0
				total_answer=0
				for q in p.question.all():
					temp={}
					pas=PollAnswer.objects.filter(question=q)
					logger.info(pas)
					total_answer+=PollAnswer.objects.filter(question=q).count()
					logger.info('total_answer')
					logger.info(total_answer)
					for pa in pas:
						logger.info('major_dhyanchand')
						logger.info(pa)
						logger.info(q.option1)
						if pa.given_text == q.option1:
							option1_total_count+=1
						elif pa.given_text == q.option2:
							option2_total_count+=1
						elif q.option3 and pa.given_text == q.option3:
							option3_total_count+=1
						elif q.option4 and pa.given_text == q.option4:
							option4_total_count+=1
						else:
							logger.info("fdhbfdhbdfh dh")
					logger.info("#####################################")
					logger.info(option1_total_count)
					temp['question'] = q.question
					temp['option1'] = q.option1
					temp['option2'] = q.option2
					logger.info(q.option2)
					if q.option3 is not None:
						temp['option3'] = q.option3
					if q.option4 is not None:
						temp['option4'] = q.option4
					if q.choice_text is not None:
						temp['choice_text'] = q.choice_text
					if total_answer!=0:
						temp['option1_count'] = int((option1_total_count/total_answer)*100)
						temp['option2_count'] = int((option2_total_count/total_answer)*100)
					l.append(temp)
				logger.info(l)
				return HttpResponse(json.dumps({'message':True,'data':l}))
				#right answer
		except:
			pass
	return HttpResponse(json.dumps({'message':False}))



def store_answer_of_poll(request):
	if request.method=="POST":
		try:
			question_id=request.POST.get('question_id',False)
			user_id=request.POST.get('user_id',False)
			given_text=request.POST.get('given_text',False)
			if user_id and question_id and given_text:
				PollAnswer.objects.create(given_by_id=user_id,given_text=given_text
					,question_id=question_id)
				return HttpResponse(json.dumps({'message':True}))
		except:
			pass
	return HttpResponse(json.dumps({'message':False}))


def get_poll(request):
	if request.method=="POST":
		try:
			poll_id=request.POST.get('poll_id',False)
			if poll_id:
				p=Poll.objects.get(id=poll_id)
				
				all_question = p.question.all()
				q_list=[]
				for q in all_question:
					temp={}
					temp['question']=q.question
					temp['question_id']=q.id
					temp['option1']=q.option1
					temp['option2'] = q.option2

					if q.option3 is not None:
						temp['option3'] = q.option3
					if q.option4 is not None:
						temp['option4'] = q.option4
					q_list.append(temp)

				logger.info('all_questions')
				logger.info(q_list)

				response={}
				response['message']=True
				response['poll_id']=p.id
				if p.duration is not None:
					response['duration']=p.duration
				else: 
					response['duration'] = -1
				response['all_question']=q_list
				#reposne['poll_id'] = p.id
				return HttpResponse(json.dumps(response))
		except:
			pass
	return HttpResponse(json.dumps({'message':False}))

def add_poll(request):
	if request.method=="POST":
		try:
			user=request.POST.get('user',False)
			if user:
				question_data=request.POST.get('question_data',False)
				duration=request.POST.get('duration',None)
				u=User.objects.get(id=user)
				p=Poll(created_by=u,duration=duration)
				p.save()
				import json
				for qdata in json.loads(question_data):
					q=qdata.get('question',False)
					if q:
						pq=PollQuestion(question=q,
							option1=qdata.get('option1',None),
							option2=qdata.get('option2',None),
							option3=qdata.get('option3',None),
							option4=qdata.get('option4',None),
							choice_text=qdata.get('choice_text',None))
						pq.save()
						p.question.add(pq)

				response = {'message':True,'poll_id':p.id}

				return HttpResponse(json.dumps(response))

		except:
			return HttpResponse("error")


class IndexView(generic.ListView):
	template_name = 'polls/index.html'
	context_object_name = 'latest_poll_list'

	def get_queryset(self):
		return Poll.objects.all()[:5]


class DetailView(generic.DetailView):
	model = Poll
	template_name = 'polls/detail.html'


class ResultsView(generic.DetailView):
	model = Poll
	template_name = 'polls/results.html'


def vote(request, poll_id):
	p = get_object_or_404(Poll, pk=poll_id)
	try:
		selected_choice = p.choice_set.get(pk=request.POST['choice'])
	except (KeyError, Choice.DoesNotExist):
		# Redisplay the poll voting form.
		return render(request, 'polls/detail.html', {
			'poll': p,
			'error_message': "You didn't select a choice.",
		})
	else:
		selected_choice.votes += 1
		selected_choice.save()
		# Always return an HttpResponseRedirect after successfully dealing
		# with POST data. This prevents data from being posted twice if a
		# user hits the Back button.
		return HttpResponseRedirect(reverse('polls:results', args=(p.id,)))
