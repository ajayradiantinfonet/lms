from django.db import models
from django.db.models.base import Model
from django.utils import timezone
# Create your models here.
#from django.contrib.auth.models import User
from django.conf import settings

from .managers import LanguageManager
from django.utils import timezone
from datetime import datetime,timedelta

from django.conf import settings
import abc
import itertools
import os
import unicodedata
from enum import Enum
from typing import Generator, List, Tuple, Set

from django.contrib.auth import get_user_model
from django.core.exceptions import ValidationError
from django.db import models
from django.db.models import Max, QuerySet, Q
from django.template.defaultfilters import filesizeformat
from django.utils.text import slugify
from django.utils.translation import gettext_lazy as _, gettext_noop, get_language
from django.utils.translation import pgettext_lazy
from taggit.managers import TaggableManager


choice_activity_type = settings.ACTIVITY_TYPE
sector_type = settings.SECTOR_TYPE
course_choices=(('course','course'),('subtopic','subtopic'))
topic_choices=(('topic','topic'),('subtopic','subtopic'))
#activity_choice = (('pdf','pdf'),('questionnaire','questionnaire'))
#sector_type=(('GOVERNMENT','government'),('CORPORATE','corporate'))
from accounts.models import User

















LANGUAGES =[]

def get_translated_languages() -> List[Tuple[str, str]]:

	languages = []
	for code, language in LANGUAGES:
		languages.append((code, _(language)))
	return languages



class Language(models.Model):
	language_name = models.CharField(max_length=125)
	language_code = models.CharField(max_length=2, unique=True, default=None)
	objects = LanguageManager()

	class Meta:
		ordering=('id',)

	def __str__(self):
		return self.language_name



class DateTimeModel(models.Model):
	start_date=models.DateTimeField(default=timezone.now)
	end_date= models.DateTimeField(null=True)
	class Meta:
		abstract =True


active_state = (
	(1, 'Active'),
	(0, 'In-Active'),
)

class Country(models.Model):
	name = models.CharField(max_length=250,unique=True)
	status = models.IntegerField(choices=active_state,blank=True)

	def __str__(self):
		return self.name

class State(models.Model):
	country = models.ForeignKey(Country,models.SET_NULL,blank=True,null=True)
	name = models.CharField(max_length=250, unique=True)
	status = models.IntegerField(choices=active_state,blank=True)

	def __str__(self):
		return self.name

class City(models.Model):
	state = models.ForeignKey(State,models.SET_NULL,blank=True,null=True)
	name = models.CharField(max_length=250, unique=True)
	status = models.IntegerField(choices=active_state,blank=True)

	def __str__(self):
		return self.name


# class CourseStatus(models.Model):
#     completed_units = models.ManyToManyField(LearningUnit,
#                                              related_name="completed_units")
#     current_unit = models.ForeignKey(LearningUnit, related_name="current_unit",
#                                      null=True, blank=True,
#                                      on_delete=models.CASCADE)
#     course = models.ForeignKey(Course, on_delete=models.CASCADE)
#     user = models.ForeignKey(User, on_delete=models.CASCADE)
#     grade = models.CharField(max_length=255, null=True, blank=True)
#     percentage = models.FloatField(default=0.0)
#     percent_completed = models.IntegerField(default=0)

#     def get_grade(self):
#         return self.grade

#     def set_grade(self):
#         if self.is_course_complete():
#             self.calculate_percentage()
#             if self.course.grading_system is None:
#                 grading_system = GradingSystem.objects.get(
#                     name__contains='default'
#                 )
#             else:
#                 grading_system = self.course.grading_system
#             grade = grading_system.get_grade(self.percentage)
#             self.grade = grade
#             self.save()

#     def calculate_percentage(self):
#         quizzes = self.course.get_quizzes()
#         if self.is_course_complete() and quizzes:
#             total_weightage = 0
#             sum = 0
#             for quiz in quizzes:
#                 total_weightage += quiz.weightage
#                 marks = AnswerPaper.objects.get_user_best_of_attempts_marks(
#                         quiz, self.user.id, self.course.id)
#                 out_of = quiz.questionpaper_set.first().total_marks
#                 sum += (marks/out_of)*quiz.weightage
#             self.percentage = (sum/total_weightage)*100
#             self.save()

#     def is_course_complete(self):
#         modules = self.course.get_learning_modules()
#         complete = False
#         for module in modules:
#             complete = module.get_status(self.user, self.course) == 'completed'
#             if not complete:
#                 break
#         return complete

#     def set_current_unit(self, unit):
#         self.current_unit = unit
#         self.save()

#     def __str__(self):
#         return "{0} status for {1}".format(
#             self.course.name, self.user.username
#         )

from django.db.models import Q
class Organization(models.Model):
	""" Model for creating organization """
	organization_name = models.CharField(max_length=255,unique=True)
	website = models.URLField(max_length=255,unique=True )
	address = models.TextField()
	pin = models.CharField(max_length=10,null=True)
	start_date = models.DateField(default=timezone.now)
	end_date = models.CharField(max_length=125,blank=True,null=True,help_text='m/d/y format')
	no_of_candidates = models.IntegerField(blank=True,null=True)
	logo = models.ImageField(upload_to='organization_logo/')
	logo1 = models.ImageField(upload_to='organization_logo/',null=True)
	show_second_logo = models.BooleanField(default=False)
	contact_person_name = models.CharField(max_length=225,null=True)
	contact_person_email = models.EmailField(unique=True)
	contact_person_phone = models.CharField(max_length=10,unique=True)
	password = models.CharField(max_length=256)
	sector_type= models.CharField(choices=sector_type,
		max_length=125,default=sector_type[0][0])

	city = models.ForeignKey(City,on_delete=models.CASCADE,null=True)
	country = models.ForeignKey(Country,on_delete=models.CASCADE,null=True)
	state = models.ForeignKey(State,on_delete=models.CASCADE,null=True)

	certificate = models.TextField(null=True)

	course = models.ManyToManyField('CoursesEndUser',related_name='organization_course')
	students = models.ManyToManyField(settings.AUTH_USER_MODEL,related_name='organization_student')

	unique_code = models.SlugField(unique=True,null=True)
	is_active = models.BooleanField(default=True)

	class Meta:
		ordering=('id',)

	def __str__(self):
		return self.organization_name

	def get_all_courses(self):
		return self.course.all().order_by('id')

	def get_all_published_courses(self):
		return self.course.filter(Q(state='PUBLISHED')).order_by('id')

	def get_all_published_course_for_student(self,userid):
		all_courses=self.course.filter(state='PUBLISHED').order_by('id')
		courses=[]
		for course in all_courses:
			if course.students.filter(id=userid):
				courses.append(course)
		return courses
		#return self.course.filter(Q(state='PUBLISHED'),students=).order_by('id')

	def total_courses(self):
		return self.organization_courses.all().count()

	def get_all_users(self):
		return self.students.all().order_by('id')


