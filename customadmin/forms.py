from django import forms
from custompermission.models import Perm
#from django.contrib.auth.models import User
from django.db.models import Q
from django.core.validators import MinLengthValidator
from django.core.exceptions import ValidationError
from django.contrib.auth.hashers import make_password
from organization.models import UserInformation
from customadmin.models import City,State
import re

from .models import (SessionActivity,SubTopic,Topic,ContentVideo,
	Courses,Topic,Language,Activities,Organization,CourseEnroll,
	Categories,CategoriesHirerchy,SpinActivity,TopicDetails,Question,City,Country,State)
from datetime import datetime
from django.utils import timezone

from .managers import LanguageManager
from django.utils import timezone

from django.contrib.auth.models import Group
from django.contrib.admin.widgets import FilteredSelectMultiple
from custompermission.models import Perm
from django.db.models import Q
from django.forms import ValidationError, TextInput, Select , Form
from django.conf import settings
from accounts.models import User
from django.contrib.auth import get_user_model
#User=settings.AUTH_USER_MODEL 

class CustomFormMixin(Form):
	custom_classes = ["form-control"]

	def __init__(self, *args, **kwargs):
		super(CustomClassesOnFormMixin, self).__init__(*args, **kwargs)
		for field in self.fields.values():
			if isinstance(field.widget, Select):
				field.widget.attrs.update({"class": "custom-select"})
			else:
				field.widget.attrs.update({"class": "form-control"})

	def clean(self):
		if not self.has_error(NON_FIELD_ERRORS):
			for field_name, field in self.fields.items():
				current_class = field.widget.attrs.get("class", str())
				if field_name in self.errors.as_data():
					field.widget.attrs.update({"class": current_class + " " + "is-invalid"})
				elif field_name in self.changed_data:
					field.widget.attrs.update({"class": current_class + " " + "is-valid"})


from.models import AssignmentActivity,DragDropActivity,DragDropActivityElements
from upload_validator import FileTypeValidator

allowed_types=['application/msword',
'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
'application/pdf','application/vnd.ms-powerpoint',
'application/vnd.openxmlformats-officedocument.presentationml.presentation',
'application/vnd.ms-excel',
'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet']


class DragForm(forms.ModelForm):
	class Meta:
		model = DragDropActivity
		fields=('__all__')

class DragElementForm(forms.ModelForm):
	class Meta:
		model = DragDropActivityElements
		fields =('__all__')


class AssignmentForm(forms.ModelForm):
	question_file = forms.FileField(help_text="Only .xlsx,.doc,.docx,.pdf formats are accepted.", 
		required=True,
		validators=[FileTypeValidator(
		 allowed_extensions=['.doc', '.docx','.pdf','.xlsx'],
		allowed_types=allowed_types )]
		# validators=[FileTypeValidator(
		# allowed_extensions=['.doc', '.docx','.pdf','.xlsx'],
		# allowed_types=allowed_types )]
	)
	description = forms.CharField(max_length=125)
	# answer_file = forms.FileField(help_text="Only .xlsx,.doc,.docx,.pdf formats are accepted.", 
	# 	required=False,validators=[FileTypeValidator(
	# 	allowed_extensions=['.doc', '.docx','.pdf','.xlsx'],
	# 	allowed_types=allowed_types )]
	# )
	created_at = forms.DateTimeField(initial=timezone.now,widget=forms.HiddenInput())
	topic = forms.ModelChoiceField(queryset = Topic.objects.all(),
		required=True,widget=forms.HiddenInput())
	
	class Meta:
		model = AssignmentActivity
		fields = ('description','question_file','created_at',
			'no_of_submission','topic')

	def __init__(self,*args,**kwargs):
		super(AssignmentForm,self).__init__(*args,**kwargs)
		initial=kwargs.get('initial',None)
		self.fields['question_file'].widget.attrs.update({"class": "form-control"})
		self.fields['description'].widget.attrs.update({"class": "form-control"})
		self.fields['no_of_submission'].widget.attrs.update({"class": "form-control"})
		#if initial is not None:
			#self.fields['topic'].queryset=initial.get('topic',None)




class BasicSearchForm(CustomFormMixin):
	query = forms.CharField(
		max_length=255,
		required=False,
		widget=forms.TextInput(attrs={"placeholder": "A title, keywords, tags, topics…"})
	)



class CountryForm(forms.ModelForm):
	name= forms.CharField(max_length=80,required=True)
	#status = forms.BooleanField()
	
	class Meta:
		model = Country
		fields = ['name', 'status']
		widgets = {
			'name': TextInput(attrs={'class': 'form-control'}),
			'status': Select(attrs={'class': 'form-control selectbox'}),
		}


class StateForm(forms.ModelForm):
	name= forms.CharField(max_length=80,required=True)
	#status = forms.BooleanField()
	country = forms.ModelChoiceField(queryset=Country.objects.filter(status=1),
		required=True)

	class Meta:
		model = State
		fields = ['name', 'country', 'status']
		widgets = {
			'name': TextInput(attrs={'class': 'form-control'}),
			'country': Select(attrs={'class': 'form-control selectbox selectbox'}),
			'status': Select(attrs={'class': 'form-control selectbox selectbox'}),
		}


