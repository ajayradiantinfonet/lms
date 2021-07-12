from __future__ import unicode_literals
from django.db import models
from django.utils.translation import ugettext_lazy as _
from django.contrib.auth.models import PermissionsMixin
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string
# Create your models here.

from django.core.mail import send_mail
from django.urls import reverse_lazy
#from customadmin.models import Organization
from django.contrib.auth.base_user import BaseUserManager

class UserManager(BaseUserManager):
	use_in_migrations = True

	def _create_user(self, email, password=None, **extra_fields):
		if not email:
			raise ValueError('The given email must be set')
		email = self.normalize_email(email)
		user = self.model(email=email, **extra_fields)
		user.set_password(password)
		user.save(using=self._db)
		return user

	def create_user(self, email, password=None, **extra_fields):
		extra_fields.setdefault('is_superuser', False)
		return self._create_user(email,password, **extra_fields)

	def create_superuser(self, email, password=None, **extra_fields):
		extra_fields.setdefault('is_superuser', True)

		if extra_fields.get('is_superuser') is not True:
			raise ValueError('Superuser must have is_superuser=True.')

		return self._create_user(email, password, **extra_fields)



from django.contrib.auth.models import AbstractUser
from django.conf import settings

class User(AbstractUser):
	first_name = models.CharField(max_length=225)
	username = None
	last_name = models.CharField(max_length=225)
	position=models.CharField(max_length=155,null=True)
	email=models.EmailField(max_length=255,unique=True,null=True)
	password=models.TextField(null=True)
	phone=models.CharField(max_length=10,unique=True,default=None)
	email_verified=models.BooleanField(default=False)
	dob=models.CharField(max_length=125,null=True)
	is_active = models.BooleanField(_('active'), default=True)
	date_joined = models.DateTimeField(_('date joined'), auto_now_add=True,null=True)
	password_change_date = models.DateTimeField(null=True)
	profile_complete = models.BooleanField(default=False)
	has_organization = models.BooleanField(default=False)
	#is_verified = models.BooleanField(default=False)
	#token = models.TextField(null=True)
	#organization=models.ForeignKey(Organization,on_delete=models.CASCADE,related_name='organization_user',null=True)
	houseno = models.CharField(max_length=125,null=True)
	registration_date = models.CharField(max_length=125,null=True,blank=True)
	address= models.CharField(max_length=225,null=True)
	address1 = models.CharField(max_length=225,null=True)
	pincode = models.CharField(max_length=150,null=True)
	image = models.ImageField(upload_to='user_profile/',null=True)
	gender = models.CharField(choices=(('male','Male'),('female','Female')),max_length=10,
		default = 'male')
	objects = UserManager()

	USERNAME_FIELD = 'email'
	REQUIRED_FIELDS = []


	def get_full_name(self):
		'''
		Returns the first_name plus the last_name, with a space in between.
		'''
		full_name = '%s %s' % (self.first_name, self.last_name)
		return full_name.strip()

	def get_short_name(self):
		'''
		Returns the short name for the user.
		'''
		return self.first_name

	def email_user(self, subject,message,token,request,from_email=None, **kwargs):
		'''
		Sends an email to this User.
		'''

		to = self.email
		context = {
			'subject': subject,
			'url': request.build_absolute_uri(
			reverse_lazy('accounts:account_activate', kwargs={'token': token})),
		}

		html_content = render_to_string(f'accounts/email_designs/activate_account.html', context)
		try:
			msg = EmailMultiAlternatives(context['subject'], html_content, settings.EMAIL_HOST_USER, [to])
			msg.attach_alternative(html_content, 'text/html')
			msg.send()
		except:
			pass
		#send_mail(subject, message, from_email, [self.email], **kwargs)
	



class AccountVerify(models.Model):
	user = models.OneToOneField(User,on_delete=models.CASCADE,null=True)
	token = models.TextField()
	email = models.CharField(max_length=125,unique=True,null=True)
	is_verified = models.BooleanField(default=False)
	ip = models.TextField(null=True)
	user_agent = models.TextField(null=True)