class OrderedEnum(Enum):
	def __init__(self, token: str, weight: int):
		self.__weight = weight

	@property
	def weight(self) -> int:
		return self.__weight

	@property
	def value(self) -> str:
		return super().value[0]

	def __eq__(self, other):
		return self.weight == other.weight

	def __lt__(self, other):
		return self.weight < other.weight

	def __gt__(self, other):
		return self.weight > other.weight

	def __le__(self, other):
		return self.weight <= other.weight

	def __ge__(self, other):
		return self.weight >= other.weight

class BasicModelMixin( models.Model):
	@property
	@abc.abstractmethod
	def author(self) -> get_user_model():
		"""
		get author of course
		"""

	@property
	@abc.abstractmethod
	def other_user_list(self) -> QuerySet:
		"""
		Get the collobrator

		:return: the  author
		"""

	name = models.CharField(
		max_length=255,
		verbose_name=_("Name"),
		help_text=_("A title that clearly indicates the theme you are writing about.")
	)
	description = models.TextField(
		blank=True,
		verbose_name=_("Description")
	)
	language = models.CharField(
		max_length=20,
		choices=get_translated_languages(),
		verbose_name=_("Language"),
		help_text=_("The language in which the entity is written in."),
		default=get_language()
	)
	tags = TaggableManager(
		help_text=_("A set of coma separated keywords that describe the theme and permits this content to be found by "
					"browsing or searching.")
	)
	favourite_for = models.ManyToManyField(
		get_user_model(),
		related_name="+",  # no reverse relation
		verbose_name=_("Favorite for users"),
	)

	"""
	Auto-generated fields
	"""
	slug = models.SlugField(unique=True)
	# noinspection PyArgumentEqualDefault
	published = models.DateTimeField(auto_now_add=True, auto_now=False, verbose_name=_("Published the…"))
	# noinspection PyArgumentEqualDefault
	updated = models.DateTimeField(auto_now_add=False, auto_now=True, verbose_name=_("Last updated the…"))

	def slug_generator(self) -> str:
		
		return self.name

	
	def add_other_user_to_collab(self, collaborator: get_user_model()) -> "ObjectCollaboratorMixin":
		pass
	
	def remove_collaborator(self, collaborator: get_user_model()) -> None:
		pass

	

	def clean(self) -> None:
		
		if self.language == str():
			raise ValidationError(_("No language selected."))


	class Meta:
		abstract = True



class UserCategories(models.Model):
	name=models.CharField(max_length=200,unique=True)
	created_at = models.DateTimeField(auto_now_add=True)
	updated_date = models.DateTimeField(auto_now=True)
	#org = models.ForeignKey(Organization,on_delete=models.CASCADE,null=True)
	#category_type=models.CharField(max_length=25,default='category',choices=(('category','category'),('subcategory','subcategory')))
	category_about = models.CharField(max_length=200,null=True)
	creator = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE,null=True)

	def __str__(self):
		return self.name



class Categories(models.Model):
	name=models.CharField(max_length=125)
	category_type=models.CharField(max_length=25,default='category',choices=(('category','category'),('subcategory','subcategory')))
	#category_hirerchy=models.ForeignKey(Categories,on_delete=models.CASCADE)
	organization =models.ForeignKey(Organization,on_delete=models.CASCADE,null=True)
	category_image = models.ImageField(upload_to='category_images/',null=True)
	category_about = models.CharField(max_length=125,null=True)

	def __str__(self):
		return self.name




class CategoriesHirerchy(models.Model):
	category=models.OneToOneField(Categories,on_delete=models.CASCADE,unique=True,null=True)
	category_father=models.ForeignKey(Categories,on_delete=models.CASCADE,null=True,related_name='category_father')




class CoursesManager(models.Manager):
	def create_trial_course(self, user):
		"""Creates a trial course for testing questions"""
		# trial_course = self.create(name="trial_course", enrollment=True,
		#                          author=user, is_trial=True,duration=120,
		#                          end_date=datetime.now())

		trial_course = self.create(name="trial_course",
								   author=user, is_trial=True,
								   end_date=datetime.now())
		#trial_course.enroll(False, user)
		return trial_course

	def get_hidden_courses(self, code):
		return self.filter(code=code, hidden=True)



from organization.models import UserInformation


course_creation_choices = (('for organization','for organization'),('for end user','for end user'))

langauge_choices =(('English','English'),('Hindi','Hindi'),('Marathi','Marathi'),('Tamil','Tamil'))

from multiselectfield import MultiSelectField


class CourseEndUserManager(models.Manager):
	def add_view(self,user):
		pass


class CourseState(Enum):
	"""
	State of a course
	"""
	DRAFT = _("Draft")
	PUBLISHED = _("Published")
	#ARCHIVED = _("Archived")


class CourseAccess(OrderedEnum):
	"""
	Access permissions on a course
	"""
	PUBLIC = (_("Public"), 0)
	STUDENTS_ONLY = (_("Students only"), 1)
	#COLLABORATORS_ONLY = (_("Collaborators only"), 2)
	#PRIVATE = (_("Private"), 3)

#from django_cloneable import CloneableMixin
class CoursesEndUser(models.Model):
	""" Model for creating Courses for end user """
	#creation_for = models.CharField(max_length=30,choices=course_creation_choices,default=course_creation_choices[0][0]) 
	name = models.TextField()
	about = models.TextField()
	created_date = models.DateTimeField(auto_now_add=True)
	updated_date= models.DateTimeField(auto_now=True,null=True)
	#organization = models.ForeignKey(Organization,on_delete=models.CASCADE,null=True,related_name='organization_courses')
	author = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE)
	thumbnail = models.ImageField(upload_to='course_images/',default=None)
	category = models.ForeignKey(UserCategories,related_name='courses_user_categories',null=True,on_delete=models.SET_NULL)
	self_enrollment = models.BooleanField(default=True)
	###ajay##
	favourites=models.ManyToManyField(User,related_name='favourite',default=None,blank=True	)
	
	#is_trial=models.BooleanField(default=False)
	#objects=CoursesManager()

	students = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='end_user_course_students')
	requests = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='end_user_course_requests')
	rejected = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='end_user_course_rejected')

	total_view = models.IntegerField(default=0)
	web = models.BooleanField(default=True,null=False)
	mobile = models.BooleanField(default=False)
	price = models.FloatField(default=0,blank=True,null=True)
	discount_price = models.FloatField(blank=True, null=True)
	duration = models.CharField(max_length=125,blank=True,null=True,help_text="In minutes")
	#language = models.CharField(choices=langauge_choices,max_length=125,default=langauge_choices[0][0])
	language = MultiSelectField(choices=langauge_choices,max_choices=5,max_length=125,default=langauge_choices[0][0])
	overview = models.TextField(blank=True,null=True)
	highlights = models.TextField(null=True)
	#category = models.CharField(choices=settings.COURSE_USER_CHOICE,max_length=200,null=True)
	post_achievement = models.TextField(null= True)
	link = models.URLField(null=True,blank=True)
	course_slug = models.SlugField(blank=True)
	star = models.CharField(max_length=3,null=True)

	state = models.CharField(
		max_length=20,
		choices=[(state.name, state.value) for state in CourseState],
		default=CourseState.DRAFT.name,
		verbose_name=_("State"),
		help_text=_("Whether the course should be considered as a draft, published ."),
		blank=False,
		null=False
	)
	access = models.CharField(
		max_length=20,
		choices=[(access.name, access.value) for access in CourseAccess],
		default=CourseAccess.PUBLIC.name,
		verbose_name=_("Access"),
		help_text=_("Whether the course should be for "
					"your students or public ."),
		blank=False,
		null=False
	)

	registration_enabled = models.BooleanField(
		default=False,
		verbose_name=_("Registration enabled"),
		help_text=_("Whether users are authorised to register or unregister from this course")
	)

	
	course_tag =  TaggableManager() 

	class Meta:
		ordering=['id']

	def change_view(self):
		self.total_view+=1

	def get_view(self):
		return self.total_view

	def get_course_org_id(self):
		all_org=self.organization_set.all()
		if len(all_org) > 0:
			return all_org[0]
		return None


	def get_course_student(self):
		self.students.all()

	def assign_course(self):
		self.pk=None
		self.save()
		all_topic = self.course_topic.all()
		for topic in all_topic:
			all_video=topic.topic_content.all()
			all_activity = topic.activity_content.all()
			for video in all_video:
				video.pk=None
				video.save()


			for activity in all_activity:
				activity.pk=None
				activity.save()


	def get_total_lession_and_duration(self):
		import math
		all_topic = self.course_topic.all()
		#print(all_topic)
		all_lession=0
		total_duration=0
		total_minute =0
		total_second=0
		for topic in all_topic:
			for sub in topic.get_all_subtopic():
				all_lession+=sub.topic_content.all().count()
				for c in sub.topic_content.all():
					if c.duration is not None:
						total_duration+=int(float(c.duration))
						# minseclist=c.duration.split(",")
						# if len(minseclist) > 1:
						# 	#second exists
						# 	total_duration+=int(minseclist[1])
						# else:
						# 	total_duration+=int(minseclist[0])*60
			all_lession=all_lession+topic.topic_content.all().count()
			for c in topic.topic_content.all():
				if c.duration is not None:
					total_duration+=int(float(c.duration))
		return all_lession,total_duration
		
	def __unicode__(self):
		return self.name

	def __str__(self):
		return self.name