class CityForm(forms.ModelForm):
	name= forms.CharField(max_length=80,required=True)
	#status = forms.BooleanField()
	state = forms.ModelChoiceField(queryset=State.objects.filter(status=1),
		required=True)
	class Meta:
		model = City
		fields = ['name', 'state', 'status']
		widgets = {
			'name': TextInput(attrs={'class': 'form-control'}),
			'state': Select(attrs={'class': 'form-control selectbox'}),
			'status': Select(attrs={'class': 'form-control selectbox'}),
		}



permission_types =(('generic','generic'),('object','object'))
class PermissionForm(forms.ModelForm):
	#codename=forms.ModelChoiceField(queryset=Perm.objects.all())
	#type = forms.ChoiceField(choices=permission_types,initial={'type': 'generic'},widget=forms.HiddenInput())
	class Meta:
		model=Perm
		fields=('type',)
		#exclude=('content_type','object_id','field_name')


class UserForm(forms.ModelForm):
	perm=forms.ModelChoiceField(queryset=Perm.objects.all(),empty_label=None)
	choice=forms.ModelChoiceField(queryset=User.objects.all(),empty_label=None)

	def __init__(self,user=None,**kwargs):
		super(UserForm, self).__init__(**kwargs)
		if user:
			#self.fields['username'].queryset = User.objects.filter(~Q(username=user.username))
			self.fields['choice'].queryset = User.objects.filter(~Q(username=user.username))
	
	class Meta:
		model=User
		fields=('choice','perm',)



class PermissionCreationForm(forms.ModelForm):

	class Meta:
		model=Perm
		fields=('type','codename','description','name','content_type','object_id','field_name')
		exclude =('content_type','object_id','field_name')
		
	def clean(self):
		self.cleaned_data = super(PermissionCreationForm, self).clean()
		field_1 = self.cleaned_data.get('type')
		field_2 = self.cleaned_data.get('codename')
		field_3 = self.cleaned_data.get('description')
		field_4 = self.cleaned_data.get('name')
		#print(field_1)
		if field_1 is not None and field_2 is not None and field_3 is not None:
			if field_1=='generic':
				pass
			elif field_1 =='model':
				pass
			elif field_1 =='object':
				pass
			else:
				pass
		else:
			self.add_error(None, ValidationError('all fields should not be blank'))
		
		return self.cleaned_data





class CourseEnrollForm(forms.ModelForm):
	class Meta:
		model=CourseEnroll
		fields =('__all__')




class CourseAllotForm(forms.ModelForm):
	organization = forms.ModelChoiceField(label='select organization',queryset=Organization.objects.all(),empty_label=None)
	class Meta:
		model = Courses
		fields =('organization',)

position_choices=(('student','student'),('teacher','teacher'),('collaborator','collaborator'),
	(None,"None"))

class AddOrganizationUser(forms.ModelForm):
	position = forms.ChoiceField(choices=position_choices)
	phone = forms.IntegerField(required=True)
	email = forms.EmailField(max_length=256,required=True)
	password = forms.CharField(max_length=256,required=False,widget=forms.PasswordInput())
	password_again = forms.CharField(max_length=256,required=False,widget=forms.PasswordInput())
	#name=forms.CharField(max_length=256,required=True)
	houseno=forms.CharField(required=False,max_length=125)
	pincode = forms.CharField(required=False,max_length=125)
	address = forms.CharField(required=False,max_length=256)
	address1 = forms.CharField(max_length=256,required=False)
	image = forms.ImageField(required=False)
	gender = forms.ChoiceField(choices=(('male','male'),('female','female')))
	organization = forms.ModelChoiceField(queryset=Organization.objects.filter(is_active=True),required=False)
	city = forms.ModelChoiceField(queryset=City.objects.filter(status=1),empty_label=None,widget=forms.Select({'class':'form-control'}))
	state = forms.ModelChoiceField(queryset=State.objects.filter(status=1),empty_label=None,widget=forms.Select({'class':'form-control'}))
	#registration_date = forms.CharField(required=False,max_length=125,initial=timezone.now())
	class Meta:
		#model = UserInformation
		model = get_user_model()
		fields = ['position','password','password_again',
		'first_name','last_name','address','pincode','email','address',
		'organization','image','phone','address1','gender','city','state']
		# widgets = {
		# 	'password': forms.PasswordInput(),
		# 	'password_again': forms.PasswordInput(),
		# }
	def __init__(self,*args,**kwargs):
		super(AddOrganizationUser,self).__init__(*args,**kwargs)
		initial = kwargs.get('initial',None)
		#if initial is not None:
			#org = initial.get('organization',False)
			#if org:
				#self.fields['organization'].initial = initial.get('organization',None)
		#self.fields['registration_date'].initial = timezone.now

	def clean_password_again(self):
		password1 = self.cleaned_data.get('password',None)
		password2 = self.cleaned_data.get('password_again',None)
		print(password2,password1)
		if password1 is not None and password2 is not None:
			if password1 != password2:
				#print(password2 , password1)
				raise ValidationError("Password should be match")
			elif len(password1) < 7 :
				raise ValidationError("Password length should be equal or greater than 7")
			else:
				return password2
		return password2

	# def clean_mobile(self):
	# 	mobile = self.cleaned_data.get('mobile')
	# 	if len(mobile) != 10 :
	# 		raise ValidationError(" mobile length should be equal to 10 ")
	# 	return mobile

garbage_value=(('hindi','hindi'),('english','englsih'))


