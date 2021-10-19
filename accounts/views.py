from django.shortcuts import render
# Create your views here.
from django.shortcuts import render, redirect  ,reverse
from django.http import HttpResponse,HttpResponseRedirect, request
from django.forms import inlineformset_factory
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.auth.decorators import login_required 
from django.contrib.auth.models import Group
from django.views.decorators.csrf import csrf_exempt
from django.utils.crypto import get_random_string
from django.urls import reverse_lazy
from LMS.settings import EMAIL_HOST_USER
from django.core.mail import send_mail
# Create your views here.
from .models import *
from .forms import CreateUserForm
# from .filters import OrderFilter
import time
from custompermission.models import Perm
from django.contrib.sites.shortcuts import get_current_site


#generic.generate_
end_user_perms=[
	'generic.can_see_all_published_courses',
	'generic.can_see_published_courses_activity',
	'generic.can_enroll_into_courses'
]



#g=Group.objects.create(name='end_user')

def check_email(request):
	email=request.POST.get('email',False)
	if email:
		ac=AccountVerify.objects.filter(email=email).order_by('-id')
		if len(ac)> 0:
			if ac[0].is_verified:
				return HttpResponse("true")
	return HttpResponse("something is not right")

def account_verify(request):
	to=request.POST.get('to',None)
	# subject = 'Verification Link for LMS'
	# message = 'Hope you are enjoying your Django Tutorials'
	# send_mail(subject, 
    #         message, EMAIL_HOST_USER, [to], fail_silently = False)
	if to is not None:
		email_user(request,to)
		return HttpResponse(f"verification link has been send to {to}")
	return HttpResponse("Please check your email is right.")

def email_user(request,to):
	print(to)
	token = get_random_string(16)
	# tokenn = str(token)+ "/" + str(to)
	# print(tokenn)
	print(token)
	
	
	context = {
		'subject': 'Verification Link for LMS',
		'url': request.build_absolute_uri(
		reverse_lazy('accounts:account_activate' ,kwargs={'token':token})),
			
	}
	html_content = render_to_string(f'accounts/email_designs/activate_account.html', context)


	try:
		subject = 'Verification Link for LMS'
		send_mail(subject,html_content, EMAIL_HOST_USER, [to], fail_silently = False)
		AccountVerify.objects.get_or_create(email=to,token=token)
		
		
	except:
		print("error occured while sending email")


def create_or_get_group():
	g,created=Group.objects.get_or_create(name='end_user_group')
	if created:
		try:
			for p in end_user_perms:
				g.perms.add_perm(Perm.objects.get_from_str(p))

		except:
			print("deleting grp", g.id)
			g.delete()
			return None
	return g


def account_activate(request,**kwargs):
	token= kwargs.get('token',None)
	print(token)
	
	if token:
		ac=AccountVerify.objects.filter(token=token).order_by('-id')
		
		if len(ac) > 0:
			if ac[0].token == token:
				ac[0].is_verified=True
				ac[0].save()
				messages.success(request, "account has been verified")
				return redirect("accounts:signup")
	return HttpResponse("error occured")

def registerPage(request):
	import json
	form = CreateUserForm()
	if request.method == 'POST':
		form = CreateUserForm(request.POST.dict())
		if form.is_valid():
			print("form valid")
			grp=create_or_get_group()
			if grp is None:
				messages.error(request, 'problem occured while setting up permission')
				return render(request,'accounts/register.html', {'form':form})
			user = form.save(commit=False)
			print(user)
			#user.image = request.POST.get('image',None)
			import io
			from django.core.files.base import File
			blob_file=None
			if blob_file and blob_file is not None:
				with io.BytesIO(blob_file) as stream:
					#print("h")
					django_file = File(stream)
					#print(django_file)
					user.image.save(user.email+'_img', django_file)
					#print("herer")
			user.save()
			grp.user_set.add(user)
			email = form.cleaned_data.get('email')
			#print(email)
			#group = Group.objects.get(name='customer')
			#user.groups.add(group)
			messages.success(request, 'Account was created for ' + email)
			#messages.success(request, 'we will redirect to login in a second')
			# for perm in perms:
			# 	user.perms.add_perm(perm)
			print("done creation")
			time.sleep(1)
			link = get_random_string(20)
		# 	user.email_user("you have been registred ",
		# '''Please click on this link to activate account<br/>
		#  Please click on this link <a href="#"></a>''',link,request,"zkhan1044@gmail.com")
			#return redirect('accounts:login')
			return HttpResponse(json.dumps({'message':True}))
		context = {'form':form}
		messages.error(request,form.errors)
		return HttpResponse(json.dumps({'message':False,'data':str(form.errors)}))
		#return render(request, 'accounts/register.html', context)
	return render(request,'accounts/registration_1.html', {'form':form})