course_creation_choices = (('for organization','for organization'),('for end user','for end user'))

class Courses(models.Model):
	""" Model for creating Courses """
	creation_for = models.CharField(max_length=30,choices=course_creation_choices,default=course_creation_choices[0][0])
	name = models.CharField(max_length=255)
	about = models.CharField(max_length=255)
	start_date = models.DateTimeField(default=timezone.now)
	end_date = models.DateTimeField(null=True)
	organization = models.ForeignKey(Organization,on_delete=models.CASCADE,null=True,related_name='organization_courses')
	author = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE)
	thumbnail = models.ImageField(upload_to='course_images/',default=None)
	type = models.CharField(max_length=10,choices=course_choices,blank=False,default=course_choices[0][0])
	#duration = models.CharField(max_length=20,default=None)
	teacher = models.ForeignKey(UserInformation,default=None,null=True,blank=True,on_delete=models.CASCADE)
	#language = models.ForeignKey(Language,on_delete=models.CASCADE)
	courses_category = models.ForeignKey(Categories,related_name='courses_categories',null=True,on_delete=models.CASCADE)
	self_enrollment = models.BooleanField(default=True,null=True)
	is_trial=models.BooleanField(default=False)
	objects=CoursesManager()

	students = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='students')
	requests = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='requests')
	rejected = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='rejected')
	#total_view = models.IntegerField(default=0)
	#web = models.BooleanField(default=True)
	#mobile = models.BooleanField(default=False)
	#price = models.FloatField(default=0)
	#discount_price = models.FloatField(blank=True, null=True)
	#duration = models.CharField(max_length=125,blank=True,null=True,help_text="In minutes")
	#slug = models.SlugField(unique=True)
	#category_detail = models.ManyToManyField()
	@property
	def get_course_type(self):
		return self.type

	class Meta:
		ordering = ('id',)

	def __str__(self):
		return self.name

	def enroll(self, was_rejected, *users):
		self.students.add(*users)
		if not was_rejected:
			self.requests.remove(*users)
		else:
			self.rejected.remove(*users)

	def get_enrolled(self):
		return self.students.all()

	def reject(self, was_enrolled, *users):
		self.rejected.add(*users)
		if not was_enrolled:
			self.requests.remove(*users)
		else:
			self.students.remove(*users)

	def get_rejected(self):
		return self.rejected.all()

	def is_enrolled(self, user):
		return user in self.students.all()

	def course_topic_content_duplicate(self,newly_course):
		all_topic=self.course_topic.all()
		temp={}
		for topic in all_topic:
			if topic.topic_type=="topic":
				all_content=topic.topic_content.all()
				new_topic=Topic.objects.create(name=topic.name,about=topic.about,
							course_id=newly_course.id,author=topic.author,
							thumbnail=topic.thumbnail,end_date=topic.end_date,duration=topic.duration,topic_type=topic.topic_type)
				print('new topic id ', new_topic.id)
				temp[topic.id]=new_topic.id
				if len(all_content) > 0:
					
					for content in all_content:
						print('content is',content)
						content.id=None
						content.topic=None
						topic.id=None
						topic.course_id=self.id
						# Topic Hirerchy for subtopic 
						#tr=TopicRelation.objects.create(topic_father_id=None,topic_id_id=new_topic.id)
						#print('tr is',tr)
						cv=ContentVideo.objects.create(video=content.video,description=content.description,
							topic_id=new_topic.id,end_date=content.end_date)

						print(cv)
						
						#print(content.about)
						#content.save()
				# else:
				#   print("insi")
				#   new_topic=Topic.objects.create(name=topic.name,about=topic.about,
				#           course_id=newly_course.id,author=topic.author,
				#           thumbnail=topic.thumbnail,end_date=topic.end_date,duration=topic.duration,topic_type=topic.topic_type)
				#   temp[topic.id] = new_topic.id
					#print(new_topic)
						# Topic Hirerchy for subtopic 
					#TopicRelation.objects.create(topic_father_id=None,topic_id_id=new_topic.id)
			else:
				print("inside subtopic")
				all_content=topic.topic_content.all()
				new_topic=Topic(name=topic.name,about=topic.about,
							course_id=newly_course.id,author=topic.author,
							thumbnail=topic.thumbnail,end_date=topic.end_date,duration=topic.duration,topic_type=topic.topic_type)
					
				#temp[topic.id] = new_topic.id
				print(temp)
				topic_father_old = TopicRelation.objects.get(topic_id_id=topic.id)
				topic_new_father_id=temp[topic_father_old.topic_father_id]
				#print('topic_father is ',topic_father)
				new_topic._topicid = topic_new_father_id
				new_topic.save()
				if len(all_content) > 0:
					for content in all_content:

						
						#TopicRelation.objects.create(topic_father_id=None,topic_id=new_topic.id)
						#content.topic=new_topic
						#content.save()
						cv=ContentVideo.objects.create(video=content.video,description=content.description,
							topic_id=new_topic.id,end_date=content.end_date)
						

				# else:
					# print("without content")
					
					# # new_topic=Topic(name=topic.name,about=topic.about,
					# #         course_id=newly_course.id,author=topic.author,
					# #         thumbnail=topic.thumbnail,end_date=topic.end_date,duration=topic.duration,topic_type=topic.topic_type)
					
					
					# print('new_topic',new_topic)
					#TopicRelation.objects.create(topic_father_id=topic_father.topic_father_id,topic_id_id=new_topic.id)

			

			#topic.topic_content.all()
			#topic.save()
	def course_content_duplicate(self):
		pass
		#all_content = self.content