class CreateCourseForm(forms.ModelForm):
	end_date = forms.DateTimeField(required=False, widget=forms.TextInput(attrs={'id': 'datepicker'}))
	language = forms.ChoiceField(choices=garbage_value)
	start_date = forms.DateTimeField(required=True,initial=timezone.now, widget=forms.TextInput(attrs={'class': 'datepicker'}))
	courses_category=forms.ModelChoiceField(required=False,queryset=Categories.objects.all(),empty_label=None)
	thumbnail = forms.ImageField(required=False)
	#assigned_teacher = forms.ModelChoiceField(queryset=UserInformation.objects.filter())
	class Meta:
		model = Courses
		fields = ['name', 'about', 'start_date','end_date','thumbnail','organization','author',
					 'language','courses_category']
		widgets = {
			#'start_date': forms.TextInput(attrs={'class': 'datepicker'}),
			'organization' : forms.HiddenInput(),
			'author':forms.HiddenInput(),
		}

	def __init__(self,*args,**kwargs):
		super(CreateCourseForm,self).__init__(*args,**kwargs)
		self.fields['language'].queryset=tuple(Language.objects.get_language_choice_tuple())
		self.fields['end_date'].initial = timezone.now

	# def clean_end_date(self):
	# 	print("fffffddddddddddddddddddddddddddd")
	# 	end_date=self.cleaned_data.get('end_date')
	# 	if end_date is not None:
	# 	#print(datetime.strptime(start_date,"%m/%d/%Y %I:%M %p"))
	# 		return datetime.strptime(end_date,"%m/%d/%Y %I:%M %p")
	# 	return end_date


from .models import CoursesEndUser
class_attr= 'form-control'


class ScheduleSessionFormSuperuser(forms.ModelForm):
	start_date = forms.CharField(required=False,widget=forms.TextInput(attrs={'id': 'datepicker-default','class':class_attr}))
	author = forms.ModelChoiceField(required=False,queryset=User.objects.all(),widget=forms.HiddenInput())
	topic = forms.CharField(required=True,widget=forms.TextInput(attrs={'class':class_attr,'required':'true'}))
	description =forms.CharField(max_length=125,widget=forms.Textarea(attrs={"rows":4, "cols":35,'class':class_attr,
		'required':'true'}))
	course =forms.ModelChoiceField(queryset=CoursesEndUser.objects.all(),empty_label='select course',required=False)
	#teacher = forms.ModelChoiceField(queryset=UserInformation.objects.filter(position='teacher'),empty_label='select teacher')
	teacher = forms.ModelChoiceField(queryset=get_user_model().objects.filter(position='teacher'),empty_label='select teacher')
	organization = forms.ModelChoiceField(queryset=Organization.objects.filter(is_active=True),required=False,empty_label='select organization')
	
	def __init__(self,*args,**kwargs):
		super(ScheduleSessionFormSuperuser, self).__init__(*args, **kwargs)
		self.fields['duration'].widget.attrs.update({'class':'form-control'})
		self.fields['organization'].widget.attrs.update({'class':'form-control'})
		self.fields['course'].widget.attrs.update({'class':'form-control'})
		self.fields['teacher'].widget.attrs.update({'class':'form-control'})

	class Meta:
		model=SessionActivity
		fields =('topic','description','start_date','duration','teacher','auto_attendence',
			'photo_attendence','record_session','enable_private_chat',
			'enable_group_chat','raise_query','download_record_session_video',
			'download_session_resource','course','organization','capture_photo_after_every','author')

		labels = {
			"teacher": "Select Teacher",
			"duration" : "In Minutes",
			"start_date" : "In /m/d/y format"
		}

	def clean_start_date(self):
		start_date=self.cleaned_data.get('start_date')
		#print(datetime.strptime(start_date,"%m/%d/%Y %I:%M %p"))
		dd=datetime.strptime(start_date,"%m/%d/%Y %I:%M %p")
		from django.utils import timezone
		current_tz=timezone.get_current_timezone()
		print(current_tz)
		t2 = current_tz.localize(dd)
		print(t2)
		return t2

	def clean_teacher(self):
		teacher=self.cleaned_data.get('teacher',None)
		if teacher is None:
			raise ValidationError("At least select a teacher")
		return teacher




