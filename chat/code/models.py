
from django.db import models
# Create your models here.
#from django.contrib.auth.models import User
from django.utils import timezone
from customadmin.models import CoursesEndUser
from django.conf import settings



class Room(models.Model):
	choices=(('started',1),('ended',2),('will start',3))
	room_id=models.SlugField(max_length=225,unique=True)
	is_private=models.BooleanField(default=False)
	course = models.ForeignKey(CoursesEndUser,on_delete=models.CASCADE,null=True)
	#id = models.AutoField(primary_key=True)
	#admin=models.OneToOneField(User,on_delete=models.CASCADE,unique=True)
	start_time=models.DateTimeField(default=timezone.now)
	end_time=models.DateTimeField(null=True)
	status =  models.CharField(max_length=10,choices=choices)
	
	def __str__(self):
		return self.room_id


	@property
	def group_name(self):
		return "room-%s" % self.id


class Room_User(models.Model):
	room_id=models.SlugField(max_length=225)
	channel_name=models.CharField(max_length=225,unique=True)
	user_id=models.CharField(max_length=40)
	status = models.BooleanField(default=False)
	course = models.ForeignKey(CoursesEndUser,on_delete=models.CASCADE,null=True)

	class Meta:
		unique_together =(('course','user_id'),)


class Layer(models.Model):
	layer_name=models.CharField(max_length=255,unique=True)
	user_name=models.CharField(max_length=40)
	course = models.ForeignKey(CoursesEndUser,on_delete=models.CASCADE,null=True)

	def __str__(self):
		return self.user_name

	class Meta:
		unique_together =(('course','user_name'),)

# class FileInformation(models.Model):
# 	file_name=models.CharField(max_length=255,unique=True)
# 	file_size=models.CharField(max_length=255)
# 	room_id=models.CharField(max_length=255)
# 	sent_from=models.CharField(max_length=255)
# 	sent_to=models.CharField(max_length=255)
# 	file=models.FileField(upload_to='uploads/')

# 	def __str__(self):
# 		return self.file_name


class Chatmessage(models.Model):
	userfrom = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE,
		related_name='chat_userfrom')
	userto = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE,
		related_name='chat_userto')
	course = models.ForeignKey(CoursesEndUser,on_delete=models.CASCADE,null=True)
	chatmessage = models.TextField()
	chattime = models.DateTimeField(default=timezone.now)
	