#spin activity

question_choices =(('radio','radio'),('checkboxes','checkboxes'),('text','text'))

class Question(DateTimeModel):
	question_name= models.CharField(max_length=255,unique=True)
	question_language = models.ForeignKey(Language,on_delete=models.CASCADE)
	question_type =models.CharField(choices=question_choices,max_length=20)
	option_a = models.CharField(max_length=200)
	option_b = models.CharField(max_length=200)
	option_c = models.CharField(max_length=200)
	option_d = models.CharField(max_length=200)
	answer_option = models.CharField(max_length=1)
	answer_text = models.CharField(max_length=225)
	author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)

	def __str__(self):
		return self.question_name



class TopicDetails(models.Model):
	questions=models.ManyToManyField(Question,related_name='topic_questions')
	topic_name=models.CharField(max_length=125)

	def __str__(self):
		return self.topic_name

	def get_all_question(self):
		return self.topic_questions.all()

	def insert_question(self,**question_details):
		try:
			q=Question.objects.create(**question_details)
		except:
			print("problem exists")

#from userlms.views import open_next

class Topic(DateTimeModel):
	#types = models.CharField(max_length=10,choices=course_choices,blank=False,default=course_choices[0][1])
	#id = models.BigAutoField(primary_key=True)
	name = models.CharField(max_length=255)
	about = models.CharField(max_length=255,default = None)
	course = models.ForeignKey(CoursesEndUser,on_delete=models.CASCADE ,related_name='course_topic',default= None,null=True)
	author = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE,default= None)
	#thumbnail = models.ImageField(upload_to='topic_images/',default=None)
	#duration = models.CharField(max_length=20,default=None,null=True)
	topic_type = models.CharField(max_length=10,choices=topic_choices,blank=False,default=topic_choices[0][0])
	ordering = models.PositiveIntegerField(null=True)
	end_date = models.DateField(null=True)

	class Meta:
		ordering = ('id',)
		unique_together=(('name','course'))

	def __str__(self):
		return self.name

	def next_video_of_topic(self,videoid):
		all_video=list(self.topic_content.all().order_by('id'))
		for video in all_video:
			if TopicWiseAnswerpaper.objects.filter(content_video_id=video.id,is_open=1,
				is_completed=1).exists():
				#print("esissiis")
				all_video.remove(video)
		print('all non completed video of topic',all_video)
		print(videoid)
		print('all content video list',all_video)
		if videoid is not None:
			try:
				#sprint(ContentVideo.objects.get(id=videoid))
				if len(all_video) < 1:
					return None
				cv=ContentVideo.objects.get(id=videoid)
				if cv in all_video:
					index=all_video.index(cv)
					return all_video[index+1]
				else:
					return all_video[0]
			except IndexError :
				return None
		else:
			try:
				return all_video[0]
			except IndexError :
				return None




	def get_all_subtopic(self):
		if self.topic_type=="topic":
			trl=TopicRelation.objects.filter(topic_father=self).order_by('id')
			all_subtopic=[]
			for tr in trl:
				all_subtopic.append(Topic.objects.get(id=tr.topic_id_id))
			return all_subtopic

	def get_next_subtopic(self,subtopicid=None):
		all_subtopic=self.get_all_subtopic()
		try:
			if subtopicid is None:
				return all_subtopic[0]
			index=all_subtopic.index(subtopicid)
			return all_subtopic[index+1]
		except IndexError:
			return None

	def get_next_topic(self,userid):
		# if self.topic_type=="subtopic":
		# 	tr=TopicRelation.objects.get(topic_id=self)
		# 	#all_subtopic=tr.topic_father.get_all_subtopic()
		# 	#if len(all_subtopic) > 0:
		# 	next_subtopic=tr.topic_father.get_next_subtopic(subtopicid=self)
		# 	if next_subtopic is None:
		# 		print("next subtopic is none , will open another topic")
		# 		return tr.topic_father.get_next_topic(userid)
		# 	print("next subtopic is ",next_subtopic)
		# 	return next_subtopic
		# else:
		try:
			all_topic=list(Topic.objects.filter(course=self.course,topic_type="topic").order_by('id'))
			index=all_topic.index(self)
			return all_topic[index+1]
		except IndexError:
			return None

	# def open_next(user,topic,video):
	# 	if topic is not None:
	# 		t=Topic.objects.get(id=topic)
	# 		print(t.name)
	# 		if t.topic_type=="subtopic":
	# 			tr=TopicRelation.objects.get(topic_id=t)
	# 			course=tr.topic_father.course
	# 		else:
	# 			course=t.course
	# 		next_video=t.next_video_of_topic(video)
	# 		print("next video",next_video)
	# 		if next_video is not None:
	# 			tws=TopicWiseAnswerpaper.objects.filter(topic=t,course=course,is_open=1,
	# 				user=user,content_video_id=next_video.id)
	# 			if len(tws) < 1:
	# 				TopicWiseAnswerpaper.objects.create(topic=t,course=course,is_completed=0,is_open=1,
	# 					user=user,content_video_id=next_video.id)
	# 			js={'video':next_video}
	# 			return js
	# 		else:
	# 			tw=TopicWiseAnswerpaper.objects.filter(Q(topic=t) & Q(is_completed=1)& Q(user=user) & ~Q(activity_id=None)).order_by('-id')
	# 			#print(tw)
	# 			if len(tw) > 0:
	# 				activity_id=tw[0].activity_id
	# 				next_learning=t.remaining_learning_unit(user,activityid=activity_id)
	# 			else:
	# 				next_learning=t.remaining_learning_unit(user)
	# 			#print(next_learning.content_id)
	# 				if next_learning is not None:
	# 					tw=TopicWiseAnswerpaper.objects.filter(topic=t,course=course,is_open=1,
	# 					user=user,activity_id=next_learning.id)
	# 					if len(tw) < 1:
	# 						TopicWiseAnswerpaper.objects.create(topic=t,course=course,is_open=1,
	# 						user=user,is_completed=0,activity_id=next_learning.id)
	# 					return HttpResponse({"activity":next_learning.id})
	# 				else:
	# 					next_topic=t.get_next_topic(user.id)
	# 					#print(next_topic.id)
	# 					all_subtopic=[]
	# 					if next_topic is not None:
	# 						all_subtopic=next_topic.get_all_subtopic()
	# 						print(all_subtopic)
	# 					if len(all_subtopic) > 0:
	# 						first_learning_unit=all_subtopic[0].remaining_learning_unit(user)

	# 					if not TopicWiseAnswerpaper.objects.filter(user=user,topic=all_subtopic[0],
	# 						course=next_topic.course,is_open=1,is_completed=0).exists():
	# 						TopicWiseAnswerpaper.objects.update_or_create(user=user,topic=all_subtopic[0],
	# 						course=next_topic.course,is_open=1,is_completed=0)
	# 						TopicWiseAnswerpaper.objects.update_or_create(user=user,topic=next_topic,
	# 						course=next_topic.course,is_open=1,is_completed=0)
	# 					else:
	# 						print("already open",next_topic.name)
	# 					if not TopicWiseAnswerpaper.objects.filter(user=user,topic=all_subtopic[0],
	# 						course=next_topic.course,is_open=1,activity=first_learning_unit,is_completed=0).exists():
	# 						TopicWiseAnswerpaper.objects.update_or_create(user=user,topic=all_subtopic[0],
	# 						course=next_topic.course,is_open=1,activity=first_learning_unit,is_completed=0)
	# 					#print(all_subtopic[0])
	# 				#all_subtopic[0].open_first_activity_of_topic(user)
	# 			else:
	# 				open_next(user,next_topic,None)
	#from userlms.views import open_next


	def open_first_activity_of_subtopic(self,user):
		tr=TopicRelation.objects.get(topic_id=self)
		all_ac=Activities.objects.filter(topic=self)
		if len(all_ac) > 0:
			#print("found activites .....")
			tws=TopicWiseAnswerpaper.objects.filter(course=tr.topic_father.course,topic=self,
				is_open=1,user=user,activity=all_ac[0])
			if len(tws) > 0:
				print("here here herer ehhe")
			# TopicWiseAnswerpaper.objects.update_or_create(course=tr.topic_father.course,topic=self,
			# 	is_open=1,is_completed=0,user=user,activity=all_ac[0])
				return all_ac[0]
			else:
				TopicWiseAnswerpaper.objects.create(course=tr.topic_father.course,topic=self,
					is_open=1,is_completed=0,user=user,activity=all_ac[0])
				return all_ac[0]
		return None



	def open_first_activity_of_topic(self,user):
		#tr=TopicRelation.objects.get(topic_id=self)
		if self.topic_type=="subtopic":
			#for video
			self.open_first_activity_of_subtopic(user)

		else:
			all_ac=Activities.objects.filter(topic=self)
			if len(all_ac) > 0:
				if not TopicWiseAnswerpaper.objects.filter(course=self.course,topic=self,
					user=user,activity=all_ac[0],is_open=1).exists():
					TopicWiseAnswerpaper.objects.create(course=self.course,topic=self,
					user=user,activity=all_ac[0],is_open=1)
				return all_ac[0]
			else:
				all_subtopic=self.get_all_subtopic()
				if len(all_subtopic) > 0:
					if not TopicWiseAnswerpaper.objects.filter(course=self.course,topic=all_subtopic[0],
						is_open=1,user=user).exists():
						TopicWiseAnswerpaper.objects.create(course=self.course,topic=all_subtopic[0],
							is_open=1,user=user)
					return all_subtopic[0].open_first_activity_of_subtopic(user)

			# tr=TopicRelation.objects.get(topic_id=self)
			# try:
			# 	all_video=list(self.topic_content.all().order_by('id'))
			# 	all_activity=list(self.activity_topic.all().order_by('id'))
			# 	if len(all_video) > 0:
			# 		video=all_video[0]
			# 		if video is not None:
			# 			print("first acttivity video f v")
			# 			TopicWiseAnswerpaper.objects.get_or_create(course=tr.topic_father.course,
			# 				topic=self,is_open=1,is_completed=0,user=user,content_video=video)
					
			# 	elif len(all_activity) > 0:
			# 			activity=all_activity[0]
			# 			TopicWiseAnswerpaper.objects.get_or_create(course=tr.topic_father.course,
			# 				topic=self,is_open=1,is_completed=0,user=user,activity=activity)
			# 	else:
			# 		next_topic=self.get_next_topic(user)
			# 		if next_topic.topic_type == "topic":
			# 			if len(next_topic.topic_content.all()) > 0:
			# 				all_v=next_topic.topic_content.all()

			# 				tws=TopicWiseAnswerpaper.objects.filter(topic=next_topic,
			# 					user=user,content_video=all_v[0],course=next_topic.course,is_open=1)
			# 				if len(tws) < 1:
			# 					TopicWiseAnswerpaper.objects.create(topic=next_topic,
			# 					user=user,content_video=all_v[0],course=next_topic.course,is_open=1)
			# 			else:
			# 				# get subtopic
			# 				trss=TopicRelation.objects.filter(topic_father=next_topic)
			# 				if len(trss) > 0:
			# 					TopicWiseAnswerpaper.objects.get_or_create(topic=trss[0].topic_id,
			# 						user=user,is_open=1,course=next_topic.course)

			# 					trss[0].topic_id.open_first_activity_of_topic(user)
							#next_topic.
							
					#open_next(user,self.get_next_topic,None)

			#except IndexError:
				#print("index error in open_first_activtiy of subtopic")
			#return None


	def remaining_learning_unit(self,user,activityid=None):
		try:
			all_activity=list(self.activity_topic.all().order_by('id'))
			#print('checking all learning unit',all_activity)
			#print(all_activity)
			if activityid is None:
				if len(all_activity) > 0:
					return all_activity[0]
				return None
			else:
				index=all_activity.index(Activities.objects.get(id=activityid))
				return all_activity[index+1]
		except IndexError:
			return None

	def get_all_video(self):
		return self.topic_content.all()

class TopicRelation(models.Model):
	topic_id=models.OneToOneField(Topic,unique=True,on_delete=models.CASCADE)
	topic_father=models.ForeignKey(Topic,on_delete=models.CASCADE,null=True,related_name='topic_father')


class ActivityType(DateTimeModel):
	name = models.CharField(max_length=225,unique=True)
	thumbnail = models.ImageField(null=True,upload_to='categories_file')
	author = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.SET_NULL,null=True)

	def __str__(self):
		return self.name


class Activities(DateTimeModel):
	author = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE)
	activity_type = models.CharField(max_length=50,choices=choice_activity_type,null=False)
	#activity_type = models.ForeignKey(ActivityType,on_delete=models.CASCADE)
	#activity_type = models.CharField(max_length=255,choices=choice_activity_type)
	activity_name = models.CharField(max_length =255)
	course = models.ForeignKey(CoursesEndUser, on_delete= models.CASCADE,null=True)
	topic = models.ForeignKey(Topic,null=True,on_delete=models.CASCADE,related_name='activity_topic')
	organization = models.ForeignKey(Organization,null=True,on_delete=models.CASCADE)
	content_id = models.CharField(max_length=20,null=True)

	class Meta:
		ordering =('id',)

	def __str__(self):
		return self.topic.name


# add many activity----    ===== add activity(ajay)
class SpinActivity(DateTimeModel):
	name=models.CharField(max_length=125)
	no_of_topic = models.IntegerField()
	activity = models.ForeignKey(Activities,on_delete=models.CASCADE,null=True)
	#question_per_slices=models.IntegerField()
	block_slice_after_open=models.BooleanField(default=False)
	topic_details = models.ManyToManyField(TopicDetails,related_name='topic_details')

#assigementactivity code
class AssignmentActivity(models.Model):
	name = models.CharField(max_length=120,default=None)
	description = models.CharField(max_length=125)
	activity = models.ForeignKey(Activities,on_delete=models.CASCADE)
	question_file = models.FileField(upload_to='assignment_file/')
	# answer_file = models.FileField(upload_to='assignment_file/')
	no_of_submission = models.CharField(max_length=2,
		help_text='how many time user can submit assignment')
	last_date = models.DateTimeField(default=timezone.now)	
	created_at = models.DateTimeField(default=timezone.now)
	status = models.BooleanField(default=False)

# urlactivity code 
class UrlActivity(models.Model):
	name = models.CharField(max_length=120)
	description = models.CharField(max_length=125)
	activity = models.ForeignKey(Activities,on_delete=models.CASCADE,null=True)
	img = models.ImageField(upload_to="urlactivityimage/")
	website = models.URLField(max_length=255 )

# PPT activity code 
class PPTActivity(models.Model):
	name = models.CharField(max_length=120)
	description = models.CharField(max_length=120)
	activity = models.ForeignKey(Activities,on_delete=models.CASCADE, null=True)
	pptfile = models.FileField(upload_to="pptactivity/")

# pdfactivity code 
class PDFActivity(models.Model):
	name = models.CharField(max_length=120)
	description = models.CharField(max_length=120)
	activity = models.ForeignKey(Activities,on_delete=models.CASCADE,null = True)
	pdffile = models.FileField(upload_to="pdfactivity/")

# new pdf activity working code
class PDFFActivity(models.Model):
	name = models.CharField(max_length=120)
	description = models.CharField(max_length=120)
	activity = models.ForeignKey(Activities,on_delete=models.CASCADE,null = True)
	pdffile = models.FileField(upload_to="pdfactivity/")




# doc activity code 
class DocActivity(models.Model):
	name =models.CharField(max_length=120)
	description = models.CharField(max_length=120)
	activity = models.ForeignKey(Activities,on_delete=models.CASCADE,null = True)
	docfile = models.FileField(upload_to="docfile/")















	


class AssignmentAnswer(models.Model):
	answer_file = models.FileField(upload_to ='assignment_file/')
	answer_file1 = models.FileField(upload_to ='assignment_file/',null=True)
	answer_file2 = models.FileField(upload_to = 'assignment_file/',null=True)
	activity = models.ForeignKey(AssignmentActivity,null=True,on_delete=models.SET_NULL)
	answer_date = models.DateTimeField(default=timezone.now)
	user = models.ForeignKey(settings.AUTH_USER_MODEL,null=True,on_delete=models.SET_NULL)
	grade=models.CharField(max_length=5)
	submission = models.CharField(max_length=2,default=0,
		help_text='how many time user has submitted assignment')


class SpinActivityEnroll(models.Model):
	enroll_date = models.DateTimeField(default=timezone.now)
	candidate = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE,null=False)
	spinactivity = models.ForeignKey(SpinActivity,on_delete=models.CASCADE,null=False)

	class Meta:
		unique_together =(('candidate','spinactivity'),)


class SpinActivityAnswer(models.Model):
	question=models.ForeignKey(Question,on_delete=models.CASCADE)
	answer_option = models.TextField(max_length=125)
	spinactivity = models.ForeignKey(SpinActivity,on_delete=models.CASCADE)


#courses=models.ForeignKey(Courses,on_delete=models.CASCADE)
#class SubCategories(models.Model):
#name=models.CharField(max_length=125)
#category_details=models.ForeignKey(Categories,on_delete=models.CASCADE,related_name='subcategories')

# class CourseSubCategory(models.Model):
#    coursecategory=models.ForeignKey(CourseCategory,on_delete=models.CASCADE)
#     courses=models.ForeignKey(CourseCategory,on_delete=models.CASCADE)

class DragDropActivity(DateTimeModel):
	"""docstring for DragDropActivityPivot"""
	name = models.CharField(max_length=300)
	settings_data = models.JSONField()
	#dda = models.ForeignKey(DragDropActivity,on_delete=models.CASCADE)
	activity = models.ForeignKey(Activities,on_delete=models.CASCADE,related_name='dd')

	def __unicode__(self):
		return self.dda

class DragDropActivityElements(DateTimeModel):
	label = models.CharField(max_length=300)
	dd_activity = models.ForeignKey(DragDropActivity,on_delete=models.CASCADE,related_name='dd_element')
	settings_data = models.JSONField()

	def __str__(self):
		return self.label

class DragDropActivityAnswers(DateTimeModel):
	#userid= models.ForeignKey(DragDropActivity,on_delete=models.CASCADE)
	dd_activity= models.ForeignKey(DragDropActivity,on_delete=models.CASCADE)
	answer_data = models.JSONField()
	grade = models.CharField(max_length=100)

	def __str__(self):
		return self.label


class ContentVideo(DateTimeModel):
	topic=models.ForeignKey(Topic,on_delete=models.CASCADE,null=True,related_name='topic_content')
	#subtopic=models.ForeignKey(SubTopic,on_delete=models.CASCADE,null=True,related_name='subtopic_content')
	video=models.FileField(upload_to='course_video/')
	thumbnail = models.ImageField(upload_to='course_video_thumbnail',null=True)
	description=models.CharField(max_length=225)
	course = models.ForeignKey(CoursesEndUser,on_delete=models.CASCADE,null=True)
	organization = models.ForeignKey(Organization,on_delete=models.CASCADE,null=True)
	language = models.ForeignKey(Language,null=True,on_delete=models.CASCADE)
	duration = models.CharField(max_length=10,null=True)


class TopicWiseAnswerpaper(models.Model):
	course = models.ForeignKey(CoursesEndUser,on_delete=models.CASCADE,)
	topic=models.ForeignKey(Topic,on_delete=models.CASCADE)
	activity = models.ForeignKey(Activities,on_delete=models.CASCADE,null=True)
	content_video= models.ForeignKey(ContentVideo,on_delete=models.CASCADE,null=True)
	user = models.ForeignKey(User,on_delete=models.CASCADE)
	date_registered = models.DateTimeField(default=timezone.now)
	is_completed = models.BooleanField(default=False)
	is_open = models.BooleanField(default=False)
	content_video_length= models.CharField(max_length=123)
	#completion_percentage = models.CharField(max_length=2)

	class Meta:
		unique_together=(('user','activity'))


class CourseEnroll(models.Model):
	course = models.ForeignKey(CoursesEndUser,on_delete=models.CASCADE)
	#topic = models.ForeignKey(Topic,on_delete=models.CASCADE,null=True)
	#activity = models.ForeignKey(Activities,on_delete=models.CASCADE,null=True)
	user = models.ForeignKey(User,on_delete=models.CASCADE)
	date_registered = models.DateTimeField(default=timezone.now)
	is_completed = models.BooleanField(default=False)
	#activity_completion = models.CharField(max_length=125,null=True)
	#is_open= models.BooleanField(default=False,null=True)
	class Meta:
		#unique_together=('user','course')
		constraints = [
			models.UniqueConstraint(fields=['user', 'course'], name='one time enroll for user')
		]

	def total_user_enrolled(self):
		return self.user.all()

	def create_topic_answerpaper(self,courseid,userid):
		from .views import all_available_topic_and_subtopic
		#all_topics=all_available_topic_and_subtopic(courseid=courseid)

		c=CoursesEndUser.objects.get(id=courseid)
		all_topics=c.course_topic.all()
		if len(all_topics) > 0:
			user=get_user_model().objects.get(id=userid)
			# open first activity or its first subtopic activity,also this method automatically open topic
			# t,created = TopicWiseAnswerpaper.objects.get_or_create(course_id=courseid,
			# 	topic=all_topics[0],user_id=userid)
			ts = TopicWiseAnswerpaper.objects.filter(Q(course_id=courseid),
				Q(topic=all_topics[0]),Q(user_id=userid),Q(activity=None))
			if len(ts) > 0:
				pass
			#if created:	
				#t=ts[0]
				#t.is_open=True
				#t.is_completed=False
				#t.save()
			else:
				TopicWiseAnswerpaper.objects.create(course_id=courseid,topic=all_topics[0],user_id=userid,is_open=1)
			is_ac = all_topics[0].open_first_activity_of_topic(user)
			if is_ac is None:
				all_subtopic=all_topics[0].get_all_subtopic()
				if len(all_subtopic) > 0:
					tt,created=TopicWiseAnswerpaper.objects.get_or_create(course_id=courseid,topic=all_subtopic[0],
						user_id=userid)
					if created:
						tt.is_completed=False
						tt.is_open=True
						tt.save()
					all_subtopic[0].open_first_activity_of_subtopic(user)
		
		''' last chnaged '''
		#print("inside",all_topics)
		# i=0;
		# if len(all_topics.items()) > 0:
		# 	tup=list(all_topics.items())[0]
		# 	topic,subtopicdir=tup[0],tup[1]

		# #for topic,subtopicdir in all_topics.items():
		# 	tw=TopicWiseAnswerpaper.objects.filter(course_id=courseid,topic=topic,is_open=1,is_completed=0,user_id=userid)
		# 	if len(tw) > 1:
		# 		pass
		# 	else:
		# 		tw=TopicWiseAnswerpaper.objects.create(course_id=courseid,
		# 				topic=topic,
		# 				is_completed=0,is_open=1,user_id=userid)
		# 	i+=1
		# 	#topic_video = subtopicdir.get('video',None)
		# 	#print("ddd",topic_video)
		# 	#print(subtopicdir)
		# 	topic_activity = subtopicdir.get('activities',None)
		# 	#print(topic_activity)
		# 	is_video_available_of_topic=True
		# 	is_activity_available_of_topic=True

		# 	if len(topic_activity) > 0 and topic_activity is not None:
		# 		#print("herer")
		# 		if len(topic_activity) > 0:
		# 			tw_activity=TopicWiseAnswerpaper.objects.filter(Q(course_id=courseid),
		# 				Q(topic=topic),~Q(activity=None),Q(user_id=userid)).order_by('-id')
		# 			print("previous activity in paper ",tw_activity)

		# 			if len(tw_activity) > 0:
		# 				next_learning=topic.remaining_learning_unit(user=userid,activityid=tw_activity[0].activity.id)
		# 				if next_learning is not None:
		# 					TopicWiseAnswerpaper.objects.get_or_create(course_id=courseid,topic=topic,
		# 					is_completed=0,activity=next_learning,is_open=1,user_id=userid)
		# 			else:
		# 				TopicWiseAnswerpaper.objects.get_or_create(course_id=courseid,topic=topic,
		# 					is_completed=0,activity=topic_video[0],is_open=1,user_id=userid)

		# 	if len(topic_activity) < 1 or topic_activity is None:
		# 		for sub,act in subtopicdir['subtopic'].items():
		# 			all_activites=act.get('activities',False)
		# 			print(all_activites)
		# 			if all_activites:
		# 				for all_act in all_activites:
		# 				#for activity_type,all_act in act.items():
		# 						tw=TopicWiseAnswerpaper.objects.filter(course_id=courseid,topic=sub,
		# 							activity=all_act,is_open=1,user_id=userid)
		# 						if tw.count() > 0:
		# 							break
		# 						else:
		# 							TopicWiseAnswerpaper.objects.create(course_id=courseid,topic=sub,
		# 									is_completed=0,activity=all_act,is_open=1,user_id=userid)
		# 						break
		# 				break

		''' last changed '''


			# if topic_video is not None:
			# 	if len(topic_video) > 0:
			# 		tw_video=TopicWiseAnswerpaper.objects.filter(Q(course_id=courseid),
			# 			Q(topic=topic),~Q(content_video=None),Q(user_id=userid)).order_by('-id')
			# 		print("previous video in paper ",tw_video)
			# 		if tw_video.count() > 0:
			# 			next_v=topic.next_video_of_topic(tw_video[0].content_video.id)
			# 			if next_v is not None:
			# 				TopicWiseAnswerpaper.objects.get_or_create(course_id=courseid,topic=topic,
			# 				is_completed=0,content_video=next_v,is_open=1,user_id=userid)
			# 				#break
			# 			#else:
			# 				#print("ony one video in topic")
			# 				#is_video_available_of_topic=False
			# 				#break
			# 		else:
			# 			TopicWiseAnswerpaper.objects.get_or_create(course_id=courseid,topic=topic,
			# 				is_completed=0,content_video=topic_video[0],is_open=1,user_id=userid)
			# 			#break

			# if topic_activity is not None:
			# 	if len(topic_activity) > 0:
			# 		TopicWiseAnswerpaper.objects.get_or_create(course_id=courseid,topic=topic,
			# 				is_completed=0,activity=topic_activity[0],is_open=1,user_id=userid)
			# 		#break

			# if topic_video is None and topic_activity is None:
			# 	#print("checking this inside")
			# 	for sub,act in subtopicdir['subtopic'].items():
			# 		for activity_type,all_act in act.items():
			# 			if activity_type=="video":
			# 				for a in all_act:
			# 					tw=TopicWiseAnswerpaper.objects.filter(course_id=courseid,topic=sub,
			# 					content_video=a,is_open=1,user_id=userid)
			# 					if tw.count() > 0:
			# 						break
			# 					else:
			# 						TopicWiseAnswerpaper.objects.create(course_id=courseid,topic=sub,
			# 							is_completed=0,content_video=a,is_open=1,user_id=userid)
			# 					break
			# 			elif activity_type =="activity":
			# 				for a in all_act:
			# 					tw=TopicWiseAnswerpaper.objects.filter(course_id=courseid,topic=sub,activity=a,is_open=1,user_id=userid)
			# 					if tw.count() > 0:
			# 						break
			# 					else:
			# 						TopicWiseAnswerpaper.objects.create(course_id=courseid,topic=sub,
			# 							is_completed=0,activity=a,is_open=1,user_id=userid)
			# 					break
			# 			else:
			# 				pass
			# 		break
				#break
		#return all_topics
		#print(list(all_topics.items))
		#TopicWiseAnswerpaper.objects.create(course=self,)