class ScheduleSessionForm(forms.ModelForm):
	start_date = forms.CharField(required=False,widget=forms.TextInput(attrs={'id': 'datepicker-default','class':class_attr}))
	author = forms.ModelChoiceField(required=False,queryset=User.objects.all(),widget=forms.HiddenInput())
	topic = forms.CharField(required=True,widget=forms.TextInput(attrs={'class':class_attr,'required':'true'}))
	description =forms.CharField(max_length=125,widget=forms.Textarea(attrs={"rows":4, "cols":35,'class':class_attr}))
	course =forms.ModelChoiceField(queryset=CoursesEndUser.objects.all(),empty_label='select course',required=False)
	#teacher = forms.ModelChoiceField(queryset=UserInformation.objects.filter(position='teacher'),empty_label='select teacher')
	teacher = forms.ModelChoiceField(queryset=get_user_model().objects.filter(position='teacher'),empty_label='select teacher')
	organization = forms.ModelChoiceField(queryset=Organization.objects.filter(is_active=True),required=False,
		widget=forms.HiddenInput(),
		empty_label='select organization')
	
	def __init__(self,*args,**kwargs):

		super(ScheduleSessionForm, self).__init__(*args, **kwargs)
		#self.fields['start_date'].initial= 
		initial=kwargs.pop('initial',None)
		if initial is not None:
			self.fields['teacher'].queryset=initial['teacher']
			course=initial.get('course',None)
			if course is not None:
				self.fields['course'].queryset = initial['course']
			organization = initial.get('organization',None)
			if organization is not None:
				self.fields['organization'].initial = initial['organization']
		else:
			pass
			#self.fields['organization'].widget=forms.SelectInput()
		self.fields['duration'].widget.attrs.update({'class':'form-control'})
		self.fields['organization'].widget.attrs.update({'class':'form-control'})
		self.fields['course'].widget.attrs.update({'class':'form-control'})
		self.fields['teacher'].widget.attrs.update({'class':'form-control'})


		# if data is None:
		# 	#if self.initial is not None:
		# 	super(ScheduleSessionForm, self).__init__(*args, **kwargs)
		# 	print("data is none")
		# 	self.initial = kwargs.get('initial',None)
		# 	for key in self.fields.keys():
		# 		if key=='teacher':
		# 				#print(self.fields[key])
		# 			self.fields[key].queryset=self.initial['teacher']
		# else:
		# 	initial_data=kwargs.pop('initial',None)
		# 	#data['author']=initial_data.get('author',None)
		# 	#kwargs['data']=data
		# 	print(kwargs)
		# # 	print(data)
		# 	super(ScheduleSessionForm, self).__init__(*args, **kwargs)
			# self.start_date=data.get('start_date',None)
			# #self.author=data.get('author',None)
			# self.topic=data.get('topic',None)
			# self.description=data.get('description',None)
			# self.duration=data.get('duration',None)
			# self.teacher = data.get('teacher',None)
			# self.auto_attendence=data.get('auto_attendence',0)
			# self.photo_attendence=data.get('photo_attendence',0)
			# self.record_session=data.get('record_session',0)
			# self.enable_private_chat=data.get('enable_private_chat',0)
			# self.raise_query=data.get('raise_query',0)
			# self.download_session_resource=data.get('download_session_resource',0)
			# self.course=data.get('course',None)




		#user=kwargs.pop('user',None)
		#if user is not None:
			#self.fields['author']=user.id
		# 	# if hasattr(self.teacher, key):
			# 	self.fields[key].initial = getattr(self.teacher, key)
	class Meta:
		model=SessionActivity
		fields =('topic','description','start_date','duration','teacher','auto_attendence',
			'photo_attendence','record_session','enable_private_chat',
			'enable_group_chat','raise_query','download_record_session_video',
			'download_session_resource','course','capture_photo_after_every','author')

		labels = {
			"teacher": "Select Teacher",
			"duration" : "In Minutes",
			"start_date" : "In /m/d/y format"
		}

	def clean_start_date(self):
		start_date=self.cleaned_data.get('start_date')
		#print(datetime.strptime(start_date,"%m/%d/%Y %I:%M %p"))
		dd=datetime.strptime(start_date,"%m/%d/%Y %I:%M %p")
		from django.utils import timezone
		current_tz=timezone.get_current_timezone()
		print(current_tz)
		t2 = current_tz.localize(dd)
		print(t2)
		return t2

	def clean_session_room_id(self):
		pass




class CreateCourseForSuperuser(forms.ModelForm):
	language = forms.ChoiceField(choices=garbage_value)
	organization = forms.ModelChoiceField(queryset = Organization.objects.all(),required=False,empty_label='select organization')
	start_date = forms.DateTimeField(required=True,initial=timezone.now(), widget=forms.TextInput(attrs={'class': 'datepicker-default'}))
	courses_category=forms.ModelChoiceField(queryset=Categories.objects.all(),required=False,empty_label='select category')
	enddate = forms.DateTimeField(required=False,widget=forms.TextInput(attrs={'id': 'datepicker'}))
	thumbnail = forms.ImageField(required=False)

	def __init__(self,*args,**kwargs):
		super(CreateCourseForSuperuser,self).__init__(*args,**kwargs)
		self.fields['language'].queryset=tuple(Language.objects.get_language_choice_tuple())
		#self.fields['end_date'].initial = timezone.now()

	class Meta:
		model = Courses
		fields = ['name', 'about', 'start_date','enddate','thumbnail','organization',
					 'language','courses_category']
		widgets = {
			#'start_date': forms.TextInput(attrs={'class': 'datepicker'}),
			#'organization' : forms.HiddenInput(),
			'author':forms.HiddenInput(),
		}


from .models import CoursesEndUser,UserCategories

options=[
	'%Y/%m/%d %H:%M:%S'
]




class CreateCategoryFormForEndUser(forms.ModelForm):
	name = forms.CharField(max_length=40,required=True,
		widget=forms.TextInput({'label':'Name','placeholder':'Enter Category Name','class':'form-control'}))

	category_about = forms.CharField(max_length=300,required=False,
		widget=forms.TextInput({'label':'about','placeholder':'Enter About Category','class':'form-control'}))


	def __init__(self,*args,**kwargs):
		super(CreateCategoryFormForEndUser,self).__init__(*args,**kwargs)

	class Meta:
		model = UserCategories
		fields = ['name', 'category_about','creator']
		widgets = {
			'creator':forms.HiddenInput(),
		}



course_end_user_field = ['name','about','author','thumbnail',
		'language',
		'self_enrollment','web','highlights','star',
		'post_achievement','category','overview','mobile','price',
		'link','duration',
		'discount_price','state','access',
		'course_tag']


langauge_choices =(('English','English'),('Hindi','Hindi'),('Marathi','Marathi'),('Tamil','Tamil'))
from taggit.forms import TagWidget
from taggit_labels.widgets import LabelWidget
from taggit.forms import TagField

class CreateCourseForEndUser(forms.ModelForm):
	#thumbnail = forms.ImageField(required=True)
	name = forms.CharField(max_length=100,required=True,
		widget=forms.TextInput({'label':'Name','placeholder':'Enter Course Name','class':'form-control'}))
	
	about = forms.CharField(required=False,
		widget=forms.Textarea({'label':'about','name':'about','placeholder':'About Course','rows':5,'cols':20,'class':'form-control'}))
	

	overview = forms.CharField(required=False,
		widget=forms.Textarea({'label':'overview','name':'overview','placeholder':'Overview Course','rows':5,'cols':20,'class':'form-control'}))

	highlights = forms.CharField(required=False,
		widget=forms.Textarea({'label':'highlights','name':'overview','placeholder':'Overview Course','rows':5,'cols':20,'class':'form-control'}))

	post_achievement = forms.CharField(required=False,
		widget=forms.Textarea({'label':'post_achievement','name':'overview','placeholder':'Overview Course','rows':5,'cols':20,'class':'form-control'}))


	category = forms.ModelChoiceField(queryset=UserCategories.objects.all(),required=False,
		empty_label='Select Category')
	#created_date = forms.DateTimeField(widget=forms.DateTimeInput(format=options))
	#updated_date = forms.DateTimeField(widget=forms.DateTimeInput(format=options))
	thumbnail = forms.ImageField(required=True,widget = forms.ClearableFileInput(
			attrs = {'class': 'form-control mb-2', 'placeholder': 
		'IMAGE',}))
	language = forms.MultipleChoiceField(required=True,widget=forms.CheckboxSelectMultiple,
										  choices=langauge_choices)
	price = forms.FloatField(widget=forms.TextInput({'class':'form-control'}),required=False)
	discount_price =forms.FloatField(required=False,widget=forms.TextInput({'class':'form-control'}))
	star = forms.CharField(max_length=3,required=False)
	link=forms.URLField(required=False)
	# course_tag = TagField(label='Course Tags',help_text='comma separed list of tags',
	# 	required=False, widget=TagWidget())

	#category = forms.IntegerField()
	def __init__(self,*args,**kwargs):
		super(CreateCourseForEndUser,self).__init__(*args,**kwargs)
		self.fields['web'].initial=1
		#self.fields['language'].queryset=tuple(Language.objects.get_language_choice_tuple())
		#self.fields['end_date'].initial = timezone.now()

	class Meta:
		model = CoursesEndUser
		fields = course_end_user_field
		widgets = {
			#'start_date': forms.TextInput(attrs={'class': 'datepicker'}),
			#'organization' : forms.HiddenInput(),
			'course_tag': TagWidget(),
			'duration':forms.TextInput(attrs={'class':'form-control'}),
			'author':forms.HiddenInput(),
			'link':forms.URLInput(attrs={'class':'form-control'}),
			'web':forms.HiddenInput(),
		}
	
	# def clean_duration(self):
	# 	duration=self.cleaned_data['duration']
	# 	if duration is not None:
	# 		try: 
	# 			int(duration)
	# 			return duration
	# 		except ValueError:
	# 			raise ValueError("duration field should be integer value")
	# 	return duration


	# def clean_discount_price(self):
	# 	price=self.cleaned_data['discount_price']
	# 	if price is not None:
	# 		try: 
	# 			float(price)
	# 			return price
	# 		except ValueError:
	# 			raise ValueError("discount price field should be integer or float value")
	# 	return price


	# def clean_price(self):
	# 	price=self.cleaned_data['price']
	# 	if price is not None:
	# 		try: 
	# 			float(price)
	# 			return price
	# 		except ValueError:
	# 			raise ValueError("price field should be integer or float value")
	# 	return price



