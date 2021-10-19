from django.db import models

# Create your models here.
from django.contrib.auth.models import User
from customadmin.models import CoursesEndUser
from django.utils import timezone
from django.conf import settings


#class BaseMixin(models.Model):
	

class Notes(models.Model):
	note = models.TextField()
	author = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE)
	course = models.ForeignKey(CoursesEndUser,on_delete=models.CASCADE,null=True)
	created_date = models.DateTimeField(default=timezone.now)

# class Forum(BaseMixin):
# 	def __str__(self):
# 		return self.created_date
 
class Discussion(models.Model):
	#forum = models.ForeignKey(BaseMixin,blank=True,on_delete=models.CASCADE)
	course =models.ForeignKey(CoursesEndUser,on_delete=models.CASCADE,null=True)
	created_date = models.DateTimeField(default=timezone.now)
	discuss = models.TextField()
	author = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE)

	def __str__(self):
		return str(self.author)


class ForumAnswer(models.Model):
	discussion = models.ForeignKey(Discussion,on_delete=models.CASCADE)
	answer = models.TextField()
	author = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE)