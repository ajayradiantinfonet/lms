#-*- coding: utf-8 -*-
from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
from django.conf import settings

class PollQuestion(models.Model):
	question= models.CharField(max_length=200)
	#poll = models.ForeignKey(Poll,on_delete=models.CASCADE)
	option1=models.CharField(max_length=200)
	option2=models.CharField(max_length=200)
	option3=models.CharField(max_length=200,null=True,blank=True)
	option4=models.CharField(max_length=200,null=True,blank=True)
	choice_text = models.CharField(max_length=200,null=True)



class Poll(models.Model):
	#question1 = models.CharField(max_length=200)
	#question2 = models.CharField(max_length=200)
	#question3 = models.CharField(max_length=200)
	#question4 = models.CharField(max_length=200)
	created_by = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE,null=True)
	duration = models.CharField(max_length=3,help_text='in minutes',null=True)
	created_at = models.DateTimeField(auto_now_add=True,null=True)
	question = models.ManyToManyField(PollQuestion)

	def total_votes(self):
		total_right = 0
		total_answer = 0

		for q in self.question.all():
			pans=PollAnswer.objects.filter(question=q)
			total_answer+=pans.count()
			for pa in pans:
				if pa.given_text == q.choice_text:
					total_right+=1

class PollAnswer(models.Model):
	given_text = models.CharField(max_length=200,null=True)
	question = models.ForeignKey(PollQuestion,on_delete=models.CASCADE)
	given_by = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE,null=True)

	def __str__(self):
		return self.given_text


class Choice(models.Model):
	poll = models.ForeignKey(Poll, on_delete=models.CASCADE,null=True)
	choice_text = models.CharField(max_length=200,null=True)
	votes = models.IntegerField(default=0)

	def __str__(self):              # Python 3: def __unicode__(self):
		return self.choice_text