class CreateOrganizationForm(forms.ModelForm):
	password_again=forms.CharField(max_length=256,required=True,widget=forms.PasswordInput(attrs={'class':'form-control'}))
	password = forms.CharField(max_length=256,required=True,widget=forms.PasswordInput(attrs={'class':'form-control','width':'50%'}))
	address = forms.CharField(required=False,
		widget=forms.Textarea({'label':'address','name':'address','placeholder':'Address','rows':5,'cols':20,'class':'form-control'}))

	#organization_name = forms.CharField(max_length=256,required=True,widget=forms.)
	no_of_candidates=forms.IntegerField(required=False,widget=forms.TextInput({'class':'form-control'}))
	end_date=forms.CharField(max_length=125,required=False,
		widget=forms.TextInput({'class':'form-control','id':'datepicker-default'}),help_text='m/d/y format')
	logo = forms.ImageField(required=True)
	logo1 = forms.ImageField(required=False)
	city = forms.ModelChoiceField(queryset=City.objects.filter(status=1),empty_label=None,widget=forms.Select({'class':'form-control'}))
	state = forms.ModelChoiceField(queryset=State.objects.filter(status=1),empty_label=None,widget=forms.Select({'class':'form-control'}))
	unique_code = forms.CharField(max_length=200,required=True,widget=forms.TextInput({'class':'form-control'}))
	website = forms.URLField(required=False,widget=forms.TextInput({'class':'form-control'}))
	pin = forms.IntegerField(required=False,widget=forms.TextInput({'class':'form-control'}))
	class Meta:
		model = Organization
		fields = ['organization_name','contact_person_email','password','password_again',
		'address','website','end_date','no_of_candidates','logo',
		'contact_person_phone','contact_person_name','sector_type',
		'pin','city','state','certificate','logo1','show_second_logo','unique_code']

		widgets = {
			'organization_name':forms.TextInput(attrs={'class':'form-control'}),
			'unique_code':forms.TextInput(attrs={'class':'form-control'}),
			'contact_person_name':forms.TextInput(attrs={'id':'person_name','class':'form-control'}),
			'contact_person_email':forms.TextInput(attrs={'id':'person_email','class':'form-control'}),
			'contact_person_phone':forms.TextInput(attrs={'id':'person_phone','class':'form-control'}),
			'website':forms.TextInput(attrs={'id':'website','class':'form-control'}),
			#'no_of_candidates':forms.TextInput(attrs={'id':'noc','class':'form-control'}),
			'logo':forms.TextInput(attrs={'id':'company_logo','class':'form-control'}),
			'sector_type':forms.Select(attrs={'id':'sector_type','class':'form-control'}),
			'pin':forms.TextInput(attrs={'id':'pin','class':'form-control'}),
			'certificate':forms.HiddenInput(),
			#'city':forms.Select(attrs={}),
			#'state':forms.Select(attrs={'class':'form-control'}),	
		}

	# def __init__(self):
	# 	super(CreateOrganizationForm,self).__init__()
	# 	for field_name,fields in self.fields.items():
	# 		fields.required=True
		#return self.cleaned_data['end_date']
	def clean_password_again(self):
		if self.cleaned_data['password_again']!=self.cleaned_data['password']:
			raise ValidationError("Password should match")
		password =self.cleaned_data['password']
		return make_password(password)

	def clean_end_date(self):
		end_date=self.cleaned_data['end_date']
		#print('end date',end_date)
		#print(datetime.strptime(start_date,"%m/%d/%Y %I:%M %p"))
		if end_date is not None and end_date!='':
			dd = datetime.strptime(end_date,"%m/%d/%Y")
			#dd=datetime.strptime(end_date,"%m/%d/%Y %I:%M %p")
			from django.utils import timezone
			current_tz=timezone.get_current_timezone()
			print(current_tz)
			t2 = current_tz.localize(dd)
			print(t2)
			return t2
		return end_date
		#return self.cleaned_data['password_again']

	# def clean_password(self):
	# 	password = self.cleaned_data['password']
	# 	return make_password(password)
	# 	if len(password) < 8:
	# 		raise ValidationError("password length should be of 8 or greter than 8")
	# 	#print(self.cleaned_data)
	# 	return self.cleaned_data
	# 	# if "@" not in password or "&" not in password or "$" not in password:
	# 	# 	raise ValidationError("please have at least one special char in password")
	# 	#if type(password)=="int"
	# 	# password_again = self.cleaned_data['password_again']
	# 	# if password != password_again:
	# 	# 	raise ValidationError("password should be match")




class AddUserOfOrganizationForSuperUser(AddOrganizationUser):
	organization = forms.ModelChoiceField(queryset=Organization.objects.filter(is_active=1),
		empty_label='select organization',required=True)
	#registration_date = forms.CharField(max_length=125,required=False,initial=timezone.now())
	phone = forms.CharField(max_length=10,required=True)
	class Meta:
		#model = UserInformation
		model = get_user_model()
		fields =['position','password','password_again','organization',
		'first_name','last_name','houseno','pincode','address','email',
		'image','phone','gender']


	def __init__(self,*args,**kwargs):
		super(AddUserOfOrganizationForSuperUser,self).__init__(*args,**kwargs)
		#self.fields['registration_date'].initial = timezone.now



class QuestionForm(forms.ModelForm):
	from .models import Question
	question_language=forms.ModelChoiceField(queryset=Language.objects.all(),
		empty_label='select language')
	start_date=forms.DateTimeField(initial=timezone.now(),widget=forms.HiddenInput())
	question_name = forms.CharField(max_length=125,widget=forms.TextInput({'class':'form-control'}))
	author = forms.ModelChoiceField(queryset=User.objects.all(),
		widget=forms.HiddenInput(),required=False)
	class Meta:
		model = Question
		fields =['question_name','option_a','option_b','option_c',
		'option_d','answer_option','author','start_date','question_language']

	def __init__(self,*args,**kwargs):
		super(QuestionForm,self).__init__(*args,**kwargs)
		initial = kwargs.get('initial',None)
		if initial is not None:
			#print(initial)
			self.fields['author'].initial=initial['author']