#from customadmin.models import Organization
#from organization.models import UserInformation
#from django.contrib.auth.models import User
from django.urls import reverse_lazy
from organization.models import UserInformation
from django.conf import settings


def permission_failure(request):
	return redirect("userlms:home")







def loginPage(request):
	try:
		if request.user.is_authenticated:
			ui=UserInformation.objects.get(user=request.user,position__isnull=False)
			request.session['organization']=ui.organization.name
			request.session['organization_id']=ui.organization.id
			print(request.session)
	except Exception as e:
		print(e)

	# if not request.user.is_anonymous:
	# 	#print(reverse_lazy('customadmin:home'))
	# 	#check user_type
	# 	if request.user.is_superuser:
	# 		return redirect('customadmin:admin_home')
	# 	if request.user.groups.filter(name=settings.END_USER_GROUP).exists():
	# 		return HttpResponseRedirect(reverse_lazy('userlms:home'))

	if request.method == 'POST':
		#username = request.POST.get('username',None)
		email = request.POST.get('email',None)
		print(email)
		password = request.POST.get('password',None)
		print(password)

		#if username is not None and password is not None:
		if email is not None and password is not None:
			#user = authenticate(request, username=username, password=password)
			user = authenticate(request,email=email,password=password)
			print(user.roles)
			if user is not None:
				try:

					if user.is_superuser == 1:
						#print("user is superuser")
						login(request,user) 
						print("user is superuser")
						return HttpResponseRedirect(reverse_lazy('customadmin:admin_home'))
					if user.roles == 'super_user':
						#print("user is superuser")
						login(request,user) 
						print("user is superuser")
						return HttpResponseRedirect(reverse_lazy('customadmin:admin_home'))
				
					
					if user.roles == 'company_admin':
						login(request,user)
						print("user is company admin")
						return HttpResponseRedirect(reverse_lazy('customadmin:admin_home'))		
						
						#return render(request, 'accounts/register.html', {})
						#return redirect('customadmin:admin_home')
					
                
					elif user.roles == 'clg_admin': #elif user.is_superuser == 2:

						login(request,user)
						print("user is clg_admin")
						return HttpResponseRedirect(reverse_lazy('customadmin:clg_home'))	

				    		
					else:
						print("login as a normal user")
							#pass
						login(request,user)
						return HttpResponseRedirect(reverse_lazy('userlms:home'))

						orgs=user.organization_student.all()
						if len(orgs) > 1:
							print("against normal structure of product")
						elif len(orgs)> 0:
							if not orgs[0].is_active:
								messages.info(request, ' your organization is inactive, can not login')
								return render(request, 'accounts/login.html', context)
							else:
								login(request,user)
								return redirect('customadmin:admin_home')
						else:
							print("login as a normal user")
							#pass
							login(request,user)
							return HttpResponseRedirect(reverse_lazy('userlms:home'))

						''' after lateste changing on 3 Apr 
						ui=UserInformation.objects.filter(user=user)
						if len(ui) > 0:
							#print(ui[0])
							if not ui[0].organization.is_active:
								messages.info(request, ' your organization is inactive, can not login')
								return render(request, 'accounts/login.html', context)
							else:
								login(request,user)
								return redirect('customadmin:admin_home')'''



				except:
					pass
				
			else:
				messages.info(request, 'Username OR password is incorrect')
		else:
			messages.info(request,'username or password cant be empty')

	context = {}
	return render(request, 'accounts/login_1.html', context)



def logoutUser(request):
	logout(request)
	return redirect('accounts:login')