class LanguageCourse(models.Model):
	lang = models.ForeignKey(Language, on_delete=models.CASCADE)
	course = models.ForeignKey(Courses, on_delete=models.CASCADE)


# class Activity(DateTimeModel):  
#     activity_type = models.ForeignKey(AcitivityCategory,on_delete=models.CASCADE)
#     #organization = models.ForeignKey(Organization , on_delete=models.CASCADE)
#     #course = models.ForeignKey(Courses, on_delete= models.CASCADE)
#     class Meta:
#         abstract = True



class PdfActivity():

	pdf_file = models.FileField(upload_to='pdf_activity/')
	#topic = models.ForeignKey(Topic,on_delete=models.CASCADE,related_name='pdfactivity_topic')
	activity_id=models.ForeignKey(Activities,on_delete=models.CASCADE)



class Answer(models.Model):
	answer=models.CharField(max_length=225)
	question = models.ForeignKey(Question,on_delete=models.CASCADE)


#class QuestionActivity(Activity):
class QuestionActivity():
	question = models.ForeignKey(Question,on_delete=models.CASCADE)
	activity_id=models.ForeignKey(Activities,on_delete=models.CASCADE)
	#topic = models.ForeignKey(Topic,on_delete=models.CASCADE,related_name='questionactivity_topic')


class ChatActivity(models.Model):
	max_user = models.CharField(max_length=225)
	activity_id=models.ForeignKey(Activities,on_delete=models.CASCADE)
	room = models.CharField(max_length=225,unique=True)


class FileActivity(models.Model):
	file=models.FileField(upload_to='file_activity/')
	activity_id=models.ForeignKey(Activities,on_delete=models.CASCADE)
	description = models.CharField(max_length=125)



class PersonInRoom(models.Model):
	user_id = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE)
	chat = models.ForeignKey(ChatActivity,on_delete=models.CASCADE)
	layer_id = models.CharField(max_length=225)



class SessionActivity(models.Model):
	#activity_id=models.ForeignKey(ActivityCategory,on_delete=models.CASCADE)
	course=models.ForeignKey(CoursesEndUser,on_delete=models.SET_NULL,null=True,related_name='course_session')
	organization = models.ForeignKey(Organization,on_delete=models.SET_NULL,null=True,related_name='org_session')
	topic=models.CharField(max_length=125,blank=False,null=True)
	description = models.TextField()
	duration = models.CharField(max_length=10,help_text='in minutes')
	#teacher = models.ForeignKey(UserInformation,null=True,on_delete=models.SET_NULL)
	teacher = models.ForeignKey(get_user_model(),related_name='session_teacher',null=True,on_delete=models.SET_NULL)
	auto_attendence = models.BooleanField(default=False)
	photo_attendence = models.BooleanField(default=True)
	record_session = models.BooleanField(default=False)
	enable_private_chat = models.BooleanField(default=False)
	enable_group_chat = models.BooleanField(default=False)
	raise_query = models.BooleanField(default=False)
	download_record_session_video= models.BooleanField(default=False)
	download_session_resource = models.BooleanField(default=False)
	capture_photo_after_every= models.CharField(max_length=5)
	author = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE,null=True)
	start_date = models.DateField(default=timezone.now,null=False)
	mute_participant_upon_entry = models.BooleanField(default=False)
	record_session_visibility_to_students=models.BooleanField(default=False)
	display_description=models.BooleanField(default=False)
	session_room_id=models.CharField(max_length=125,unique=True,null=True)


class SubTopic(DateTimeModel):
	name = models.CharField(max_length=125)
	about = models.CharField(max_length=125)
	topic = models.ForeignKey(Topic,on_delete=models.CASCADE,related_name='topic_subtopic')
	duration = models.DurationField()
	author = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE)


class classroom(models.Model):
	user = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE)
	sessionactivity=models.ForeignKey(SessionActivity,on_delete=models.CASCADE)
	#room_id=models.CharField(unique=True,max_length=125)
	

#class VideoContent(models.Model):
import django_filters

# add activity to courses directly , or topic 

class ActivityAdding(DateTimeModel):
	#activity_id= models.ForeignKey(Acitivity,on_delete=models.CASCADE)
	course_id= models.ForeignKey(Courses,on_delete=models.CASCADE)
	topic_id = models.ForeignKey(Topic,on_delete=models.CASCADE)

	def __unicode__(self):
		return self.course_id


############################ group #############
from django.contrib.auth.models import Group
Group.add_to_class('u_id',models.CharField(max_length=120,default=None,null = True))
Group.add_to_class('org',models.ForeignKey(Organization,on_delete=models.CASCADE,default=None,null = True))



# class ProductFilter(django_filters.FilterSet):
#     class Meta:
#         model = UserInformation
#         fields = {
#             'position': ['lt', 'gt'], 
#             'release_date': ['exact', 'year__gt'],
#         }

# class QuestionActivity(Activity):
#     question = models.ForeignKey(Question,on_delete=models.CASCADE,related_name='question')
# class QuestionActivity(Activity):
#     question_name = models.CharField(max_length=100)


	#course_id = models.ForeignKey(Courses,on_delete=models.CASCADE,related_name='course_topic')


# class SubTopic(DateTimeModel):
#     name=models.Model(max_length=255)
#     course = models.ForeignKey(Courses,on_delete=models.CASCADE)
#     description = models.CharField(max_lemgth=255)
#     thumbnail=models.



#celery for verifying emails and user
#for task management


class UserGrade(models.Model):
	grade = models.CharField(max_length=125)
	user = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, on_delete=models.SET_NULL)




# this is college model
class College(models.Model):
	organization = models.ForeignKey(Organization,on_delete=models.CASCADE,null=True)
	user = models.ForeignKey(settings.AUTH_USER_MODEL,null=True,on_delete=models.CASCADE)
	clg_name = models.CharField(max_length=100)
	website = models.URLField(max_length=255,unique=True )
	address = models.TextField()
	pin = models.CharField(max_length=10,null=True)
	start_date = models.DateField(default=timezone.now)
	no_of_candidates = models.IntegerField(blank=True,null=True)
	logo = models.ImageField(upload_to='college_logo/')
	logo1 = models.ImageField(upload_to='college_logo/',null=True)
	show_second_logo = models.BooleanField(default=False)
	contact_person_name = models.CharField(max_length=225,null=True)
	contact_person_email = models.EmailField(unique=True)
	contact_person_phone = models.CharField(max_length=10,unique=True)
	password = models.CharField(max_length=256)
	sector_type= models.CharField(choices=sector_type,
		max_length=125,default=sector_type[0][0])
	city = models.ForeignKey(City,on_delete=models.CASCADE,null=True)
	country = models.ForeignKey(Country,on_delete=models.CASCADE,null=True)
	state = models.ForeignKey(State,on_delete=models.CASCADE,null=True)
	certificate = models.TextField(null=True)

	def __str__(self):
		return self.clg_name
	