class TopicForm(forms.ModelForm):
	author = forms.ModelChoiceField(queryset = User.objects.all(),widget=forms.HiddenInput())
	about = forms.CharField(required=False,max_length=125)
	#thumbnail = forms.ImageField(required=False)
	#duration = forms.CharField(required=False,help_text='In minutes')
	# end_date = forms.DateField(required=False,
	# 	input_formats=['%m/%d/%Y'],
	# 	widget=forms.DateInput(attrs={
	# 		'id':'datepicker',
	# 		'class':'datepicker',
	# 	}),
		# help_text='expiration date of topic (keep blank for forever), format="m/d/y"')
	start_date = forms.DateTimeField(required=False,initial=timezone.now(),
		widget=forms.HiddenInput())
	topic_type=forms.CharField(max_length=20,widget=forms.HiddenInput())
	course=forms.ModelChoiceField(required=False,queryset=CoursesEndUser.objects.filter(~Q(name='trial_course')),
		empty_label='Select Course',widget=forms.HiddenInput())
	class Meta:
		model = Topic
		fields = ['name','about','author','course',
			'start_date','topic_type']

	def clean(self):
		cleaned_data = self.cleaned_data
		name = cleaned_data['name']
		return cleaned_data

	# def clean_end_date(self):
	# 	pass

	# def clean_start_date(self):
	# 	pass

	# def clean_about(self):
	# 	pass


from .models import ActivityType

class ActivityTypeForm(forms.ModelForm):
	author = forms.ModelChoiceField(queryset=User.objects.all(),widget=forms.HiddenInput())
	class Meta:
		model = ActivityType
		fields =('author','name','thumbnail',)

	def __init__(self,*args,**kwargs):
		super(ActivityTypeForm,self).__init__(*args,**kwargs)
		initial = kwargs.get('initial',None)
		if initial is not None:
			self.fields['author'].initial=initial['author']


class AddActivityForm(forms.ModelForm):
	author = forms.ModelChoiceField(queryset=User.objects.all(),
		widget=forms.HiddenInput())
	course = forms.ModelChoiceField(queryset=CoursesEndUser.objects.all(),required=False,widget=forms.HiddenInput())
	organization = forms.ModelChoiceField(queryset=Organization.objects.all(),required=False,widget=forms.HiddenInput())
	
	class Meta:
		model = Activities
		fields = ('author','course','organization','start_date','end_date','activity_name',
			'activity_type')



	def __init__(self,*args,**kwargs):
		super(AddActivityForm,self).__init__(*args,**kwargs)
		initial = kwargs.get('initial',None)
		if initial is not None:
			self.fields['author'].initial=initial['author']






class CreateGroupForm(forms.Form):
	name= forms.CharField(max_length=125)
	users= forms.ModelMultipleChoiceField(queryset=User.objects.all(),
			required=True, widget=FilteredSelectMultiple('users', False))
	permissions = forms.ModelMultipleChoiceField(queryset=Perm.objects.all(),required=True,
			widget=FilteredSelectMultiple('permissions', False))
	# class Meta:
	# 	model = Group
	# 	exclude=[]

		
	def __init__(self, *args, **kwargs):
		super(CreateGroupForm, self).__init__(*args, **kwargs)
		#if self.instance.pk:
			#self.fields['users'].initial = self.instance.user_set.all()


	def save_m2m(self):
		#self.instance.permissions.set(self.cleaned_data['permissions'])
		g=Group.objects.create(name=self.cleaned_data['name'])
		for obj in self.cleaned_data['permissions']:
			g.perms.add_perm(obj.id)
		g.user_set.add(self.cleaned_data['users'])
		#self.instance.user_set.set(self.cleaned_data['users'])

	def save(self, *args, **kwargs):
		#instance = super(CreateGroupForm, self).save()
		#print(self)
		g,created=Group.objects.get_or_create(name=self.cleaned_data['name'])

		for obj in self.cleaned_data['permissions']:
			g.perms.add_perm(obj)
		for user in self.cleaned_data['users']:
			g.user_set.add(user)
		#self.save_m2m()
		return True



class SubTopicForm(forms.ModelForm):
	name=forms.CharField(max_length=125)
	about=forms.CharField(max_length=125,required=False)
	#duration=forms.CharField(required=False,help_text='in minutes')
	topic=forms.ModelChoiceField(queryset=Topic.objects.all(),
		widget=forms.HiddenInput(),empty_label=None)
	author = forms.ModelChoiceField(queryset=User.objects.all(),widget=forms.HiddenInput())
	# end_date = forms.DateField(required=False,input_formats=['%m/%d/%Y'],
	# 	widget=forms.DateInput(attrs={
	# 		'id':'datepicker',
	# 		'class':'datepicker',
	# 	}),help_text='expiry date for subtopic(keep blank for forever)')
	#thumbnail = forms.ImageField(required=False)
	topic_type = forms.CharField(max_length=20,initial='subtopic',widget=forms.HiddenInput())
	#course= forms.ModelChoiceField(queryset=Courses.objects.filter(~Q(name='trial_course')),
		#widget=forms.HiddenInput(),empty_label=None)

	class Meta:
		model=Topic
		fields =('name','about','topic','author','topic_type')


	def __init__(self,*args,**kwargs):
		super(SubTopicForm, self).__init__(*args, **kwargs)
		initial=kwargs.pop('initial',None)

		if initial is not None:
			self.fields['topic'].initial=initial['topic']
			self.fields['author'].initial=initial['author']

from .validators import validate_video_extension
class AddVideoForm(forms.ModelForm):
	video = forms.FileField(required=True,validators=[validate_video_extension])
	#subtopic=forms.ModelChoiceField(queryset=SubTopic.objects.all(),required=False)
	# topic = forms.ModelChoiceField(queryset=Topic.objects.all(),widget=forms.HiddenInput(),required=False)
	# end_date = forms.DateField(required=False,widget=forms.DateInput(attrs={
	# 	'id':'datepicker',
	# 	'class':'datepicker',
	# 	}))
	organization = forms.ModelChoiceField(queryset=Organization.objects.all(),widget=forms.HiddenInput(),required=False)
	course = forms.ModelChoiceField(queryset=CoursesEndUser.objects.all(),widget=forms.HiddenInput(),required=False)
	thumbnail = forms.ImageField(initial=None,required=False,help_text='either upload it or \
		it will be automatically updated')
	language = forms.ModelChoiceField(queryset=Language.objects.all(),
		required=True,empty_label='select language')

	class Meta:
		model=ContentVideo
		# fields=('video','thumbnail','organization','course','description','language')
		fields = "__all__"
		exclude = ('start_date','end_date')

	def __init__(self,*args,**kwargs):
		super(AddVideoForm, self).__init__(*args, **kwargs)
		initial = kwargs.get('initial',None)
		if initial is not None:
			topic=initial.get('topic',None)
			subtopic=initial.get('subtopic',None)

			if topic is not None:
				self.fields['topic'].initial=topic
				self.fields['topic'].widget=forms.HiddenInput()
				self.fields['course'].initial=initial.get('course',None)
				self.fields['course'].widget=forms.HiddenInput()

			if subtopic is not None:
				self.fields['subtopic'].initial=initial['subtopic']
	
	# def clean_video(self):
	# 	import magic
	# 	from pymediainfo import MediaInfo
	# 	#print(self.cleaned_data)
	# 	file = self.cleaned_data.get("video", False)
	# 	print(file)
	# 	fileInfo = MediaInfo.parse(file)
	# 	for track in fileInfo.tracks:
	# 		if track.track_type == "Video":
	# 			pass
	# 		else:
	# 			raise ValidationError("File is not Video.")
		# if file:
		# 	filetype = magic.from_buffer(file.read(1024))
		# 	if not "media" in filetype:
		# 		raise ValidationError("File is not Video.")
		# return file

	def clean_topic(self):
		return self.cleaned_data['topic']

	def clean_thumbnail(self):
		thumbnail = self.cleaned_data.get('thumbnail',None)
		if thumbnail is None:
			pass
			#print(self.cleaned_data['video'])
		return thumbnail



class CategoryForm(forms.ModelForm):
	category_image=forms.ImageField(required=False)
	organization=forms.ModelChoiceField(queryset=Organization.objects.all(),required=True,empty_label=None)
	class Meta:
		model= Categories
		fields =('name','category_about','category_type','category_image','organization')

	def __init__(self,*args,**kwargs):
		super(CategoryForm, self).__init__(*args, **kwargs)
		initial = kwargs.pop('initial',None)

		if initial is not None:
			category_type=initial.get('category_type',None)
			self.fields['category_type'].initial=category_type

	def save(self,*args,**kwargs):
		#print(kwargs)
		instance = super(CategoryForm,self).save()

		category_father=kwargs.get('category_father',None)
		category_type=self.cleaned_data['category_type']
		#print(self.cleaned_data['organization'])
		if instance is not None:
			#print(category_father)
			#print(category_type)
			if category_type=='subcategory' and category_father is not None:
				CategoriesHirerchy.objects.create(category_id=instance.id,category_father_id=category_father)
				#print(category_father)
			if category_type=='category':
				CategoriesHirerchy.objects.create(category_id=instance.id,category_father_id=None)
		return instance



class TopicDetailsForSpin(forms.ModelForm):
	class Meta:
		model=TopicDetails
		fields=('__all__')


from django.contrib.auth import get_user_model
class UserInformationForm(forms.ModelForm):
	#image = forms.ImageField(required=False)
	password_again = forms.CharField(max_length=125,required=True,widget=forms.PasswordInput())
	class Meta:
		#model=UserInformation
		model = get_user_model()
		#fields='__all__'
		#exclude =('user',)
		exclude = ('password_change_date',)

	def __init__(self,*args,**kwargs):
		super(UserInformationForm, self).__init__(*args, **kwargs)
		#initial = kwargs.pop('initial',None)
		#print(initial)
		#if initial is not None:
			#user=initial.get('user',None)
			#print(user)
			#if user is not None:
				#self.fields['user'].initial=user
	
	# def clean_user(self):
	# 	print(self.cleaned_data['user'])
	# 	return self.cleaned_data['user']


class SpinActivityForm(forms.ModelForm):
	#topic_details= forms.ModelMultipleChoiceField(queryset=TopicDetails.objects.all())
	#topics=forms.ModelMultipleChoiceField(queryset=TopicDetails.objects.all())
	#questions=forms.ModelMultipleChoiceField(queryset=Question.objects.all())
	no_of_topic = forms.IntegerField(required=True)
	#question_per_slices = forms.IntegerField(required=False)
	block_slice_after_open = forms.BooleanField(initial=False,required=False)
	#topic_name =forms.CharField(max_length=125)

	class Meta:
		model=SpinActivity
		fields=('name','no_of_topic','block_slice_after_open')


	def __init__(self, *args, **kwargs):
		super(SpinActivityForm, self).__init__(*args, **kwargs)
		#self.fields['topics'].queryset=TopicDetails.objects.all()
		#self.fields['topics'].help_text='(Add Topics To Spin wheel)'
		#self.fields['topic_details'].queryset = TopicDetails.objects.all()

			#self.fields['author'].initial=initial['author']































	
