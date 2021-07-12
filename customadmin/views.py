from django.shortcuts import render,redirect,reverse
# Create your views here.
from custompermission import enums
from custompermission.models import Perm
from django.contrib.auth.decorators import login_required
from custompermission.decorators import has_generic_permission
from django.http import HttpResponse,Http404
from django.views import View
#from .forms import PermissionForm,UserForm,PermissionCreationForm,CreateOrganizationForm
from django.shortcuts import HttpResponseRedirect
from django.views.decorators.cache import cache_control
from django.views.decorators.csrf import csrf_exempt
from .models import Organization
from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView,UpdateView,DeleteView
from accounts.forms import CreateUserForm
from organization.models import UserInformation
from django.contrib.auth.models import User
from django.views.generic.list import ListView
#from django.views.generic import DeleteView
from django.views.generic.edit import DeleteView
from django.core.exceptions import ObjectDoesNotExist
import threading,cv2
from django.http import StreamingHttpResponse
from django.template import Context, Template

from django.db.models import Q
from .forms import (CreateCourseForm , TopicForm ,
	CreateCourseForSuperuser,AddActivityForm,CategoryForm,CourseEnrollForm,
	PermissionForm,UserForm,PermissionCreationForm,CreateOrganizationForm,
	AddOrganizationUser,
	AddUserOfOrganizationForSuperUser,ScheduleSessionForm,CreateGroupForm,
	SubTopicForm,AddVideoForm,SpinActivityForm,TopicDetailsForSpin,CourseAllotForm,
	CountryForm,StateForm,CityForm
)
from django.core.exceptions import EmptyResultSet

from .models import (Categories,CourseEnroll, 
	Courses,LanguageCourse , Language ,TopicRelation,UserCategories,
	Topic,CategoriesHirerchy,SessionActivity,Question,TopicDetails,SpinActivity,
	Country,City,State,AssignmentActivity)
 
from datetime import datetime , timedelta
from django.utils import timezone
from django.utils.decorators import method_decorator
from django.utils.text import unescape_entities
from django.utils.html import escape
from .auth_helper import get_sign_in_flow, get_token_from_code,get_token,store_user
from .graph_helper import *
from .forms import AssignmentForm,DragForm,DragElementForm
from .models import DragDropActivity,DragDropActivityElements
from custompermission.decorators import has_generic_permission
from userlms.decorators import is_profile_complete
import logging
from django.contrib.auth import get_user_model
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

logger=logging.getLogger('django')



UPLOAD_PATH = 'uploads/%Y/%m'


from datetime import date
import os

def handle_uploads(request, keys):
	saved = []
	
	upload_dir = date.today().strftime(settings.UPLOAD_PATH)
	upload_full_path = os.path.join(settings.MEDIA_ROOT, upload_dir)

	if not os.path.exists(upload_full_path):
		os.makedirs(upload_full_path)

	for key in keys:
		if key in request.FILES:
			upload = request.FILES[key]
			while os.path.exists(os.path.join(upload_full_path, upload.name)):
				upload.name = '_' + upload.name
			dest = open(os.path.join(upload_full_path, upload.name), 'wb')
			for chunk in upload.chunks():
				dest.write(chunk)
			dest.close()
			saved.append((key, os.path.join(upload_dir, upload.name)))
	# returns [(key1, path1), (key2, path2), ...]
	return saved


@is_profile_complete()
def admin_home(request):
	#all_user = UserInformation.objects.all()
	#all_organization = Organization.objects.all()
	#all_course = CoursesEndUser.objects.all()

	#print(request.user)
	page = request.GET.get('page', 1)

	if request.user.is_superuser:
		all_user = get_user_model().objects.all()
		all_organization = Organization.objects.all()
		all_course = CoursesEndUser.objects.all()
		paginator = Paginator(all_course, 8)

	elif (request.user.perms.has_perm("generic.can_view_admin_panel") or 
		request.user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists()):

		user=request.user
		orgs=user.organization_student.all()
		if len(orgs) > 0:
			org=orgs[0]
			all_course = org.get_all_courses()
			paginator = Paginator(all_course, 8)
			all_organization = orgs
			all_user = org.students.all()

	else:
		return HttpResponseRedirect(reverse_lazy('userlms:home'))
		# ui=UserInformation.objects.filter(user=request.user)
		# if len(ui) > 0:
		# 	all_course=ui[0].organization.get_all_courses()
		# 	all_organization=Organization.objects.filter(id=ui[0].organization_id)
		# 	all_user = UserInformation.objects.filter(organization=ui[0].organization)
	try:
		course = paginator.page(page)
	except PageNotAnInteger:
		course = paginator.page(1)
	except EmptyPage:
		course = paginator.page(paginator.num_pages)

	return render(request,'customadmin/dashboard.html',{'users':all_user,
		'organizations':all_organization,'courses':all_course,'course':course,'user':request.user})
	




@has_generic_permission('generic.can_create_role','Permission required for creating Role- Please contact Admin')
def add_role(request):
	if request.method == "POST":
		name= request.POST.get('name',False)
		permission = request.POST.getlist('permission[]',False)
		print(permission)
		if name:
			try:
				g=Group.objects.create(name=name)
				if permission:
					for p in perms:
						g.perms.add(Perm.objects.get(id=p))
				return HttpResponse("true")
			except :
				return HttpResponse("You dont have permission")
	return HttpResponse("error")



def drag(request,pk):
	redirect_url ='customadmin:edit_course_user'
	form_class = DragForm
	if request.method=="GET":
		try:
			activity_data = None
			nextval = request.GET.get('next',None)
			activity_id=request.GET.get('activtiy_id',False)
			t = Topic.objects.get(id=pk)
			if activity_id:
				d=DragDropActivity.objects.filter(id=activity_id)
				if len(d) > 0:
					activity_data=JSON.loads(d.settings_data)
		except Topic.DoesNotExist:
			messages.info(request,"drag activity could not be added")
			return HttpResponseRedirect(reverse_lazy(redirect_url))
		form = form_class(initial={'topic':t})
		
		return render(request,'customadmin/add_drag_activity.html',{'form':form,
			'desc':'Add Assignment','next':nextval,'topicid':pk,'activity_data':activity_data})
	else:
		title = request.POST.get('title',None)
		print(request.POST.dict().items())
		#title=data.pop('title')
		#print('title is ',title)
		topicid=request.POST.get('topicid',None)
		import json
		#width=request.POST.get('width',None)
		#height=request.POST.get('height',None)
		#background= request.POST.get('background',None)
		data_dict = {k:v for k,v in request.POST.dict().items()}

		#setting_data={'height':height,'width':width,'background':background}
		if topicid is not None:
			t = Topic.objects.get(id=pk)
			a=Activities(activity_name=title,
				activity_type='drag_and_drop',author=request.user,topic_id=t.id)
			a.save()

			d=DragDropActivity.objects.create(name=title,
				settings_data = json.dumps(data_dict),activity_id=a.id)
			a.content_id=d.id
			a.save()
			#messages.success(request,"activity added successfully")
			return HttpResponse(a.id)
		return HttpResponse('error')

		#form = form_class(request.POST)
		# if form.is_valid():
		# 	name=form.cleaned_data.get("name",None)
		# 	topic = form.cleaned_data.get('topic',None)
		# 	a=Activities(activity_name=name,
		# 		activity_type='drag_and_drop',author=request.user,
		# 		topic_id=topic.id)
		# 	a.save()
		# 	obj=form.save(commit=False)
		# 	obj.activity_id = a.id
		# 	obj.
		# 	obj.save()
		# 	a.content_id=obj.id
		# 	a.save()
		# 	messages.success(request,"assignment activity added successfully")
		# 	return render(request,'customadmin/add_topics.html',
		# 	{'form':form,'desc':'Add Assignment'})
		# else:
		# 	print(form.errors)


def delete_drag_element(request,pk):
	if request.method=="POST":
		try:
			de=DragDropActivityElements.objects.get(id=pk)
			de.delete()
			return HttpResponse("true")
		except:
			pass
	return HttpResponse("error")
	

from django.forms.models import model_to_dict
def drag_element(request,pk):
	if request.method=="GET":
		try:
			da=DragDropActivity.objects.get(id=pk)
			dict_da=model_to_dict(da,fields=[field.name for field in da._meta.fields if not 'date' in field.name])
			all_element=[]
			daes=DragDropActivityElements.objects.filter(dd_activity=da)
			for dae in daes:
				all_element.append(model_to_dict(dae,fields=[field.name for field in da._meta.fields]))
			import json
			json_data=json.dumps({'activity':dict_da,'elements':all_element})
			return HttpResponse(json_data);

		except DragDropActivity.DoesNotExist:
			print("wrong id ")

	if request.method=="POST":
		try:
			edit=request.POST.pop('edit',False)
			element_id=request.POST.pop('element_id',False)
			act=Activities.objects.get(id=pk)
			d=DragDropActivity.objects.get(id=act.content_id)
			#print(request.POST)
				#data = request.POST.get('data')
				#print(data)
			label=request.POST.get('label')
			import json
			data = {k:v[0] for k,v in request.POST.dict().items()}
			md = {'left':request.POST.get('left',None),'top':request.POST.get('top',None),
				'labelShow':request.POST.get('labelShow',None),
				'backgroundOpacity':request.POST.get('backgroundOpacity',None),
				'correctDroppables':request.POST.get('correctDroppables',None),
				'dropOnlyOne':request.POST.get('dropOnlyOne',None)}

			if not edit:
				de=DragDropActivityElements.objects.create(label=label,
					dd_activity=d,settings_data=json.dumps(data))
			else:
				de=DragDropActivityElements.objects.filter(id=element_id).update(settings_data=json.dumps(data),
					label=label)
			return HttpResponse(json.dumps({'id':de.id}))

		except Activities.DoesNotExist:
			#print("ffffkfk")
			return HttpResponse("error")
	return HttpResponse("error")
	#form_class = DragElementForm



def edit_assignment(request,pk):
	ac= Activities.objects.filter(content_id=int(pk),activity_type='Assignment')
	#print(ac)
	if len(ac) > 0:
		asac=AssignmentActivity.objects.get(id=pk)
	if request.method=="GET":
		#print(pk)
		nextval=request.GET.get('next',False)
		form = AssignmentForm(initial={'topic':int(ac[0].topic_id)},instance=asac)
		print(form)
		#if form.is_valid():
		return render(request,'customadmin/add_topics.html',{'form':form,
			'desc':'Add Assignment','next':nextval})
			#else:
		#print(form.errors)
		#return HttpResponse("ddd")
	if request.method=="POST":
		nextval=request.POST.get('next','')
		form = AssignmentForm(request.POST,request.FILES,
			instance=asac)
		if form.is_valid():
			form.save()
			messages.success(request,'assignment activity has been edited')
			return HttpResponseRedirect(settings.EXTRA_URL+nextval.replace("$","#"))
		return render(request,'customadmin/add_topics.html',{'form':form,
				'desc':'Add Assignment','next':nextval})

def assignment(request,pk):
	redirect_url ='customadmin:edit_course_user'
	if request.method=="GET":
		nextval=request.GET.get('next',False)
		try:
			t=Topic.objects.get(id=pk)
		except Topic.DoesNotExist:
			return HttpResponseRedirect(reverse_lazy(redirect_url))
		form = AssignmentForm(initial={'topic':t})
		return render(request,'customadmin/add_topics.html',{'form':form,
			'desc':'Add Assignment','next':nextval})
	else:
		form = AssignmentForm(request.POST,request.FILES)
		#print(form)
		if form.is_valid():
			description=form.cleaned_data.get("description",None)
			topic = form.cleaned_data.get('topic',None)
			nextval=request.POST.get('next',False)
			#print(nextval)
			a=Activities(activity_name=description,
				activity_type='Assignment',author=request.user,
				topic_id=topic.id)
			a.save()

			obj=form.save(commit=False)
			obj.activity_id = a.id
			obj.save()
			a.content_id=obj.id
			a.save()
			messages.success(request,"assignment activity added successfully")
			if nextval:
				return HttpResponseRedirect(settings.EXTRA_URL+nextval.replace("$","#"))
			return render(request,'customadmin/add_topics.html',
			{'form':form,'desc':'Add Assignment'})
		else:
			print(form.errors)
			#messages.success(request,form.errors)
			return render(request,'customadmin/add_topics.html',{'form':form,'desc':'Add Assignment'})


def get_iana_from_windows(windows_tz_name):
	if windows_tz_name in settings.ZONE_MAPPINGS:
		return settings.ZONE_MAPPINGS[windows_tz_name]
	else:
		return windows_tz_name

def callback(request):
	result = get_token_from_code(request)
	print(result)
	user = get_user(result['access_token'])
	store_user(request, user)
	return HttpResponseRedirect(reverse('userlms:home'))

def outlook_sign_in(request):
	#Get the sign-in flow
	flow = get_sign_in_flow()
	# Save the expected flow so we can use it in the callback
	request.session['auth_flow'] = flow
	# Redirect to the Azure sign-in page
	return HttpResponseRedirect(flow['auth_uri'])


@csrf_exempt
def test(request):
	if request.method=="POST":
		import json
		#print(request.POST)
		x=request.POST.get('data',None)
		x=json.loads(x)
		return HttpResponse(x)


from .models import CoursesEndUser
#@login_required(login_url='accounts:login')
def home(request):
	try:
		course_list=CoursesEndUser.objects.all().order_by('id')
		all_cuser_categories=UserCategories.objects.all().order_by('id')
		print(course_list)
		return render(request,'user_lms/first.html',{'user':request.user,'object_list':course_list,
			'categories':all_cuser_categories})
	except:
		return HttpResponse('401 Unauthorized', status=401)

t = Template('{{ mydata }} <br />\n')

def initialize_context(request):
	context = {}
	error = request.session.pop('flash_error', None)

	if error != None:
		context['errors'] = []
		context['errors'].append(error)

	context['user'] = request.session.get('user', {'is_authenticated': False})
	return context


#@has_generic_permission('generic.can_see_calendar','you dont have permission')
def calendar(request):
	# context = initialize_context(request)
	# user = context['user']

	# #from django.utils import tz
	# import pytz
	# #time_zone = get_iana_from_windows(user['Asia/Kolkata'])
	# #tz_info = tz.gettz('Asia/Kolkata')

	# today = datetime.now().replace(
	# #today = datetime.now(tz_info).replace(
	# 	hour=0,
	# 	minute=0,
	# 	second=0,
	# 	microsecond=0)

	# # Based on today, get the start of the week (Sunday)
	# if (today.weekday() != 6):
	# 	start = today - timedelta(days=today.isoweekday())
	# else:
	# 	start = today

	# end = start + timedelta(days=7)

	# token = get_token(request)

	# events = get_calendar_events(
	# 	token,
	# 	start.isoformat(timespec='seconds'),
	# 	end.isoformat(timespec='seconds'),
	# 	user['timeZone']
	# )



	# if events:
	# # Convert the ISO 8601 date times to a datetime object
	# # This allows the Django template to format the value nicely
	# 	for event in events['value']:
	# 		event['start']['dateTime'] = parser.parse(event['start']['dateTime'])
	# 		event['end']['dateTime'] = parser.parse(event['end']['dateTime'])

	# 	context['events'] = events['value']

	return render(request, 'customadmin/calendar_1.html',{'user':request.user})

class VideoCamera(object):
	def __init__(self):
		self.video = cv2.VideoCapture(0)
		(self.grabbed, self.frame) = self.video.read()
		threading.Thread(target=self.update, args=()).start()

	def __del__(self):
		self.video.release()

	def get_frame(self):
		image = self.frame
		ret, jpeg = cv2.imencode('.jpg', image)
		return jpeg.tobytes()

	def update(self):
		while True:
			(self.grabbed, self.frame) = self.video.read()

def gen(camera):
	vc=VideoCamera()
	while True:
		frame = vc.get_frame()
		#c = Context({'mydata': frame})
		yield(b'--frame\r\n' 
			b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n\r\n')

def test_classroom(request):
	try:
		resp=StreamingHttpResponse(gen(VideoCamera()), content_type="multipart/x-mixed-replace;boundary=frame")
		return render(request,'customadmin/test_classroom.html',{'frame':resp})
	except:
		pass


@login_required
@has_generic_permission('generic.can_create_custompermission')
def create_permission(request):
	Perm.objects.create(
		type=enums.PERM_TYPE_GENERIC,
		codename='can_assign_custom_permission',
	)
	Perm.objects.create_from_str('generic.export')

	return HttpResponse("permission has been created")


import json
@login_required
def user_permission(request):
	user=request.user
	l=[]
	
	for permission in user.perms.all():
		dic={}
		dic['codename']=permission.codename
		dic['type']=permission.type
		dic['description']=permission.description
		l.append(dic)

	#print(json.dumps(l))

	return render(request,'tables.html',{'data':json.dumps(l)})


@login_required
@has_generic_permission('generic.can_see_all_custompermission')
def all_permission(request):
	user=request.user
	l=[]

	for permission in Perm.objects.all():
		dic={}
		dic['codename']=permission.codename
		dic['type']=permission.type
		dic['description']=permission.description
		l.append(dic)

	return render(request,'tables.html',{'data':json.dumps(l)})


@login_required
@has_generic_permission('generic.can_assign_custompermission')
@has_generic_permission('generic.can_see_all_custompermission')
def assign_permission(request):
	return HttpResponse("working on it")

from django.urls import reverse_lazy

class CustomMixin(object):
	permission_failure = reverse_lazy('accounts:permission_failure')
	#def __init__(self):
		#self.permission_name=permission_name
	form_class = None
	user_type=None
	def check_user(self, user):
		if user.is_authenticated:
			return True

	def get_user_type(self,user):
		if user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
			self.user_type='company admin'
		elif user.groups.filter(name=settings.COMPANY_INSTRUCTOR_GROUP).exists():
			self.user_type='company instructor'
		elif user.groups.filter(name=settings.COMPANY_COLLAB_GROUP).exists():
			self.user_type='company collaborator'
		elif user.is_superuser:
			self.user_type='superuser'
		else:
			self.user_type='end user'


	def form_class(self):
		if self.form_class:
			return self.form_class

	def user_check_failed(self, request, *args, **kwargs):
		#messages.success(request,'you dont have permission')
		return redirect(self.permission_failure)

	def dispatch(self, request, *args, **kwargs):
		self.form_class()
		if not self.check_user(request.user):
			return self.user_check_failed(request, *args, **kwargs)
		return super(CustomMixin, self).dispatch(request, *args, **kwargs)


from django.contrib.auth.models import Group
@login_required
@has_generic_permission('generic.can_assign_custompermission',redirect='(can assign custompermission), permission required')
@has_generic_permission('generic.can_see_all_custompermission',redirect='(can see all_custompermission), permission required')
def assign_permission_and_role(request):
	if request.method=="POST":
		permissions=request.POST.getlist('permission[]',None)
		roles= request.POST.getlist('group[]',None)
		user = request.POST.get('user',None)
		print(permissions,roles)
		if user is not None :
			try:

				u=User.objects.get(id=user)
				

				for p in u.perms.all():
					u.perms.remove(p)

				for p in permissions:
					p_o=Perm.objects.get(id=p)
					u.perms.add(p_o)

				allready_in_group=u.groups.all()
				for g in allready_in_group:
					g.user_set.remove(u)
					for gp in g.perms.all():
						u.perms.remove(gp)


				for g in roles:
					g_o=Group.objects.get(id=g)
					#print(g_o)
					g_o.user_set.add(u)
					#print("after adding")

				#print("here")

				return HttpResponse("true")

			except:
				return HttpResponse("error occured")
	return HttpResponse("error")


class CreatePermission(CustomMixin,View):
	form_class = PermissionCreationForm
	template_name='create_custom_permission.html'
	permission_failure ='customadmin:students'
	success_url='customadmin:create_permission'

	def check_user(self,user):
		if user.is_superuser:
			return True
		if user.perms.has_perm("generic.can_create_custompermission"):
			return True
		return False

	# @has_generic_permission('generic.can_create_custompermission')
	# def dispatch(self, request, *args, **kwargs):
	#   return super(CreatePermission, self).dispatch(request, *args, **kwargs)
	def get(self,request,*args,**kwargs):
		return render(request,self.template_name,
			{'form':self.form_class(),'desc':'create permission',
			'action':self.success_url,'next':request.GET.get('next',False)})

	@has_generic_permission('generic.can_create_custompermission')
	def post(self,request,*args,**kwargs):
		form=self.form_class(request.POST)
		if form.is_valid():
			nextval =request.POST.get('next',False)
			form.save()
			if nextval:
			#cleaned_data=self.form_class().clean()
			#print(form.cleaned_data)
				messages.success(request,"permission created successfully")
				return HttpResponseRedirect(nextval)
			else:
				return render(request,self.template_name,{'form':form,
					'msg':'Permission Created Successfully',
					'action':self.success_url})
		else:
			return render(request,self.template_name,{'form':form,
				'msg':form.errors,'action':self.success_url})
		

from django.conf import settings
from django.contrib.auth.models import Group
from django.contrib import messages
def create_group_for(forwhat):
	if forwhat=="company_admin":
		g,created=Group.objects.get_or_create(name=settings.COMPANY_ADMIN_GROUP)
		if created:
			try:
				for custom_permission in settings.COMPANY_ADMIN_PERM:
					p=Perm.objects.get_from_str(custom_permission)
					g.perms.add_perm(p)
			except:
				print("deleting grp", g.id)
				g.delete()
				return None
		else:
			print("group already created")
			if len(g.perms.all()) < 1:
				try:
					for custom_permission in settings.COMPANY_ADMIN_PERM:
						p=Perm.objects.get_from_str(custom_permission)
						g.perms.add_perm(p)
				except:
					print("deleting grp", g.id)
					g.delete()
					return None
		return g
	elif forwhat == "student":
		pass
		# g,created=Group.objects.get_or_create(name=settings.COMPANY_USER_GROUP)
		# if created:
		# 	try:
		# 		for custom_permission in settings.COMPANY_USER_GROUP:
		# 			p=Perm.objects.get_from_str(custom_permission)
		# 			g.perms.add_perm(p)
		# 	except:
		# 		print("deleting grp", g.id)
		# 		g.delete()
		# 		return None
		# return g
	else:
		pass


class DeleteOrganization(CustomMixin,DeleteView):
	model = Organization
	form_class = CreateOrganizationForm
	success_url = reverse_lazy('customadmin:all_organization')

	def check_user(self,user):
		if user.is_authenticated:
			if user.is_superuser or user.perms.has_perm("generic.can_delete_organization"):
				return True
		return False

	def get_context_data(self,**kwargs):
		ctx = super(DeleteOrganization, self).get_context_data(**kwargs)
		ctx['desc']='Delete Organization'
		return ctx

	def post(self,*args,**kwargs):
		self.obj=self.get_object()
		#u=User.objects.get(username=self.obj.contact_person_email)
		#g=Group.objects.get(name='company_admin_group')
		#g.user_set.remove(u)
		#ui=UserInformation.objects.filter(user_id=u.id)
		#if len(ui) > 0:
			#ui[0].delete()
		#u.delete()
		#self.obj.delete()
		self.obj.is_active = False
		self.obj.save()
		messages.success(self.request,f"Organization {self.obj.organization_name} is inactive now")
		return HttpResponseRedirect(self.success_url)
	
	def get(self, *args, **kwargs):
		return self.post(*args, **kwargs)


class EditOrganization(CustomMixin,UpdateView):
	model = Organization
	form_class = CreateOrganizationForm
	template_name_suffix = '_create_form_3'
	success_url = reverse_lazy('customadmin:all_organization')

	def check_user(self,user):
		if user.is_authenticated:
			if user.is_superuser or user.perms.has_perm("generic.can_edit_organization"):
				return True
		return False


	def form_invalid(self,form):
		messages.info(self.request,"organization could not be edited")
		return HttpResponseRedirect(self.success_url)


	def get_context_data(self,**kwargs):
		ctx = super(EditOrganization, self).get_context_data(**kwargs)
		ctx['desc']='Edit Organization'
		ctx['editing'] = True
		ctx['obj'] = self.get_object()
		return ctx



def save_image_to_folder(folder,image,name):
	import os
	from PIL import image
	i=Image.open(image)

	i.save(settings.MEDIA_ROOT+folder+name+".png")

def save_org_cer_img(request):
	if request.method=="POST":
		img=request.FILES.get('image',False)
		org_name = request.POST.get('name',False)
		if img:
			save_image_to_folder('organization_certificate',img,org_name)
			return HttpResponse("true")
	return HttpResponse("error")



class CreateOrganization(CustomMixin,CreateView):
	#model = Organization
	template_name_suffix = '_create_form_2'
	#fields = ('name','email','password','address','website','no_of_candidates','company_logo',
	#'end_date','phone',)

	#template_name = 'organization'
	form_class = CreateOrganizationForm
	model = Organization
	success_url = reverse_lazy('customadmin:create_organization')

	def check_user(self,user):
		if user.is_authenticated:
			if user.is_superuser or user.perms.has_perm("generic.can_create_organization"):
				return True
		return False
	# # def get_initial(self):
	# #     initial_data = super(CreateOrganization, self).get_initial()
	# #     #initial_data['first_name'] = 'from initial data'
	# #     #initial_data['title']='Create Organization'
	# #     return initial_data

	def get_context_data(self, **kwargs):
		ctx = super(CreateOrganization, self).get_context_data(**kwargs)
		ctx['desc'] = 'Create Organization'
		#print(ctx)
		return ctx


	def form_valid(self, form):
		#print(type(model))
		#print(self.request.POST)
		try:
			g=create_group_for('company_admin')
			if g is None:
				return HttpResponse("problem with permission")
			#p_can_add_user=Perm.objects.get(codename='can_add_user_of_organization', type='generic')
			#p_can_see_all=Perm.objects.get(codename='can_see_all_courses', type='generic')
			#p_can_create=Perm.objects.get(codename='can_create_courses_for_organization', type='generic')
		except ObjectDoesNotExist as e:
			print("required permission need to be created")
			raise KeyError("permission need to be created")
		try:
			post_data={
				'username':form.cleaned_data['contact_person_email'],
				'password1':form.cleaned_data['password']
			}
			profile_update=self.request.POST.get('profile_update',False)
			try:
				self.obj = form.save(commit=True)
			except:
				messages.success(self.request,'organization could not be created...')
				return HttpResponseRedirect(self.success_url)
			if not profile_update:
				if get_user_model().objects.filter(email=form.cleaned_data['contact_person_email']).exists():
					messages.info(self.request,"Organization with this email already exist")
					return HttpResponseRedirect(self.success_url)
				user_obj=get_user_model().objects.create_user(email=form.cleaned_data['contact_person_email'],
					phone=form.cleaned_data['contact_person_phone'])
				user_obj.set_password(form.cleaned_data['password'])
				user_obj.position='admin'
				user_obj.save()
				g.user_set.add(user_obj)

				for p in settings.COMPANY_ADMIN_PERM:
					po=Perm.objects.get_from_str(p)
					user_obj.perms.add(po)


				
				self.obj.students.add(user_obj)
			else:
				#self.obj=form.save(commit=True)
				self.obj.students.add(self.request.user)

			#UserInformation.objects.create(user=user_obj,end_user=False,position='admin',phone=form.cleaned_data['contact_person_phone'],
			#email=form.cleaned_data['contact_person_email'],is_active=True,organization=self.obj)
			"""Assign permission to created User """
			#user_obj.perms.add_perm(p_can_add_user)
			#user_obj.perms.add_perm(Perm.objects.get(codename='can_see_organization_courses', type='generic'))
			#user_obj.perms.add_perm(p_can_see_all)
			#user_obj.perms.add_perm(p_can_create)
			#user_form = CreateUserForm(post_data)
			# if user_form.is_valid():
			#   user_form.save()
			# else:
			#   return HttpResponse("hi")
			self.request.session['organization'] = self.obj.website
			#self.obj=form.save(commit=False)
			if self.obj.certificate is not None:
				#import os 
				#import webkit2png
				#os.system('webkit2png escape(self.obj.certificate) -o BASE_DIR+"uploads/organization_certificate/"+self.obj.name+".png"')
				self.obj.certificate = escape(self.obj.certificate)
			
			try:
				self.obj.save()
				messages.success(self.request,'organization created')
			except:
				messages.success(self.request,'organization could not be created...')
			
			if self.request.POST.get('ajax_request',False):
				self.request.user.profile_complete=1
				self.request.user.has_organization=1
				self.request.user.save()
				return HttpResponseRedirect(reverse_lazy('userlms:home'))
			return HttpResponseRedirect(self.success_url)
			#return super(CreateOrganization, self).form_valid(form)
		except Exception as e:
			print(e)
			raise KeyError(e)

	def form_invalid(self,form):
		print(form.errors)
		messages.info(self.request,form.errors)
		return render(self.request,'customadmin/organization_create_form_1.html',{'form':form})
		#return HttpResponseRedirect(self.success_url)




class CreateOrganizationUser(CustomMixin,CreateView):
	#model = UserInformation
	model = get_user_model()
	#template_name_suffix = '_create_form'
	#fields = '__all__'
	#template_name = 'customadmin/create_organization_user_form'
	template_name = 'customadmin/user_profile_1.html'
	form_class = AddOrganizationUser
	success_url = reverse_lazy('customadmin:students')

	def check_user(self,user):
		if user.is_authenticated:
			if user.is_superuser or user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists() or user.perms.has_perm('generic.can_add_user_of_organization'):
				return True
		return False


	def form_class(self):
		if self.request.user.is_superuser:
			self.form_class=AddUserOfOrganizationForSuperUser
		else:
			self.form_class = AddOrganizationUser
			return self.form_class

	def get_initial(self):
		initial_data = super(CreateOrganizationUser, self).get_initial()
		#initial_data['registration_date'] = timezone.now()
		#if not self.request.user.is_superuser :
			#ui=UserInformation.objects.filter(user_id=self.request.user.id)
			#initial_data['organization_id'] = ui[0].organization_id
			#initial_data['organization_id'] = self.request.session['organization_id']
			#self.form_class = AddUserOfOrganizationForSuperUser
			#initial_data['organization']=Organization.objects.all()
			#raise KeyError("Please give for which organization you want to add User")
		#return initial_data

	def get_context_data(self, **kwargs):
		ctx = super(CreateOrganizationUser, self).get_context_data(**kwargs)
		ctx['desc'] = 'Create Organization User'
		ctx['create'] = True
		if self.user_type == "superuser":
			ctx['is_superuser'] = True
		return ctx

	def form_valid(self,form):
		# try:
		#   #p_can_add_user=Perm.objects.get(codename='can_add_user_of_organization', type='generic')
		#   p_can_see_all= Perm.objects.get(codename='can_see_all_courses', type='generic')
		#   p_can_enroll_courses=Perm.objects.get(codename='can_enroll_into_courses', type='generic')
		#   #p_can_create=Perm.objects.get(codename='can_create_courses_for_organization', type='generic')
		# except ObjectDoesNotExist as e:
		#   print("required permission need to be created")
		#   raise KeyError("permission need to be created")
		#print(form.cleaned_data)
		#print(form.cleaned_data['organization'].id)
		my_group=''
		organization_id=None
		already_user=0
		no_of_candidates=0
		if not self.request.user.is_superuser:
			user=self.request.user
			orgs=user.organization_student.all()
			if len(orgs) > 0:
				org=orgs[0]
			#ui=UserInformation.objects.filter(user_id=self.request.user.id)
			#print(ui[0])
				organization_id = org.id
		elif self.request.user.is_superuser:
			organization_id=form.cleaned_data['organization'].id
		else:
			raise TypeError("new cases occured")
		
		if organization_id is not None:
			#already_user=UserInformation.objects.filter(organization_id=organization_id,position='student').count()
			orgs=Organization.objects.filter(id=organization_id)
			already_user = len(orgs[0].students.all())
			no_of_candidates=orgs[0].no_of_candidates

		if no_of_candidates is not None:
			if no_of_candidates <= already_user:
				messages.add_message(self.request,messages.INFO,'User added limit exceed')
				return HttpResponseRedirect(self.success_url)
		try:
			user_obj = get_user_model().objects.create_user(email=form.cleaned_data['email'],
				first_name=form.cleaned_data['first_name'],phone=form.cleaned_data['phone'],
				last_name=form.cleaned_data['last_name'])
			# user_obj = User.objects.create_user(username=form.cleaned_data['email'],
			# 	first_name=form.cleaned_data['first_name'],last_name=form.cleaned_data['last_name'])
			user_obj.set_password(form.cleaned_data['password'])
			user_obj.save()
			#if form.cleaned_data['position'] =='teacher':
			#user_obj.perms.add_perm(p_can_see_all)
			#user_obj.perms.add_perm(p_can_enroll_courses)
			#self.obj = form.save(commit=False)
			#print(self.obj)
			#self.obj.user_id=user_obj.id
			position=form.cleaned_data.get('position',None)
			if position == "student":
				my_group,created = Group.objects.get_or_create(name=settings.END_USER_GROUP)
			elif position=="teacher":
				my_group,created = Group.objects.get_or_create(name=settings.COMPANY_INSTRUCTOR_GROUP)
			#print(my_group)
			my_group.user_set.add(user_obj)
			#user_obj.groups.add(settings.END_USER_GROUP)
			#self.obj.end_user=0
			user_obj.is_active=1
			#self.obj.is_active=1
			#self.obj.organization_id = organization_id
			#print(form.cleaned_data)
			#self.obj.email=form.cleaned_data['email']
			user_obj.email = form.cleaned_data['email']
			user_obj.gender = form.cleaned_data['gender']
			user_obj.position = form.cleaned_data['position']
			user_obj.dob = form.cleaned_data.get('dob',None)
			#user_obj.phone = form.cleaned_data['phone']
			
			#self.obj.phone=form.cleaned_data['phone']
			#self.obj.registration_date=datetime.now().today()
			#self.obj.date_joined=datetime.now().today()
			#self.obj.image = form.cleaned_data.get('image',None)
			user_obj.image = form.cleaned_data.get('image',None)
			#print(self.obj.__dict__)
			try:
				#self.obj.save()
				user_obj.save()
			except :
				my_group.user_set.remove(user_obj)
				#self.obj.delete()
				user_obj.delete()
			#org=form.cleaned_data.get('organization',None)
			#if org is not None:
			oos=Organization.objects.filter(id=organization_id)
			if len(oos) > 0:
				oos[0].students.add(user_obj)
			messages.add_message(self.request,messages.INFO,'User added successfully')
			return HttpResponseRedirect(self.success_url)
			#return super(CreateOrganizationUser, self).form_valid(form)
		except Exception as e:
			print(e)
			# user_obj = UserInformation.objects.filter(user=form.cleaned_data['email'])
			# if len(user_obj) > 0:
			# 	my_group.user_set.remove(user_obj[0])
			# 	user_obj[0].delete()
			messages.add_message(self.request,messages.INFO,'Problem with Input Data')
			return render(self.request,self.template_name,{'form':form})
		return super(CreateOrganizationUser, self).form_valid(form)

	def form_invalid(self,form):
		print(form.errors)
		messages.add_message(self.request,messages.INFO,form.errors)
		return HttpResponseRedirect(self.success_url)


def analytics(request):
	import psutil
	vcc=psutil.cpu_count()
	vcpu=psutil.cpu_percent()
	vvm=psutil.virtual_memory()
	x=dict(psutil.virtual_memory()._asdict())
	list_p=[]
	c=1
	for process in psutil.process_iter():
		c=c+1
		if c > 10:
			break
		Name = process.name () # Name of the process
		ID = process.pid # ID of the process
		list_p.append(Name)
	#print ("Process name =", Name ,",","Process ID =", ID)
	return render(request,'customadmin/analytics.html',{'cpucount':vcc,
		'cpupercent':vcpu,'virtual':x,'process':list_p})


class UserChat(ListView):
	pass


class AllCourse(ListView):
	""" Show All Courses """
	model=Courses
	template_name='customadmin/all_courses.html'
	paginate_by =10
	ordering = ['-created']

	def get_context_data(self,**kwargs):
		ctx = super(AllCourse, self).get_context_data(**kwargs)
		ctx['desc']='View All Course'
		#print(Organization.objects.filter(id=self.request.session['organization'].id)[0].name)
		#if not self.request.user.is_superuser:
			#ctx['organization'] = self.request.session['organization']
			#ctx['organization_name'] = self.request.session['organization']
		return ctx

	def get_queryset(self,*args,**kwargs):
		orgid=self.kwargs.get('orgid',None)
		categoryid=self.request.GET.get('category',None)

		if categoryid is not None:
			try:
				category=Categories.objects.get(id=categoryid)
				org=Organization.objects.get(id=category.organization_id)
				#ctx=self.get_context_data()
				#self.ctx['desc'] = 'category '+category.name +'\'s Courses'
				return Courses.objects.filter(courses_category_id=category)
			except Categories.DoesNotExist:
				raise Http404("no course assigned with this topic")
			except Organization.DoesNotExist:
				raise Http404("no organization found with this topic")
				#raise Http404("No Organization found with this ")
		elif orgid is not None:
			try:
				print("orgid",orgid)
				org=Organization.objects.get(id=orgid)
				return org.get_all_courses()
			except Exception as e:
				raise KeyError(e)
		else:
			s_org_id=self.request.session.get('organization_id',None)
			#print(s_org_id)
			if s_org_id is not None:
				print("user is from orga")
				#print(self.model.objects.filter(organization_id=s_org_id,is_trial=0))
				return self.model.objects.filter(organization_id=s_org_id,is_trial=0)
			return self.model.objects.filter(is_trial=0)


class CountryListView(CustomMixin,ListView):
	model = Country
	template_name = 'customadmin/country_list.html'
	paginate_by = 10  
	context_object_name = 'object_list'

	def check_user(self,user):
		return True

	def get_queryset(self):
		try:
			a = self.request.GET.get('country', )
		except KeyError:
			a = None
		if a:
			country_list = Country.objects.filter(
				name__icontains=a,
				#owner=self.request.user
			)
		else:
			country_list = Country.objects.filter()
		return country_list

	def get_context_data(self, **kwargs):
		context = super(CountryListView, self).get_context_data(**kwargs)
		context['desc'] ='Country List'
		return context




class CountryCreate(CustomMixin,CreateView):
	form_class = CountryForm
	model = Country
	success_url = reverse_lazy('customadmin:country')

	def check_user(self,user):
		if user.is_superuser:
			return True

	def get_context_data(self, **kwargs):
		context = super(CountryCreate, self).get_context_data(**kwargs)
		return context


class CountryUpdate(CustomMixin,UpdateView):
	form_class = CountryForm
	model = Country
	success_url = reverse_lazy('customadmin:country')

	def check_user(self,user):
		if user.is_superuser:
			return True

	def get_context_data(self, **kwargs):
		context = super(CountryUpdate, self).get_context_data(**kwargs)
		return context


class CountryDelete(CustomMixin,DeleteView):
	model = Country

	def check_user(self,user):
		if user.is_superuser:
			return True

	def get(self, *args, **kwargs):
		return self.post(*args, **kwargs)

	success_url = reverse_lazy('customadmin:country')


class StateListView(CustomMixin,ListView):
	model = State
	paginate_by = 10  # if pagination is desired
	context_object_name = 'my_state_list'


	def check_user(self,user):
		return True

	def get_queryset(self):
		try:
			a = self.request.GET.get('state', )
		except KeyError:
			a = None
		if a:
			state_list = State.objects.filter(
				name__icontains=a,
			)
		else:
			state_list = State.objects.filter()
		return state_list


	def get_context_data(self, **kwargs):
		context = super(StateListView, self).get_context_data(**kwargs)
		context['desc'] = 'State List'
		return context


class StateCreate(CustomMixin,CreateView):
	form_class = StateForm
	model = State
	success_url = reverse_lazy('customadmin:state')

	def check_user(self,user):
		if user.is_superuser:
			return True

	def get_context_data(self, **kwargs):
		context = super(StateCreate, self).get_context_data(**kwargs)
		context['desc'] = 'Create State'
		return context


class StateUpdate(CustomMixin,UpdateView):
	form_class = StateForm
	model = State
	success_url = reverse_lazy('customadmin:state')

	def check_user(self,user):
		if user.is_superuser:
			return True

	def get_context_data(self, **kwargs):
		context = super(StateUpdate, self).get_context_data(**kwargs)
		context['desc'] ='Edit State'
		return context

	def check_user(self,user):
		if user.is_superuser:
			return True


class StateDelete(CustomMixin,DeleteView):
	model = State
	success_url = 'customadmin:state'
	template_name ='customadmin/state_list.html'

	def check_user(self,user):
		if user.is_superuser:
			return True

	def post(self,*args,**kwargs):
		obj=self.get_object()
		cities=City.objects.filter(state=obj)
		for city in cities:
			city.delete()
		obj.delete()
		messages.success(self.request,"state has been deleted along with its cities")
		#return render(self.request,self.template_name)
		return HttpResponseRedirect(settings.EXTRA_URL+"/admin/state/")

	def get(self, *args, **kwargs):
		return self.post(*args, **kwargs)

	success_url = reverse_lazy('customadmin:state')


class CityListView(CustomMixin,ListView):
	model = City
	paginate_by = 10
	template_name = 'customadmin/city_list.html'
	context_object_name = 'object_list'

	def get_queryset(self):
		try:
			a = self.request.GET.get('city', )
		except KeyError:
			a = None
		if a:
			city_list = City.objects.filter(
				name__icontains=a,
			)
		else:
			city_list = City.objects.filter()
		return city_list


	def get_context_data(self, **kwargs):
		context = super(CityListView, self).get_context_data(**kwargs)
		context['desc'] = 'City List'
		return context


class CityCreate(CustomMixin,CreateView):
	form_class = CityForm
	model = City
	success_url = reverse_lazy('customadmin:city')

	def check_user(self,user):
		if user.is_superuser:
			return True

	def get_context_data(self, **kwargs):
		context = super(CityCreate, self).get_context_data(**kwargs)
		context['desc'] ='City Create'
		return context


class CityUpdate(CustomMixin,UpdateView):
	form_class = CityForm
	model = City
	success_url = reverse_lazy('customadmin:city')

	def check_user(self,user):
		if user.is_superuser:
			return True

	def get_context_data(self, **kwargs):
		context = super(CityUpdate, self).get_context_data(**kwargs)
		context['desc'] ='City Update'
		return context


class CityDelete(CustomMixin,DeleteView):
	model = City

	def check_user(self,user):
		return True

	def get(self, *args, **kwargs):
		return self.post(*args, **kwargs)

	success_url = reverse_lazy('customadmin:city')

def all_org_ajax(request):
	all_org=Organization.objects.all(is_active=1)
	pass


class AllOrganization(CustomMixin,ListView):
	""" Show All Organization """
	model=Organization
	paginate_by = 8
	template_name='customadmin/all_organization_1.html'

	def check_user(self,user):
		if user.groups.filter(name=settings.COMPANY_USER_GROUP).exists():
			return False
		if user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
			return True
		if user.is_superuser:
			return True
		if user.perms.has_perm('can_view_own_organization'):
			return True
		return False


	def get_context_data(self,**kwargs):
		ctx = super(AllOrganization, self).get_context_data(**kwargs)
		ctx['desc']='View All Organization'
		#print(Organization.objects.filter(id=self.request.session['organization'].id)[0].name)
		#if not self.request.user.is_superuser:
			#ctx['organization'] = self.request.session['organization']
			#ctx['organization_name'] = self.request.session['organization']
		return ctx


	def get_queryset(self):
		s_org_id=self.request.session.get('organization_id',None)
		self.get_user_type(self.request.user)
		if self.user_type=='company admin' or self.user_type=='company instructor':
			# ui=UserInformation.objects.get(user_id=self.request.user.id)
			# return self.model.objects.filter(id=ui.organization_id)
			user=self.request.user
			orgs=user.organization_student.all()
			return orgs
			if len(orgs) > 0:
				org=orgs[0]
				return self.model.objects.filter(id=org.id)
		#check user is org admin or instructor or collab
		elif s_org_id is not None:
			return self.model.objects.filter(id=s_org_id)

		#model_p=self.model.objects.all()
		# object_list=[]
		# for model in model_p:
		#   temp={}
		#   print(unescape_entities(model.certificate))
		return self.model.objects.all()






class CourseEnroll(CreateView,DetailView):
	model=Courses
	form_class=CourseEnrollForm
	template_name='customadmin/course_enroll.html'

	def form_valid(self,form):
		return super(CourseEnroll, self).form_valid(form)

	def get_object(self):
		obj=super().get_object()
		return obj

	def get_context_data(self,**kwargs):
		ctx = super(CourseEnroll, self).get_context_data(**kwargs)
		obj=self.get_object()
		activity_list=[]
		for topic in obj.course_topic.all():
					#print(topic)
			activity_l={}
			temp=[]
			for activity in topic.activity_topic.all():
				tem={}
				tem['activity_name'] = activity.activity_name
				tem['activity_type'] = activity.activity_type
				tem['activity_author'] = activity.author
				temp.append(tem)
			activity_l['topic_name'] = topic.name
			activity_l['topic_about'] = topic.about
			activity_l['topic_author'] = topic.author
			activity_l['topic_duration'] = topic.duration
			activity_l['activity'] = temp
			activity_list.append(activity_l)
			
		ctx['activity_list'] = activity_list
		return ctx


class CourseDetail(DetailView):
	""" Show All Courses """
	model=Courses
	template_name='customadmin/course_detail.html'

	def get_object(self):
		obj = super().get_object()
		# Record the last accessed date
		#obj.last_accessed = timezone.now()
		#obj.save()
		return obj

	def get_context_data(self,**kwargs):
		ctx = super(CourseDetail, self).get_context_data(**kwargs)
		ctx['desc']='Course Data'
		obj=self.get_object()
		if not self.request.user.is_anonymous:
			if self.request.user.perms.has_perm('generic.can_update_courses_for_organization') and \
					self.request.user.perms.has_perm('generic.can_create_courses_for_organization'):
				#ui=UserInformation.objects.get(position='admin',user=self.request.user)
				#all_teacher = UserInformation.objects.filter(organization_id=ui[0].organization_id,position='teacher')
				#ctx['all_teacher'] = all_teacher
				#print(ui)
				#check for topics and activity
				all_teacher = UserInformation.objects.filter(organization_id=self.get_object().organization_id,
					position='teacher').exclude(end_user=1)

				f_list=[]
				for teacher in all_teacher:
					temp={}
					#userinfo=User.objects.filter(id=teacher.user_id)
					#print(userinfo)
					temp['username'] = teacher.email
					temp['userid'] = teacher.user_id
					temp['teacherid'] = teacher.id
					f_list.append(temp)
				
				ctx['all_teacher'] = f_list


			activity_list=[]
			for topic in obj.course_topic.all():
				#print(topic)
				activity_l={}
				temp=[]
				for activity in topic.activity_topic.all():
					tem={}
					tem['activity_name'] = activity.activity_name
					tem['activity_type'] = activity.activity_type
					tem['activity_author'] = activity.author
					temp.append(tem)

				v_t_temp=[]
				for video in topic.topic_content.all():
					tem={}
					tem['video_description']=video.description
					tem['video_file'] =video.video
					v_t_temp.append(tem)

				s_t_temp=[]
				# for subtopic in topic.topic_subtopic.all():
				#   tem={}
				#   tem['about']=subtopic.about
				#   tem['name'] = subtopic.name
				#   tem['duration'] = subtopic.duration
				#   s_t_temp.append(tem)
				for subtopic in TopicRelation.objects.all():
					if subtopic.topic_father_id==topic.id:
						tp=Topic.objects.get(id=subtopic.topic_id_id)
						tem={}
						tem['about']=tp.about
						tem['name'] = tp.name
						tem['duration'] = tp.duration

						s_t_temp.append(tem)
				activity_l['topic_name'] = topic.name
				activity_l['topic_about'] = topic.about
				activity_l['topic_author'] = topic.author
				activity_l['topic_duration'] = topic.duration
				activity_l['topic_id']=topic.id
				activity_l['activity'] = temp
				activity_l['video']=v_t_temp
				activity_l['subtopic'] = s_t_temp
				activity_list.append(activity_l)
			
			ctx['activity_list'] = activity_list

			
			classroomactivity=SessionActivity.objects.filter(course_id=obj.id)
			classroomlist=[]
			for classroom in classroomactivity:
				classrooms={}
				classrooms['topic']=classroom.topic
				classrooms['description']=classroom.description
				classrooms['id']=classroom.id
				#print(classroom.session_room_id)
				classrooms['room_id']=classroom.session_room_id
				classroomlist.append(classrooms)

			ctx['classroomlist']=classroomlist
			ctx['user']=self.request.user


			print(activity_list)
				#pass

			# elif self.request.user.is_superuser:
			#   print(self.get_object())
			#   #all_teacher = UserInformation.objects.filter(organization_id=self.get_object().organization_id,position='teacher')
			#   #print(all_teacher)
			#   #ctx['all_teacher'] = all_teacher
			#else:
				#pass
		#print(Organization.objects.filter(id=self.request.session['organization'].id)[0].name)
		#if not self.request.user.is_superuser:
			#ctx['organization'] = self.request.session['organization']
			#ctx['organization_name'] = self.request.session['organization']
		return ctx


def convert24(str1):
	if str1[-2:] == "AM" and str1[:2] == "12":
		return "00" + str1[2:-2]

	elif str1[-2:] == "AM":
		return str1[:-2]
  
	elif str1[-2:] == "PM" and str1[:2] == "12":
		return str1[:-2]
		 
	else:
		return str(int(str1[:2]) + 12) + str1[2:8] 



def course_allot(request,*args,**kwargs):
	if kwargs.get('courseid',None) is not None:
		courseid = kwargs.get('courseid',None)
	else:
		raise Http404("Page not found")

	template_name ='customadmin/course_allot.html'
	form_class = CourseAllotForm
	if request.method =="GET":
		form = form_class()
		return render(request,template_name,{'form':form_class()})
	if request.method =="POST":
		forms=form_class(request.POST or None)
		if forms.is_valid():
			organization_id=forms.cleaned_data.get('organization',None) 
			if organization_id is not None:
				#print(courseid)
				course=Courses.objects.get(id=courseid)
				org=Organization.objects.get(id=organization_id.id)
				cc=Courses.objects.create(name=course.name,
					about=course.about,thumbnail=course.thumbnail,type=course.type
					,end_date=course.end_date,author_id=course.author_id,organization_id=org.id,
					teacher=course.teacher,courses_category=course.courses_category)

				# for duplicating all the topics and subtopics and content 
				course.course_topic_content_duplicate(cc)


				#print(course)
				#course.id = None
				#course.organization=Organization.objects.get(id=organization_id.id)
				#course.save()
				return render(request,template_name,{'msg':'course has been alloted'})
		return render(request,template_name,{'msg':'Problem Occured'})

class CreateCourse(CustomMixin,CreateView):
	""" Create Courses for Organization """
	form_class = CreateCourseForm
	template_name = 'customadmin/create_course.html'
	model = Courses
	#fields = ['name', 'about', 'start_date', 'end_date', 'organization', 'end_user']
	success_url = reverse_lazy('userlms:home')

	def check_user(self,user):
		if user.perms.has_perm('generic.can_create_courses_for_organization') or user.is_superuser:
			return True
		return False

	def form_class(self):
		if self.request.user.is_superuser:
			self.form_class = CreateCourseForSuperuser
		else:
			self.form_class = CreateCourseForm
			return self.form_class

	def get_initial(self):
		initial_data = super(CreateCourse, self).get_initial()
		if not self.request.user.is_superuser :
			if self.request.session.get('organization_id',None) is None:
				raise Exception('''Only user associated with organization can create 
					courses''')
			initial_data['organization'] = self.request.session['organization_id']  
		else:
			pass
			#initial_data['organization'] = Organization.objects.all()
			#initial_data['author'] = User.objects.filter(user)
		initial_data['author'] = self.request.user.id
		return initial_data

	def get_context_data(self,**kwargs):
		ctx = super(CreateCourse, self).get_context_data(**kwargs)
		ctx['desc'] = 'Create Course'
		if not self.request.user.is_superuser :
			ctx['organization_id']=self.request.session['organization']
			ctx['author'] = self.request.user.id
		return ctx

	def form_valid(self,form):
		#self.obj=form.save(commit=False)
		#print(self.get_initial())
		
		#if self.request.user.is_superuser:
		#   return HttpResponse("you can not create any courses right now")
		try:
			#print(form.cleaned_data['language'])
			lang_id=Language.objects.filter(language_name=form.cleaned_data['language'])[0].id
		except EmptyResultSet as e:
			raise EmptyResultSet("No Language found error")
		try:
			#course=Courses.objects.create(organization_id = self.request.session['organization_id'],
			#           end_user_id = self.get_initial()['end_user_id'],
			# name=form.validated_data['name'],about=form.validated_data['about'],
			# end_date=form.validated_data['end_date'],thumbnail=form.validated_data['thumbnail'])
			#print(form.cleaned_data)
			if self.request.user.is_superuser:
				if form.cleaned_data['organization'] is not None:
					organization = form.cleaned_data['organization'].id
				else:
					organization = None
				print("user is superuser")
			else:
				organization = self.request.session['organization_id']

			author = self.get_initial()['author']
			#print(author)
			#print(organization)
			enddate = form.cleaned_data.get('enddate',None)
			name = form.cleaned_data.get('name',None)
			print(enddate)
			course = Courses(organization_id=organization,
					author_id=author,name=name,
					about=form.cleaned_data['about'],end_date=enddate,
					thumbnail=form.cleaned_data['thumbnail'],
					#duration=form.cleaned_data['duration'],
					courses_category=form.cleaned_data['courses_category'])
			print(course)

			course.save()
			print(course.id)
			
			LanguageCourse.objects.create(course_id=course.id,lang_id = lang_id)
			#Courses.objects.create(organization_id = self.request.session['organization_id'],
								   #end_user_id = self.get_initial()['end_user_id'], **form.validated_data)
		except Exception as e:
			print(e)
		return HttpResponse("created Course")
		#return super(CreateCourse, self).form_valid(form)

	def form_invalid(self,form):
		print(form.errors)
		#print(form.fields['enddate'])

	#   #print(form)
	#   #print(form)
		return HttpResponse("Problem with form data...see terminal")



from .forms import CreateCourseForEndUser
from .forms import CreateCategoryFormForEndUser
from .models import CoursesEndUser,UserCategories

class DeleteCourseForEndUser(CustomMixin,DeleteView):
	template_name='customadmin/all_courses_for_enduser.html'
	model= CoursesEndUser
	success_url = reverse_lazy('customadmin:all_course_user')

	def get(self, *args, **kwargs):
		return self.post(*args, **kwargs)

	def post(self,*args,**kwargs):
		self.obj=self.get_object()
		if self.obj.state=='DRAFT':
			pass
		else:
			self.obj.state='DRAFT'
			self.obj.save()
		messages.success(self.request,"course state has been changed")
		return HttpResponseRedirect(self.success_url)

	def check_user(self,user):
		if user.is_authenticated:
			if user.groups.filter(name=settings.END_USER_GROUP).exists():
				return False
			if user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
				return True
			if user.is_superuser:
				return True
			if user.perms.has_perm('generic.can_create_courses_for_organization'):
				return True
		return False
		#raise Http404('you cant access this page')


class DeleteCategoryForEndUser(CustomMixin,DeleteView):
	template_name='customadmin/all_category_for_enduser.html'
	model= UserCategories
	success_url = reverse_lazy('customadmin:all_category_user')

	def get(self, *args, **kwargs):
		return self.post(*args, **kwargs)

	def check_user(self,user):
		if user.is_authenticated:
			if (user.perms.has_perm('generic.can_delete_category') or user.is_superuser 
				or user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists()):
				return True
			return False
		raise Http404('you cant access this page')

	def get_context_data(self,**kwargs):
		ctx=super(DeleteCategoryForEndUser,self).get_context_data(**kwargs)
		messages.success(self.request,'category has been deleted')
		return ctx


from django.core.paginator import Paginator
from django.forms.models import model_to_dict
from .models import ContentVideo,Activities
from django.utils import timezone

def convert_model_to_dict(model,exclude_fields):
	print('exclude_fields',exclude_fields)
	x=model_to_dict(model,fields=[field.name for field in model._meta.fields if field.name not in exclude_fields])
	#print(x)
	return x



#@has_generic_permission('generic.can_assign_course_to_org')
def assign_course(request):
	import json
	if request.method=="POST":
		l_o_id=request.POST.getlist('org_id[]',False)
		course_id=request.POST.get('course_id',False)
		#print('course_id',course_id,l_o_id)
		if course_id and l_o_id:
			#print("hrerr")
			try:
				for org in l_o_id:
					c=CoursesEndUser.objects.get(id=int(course_id))
					# course_dict=convert_model_to_dict(c,['created_date','id','author','category'])
					# new_course=CoursesEndUser(**course_dict,category=c.category,
					# 	author=c.author)
					# new_course.save()
					# topics=c.course_topic.all()
					# for topic in topics:
					# 	topic_dict = convert_model_to_dict(topic,['id','start_date','course','author'])
					# 	trs=TopicRelation.objects.filter(topic_father=topic)
					# 	tt=Topic(**topic_dict,course=new_course,author=topic.author)
					# 	tt.save()
					# 	for tr in trs:
					# 	#print(tr.topic_id)
					# 		subtopic_dict=convert_model_to_dict(tr.topic_id,['id','start_date','course','author'])
					# 	#print('subtopic_dict',subtopic_dict)
					# 		st=Topic(**subtopic_dict,author=tt.author)
					# 		st._topicid=tt.id
					# 		st.save()
					# 		print('subtopic',st.topic_type)
					# 		all_video=tr.topic_id.topic_content.all()
					# 		all_activity=tr.topic_id.activity_topic.all()
					# 		print(all_video)

					# 		for video in all_video:
					# 			video_dict=convert_model_to_dict(video,['id','start_date','topic'])
					# 			cv=ContentVideo(**video_dict,topic=st,start_date=timezone.now())
					# 			cv.save()

					# 		for activity in all_activity:
					# 			activity_dict=convert_model_to_dict(activity,['id','start_date','topic','author'])
					# 			act=Activities(**activity_dict,topic=st,author=activity.author)
					# 			act.save()


					# 	for video in topic.topic_content.all():
					# 		video_dict=convert_model_to_dict(video,['id','start_date','topic'])
					# 		ContentVideo(**video_dict,topic=tt).save()

					# 	for activity in topic.activity_topic.all():
					# 		activity_dict=convert_model_to_dict(activity,['id','start_date','topic'])
					# 		act=Activities(**activity_dict,topic=tt).save()
					o=Organization.objects.get(id=int(org))
					o.course.add(c)
				return HttpResponse("true")
			except:
				pass
	return HttpResponse("error")

					

class AllCourseForEndUser(CustomMixin,ListView):
	model= CoursesEndUser
	template_name ='customadmin/all_course_for_enduser_1.html'
	paginate_by = 8
	ordering = ['id']

	def check_user(self,user):
		if user.is_authenticated:
			if user.groups.filter(name=settings.END_USER_GROUP).exists():
				return False
			if user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
				return True
			if user.is_superuser:
				return True
		return False

	def get_queryset(self):
		self.get_user_type(self.request.user)
		if self.user_type == "superuser":
			all_course=CoursesEndUser.objects.all()
		elif self.user_type=="company admin":
			#get organization courses
			user=self.request.user
			orgs=user.organization_student.all()
			if len(orgs) > 0:
				org=orgs[0]
				all_course=org.get_all_courses()
			#ui=UserInformation.objects.get(user_id=self.request.user.id)
			#return ui.organization.get_all_courses()
		else:
			all_course=self.model.objects.all()

		return all_course
		# Paginator(all_course,self.pagin)
		# try:
		# 	course = paginator.page(page)
		# except PageNotAnInteger:
		# 	course = paginator.page(1)
		# except EmptyPage:
		# 	course = paginator.page(paginator.num_pages)
	
	def get_context_data(self,**kwargs):
		ctx = super(AllCourseForEndUser, self).get_context_data(**kwargs)
		ctx['desc']='All Courses'
		#p = Paginator(Organization.objects.filter(is_active=1),1)
		all_org=[]
		for org in Organization.objects.filter(is_active=1):
			temp={}
			if org.logo :
				temp={'name':org.organization_name,'logo':org.logo.url,'id':org.id}
			else:
				temp={'name':org.organization_name,'logo':'','id':org.id}
			all_org.append(temp)
		import json
		ctx['organization'] = json.dumps(all_org)
		return ctx


from django.views.generic import DetailView
class CourseViewForEnduser(CustomMixin,DetailView):
	model = CoursesEndUser
	template_name = 'customadmin/view_course_for_enduser.html'
	context_object_name = 'course_obj'

	def get_context_data(self, **kwargs):
		context = super().get_context_data(**kwargs)
		context['course_list'] = CoursesEndUser.objects.all()
		context['shared_org'] = self.get_object().organization_course.all()
		context['all_topics'] = all_available_topic_and_subtopic(courseid=self.get_object().id)
		return context



class ViewOrg(CustomMixin,DetailView):
	model = Organization
	template_name = 'customadmin/view_org.html'
	context_object_name = 'org'

	def get_context_data(self, **kwargs):
		context = super().get_context_data(**kwargs)
		context['object'] = self.get_object()
		#context['course_list'] = CoursesEndUser.objects.all()
		#context['shared_org'] = self.get_object().organization_course.all()
		#context['all_topics'] = all_available_topic_and_subtopic(courseid=self.get_object().id)
		return context


class EditCategoryForEndUser(CustomMixin,UpdateView):
	model = UserCategories
	form_class = CreateCategoryFormForEndUser
	template_name ='customadmin/create_category_for_enduser.html'
	success_url =reverse_lazy("customadmin:all_category_user")

	def check_user(self,user):
		if user.is_authenticated:
			if (user.perms.has_perm('generic.can_update_category') or user.is_superuser or 
					user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists()):
				return True
			return False
		raise Http404("You can't access this page")

	def get_context_data(self,**kwargs):
		ctx = super(EditCategoryForEndUser, self).get_context_data(**kwargs)
		ctx['desc']='Edit Category'
		messages.success(self.request,'category has been edited')
		return ctx

	# def form_valid(self,form):
	#   try:
	#       self.obj= form.save(commit=False)
	#       self.obj.updated_date = timezone.now()
	#       self.obj.save()
	#       return render(self.request,self.template_name,{'form':form})
	#   except:
	#       print(e)
	#       return render(self.request,self.template_name,{'form':form,'msg':'error occured'})


class CreateCategoryForEndUser(CustomMixin,CreateView):
	model = UserCategories
	template_name = 'customadmin/create_category_for_enduser.html'
	form_class = CreateCategoryFormForEndUser
	success_url = reverse_lazy('customadmin:all_category_user')

	def check_user(self,user):
		if (user.has_perm('generic.can_create_category') or 
			user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists() or user.is_superuser ):
			return True

	def get_initial(self):
		initial_data = super(CreateCategoryForEndUser, self).get_initial()
		initial_data['creator'] = self.request.user.id
		return initial_data
	def get_context_data(self,**kwargs):
		ctx=super(CreateCategoryForEndUser,self).get_context_data(**kwargs)
		ctx['desc'] = 'Create Category'
		return ctx

	def form_valid(self,form):  
		req_type=self.request.POST.get('req_type',False)
		try:
			self.obj=form.save(commit=True)
			print('req_type',req_type)
			if req_type:
			#super(CreateCategoryForEndUser, self).form_valid(form)
				return HttpResponse("true")
			else:
				messages.success(self.request,"category has been created")
				return HttpResponseRedirect(self.success_url)
				#return render(self.request,self.template_name,{'form':form,'msg':'category created'})
		except Exception as e:
			if req_type:
				return HttpResponse("error occured")
			else:
				return render(self.request,self.template_name,{'form':form,'msg':'category created'})

	def form_invalid(self,form):
		error_str=''
		output_string=''
		for field,errors in form.errors.items():
			for error in errors:
				output_string=output_string+error+"\n"
		
		if self.request.POST.get('req_type',False):
			return HttpResponse(output_string)
		return render(self.request,self.template_name,{'form':form,'msg':form.errors})



class AllCategoryForEndUser(CustomMixin,ListView):
	model= UserCategories
	template_name ='customadmin/all_category_for_enduser.html'
	paginate_by =5
	ordering = ['id']

	def check_user(self,user):
		if user.is_superuser or user.perms.has_perm('generic.can_view_category'):
			return True
		return False

	# def get_queryset(self):
	# 	return self.model.objects.filter(status=1)

	def get_context_data(self,**kwargs):
		ctx = super(AllCategoryForEndUser, self).get_context_data(**kwargs)
		ctx['desc']='All Category'
		return ctx  



from preassesment.forms import QuizForm


class EditCourseForEndUser(CustomMixin,UpdateView):
	model = CoursesEndUser
	form_class = CreateCourseForEndUser
	#template_name ='customadmin/create_course_for_enduser.html'
	template_name = 'customadmin/create_course_for_enduser_1.html'
	video_form = AddVideoForm
	topic_form = TopicForm
	subtopic_form = SubTopicForm
	category_form = CreateCategoryFormForEndUser
	# fields = [ 
	#   "name", 
	#   "about",
	#   "thumbnail",
	#   "duration",
	#   "price",
	#   "discount_price",
	#   "language",
	#   "overview",
	#   "link",
	#   "language",
	# ] 
	success_url =reverse_lazy("customadmin:all_course_user")


	def check_user(self,user):
		if user.is_authenticated:
			if user.groups.filter(name=settings.END_USER_GROUP).exists():
				return False
			if user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
				return True
			if user.is_superuser:
				return True
		return False

	def get_context_data(self,**kwargs):
		ctx = super(EditCourseForEndUser, self).get_context_data(**kwargs)
		ctx['desc']='Edit Course'
		self.object = self.get_object()
		topic_activity_list=all_available_topic_and_subtopic()
		#print(topic_activity_list)
		ctx['topic_activity_list'] = topic_activity_list
		course_topic_list = all_available_topic_and_subtopic(courseid=self.object.id)
		ctx['course_topic_list'] = course_topic_list
		ctx['courseid'] = self.object.id
		ctx['content_video_form'] = AddVideoForm()
		ctx['is_editing']=True
		ctx['video_form'] = self.video_form()
		ctx['topic_form'] = self.topic_form(initial={'courseid':self.object.id})
		ctx['subtopic_form'] = self.subtopic_form()
		ctx['quizform'] = QuizForm()
		ctx['object']=self.get_object()
		ctx['category_form'] = self.category_form()
		#ctx['student_list'] = UserInformation.objects.filter(organization=self.object.get_course_org_id(),is_active=1)
		return ctx


from preassesment.models import Quiz,QuestionPaper
def all_available_topic_and_subtopic(courseid=None,user=None):
	from collections import OrderedDict
	if courseid is not None:
		all_topics=Topic.objects.filter(topic_type='topic',course_id=courseid).order_by('id')
	else:
		all_topics=Topic.objects.filter(topic_type='topic').order_by('id')
	object_list=OrderedDict()


	for topic in all_topics:
		object_list[topic]={}
		all_activities=Activities.objects.filter(topic=topic)
		object_list[topic]['activities'] = [ac for ac in all_activities]

		object_list[topic]['subtopic']={}

		trs=TopicRelation.objects.filter(topic_father_id=topic.id).order_by('id')

		if len(trs) > 0:
			for tr in trs:
				subtopic = Topic.objects.get(id=tr.topic_id_id)
				all_activities=Activities.objects.filter(topic=subtopic)
				object_list[topic]['subtopic'][subtopic]={}
				object_list[topic]['subtopic'][subtopic]['activities']=[ac for ac in all_activities]


	# for topic in all_topics:
	# 	#is there any activity of topic
	# 	#object_list[topic]={}
	# 	all_activity=topic.activity_topic.all().order_by('id')
	# 	all_video = topic.topic_content.all().order_by('id')
	# 	#print(all_video)
	# 	object_list[topic]={}
	# 	if len(all_video) > 0:
	# 		print("topic has video deirect")
	# 		object_list[topic]['video']=[act for act in all_video]

	# 	if len(all_activity) > 0:
	# 		print("topic has activity deirect")
			
	# 		if user is not None:
	# 			filter_activity=[]
	# 			for act in all_activity:
	# 				if act.activity_type == "quiz":
	# 					qz=Quiz.objects.filter(id=act.content_id)
	# 					if len(qz) > 0:
	# 						if qz[0].active == 1 and QuestionPaper.objects.filter(quiz_id=qz[0].id).exists():
	# 							filter_activity.append(act)

	# 			object_list[topic]['activity']=filter_activity		
	# 		else:
	# 			object_list[topic]['activity']=[act for act in all_activity]

	# 	#print(object_list[topic])
	# 	object_list[topic]['subtopic']={}
	# 	#get childs
	# 	trs=TopicRelation.objects.filter(topic_father_id=topic.id).order_by('id')
	# 	#print(trs)
	# 	if len(trs) > 0:
	# 		#print(object_list[topic]['subtopic'])
	# 		#object_list[topic]['subtopic']['topic']=[]
	# 		#object_list[topic]['subtopic']['activity']=[]
	# 		for tr in trs:
	# 			subtopic = Topic.objects.get(id=tr.topic_id_id)
	# 			sub_act=subtopic.activity_topic.all()
	# 			sub_video=subtopic.topic_content.all()
	# 			object_list[topic]['subtopic'][subtopic]={}
	# 			if len(sub_act) > 0:
	# 				if user is not None:
	# 					print("################################")
	# 					filter_activity=[]
	# 					#complete_activity =[]
	# 					#print(all_activity)
	# 					for act in sub_act:
	# 						if act.activity_type == "quiz":
	# 							qz=Quiz.objects.filter(id=act.content_id)
	# 							#print(qz)
	# 							if len(qz) > 0:
	# 								#print(qz[0])
	# 								if qz[0].active and QuestionPaper.objects.filter(quiz_id=qz[0].id).exists():
	# 									filter_activity.append(act)

	# 						else:
	# 							filter_activity.append(act)
	# 					object_list[topic]['subtopic'][subtopic]['activity']=filter_activity		
	# 				else:
	# 					object_list[topic]['subtopic'][subtopic]['activity']=[act for act in sub_act]
				
	# 			if len(sub_video) > 0:
	# 				object_list[topic]['subtopic'][subtopic]['video']=[act for act in sub_video]
				
	
	return object_list

class CreateCourseForEndUser(CustomMixin,CreateView):
	""" Create Courses for Organization """
	form_class = CreateCourseForEndUser
	template_name = 'customadmin/create_course_for_enduser_1.html'
	#template_name = 'customadmin/aaa.html'
	model = CoursesEndUser
	category_form = CreateCategoryFormForEndUser
	video_form = AddVideoForm
	topic_form = TopicForm
	subtopic_form = SubTopicForm
	#fields = ['name', 'about', 'start_date', 'end_date', 'organization', 'end_user']
	success_url = reverse_lazy('customadmin:add_course_user')

	def check_user(self,user):
		if user.is_authenticated:
			if user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists() or user.is_superuser:
				return True
			return False
		else:
			raise Http404("You cant access this page")

	def get_initial(self):
		initial_data = super(CreateCourseForEndUser, self).get_initial()
		initial_data['author'] = self.request.user.id
		return initial_data

	def get_context_data(self,**kwargs):
		ctx = super(CreateCourseForEndUser, self).get_context_data(**kwargs)
		ctx['desc'] = 'Create Course'
		#find available topic and subtopic
		topic_activity_list=all_available_topic_and_subtopic()
		#ctx['form'] = self.form_class()
		ctx['topic_activity_list'] = topic_activity_list
		ctx['category_form'] = self.category_form()
		ctx['video_form'] = self.video_form()
		ctx['topic_form'] = self.topic_form()
		ctx['subtopic_form'] = self.subtopic_form()
		ctx['quizform'] = QuizForm()
		ctx['editing'] = False
		msg=kwargs.get('msg',None)
		if msg is not None:
			ctx['msg']=msg
		# if not self.request.user.is_superuser :
		#   ctx['organization_id']=self.request.session['organization']
		#   ctx['author'] = self.request.user.id
		return ctx

	def form_valid(self,form):
		#print(self.get_initial())
		
		#if self.request.user.is_superuser:
		#   return HttpResponse("you can not create any courses right now")     
		#try:
		self.obj=form.save()
		#ui=UserInformation.objects.filter(user_id=self.request.user.id)
		#if len(ui) > 0:
			#if ui[0].organization is not None:
				#org=Organization.objects.get(id=ui[0].organization_id)
				#org.course.add(self.obj.id)
		org_student=self.request.user.organization_student.all()
		if len(org_student) > 0:
			org=org_student[0]
			org.course.add(self.obj.id)


			#super(CreateCourseForEndUser, self).form_valid(form)
		messages.success(self.request,"course has been created")
		return render(self.request,self.template_name,{'form':form,'desc':'Create Course'})

		#except Exception as e:
		#print("user is superuser")
			#ctx=self.get_context_data()
			#ctx['msg'] = form.errors
		#return render(self.request,self.template_name,{'form':form,'msg':'problem occured'})
			#return HttpResponseRedirect(self.success_url)
		
		#return HttpResponse(self.success_url)
		

	def form_invalid(self,form):
		print(form.errors)
		#self.get_context_data(form=form,msg=form.errors)
		# return self.render_to_response(
  #           self.get_context_data(
  #               form=form, 
  #               msg=form.errors
  #           )
  #       )
		messages.add_message(self.request,messages.INFO,"Fill all the required fields.")
		return render(self.request,self.template_name,{'form':form,'desc':'Create Course'})
		return HttpResponseRedirect(self.success_url)





class AllVideo(CustomMixin,ListView):
	model = ContentVideo
	template_name ='customadmin/all_video.html'
	paginate_by =10
	ordering = ['-id']

	def check_user(self,user):
		if user.is_superuser or user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
			return True
		return False

	def get_context_data(self,**kwargs):
		ctx = super(AllVideo, self).get_context_data(**kwargs)
		ctx['desc']='All Video'
		return ctx


class EditVideo(CustomMixin,UpdateView):
	model= ContentVideo
	form_class= AddVideoForm
	template_name ='customadmin/add_video.html'
	#paginate_by =10
	#ordering = ['-id']
	success_url =reverse_lazy("customadmin:all_course_user")

	def check_user(self,user):
		if user.is_superuser or user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
			return True
		return False

	def get_context_data(self,**kwargs):
		ctx = super(EditVideo, self).get_context_data(**kwargs)
		ctx['desc']='Edit Video'
		ctx['next'] = self.request.GET.get('next','')
		return ctx


class DeleteVideo(CustomMixin,DeleteView):
	template_name='customadmin/all_video.html'
	model= ContentVideo
	success_url = reverse_lazy('customadmin:all_course_user')

	def post(self, *args, **kwargs):
		nextval =self.request.GET.get('next',False)
		self.get_object().delete()
		if nextval:
			return HttpResponseRedirect(settings.EXTRA_URL+nextval.replace('$','#'))
		return HttpResponseRedirect(reverse_lazy('customadmin:all_course_user'))
		#return self.post(*args, **kwargs)
	
	def get(self, *args, **kwargs):
		#print("in get",kwargs,args)
		return self.post(*args, **kwargs)

	def check_user(self,user):
		if user.is_superuser or user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
			return True
		return False


from .models import ActivityType
from .forms import ActivityTypeForm

class EditActivityType(CustomMixin,UpdateView):
	model= ActivityType
	form_class = ActivityTypeForm
	template_name = 'customadmin/add_activity_type.html'
	#paginate_by =10
	#ordering = ['-id']
	success_url =reverse_lazy("customadmin:all_activity_type")

	def get_initial(self):
		initial_data = super(EditActivityType, self).get_initial()
		initial_data['author'] = self.request.user.id
		return initial_data

	def check_user(self,user):
		if user.is_superuser:
			return True
		return False

	def get_context_data(self,**kwargs):
		ctx = super(EditActivityType, self).get_context_data(**kwargs)
		ctx['desc']='Edit Video'
		return ctx


class DeleteActivityType(CustomMixin,DeleteView):
	template_name='customadmin/all_video.html'
	model= ActivityType
	success_url = reverse_lazy('customadmin:all_activity_type')

	def get(self, *args, **kwargs):
		return self.post(*args, **kwargs)

	def check_user(self,user):
		if user.is_authenticated:
			if user.perms.has_perm('generic.can_delete_activity_type') or user.is_superuser:
				return True
			return False
		raise Http404('you cant access this page')


class AddActivityType(CustomMixin,CreateView):
	form_class = ActivityTypeForm
	template_name = 'customadmin/add_activity_type.html'
	def check_user(self,user):
		if user.is_authenticated:
			if user.perms.has_perm('generic.can_create_activity_type_for_organization') or user.is_superuser:
				return True
			return False
		else:
			raise Http404("You cant access this page")

	def get_initial(self):
		initial_data = super(AddActivityType, self).get_initial()
		initial_data['author'] = self.request.user.id
		return initial_data

	def get_context_data(self,**kwargs):
		ctx = super(AddActivityType, self).get_context_data(**kwargs)
		ctx['desc'] = 'Create Activity Type'
		msg=kwargs.get('msg',None)
		if msg is not None:
			ctx['msg']=msg
		# if not self.request.user.is_superuser :
		#   ctx['organization_id']=self.request.session['organization']
		#   ctx['author'] = self.request.user.id
		return ctx

	def form_valid(self,form):      
		try:
			self.obj=form.save()
			super(AddActivityType, self).form_valid(form)
			return render(self.request,self.template_name,{'form':form,'msg':'course created'})
		except Exception as e:
			print(e)
			return render(self.request,self.template_name,{'form':form})
			#return HttpResponseRedirect(self.success_url)
		#return HttpResponse(self.success_url)
		
def add_student_to_course(request):
	if request.method=="POST":
		student_id=request.POST.get('student_id',None)
		course_id=request.POST.get('course_id',None)
		try:
			if student_id is not None and course_id is not None:
				c=CoursesEndUser.objects.get(id=course_id)
				u=UserInformation.objects.get(id=student_id)
				c.students.add(u.user_id)
				return HttpResponse("user successfully added")
			return HttpResponse("arguments are not given")
		except:
			return HttpResponse("Error Occured")

class AllActivityType(CustomMixin,ListView):
	model = ActivityType
	template_name = 'customadmin/all_activity_type.html'
	ordering = ['id']

	def check_user(self,user):
		if user.is_superuser:
			return True
		return False

	def get_context_data(self,**kwargs):
		ctx = super(AllActivityType, self).get_context_data(**kwargs)
		ctx['desc']='All Activity Type'
		return ctx

class SetOrderTopic(CustomMixin,View):
	model = Topic

	def check_user(self,user):
		return True

	def post(self,request,*args,**kwargs):
		print(request)
		print(request.data)
		return Response("ssss")

from .forms import UserInformationForm
from django.contrib import messages
class EditStudents(CustomMixin,UpdateView):
	#model = UserInformation
	model = get_user_model()
	template_name ='customadmin/user_profile_1.html'
	#ordering =['id']
	#form_class = UserInformationForm
	form_class = AddOrganizationUser
	success_url = reverse_lazy('customadmin:students')

	def post(self,request,*args,**kwargs):
		self.object=self.get_object()
		forms=self.form_class(request.POST,request.FILES,
			#initial={'user':self.object.user},
			instance=self.object)
		#print(forms.errors)
		if forms.is_valid():
			self.obj=forms.save(commit=False)
			#print(self.obj.first_name)
			#self.obj.user_id=self.object.user.id
			self.obj.is_active=1
			#self.obj.save()
			self.object.image = forms.cleaned_data.get('image',None)
			self.object.first_name = forms.cleaned_data.get('first_name',None)
			self.object.last_name = forms.cleaned_data.get('last_name',None)
			self.object.gender = forms.cleaned_data.get('gender',None)
			self.object.address= forms.cleaned_data.get('address',None)
			self.object.address1=forms.cleaned_data.get('address1',None)
			self.object.houseno = forms.cleaned_data.get('houseno',None)
			self.object.pincode = forms.cleaned_data.get('pincode',None)
			self.object.phone = forms.cleaned_data.get('phone',None)
			self.object.save()
			#u=User.objects.filter(id=self.object.id)
			#if len(u) > 0:
				#u[0].username = forms.cleaned_data['email']
				#u[0].first_name = forms.cleaned_data['first_name']
				#u[0].last_name = forms.cleaned_data['last_name']
				#u[0].save()
			messages.add_message(request, messages.INFO, 'Profile Updated')
			return HttpResponseRedirect(self.success_url)
		messages.add_message(request, messages.INFO, forms.errors)
		return HttpResponseRedirect(self.success_url)

		#self.get_object().update(**request.POST)

	def check_user(self,user):
		if user.is_superuser or user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
			return True
		return False

	def get_user_obj(self):
		#return User.objects.get(id=self.get_object().user_id)
		return get_user_model().objects.get(id=self.get_object().id)

	def get_context_data(self,**kwargs):
		ctx = super(EditStudents, self).get_context_data(**kwargs)
		ctx['desc']= 'Edit Students'
		#print(self.get_object())
		ctx['cuser'] = self.get_object()
		ctx['media_url'] = "/media/user_profile/"
		all_group = Group.objects.all()
		ctx['roles'] = all_group
		ctx['user_group'] = self.get_user_obj().groups.all()
		#print(self.get_user_obj().perms.all())
		user_permission=[]
		for p in self.get_user_obj().perms.all():
			user_permission.append(p)
		for g in self.get_user_obj().groups.all():
			#print(g.perms.all())
			for gg in g.perms.all():
				#print("herer")
				if gg not in user_permission:
					user_permission.append(gg)
		#user_permission.extend(self.get_user_obj.)
		print(user_permission)
		ctx['user_permission'] = user_permission
		from custompermission.models import Perm
		ctx['permissions'] = Perm.objects.all()
		ctx['EXTRA_URL'] = settings.EXTRA_URL
		all_group_perm={}
		for g in all_group:
			all_group_perm[g]=g.perms.all()

		ctx['group_permissions'] = all_group_perm
		#ctx['user_permission'] = Perm.objects.all()
		return ctx


class DeleteStudents(CustomMixin,DeleteView):
	#model = UserInformation
	model = get_user_model()
	template_name ='customadmin/user_profile.html'
	ordering =['id']
	success_url = reverse_lazy('customadmin:students')
	#form_class = CreateOrganizationForm

	def check_user(self,user):
		if user.is_superuser or user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
			return True
		return False

	def post(self,*args,**kwargs):
		self.obj = self.get_object()
		#u=User.objects.filter(id=self.obj.user.id)
		#if len(u) > 0:
		self.obj.delete()

		#u[0].delete()

	def get(self, *args, **kwargs):
		messages.success(self.request,'user deleted successfully')
		self.post(*args, **kwargs)
		return HttpResponseRedirect(reverse_lazy('customadmin:students'))

	def get_context_data(self,**kwargs):
		ctx=super(DeleteStudents,self).get_context_data(**kwargs)
		ctx['desc']= 'Delete Students'
		return ctx


class AllStudents(CustomMixin,ListView):
	#model= UserInformation
	model= get_user_model()
	template_name ='customadmin/students_1.html'
	ordering = ['id']
	#paginate_by =15
	#context_object = 'student_list'

	def check_user(self,user):
		if user.is_superuser or user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
			return True
		return False

	def get_queryset(self):
		self.get_user_type(self.request.user)
		user=self.request.user
		org = user.organization_student.all()[0]
		if user.is_superuser:
			return self.model.objects.all()
		if self.user_type=='company admin' or self.user_type=='company instructor':
			# ui=UserInformation.objects.get(user_id=self.request.user.id)
			user=self.request.user
			org = user.organization_student.all()[0]
			return org.students.filter(is_active=1)
			#return self.model.objects.filter(id=ui.organization_id)
			#return self.model.objects.filter(is_active=1,organization=org)
			#return self.model.objects.filter(is_active=1,organization=ui.organization)
		#return org.students.filter(is_active=1)
		return self.model.objects.filter(is_active=1)

	def get_context_data(self,**kwargs):
		ctx=super(AllStudents,self).get_context_data(**kwargs)
		ctx['desc']= 'All Users'
		return ctx


class AllTopic(CustomMixin,ListView):
	model= Topic
	template_name ='customadmin/all_topic.html'
	#paginate_by =10
	ordering = ['id']

	def check_user(self,user):
		if user.is_superuser or user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
			return True
		return False

	def get_queryset(self):
		courseid=self.request.GET.get('courseid',None)
		print(courseid)
		if courseid is not None:
			all_topics = self.model.objects.filter(topic_type='topic',
				course_id=int(courseid))
			#print(all_topics)
		else:
			all_topics=self.model.objects.filter(topic_type='topic')
		object_list={}
		for topic in all_topics:
			#get childs
			object_list[topic]=[]
			trs=TopicRelation.objects.filter(topic_father_id=topic.id)
			#print(trs)
			if len(trs) > 0:
				for tr in trs:
					object_list[topic].append(Topic.objects.get(id=tr.topic_id_id))

		#print(object_list)
		return object_list
		# topic is not subtopic
	# def get(self,request,*args,**kwargs):
	#   pass

	def get_context_data(self,**kwargs):
		ctx = super(AllTopic, self).get_context_data(**kwargs)
		courseid=self.request.GET.get('courseid',None)
		#if courseid is not None:
			#ctx['ordering']=True
		ctx['desc']='All Topic'
		return ctx


class EditTopic(CustomMixin,UpdateView):
	model= Topic
	form_class= TopicForm
	template_name ='customadmin/edit_topics.html'
	#paginate_by =10
	#ordering = ['-id']
	success_url =reverse_lazy("customadmin:all_topic")

	def check_user(self,user):
		if user.is_superuser or user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
			return True
		return False

	def get(self,*args,**kwargs):
		nextval = self.request.GET.get('next',False)
		self.obj=self.get_object()
		form = self.form_class(instance=self.obj)
		#if nextval:
		if self.obj.topic_type=="subtopic":
			return render(self.request,self.template_name,
				{'desc':'EditSubTopic','next':nextval,'form':form})
		else:
			return render(self.request,self.template_name,
				{'desc':'EditTopic','next':nextval,'form':form})


	def post(self,*args,**kwargs):
		nextval = self.request.POST.get('next',False)
		self.obj=self.get_object()
		form = self.form_class(self.request.POST)
		if form.is_valid():
			self.o=form.save(commit=False)
			dd=self.request.POST.dict()
			dd.pop('csrfmiddlewaretoken')
			dd.pop('next')
			end_date_str=dd.get('end_date')
			print("editing here .....",end_date_str)
			#topic_obj=self.model.objects.filter(id=self.obj.id)
			tr=None
			if self.o.topic_type=="subtopic":
				tr=TopicRelation.objects.filter(topic_id_id=self.o.id)
				#topic_obj[0]._topicid=tr.topic_father_id
				#print("cckkckckcc",topic_obj[0]._topicid)
				#topic_obj[0]._topicid = tr.topic_father_id
			#print(dd)
			if end_date_str=='' or end_date_str is None:
				#topic_obj[0]._topicid=tr.topic_father_id
				self.o.end_date=None
			else:
				import datetime
				date_obj=datetime.datetime.strptime(end_date_str, "%m/%d/%Y").date()
				print("date object id",type(date_obj))
				#d_o=datetime.datetime.combine(date_obj,datetime.datetime.min.time())
				self.o.end_date = date_obj
				
			#if tr is not None:
				#topic_obj[0]._topicid = tr.topic_father_id
			#topic_obj.update(**dd)
			#print(topic_obj[0]._topicid)
			self.o.name=dd.get('name')
			#print(topic_obj[0].name)
			self.o.about = dd.get('about')
			#print(self.o.name)
			#o.end_date = dd.get('end_date')
			tt=Topic.objects.get(id=self.obj.id)
			tt.name=self.o.name
			tt.about = self.o.about
			tt.end_date=self.o.end_date
			tt.save()
			#self.o.save()
			#print(topic_obj[0].__dict__)
			#print(topic_obj[0].end_date)
			#print(topic_obj[0]._topicid)
			#topic_obj[0].save()
			if nextval:
				messages.success(self.request,"topic edited successfully")
				return HttpResponseRedirect(settings.EXTRA_URL+nextval.replace("$","#"))
			return render(self.request,self.template_name,{'form':form})
		else:
			#print(form.errors)
			return render(self.request,self.template_name,{'form':form,'next':nextval})
		
	def get_context_data(self,**kwargs):
		ctx = super(EditTopic, self).get_context_data(**kwargs)
		ctx['desc']='Edit Topic'
		return ctx



class DeleteTopic(CustomMixin,DeleteView):
	template_name='customadmin/all_topics.html'
	model= Topic
	success_url = reverse_lazy('customadmin:all_topic')

	def get(self, *args, **kwargs):
		return self.post(*args, **kwargs)

	def check_user(self,user):
		if user.is_superuser or user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
			return True
		return False
		raise Http404('you cant access this page')



class AddTopic(CustomMixin,View):
	form_class = TopicForm
	#permission_failure  = 'userlms:home'
	template_name = 'customadmin/add_topics.html'

	def get_initial(self):
		#initial_data = super(AddTopic, self).get_initial()
		initial_data={}
		initial_data['author']= self.request.user.id
		initial_data['topic_type'] = 'topic'
		return initial_data

	def get_context_data(self,**kwargs):
		ctx = super(AddTopic, self).get_context_data(**kwargs)
		ctx['desc'] = 'Create Topics'
		return ctx

	def check_user(self,user):
		if user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists() or user.is_superuser:
			return True
		return False

	def get(self,request,*args,**kwargs):
		#print(args)
		#print(kwargs)
		course=kwargs.get('courseid',None)
		nextval=request.GET.get('next',None)
		print('get',nextval)
		#print(course)
		#course = None
		if course is not None:
			c=CoursesEndUser.objects.get(id=course)
			if c is None:
				return Http404("problem with courses")
			#print(c)

		initial=self.get_initial()
		initial['course']=course
		form = self.form_class(initial=initial)
		return render(request,self.template_name,{'form':form,'next':nextval,'desc':'Add Topic',
			'course_id':course})

	def post(self,request,*args,**kwargs):
		#print(request.POST)
		#print(kwargs)
		nextval=request.POST.get('next',None)
		print(nextval)
		forms_s = TopicForm(request.POST , request.FILES )
		#print(form_s)
		course=kwargs.get('courseid',None)
		if forms_s.is_valid():
			forms_s.save()
			if nextval is not None:
				messages.success(request,"topic has been created")
				# return HttpResponseRedirect(settings.EXTRA_URL+nextval.replace("$","#"))
				return HttpResponseRedirect(reverse_lazy('customadmin:all_topic'))
			return render(request,'customadmin/add_topics.html',{"msg":"topic created",'next':nextval,'desc':'Add Topic','form':forms_s,'course_id':course})
		else:
			messages.info(request,"problem in topic creation")
			return render(request,'customadmin/add_topics.html',{"msg":"topic could not created",'next':nextval,'desc':'Add Topic','form':forms_s,'course_id':course})
		return render(request,'customadmin/add_topics.html',{"msg":forms_s.errors,'desc':'Add Topic','form':forms_s,'course_id':course})



class AddActivity(View):
	form_class = AddActivityForm
	template_name = 'customadmin/add_activity.html'
	permission_failure = 'userlms:home'


	def get(self,request,*args,**kwargs):
		#if self.request.user.perms.has_perm('generics.can_create_activity_for_topic'):
		if self.request.user.is_authenticated:
			topicid=kwargs.get('topicid',None)
			initial={}
			initial['author'] = self.request.user
			if topicid is not None:
				initial['topic']=topicid
				try:
					topic_obj=Topic.objects.get(id=topicid)
					initial['course']=topic_obj.course
				except:
					pass
			#print(initial)
			form=self.form_class(initial=initial)
			return render(request,self.template_name,{'form':form})
		return HttpResponse("not authorised")

	def post(self,request,*args,**kwargs):
		#if self.request.user.perms.has_perm('generics.can_create_activity_for_topic'):
		if self.request.user.is_authenticated:
			forms = self.form_class(request.POST or None)
			if forms.is_valid():
				forms.save()
				return render(request,self.template_name,{'form':forms,'msg':'activity created'})
			return render(request,self.template_name,{'form':forms})
		return HttpResponse("Not authorised")

	def update(self,request,*args,**kwargs):
		pass

	def destroy(self,request,*args,**kwargs):
		pass


class Assign_permission(CustomMixin,View):
	form_class = PermissionForm
	form2_class = UserForm
	initial = {'key': 'value'}
	template_name = 'create_custom_permission.html'
	permission_failure ='userlms:home'

	def check_user(self,user):
		if user.perms.has_perm('generic.can_assign_custompermission') and \
		user.perms.has_perm('generic.can_see_all_custompermission'):
			return True
		return False

	def get(self, request, *args, **kwargs):
		form = self.form_class(initial=self.initial)
		form2=self.form2_class(user=request.user)
		return render(request, self.template_name,{'form': form,'form2':form2,'desc':'assign permission','action':'customadmin:assign_permission'})

	def post(self, request, *args, **kwargs):
		form1 = self.form_class(request.POST)
		d=request.POST
		#d['user']=request.user
		form2 = self.form2_class(user=request.user,data=request.POST)
		if form1.is_valid():
			permtype=form1.cleaned_data['type']
			#return HttpResponseRedirect('customadmin:home')

		if form2.is_valid():
			perm=form2.cleaned_data['perm']
			choice=form2.cleaned_data['choice']
		user=request.user
		#string_name=permtype+'.'+perm
		choice.perms.add_perm(Perm.objects.get(codename=perm,type=permtype))
			#Perm.objects.create(codename=perm,type=permtype)

		return render(request, self.template_name, {'form': form1,'form2':form2,'action':'customadmin:assign_permission'})

class Activity(CustomMixin,CreateView):
	def get_context_data(self,**kwargs):
		pass


from .forms import QuestionForm
class AllQuestion(View):
	form_class=QuestionForm
	success_url = 'customadmin:all_course_user'

	def get_initial(self, *args, **kwargs):
		initial = super(AllQuestion, self).get_initial(**kwargs)
		initial['author'] = self.request.user
		return initial

	def get(self,request,*args,**kwargs):
		allq=Question.objects.all()
		return HttpResponse(allq)

	def post(self,request):
		form=QuestionForm(initial={'author':request.user},data=request.POST)
		if form.is_valid():
			form.save()
			return HttpResponseRedirect(reverse_lazy(self.success_url))
		else:
			print(form.errors)
			return HttpResponse(form.errors)


def spin_activity_enroll(request):
	pass


from .models import (SpinActivityEnroll,SpinActivityAnswer,Activities,
TopicWiseAnswerpaper,DragDropActivity,DragDropActivityElements,
DragDropActivityAnswers)

from preassesment.models import Quiz

def delete_activity(request,*args,**kwargs):
	pk=kwargs.get('pk',None)
	nextval = request.GET.get('next',False)
	if pk is not None:
		try:
			ac=Activities.objects.get(id=pk)
			print('ac is ',ac)
			#if TopicWiseAnswerpaper.objects.filter(activity=ac.content_id).exists():
				#print("found enrolled")
				#return HttpResponse("error")
				#raise Http404("some students already enrolled in this activity")
			if ac.activity_type =="quiz":
				q=Quiz.objects.filter(id=ac.content_id)
				if len(q) > 0:
					if TopicWiseAnswerpaper.objects.filter(activity_id=q[0].id).exists():
						return HttpResponse("error")
					else:
						q[0].delete()
						ac.delete()
			elif ac.activity_type =="spin_activity":
				sp=SpinActivity.objects.filter(activity=ac)
				if len(sp) > 0:
					if TopicWiseAnswerpaper.objects.filter(activity_id=sp.id).exists():
						return HttpResponse("error")
					else:
						sp.spinactivityanswer_set.all().delete()
						sp.delete()
						ac.delete()
			elif ac.activity_type=="drag_and_drop":
				d=DragDropActivity.objects.filter(id=ac.content_id)
				if len(d) == 1:
					if TopicWiseAnswerpaper.objects.filter(activity_id=d[0].id).exists():
						return HttpResponse("error")
					else:
						DragDropActivityElements.objects.filter(dd_activity=d[0]).delete()
						DragDropActivityAnswers.objects.filter(dd_activity=d[0]).delete()
						d.delete()
						ac.delete()

			elif ac.activity_type=="Assignment":
				d=AssignmentActivity.objects.filter(id=ac.content_id)
				if len(d) == 1:
					if TopicWiseAnswerpaper.objects.filter(activity_id=d[0].id).exists():
						return HttpResponse("error")
					else:
						d.delete()
						ac.delete()
				#print(sp.topic_details.all())
			else:
				pass
				
			
			return HttpResponse("true")

		except Activities.DoesNotExist:
			return HttpResponse("no activity with this id exist")
	return HttpResponse("ff")

from django.shortcuts import get_object_or_404


def edit_spin_activity(request,*args,**kwargs):
	form_class=SpinActivityForm
	form1_class = TopicDetailsForSpin
	form2_class = QuestionForm
	template_name='customadmin/edit_spin_activity.html'
	if request.method == "GET":
		pk=kwargs.get('pk',None)
		nextval=request.GET.get('next',False)
		act=Activities.objects.get(id=pk)
		obj = get_object_or_404(SpinActivity,activity=act)
		all_topic=obj.topic_details.all()
		#print(all_topic[0].questions.all())
		form=form_class(instance=obj)
		from customadmin.models import Question
		all_q = Question.objects.all()
		return render(request,template_name,{'form':form,
			'all_topic':all_topic,'obj':obj,'topic_len':len(all_topic),
			'question_form':form2_class(initial={'author':request.user}),'all_question':all_q,
			'next':nextval})

	if request.method== "POST":
		pk=kwargs.get('pk',None)
		print(pk)
		#post_data=request.POST.dict()
		nextval = request.POST.get('next',False)
		act=Activities.objects.get(id=pk)
		obj = get_object_or_404(SpinActivity,activity=act)
		post=request.POST
		#print(post)
		name=post.get('name')
		no_of_topic=post.get('no_of_topic')
		block_slice_after_open=post.get('block_slice_after_open',False)
		#print(block_slice_after_open)
		topic_details=[]

		topic_details_obj=obj.topic_details.all()
		print(topic_details_obj)
		for i in range(1,int(no_of_topic)+1):
			topic_value=post.get('topics'+str(i))
			id_questions=post.getlist('topics'+str(i)+'questions')
			#print(id_questions)
			for td in topic_details_obj:
				if td.topic_name == topic_value:
			#td,created=TopicDetails.objects.get_or_create(topic_name=topic_value)
			#all_topics=obj.topic_details.all()
			#tds=TopicDetails.objects.filter(topic_name=topic_value)
			#print(td.questions.all())
					all_q=td.questions.all()
					for q in all_q:
						td.questions.remove(q)
					for j in range(len(id_questions)):
						td.questions.add(id_questions[j])
					topic_details.append(td)

		obj.no_of_topic=no_of_topic
		obj.block_slice_after_open=block_slice_after_open
		obj.name=name

		#sp=SpinActivity.objects.(end_date=timezone.now(),name=name,no_of_topic=no_of_topic)	
		for td in topic_details:
			obj.topic_details.add(td.id)

		obj.save()
		act.activity_name=name
		act.save()

		messages.success(request,"spin activity has been edited")
		if nextval :
			return HttpResponseRedirect(settings.EXTRA_URL+nextval.replace("$","#"))
		else:
			return render(request,template_name,{})


	

class SpinActivities(View):
	form_class=SpinActivityForm
	form1_class = TopicDetailsForSpin
	template_name='customadmin/spin_activity.html'

	def get_context_data(self):
		temp=[]
		allques=Question.objects.all()
		for q in allques:
			allq={}
			allq['id']=q.id
			allq['name']=q.question_name
			temp.append(allq)
		return temp
	# def put(self, request, *args, **kwargs):
	# 	# import ast
	# 	# dict_str = request.body.decode("UTF-8")
	# 	# mydata = ast.literal_eval(dict_str)
	# 	# print(mydata)
	# 	return self.get(request, *args, **kwargs)
	def get_object(self,id):
		obj = get_object_or_404(SpinActivity, id = id) 
		return obj

	def get(self,request,*args,**kwargs):
		spin_activity_id=kwargs.pop('id',None)
		allq=self.get_context_data()
		topics=[]
		if spin_activity_id is not None:
			sp=self.get_object(spin_activity_id)
			form=self.form_class(instance=sp)
			form1=self.form1_class()
			# sp=SpinActivity.objects.filter(id=spin_activity_id)

			#for spactivity in sp:
				# try:
				# 	SpinActivityEnroll.objects.create(candidate=request.user,spinactivity_id=spactivity.id)
				# except:
				# 	print("already enrolled to spin activity")
			for topic in sp.topic_details.all():
					#print(topic)
				temp={}
				temp['topic_name']=topic.topic_name
				tq=[]
				print(topic.questions.all())
				for q in topic.questions.all():
					tq.append({'qid':q.id,'q':q.question_name,'op1':q.option_a,
							'op2':q.option_b,'op3':q.option_c,'op4':q.option_d})
				temp['questions']=tq
				topics.append(temp)
			print(topics)
			return render(request,self.template_name,{'allq':allq,'show_spin':True,'alltopics':topics,
				'spinactivity_id':spin_activity_id,'question_form':QuestionForm(initial={'author':request.user})})
			#return render(request,self.template_name,{'allq':allq,'question_form':question_form,'show_spin':False})

		else:
			form=self.form_class()
			form1=self.form1_class()
			question_form = QuestionForm(initial={'author':request.user})
		
			return render(request,self.template_name,{'allq':allq,'question_form':question_form,'show_spin':False})

	def post(self,request,*args,**kwargs):
		topicid=kwargs.pop('topicid',None)
		allq=self.get_context_data()
		question_form = QuestionForm(initial={'author':request.user})
		print('while editing',topicid)
		if topicid is not None:
			try:
				t=Topic.objects.get(id=topicid)
				post=request.POST
				#print(post)
				name=post.get('name')
				no_of_topic=post.get('no_of_topic')
				block_slice_after_open=post.get('block_slice_after_open')


				topic_details=[]
				for i in range(1,int(no_of_topic)+1):
					topic_value=post.get('topics'+str(i))
					id_questions=post.getlist('topics'+str(i)+'questions')
					if(len(id_questions)) < 1:
						messages.info(request,"Please select at least one question in each topic")
						return render(request,self.template_name,{'allq':allq,'question_form':question_form,'show_spin':False})
					td=TopicDetails.objects.create(topic_name=topic_value)
					for j in range(len(id_questions)):
						td.questions.add(id_questions[j])
					topic_details.append(td)
			
				sp=SpinActivity.objects.create(end_date=timezone.now(),name=name,no_of_topic=no_of_topic)
				for td in topic_details:
					sp.topic_details.add(td.id)
	
				ac=Activities.objects.create(activity_type='spin_activity',
					author=request.user,activity_name=name,topic_id=t.id,content_id=sp.id)
				sp.activity=ac
				sp.save()
				messages.add_message(request,messages.INFO,"spin activity has been added")
				return HttpResponseRedirect(reverse_lazy('customadmin:all_course_user'))
				#return render(request,self.template_name,{'show_spin':False,'spinactivityid':sp.id})
			except:
				messages.add_message(request,messages.INFO,"Problem Occured while creating spin activity")
				print("problem here")
				return HttpResponseRedirect(reverse_lazy('customadmin:all_course_user'))
		else:
			return HttpResponseRedirect(reverse_lazy('customadmin:all_course_user'))
			#return render(request,self.template_name,{'show_spin':True,'error':'Problem Occured'})
		# try:
		#   post=request.POST
		#   print(post)
		#   name=post.get('name')
		#   no_of_topic=post.get('no_of_topic')
		#   #question_per_slices=post.get('question_per_slices')
		#   #id_questions=post.getlist('topics1questions')
		#   #print(id_questions)
		#   block_slice_after_open=post.get('block_slice_after_open')
		#   topic_details=[]
		#   for i in range(1,int(no_of_topic)+1):
		#       #print('topics'+str(i))
		#       topic_value=post.get('topics'+str(i))
		#       id_questions=post.getlist('topics'+str(i)+'questions')
		#       #print(id_questions)
		#       td=TopicDetails.objects.create(topic_name=topic_value)
		#       #print(td)
		#       for j in range(len(id_questions)):
		#           td.questions.add(id_questions[j])
		#       #td.questions.add(id_questions)
		#       #for j in range(1,id_questions+1):
		#           #td.questions.add(j)
		#       #td.save()
		#       topic_details.append(td)
		#   sp=SpinActivity.objects.create(end_date=timezone.now(),name=name,no_of_topic=no_of_topic)
		#       #question_per_slices=question_per_slices)
		#   #print(sp)
		#   for td in topic_details:
		#       sp.topic_details.add(td.id)
	
		#   return render(request,self.template_name,{'show_spin':False,'spinactivityid':sp.id})
		# except:
		#   return render(request,self.template_name,{'show_spin':False})
		# #if form.is_valid():
			#instance=form.save(commit=False)
			#print(instance)
			#print(request.POST)
			#return render(request,self.template_name,{'form':form})
		#return render(request,self.template_name,{'form':form})


from .models import AssignmentAnswer
from grades.models import GradingSystem,GradeRange
@login_required
def all_assignment(request):
	if request.user.is_superuser or request.user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
		all_a_answer = AssignmentAnswer.objects.all()
		all_grade=GradingSystem.objects.all()
		grades=[]
		try:
			ranges = all_grade[0].graderange_set .all()
			for r in ranges:
				grades.append({'id':r.id,'grade':r.grade})
		except ValueError:
			pass
		return render(request,'customadmin/assignment.html',{'assignments':all_a_answer,
			'grade':grades})



@csrf_exempt
def store_answer_for_spinactivity(request):
	try:
		qid=request.POST.get('questionid',None)
		aid=request.POST.get('answerid',None)
		sid=request.POST.get('spinactivityid',None)
		# seid=SpinActivityEnroll.objects.get(candidate_id=request.user.id,
		#   spinactivity_id=sid)
		#print(qid,aid,sid)
		sp,created=SpinActivityAnswer.objects.update_or_create(answer_option=aid,question_id=qid,spinactivity_id=sid)
		# sp.answer_option=aid
		# sp.save()
		return HttpResponse("response saved")
	except KeyError:
		print("all arguments are not passed")
	except:
		print("answer could not be loaded")
	return HttpResponse("error")


@csrf_exempt
def check_spin_result(request):
	try:
		user=request.user
		spinactivity_id=request.POST['spinactivity_id']
		se=SpinActivityEnroll.objects.get(candidate_id=user.id,
			spinactivity_id=spinactivity_id)
		submit_spin_question_answer=SpinActivityAnswer.objects.filter(spinactivity_id=se.id)
		for sqa in sqas:
			print(sqa)

	except:
		print("problem occured")

#@csrf_exempt
# def get_result(request):
#   try:
#       user=request.user
#       spinactivity_id=request.POST['spinactivity_id']
#       se=SpinActivityEnroll.objects.get(candidate_id=user.id,
#           spinactivity_id=spinactivity_id)
#       submit_spin_question_answer=SpinActivityAnswer.objects.filter(spinactivity_id=se.id)
#       for sqa in sqas:
#           print(sqa)

#   except:
#       print("problem occured")

from django.http import Http404
def get_all_courses_of_org(request):
	import json
	if request.method=="POST":
		org_id=request.POST.get('organization_id',None)
		if org_id is not None:
			org=Organization.objects.get(id=org_id)
			all_courses=org.get_all_courses()
			temp=[]

			for c in all_courses:
				t={}
				t['id']=c.id
				t['name'] = c.name
				temp.append(t)
			
			teachers = org.students.filter(position='student')
			t_temp=[]
			for teacher in teachers:
				t={}
				t['id']=teacher.id
				t['name'] = teacher.email
				t_temp.append(t)


			return HttpResponse(json.dumps({'message':True,'courses':temp,
				'teachers':t_temp}))

		return HttpResponse(json.dumps({'message':'problem with input data'}))
	return Http404(json.dumps({'message':'method not supported'}))


class ScheduleSession(View):
	form_class=ScheduleSessionForm
	template_name= 'customadmin/schedule_session_1.html'

	def get(self,request,*args,**kwargs):
		if not request.user.is_anonymous:
			context={}
			context['desc']='Session'
			if request.GET.get('upcoming_session',None) is not None:
				cont={}

				if request.user.is_superuser:
					all_event=[]
					all_se=SessionActivity.objects.filter(start_date__gte=timezone.now())

					for se in all_se:
						sed={}
						sed['title'] = se.topic
						sed['start'] = timezone.localtime(se.start_date).strftime("%Y-%m-%d %H:%M:%S")
						sed['teacher']=se.teacher.get_full_name()
						sed['description'] = se.description
						sed['link']=se.session_room_id

						all_event.append(sed)
					import json
					return HttpResponse(json.dumps(all_event))


				if request.user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
					#print("here")
					#ui=UserInformation.objects.get(user_id=request.user.id)
					orgs=request.user.organization_student.all()

					s_org_id=orgs[0].id
					#s_org_id=ui.organization_id
					all_courses=Organization.objects.get(id=s_org_id).course.all()
						#print(all_courses)
					all_event=[]
					ses=SessionActivity.objects.all()
					current_tz=timezone.get_current_timezone()
					#for course in all_courses:
					all_se=SessionActivity.objects.filter(start_date__gte=timezone.now())
					print('all session',all_se)
					for se in all_se:
						sed={}
						sed['title'] = se.topic
						sed['teacher'] = se.teacher.get_full_name()
						sed['start'] = timezone.localtime(se.start_date).strftime("%Y-%m-%d %H:%M:%S")
						sed['description'] = se.description
						sed['link'] = se.session_room_id
						all_event.append(sed)
							#print(all_event)
					cont['upcoming_session'] = all_event
						#print(cont)
					import json
					#print(all_event)
					return HttpResponse(json.dumps(all_event))
				if request.user.groups.filter(name=settings.COMPANY_INSTRUCTOR_GROUP).exists():
					pass
				

			if request.user.is_superuser:
				initial={}
				#initial['teacher'] = UserInformation.objects.filter(position='teacher')
				initial['teacher'] = get_user_model().objects.filter(position='teacher')
				#initial['organization'] = Organization.objects.all()
				from .forms import ScheduleSessionFormSuperuser
				form= ScheduleSessionFormSuperuser(initial=initial)
				context['form']=form
				context['upcoming_session']=SessionActivity.objects.filter(start_date__gte=timezone.now())
				return render(request,self.template_name,context)
			#if request.user.perms.has_perm('generic.can_schedulde_session'):
			if request.user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists() or \
				request.user.groups.filter(name=settings.COMPANY_INSTRUCTOR_GROUP).exists():
				#s_org_id=request.session.get('organization_id',None)
				#ui=UserInformation.objects.get(user_id=request.user.id)
				all_orgs=request.user.organization_student.all()
				if len(all_orgs) > 0:
					s_org_id= all_orgs[0].id
					s_org= all_orgs[0]
				#s_org_id=ui.organization_id
				#if s_org_id is None:
					#raise KeyError("There is problem with session org id")
				initial={}
				initial['teacher'] = s_org.students.filter(position='teacher')
				#initial['teacher'] = UserInformation.objects.filter(organization_id=s_org_id,position='teacher')
				initial['course'] = Organization.objects.get(id=s_org_id).course.all()
				initial['organization'] = Organization.objects.get(id=s_org_id)
				form= self.form_class(initial=initial)
				#print(form.fields['teacher'].initial_data)
				#print(form)
				context['form']=form
				return render(request,self.template_name,context)
				#return render(request,self.template_name,{'form':form,'desc':'Schedule Session'})
			#if request.user.perms.has_perm('generic.can_see_upcoming_session'):
				#pass

			return HttpResponse("Not Authorised")
		return HttpResponse("Not Authorised")

	def post(self,request):
		if not request.user.is_anonymous:

			if request.user.is_superuser:
				#print("in super user",request.POST)
				from .forms import ScheduleSessionFormSuperuser
				form = ScheduleSessionFormSuperuser(request.POST)
				if form.is_valid():
					print("hererer")
					form.author=request.user
					#f.organization = Organization.objects.get(id=s_org_id)
					self.obj=form.save(commit=False)
					times=form.cleaned_data['start_date'].timestamp()

					self.obj.session_room_id = form.cleaned_data['topic']+str(times)+str(form.cleaned_data['teacher'])
					self.obj.save()
					messages.success(request,"class room session has been scheduled")
					return HttpResponseRedirect(reverse_lazy("customadmin:calendar"))
				else:
					print(form.errors)
					#return render(request,"")
					
			if request.user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists() or \
				request.user.groups.filter(name=settings.COMPANY_INSTRUCTOR_GROUP).exists():
				#ui=UserInformation.objects.get(user_id=request.user.id)
				#s_org_id=ui.organization_id
				user = request.user
				s_org_id=user.organization_student.all()[0].id
				initial={}
				#initial['teacher'] = UserInformation.objects.filter(organization_id=s_org_id,position='teacher')
				initial['course'] = Organization.objects.get(id=s_org_id).course.all()
				initial['organization'] = Organization.objects.get(id=s_org_id)
				
				form=self.form_class(data=request.POST,initial=initial)
				#print(form.errors)
				if form.is_valid():
					f=form.save(commit=False)
					f.author=request.user
					f.organization = Organization.objects.get(id=s_org_id)
					times=form.cleaned_data['start_date'].timestamp()
					f.session_room_id = form.cleaned_data['topic']+str(times)+str(form.cleaned_data['teacher'])
					f.save()
					return HttpResponseRedirect(reverse('customadmin:calendar'))
					return render(request,self.template_name,{'form':form,
						'desc':'Schedule Session','msg':'Session Created'})
				else:
					return render(request,self.template_name,{'form':form,
						'desc':'Schedule Session','msg':'Problem with Data'})

			

			return HttpResponse("Not Authorised")
		return HttpResponse("Not Authorised")


class MeasureType(CreateView):
	pass


def classroom(request):
	if request.user.is_authenticated:
		return render(request,'customadmin/classroom_.html')
	return HttpResponse("Not Authorised")

def start_classroom_1(request,*args,**kwargs):
	if request.user.is_authenticated:
		session_room_id=kwargs.pop('session_room_id')
		username= request.user.username
		try:
			ui=UserInformation.objects.get(user_id=request.user.id)
			if ui.position=='teacher':
				isTeacher=True
		except:
			isTeacher=False
		return render(request,'customadmin/start_classroom.html',
			{'idx':'5678765','room_id':session_room_id,
			'userFullName':username,'isTeacher':isTeacher})
	return HttpResponse("No authorised")



def start_classroom(request,*args,**kwargs):
	import json
	session_room_id=kwargs.pop('roomid')
	username= request.user.username
	isTeacher = False
	classRoomConf = {"raiseQuery" : True}
	if request.user.is_superuser:
		isTeacher=True
		return render(request,'customadmin/teacher_classroom_page.html',
			{'idx':'5678765','room_id':session_room_id,
			'userFullName':username,'user_id': request.user.id,
			 'conf':classRoomConf,'isTeacher':isTeacher
		})

	if request.user.is_authenticated:
		try:
			ui=UserInformation.objects.get(user_id=request.user.id)
			classRoomConf = {"raiseQuery" : True}
			if ui.position=='teacher':
				isTeacher=True

			logger.info(isTeacher)
			import json
			if isTeacher:
				return render(request,'customadmin/teacher_classroom_page.html',
					{'idx':'5678765','room_id':session_room_id,
					'userFullName':username,'user_id': request.user.id,
					'conf':json.dumps(classRoomConf),'isTeacher':isTeacher,
					'duration':500})
			else:
				return render(request,'customadmin/student_classroom_page.html',
					{'idx':'5678765','room_id':session_room_id,
					'userFullName':username,'user_id': request.user.id,
					'conf':json.dumps(classRoomConf),'isTeacher':isTeacher})
		except UserInformation.ObjectDoesNotExist:
			print("ui is not defined")

		
	return HttpResponse("Not authorised")


def check_for(request):
	pass


@login_required
def get_enrolled_user_list(request):
	from .models import CourseEnroll
	if request.method=="POST":
		courseid=request.POST.get('courseid',False)
		if courseid:
			ce=CourseEnroll.objects.filter(course_id=courseid)
			all_user=[(c.user.get_full_name(),c.user.email,c.user.id) for c in ce]
			#print(all_user)
			return HttpResponse(json.dumps({'message':True,
				'users':all_user}))
	return HttpResponse(json.dumps({'message':False}))


@login_required
def course_report(request):
	all_course=[]
	all_user =[]

	if request.user.is_superuser:
		all_course= CoursesEndUser.objects.filter(~Q(state='DRAFT'))
		all_user = get_user_model().objects.filter(is_active=True)

	if request.method =="GET":
		return render(request,'customadmin/course_report.html',
			{'courses':all_course,'users':all_user})

	if request.method =="POST":
		#print(request.POST)
		userid=request.POST.get('userid',False)
		courseid= request.POST.get('courseid',False)
		if userid!='' and courseid!='':
			c=CoursesEndUser.objects.get(id=courseid)
			u=get_user_model().objects.get(id=userid)
			tws=TopicWiseAnswerpaper.objects.filter(user_id=userid,
				course_id=courseid)
			all_topics = c.course_topic.all()
			all_row=[]
			for topic in all_topics:
				print('topic',topic)
				#t=tws.filter(topic=topic)
				all_subtopic=topic.get_all_subtopic()
				print(userid,courseid,topic.id)
				tss=TopicWiseAnswerpaper.objects.filter(Q(user_id=userid),
					Q(course_id=courseid),Q(topic=topic))
				#print('tss',tss)
				if len(tss) > 0:
					if tss[0].is_completed==1:
						status = 'Completed'
					elif tss[0].is_open==1:
						status = 'In Progress'
					else:
						status = 'Not Opened'
					all_row.append([topic.name,'N/A','N/A',
						'N/A',status,str(tss[0].date_registered),'N/A',u.email])

				t=TopicWiseAnswerpaper.objects.filter(Q(user_id=userid),
					Q(course_id=courseid),~Q(activity=None),Q(topic=topic))

				if len(t) > 0:
					for ac in t:
						if ac.is_completed==1:
							status ='Completed'
						elif ac.is_open==1:
							status = 'In Progress'
						else:
							status = 'Not Opened'
						all_row.append([topic.name,ac.topic.name,ac.activity.activity_name,ac.activity.activity_type,
							status,str(ac.date_registered),'N/A',u.email])

				for t in all_subtopic:
					tss=TopicWiseAnswerpaper.objects.filter(Q(user_id=userid),
						Q(course_id=courseid),Q(activity=None),Q(topic=t))
					if len(tss) > 0:
						if tss[0].is_completed==1:
							status = 'Completed'
						elif tss[0].is_open==1:
							status = 'In Progress'
						else:
							status = 'Not Opened'
						all_row.append([topic.name,t.name,'N/A','N/A',status,str(tss[0].date_registered),'N/A',u.email])

					ts=TopicWiseAnswerpaper.objects.filter(Q(user_id=userid),
						Q(course_id=courseid),~Q(activity=None),Q(topic=t))

					if len(ts) > 0:
						for ac in ts:
							if ac.is_completed==1:
								status = 'Completed'
							elif ac.is_open==1:
								status = 'In Progress'
							else:
								status = 'Not Opened'
							all_row.append([topic.name,ac.topic.name,ac.activity.activity_name,
								ac.activity.activity_type,
								status,str(ac.date_registered),'N/A',u.email])

		#print(all_row)
		return render(request,'customadmin/course_report.html',
			{'courses':all_course,'users':all_user,'report':all_row})
	if True:
		try:
			import xlwt
			userid=request.POST.get('user_id',False)
			courseid= request.POST.get('course_id',False)

			c=CoursesEndUser.objects.get(id=courseid)

			all_content=all_available_topic_and_subtopic(courseid=courseid,user=True)
			#for content in all_content.items():
				#content.activity_type
			tws=TopicWiseAnswerpaper.objects.filter(user_id=userid,course_id=courseid)
			c.course_topic.all()
		except:
			pass

		#activity=
		# wb = xlwt.Workbook(encoding='utf-8')
		# ws = wb.add_sheet("sheet1")
		# row_num = 0
		# font_style = xlwt.XFStyle()
		# font_style.font.bold = True

		# columns = ['Topic','subtopic','Registered At','open','completed','activity type',
		# 		'Activity name','Time taken to complete']

		# for col_num in range(len(columns)):
		# 	ws.write(row_num, col_num, columns[col_num], font_style)

		# font_style = xlwt.XFStyle()

		# if userid:
		# 	print(userid)
		# 	response = HttpResponse(content_type='application/ms-excel')
		# 	response['Content-Disposition'] = 'attachment;filename="course_report.xls"'

		# 	tws=TopicWiseAnswerpaper.objects.filter(user_id=userid,course_id=courseid)
		# 	for tw in tws:
		# 		row_num+=1
		# 		if tw.topic.topic_type=="topic":
		# 			ws.write(row_num, 0, tw.topic.name, font_style)
		# 			all_subtopic=tws.filter(Q(topic=tw.topic),Q(activity=None))
		# 			print('all_subtopic',all_subtopic)
		# 			#ws.write(row_num, 0, my_row.name, font_style)
		# 			r=row_num
		# 			for sub in all_subtopic:
		# 				ws.write(r, 1, sub.topic.name, font_style)
		# 				r+=1
		# 			ws.write(row_num, 2, str(tw.date_registered.date()), font_style)
		# 			ws.write(row_num, 3, tw.is_open, font_style)
		# 			ws.write(row_num, 4, tw.is_completed, font_style)
		# 			if tw.activity is not None:
		# 				ws.write(row_num, 5, tw.activity.activity_type, font_style)
		# 				ws.write(row_num, 6, tw.activity.activity_name, font_style)
		# 			else:
		# 				ws.write(row_num, 5, 'N/A', font_style)
		# 				ws.write(row_num, 6, 'N/A', font_style)
		# 			ws.write(row_num, 7, 'N/A', font_style)
		# 		row_num=r
		# 	wb.save(response)
		# 	return response


class CreateGroup(View):
	form_class=CreateGroupForm

	def get(self,request):
		form=self.form_class()
		return render(request,'customadmin/create_group.html',{'form':form})

	def post(self,request):
		form=self.form_class(request.POST or None)
		if form.is_valid():
			#print(form)
			#print(form.cleaned_data)
			form.save()
			return render(request,'customadmin/create_group.html',{'form':form,'msg':'group created'})


def delete_activity_of_subtopic(subtopic):
	ac=Activities.objects.filter(topic=subtopic)
	if ac.exists():
		if ac.content_id is not None:
			if ac.activity_type=="spin":
				sp=SpinActivities.objects.filter(id=ac.content_id)
				if len(sp) > 0:	
					ta=TopicWiseAnswerpaper.objects.filter(activity=sp[0])
			if ac.activtiy_type=="drag_and_drop":
				pass
			if ac.activity_type == "quiz":
				from preassesment.models import Quiz
				q=Quiz.objects.filter(id=ac.content_id)
				if len(q) > 0:
					ta=TopicWiseAnswerpaper.objects.filter(activity=q[0])
			if ac.activity_type == "Assignment":
				pass

			if len(ta) > 0:
				ta[0].delete()


		ac.delete()

	subtopic.topic_content.all().delete()

def delete_topic(request):
	if request.method=="POST":
		topicid=request.POST.get('topicid',None)
		if topicid is not None:
			t=Topic.objects.get(id=topicid)
			if t.topic_type=="topic":
				all_subtopic=TopicRelation.objects.filter(topic_father=t)
				for subtopic in all_subtopic:
					delete_activity_of_subtopic(subtopic.topic_id)
					subtopic.delete()
				delete_activity_of_subtopic(t)
			else:
				delete_activity_of_subtopic(t)
			t.delete()
			return HttpResponse("true")
		return HttpResponse("error")
	return HttpResponse("error")
				#delete all subtopic and activity of it




class SubTopic(View):
	form_class = SubTopicForm
	template_name='customadmin/add_subtopic.html'


	def get(self,request,*args,**kwargs):
		topicid=kwargs.pop('topicid',None)
		nextval=request.GET.get('next',None)
		if topicid is None:
			return render(request,self.template_name,{'msg':'topic id is not defined'})
		
		topic=Topic.objects.get(id=topicid)
		course = topic.course
		#print(course)
		#print(course.course_topic.all())
		form = self.form_class(initial={'topic':topic,
			'author':request.user,'course':course,'topic_type':'subtopic'})
		return render(request,self.template_name,{'form':form,'next':nextval,'desc':'Add Subtopic'})

	def post(self,request,*args,**kwargs):
		topicid=kwargs.pop('topicid',None)
		nextval=request.POST.get('next',None)
		form=self.form_class(request.POST or None)
		#print(form.errors)
		if form.is_valid():
			obj=form.save(commit=False)
			obj._topicid=topicid
			#print(form.instance.topicid)
			obj.save()
			if nextval is not None:
				messages.success(request,'subtopic has been created')
				# return HttpResponseRedirect(settings.EXTRA_URL+nextval.replace("$","#"))
				return HttpResponseRedirect(reverse_lazy('customadmin:all_topic'))
			#return render(request,self.template_name,{'form':form,'next':nextval,'msg':'subtopic created'})
		messages.info(request,'topic could not be created')
		return render(request,self.template_name,{'form':form,'desc':'Add Subtopic','next':nextval,'msg':'subtopic could not be created'})
		#return render(request,self.template_name,{'form':form,'msg':'error occured'})



def maddvideo(request,*args,**kwargs):
	if request.method=="POST":
		# video=request.FILES['video']
		# description=request.POST['description']
		# topic=request.POST['topic']
		# if topic is not None:
		form=AddVideoForm(request.POST,request.FILES)
		if form.is_valid():
			obj=form.save()
			Activities.objects.create(activity_type='video',activity_name=obj.description,
				author=request.user,content_id=obj.id,topic=obj.topic)
			#ContentVideo.objects.create(topic_id=topic,video=video,description=description)
			return HttpResponse("Successfully Video Added")
		else:
			#print(form.errors)
			import json
			output_string=''
			for field,errors in form.errors.items():
				for error in errors:
					output_string=output_string+error+"\n"
			return HttpResponse(output_string)

# class UpdateVideo(UpdateView):
# 	form_class = AddVideoForm
# 	template_name = 'customadmin/add_video.html'
# 	success_url =reverse_lazy("customadmin:edit_course_user")

# 	def check_user(self,user):
# 		if user.is_superuser or user.groups.filter(name=settings.COMPANY_ADMIN_GROUP).exists():
# 			return True
# 		return False

# 	def get_context_data(self,**kwargs):
# 		ctx = super(EditTopic, self).get_context_data(**kwargs)
# 		ctx['desc']='Update Video'
# 		return ctx

class AddVideo(View):
	form_class= AddVideoForm
	template_name='customadmin/add_video.html'
	def get(self,request,*args,**kwargs):
		nextval=request.GET.get('next',None)
		#if nextval is not None:
		#return HttpResponseRedirect(nextval)
		try:
			topicid=kwargs.pop('topicid',None)
			subtopicid=kwargs.pop('subtopicid',None)
		except KeyError as e:
			print(e)
		initial={}
		if topicid is not None:
			initial['topic']=topicid
			tp=Topic.objects.get(id=topicid)
			if tp.course_id is not None:
				initial['course']= tp.course_id
		if subtopicid is not None:
			initial['subtopic']=subtopicid
		#print(initial)
		form=self.form_class(initial=initial) 
		return render(request,self.template_name,{'form':form,'next':nextval,'desc':'Add Video'})

	def post(self,request,*args,**kwargs):
		form=self.form_class(request.POST ,request.FILES)
		#print(form)
		#print(args)
		#print(kwargs)
		nextval=request.POST.get('next',None) 
		#print(nextval)
		if form.is_valid():
			obj=form.save()
			Activities.objects.create(activity_type='video',activity_name=obj.description,
				author=request.user,content_id=obj.id,topic=obj.topic)
			if nextval is not None:
				messages.success(request,"video added successfully")
				# return HttpResponseRedirect(settings.EXTRA_URL+nextval.replace("$","#"))
				return HttpResponseRedirect(reverse_lazy('customadmin:all_video'))
			return render(request,self.template_name,{'form':form,'next':nextval})
		else:
			#print(form.errors)
			messages.info(request,form.errors)
			return render(request,self.template_name,{'form':form,'desc':'Add Video','next':nextval})



class UpcomingSession(View):
	def get(self,request,*args,**kwargs):
		sa=SessionActivity.objects.all()
		return HttpResponse(sa)


def have_father(dic,obj):
	if dic.get(obj,None) is None:
		return False
	return True



class Tree(object):
	"""Generic tree node."""
	def __init__(self, name='root', obj=None, children=None):
		self.name = name
		self.obj=obj
		self.children = []
		if children is not None:
			for child in children:
				self.add_child(child)

	def __repr__(self):
		return "root"
		#return self.name

	def add_child(self, node):
		assert isinstance(node, Tree)
		self.children.append(node)

	def has_child(self):
		if len(self.children) > 0:
			return True
		return False

	def get_parent(self,child_nodes_of_root,node):
		for childs in child_nodes_of_root:
			if node==childs:
				return original_tree_node
		
		for child in child_nodes_of_root:
			if child.has_child():
				return get_parent(child.children,node)

		return None

	def get_object_node(self,obj):
		if self is not None and self.has_child():
			for childs in self.children:
				if obj==childs.obj:
					return childs
				elif childs.has_child():
					print("ddddddd",childs)
					childs.get_object_node(obj)
				else:
					pass
		return None

	a=[]
	def represent_tree(self):
		global a
		for childs in self.children:
			a[childs]=[]
			if childs in a:
				pass
			if childs.has_child():
				childs.represent_tree()



class UpdateCategory(UpdateView):
	model = Categories
	template_name ='customadmin/categories.html'
	fields = [ 
		"name", 
		"category_about",
		"organization",
	] 
	success_url =reverse_lazy("customadmin:all_categories")

	def get_context_data(self,**kwargs):
		ctx = super(UpdateCategory, self).get_context_data(**kwargs)
		ctx['desc']='Edit Category'
		return ctx



class DeleteCategory(DeleteView):
	# def get_object(self, queryset=None):
 #        """ Hook to ensure object is owned by request.user. """
 #        obj = super(MyDeleteView, self).get_object()
 #        if not obj.owner == self.request.user:
 #            raise Http404
 #        return obj
	model = Categories
	success_url = reverse_lazy('userlms:home')

	def get_success_url(self):
		return reverse_lazy('customadmin:all_categories')

	def get(self, request, *args, **kwargs):
		return self.post(request, *args, **kwargs)


	


class CategoriesListView(ListView):
	model = Categories
	template_name = 'customadmin/allcategories.html'

	def get_context_data(self,**kwargs):
		ctx = super(CategoriesListView, self).get_context_data(**kwargs)
		ctx['desc']='View All Categories'
		return ctx

	def get_queryset(self):
		allch=CategoriesHirerchy.objects.select_related('category_father')
		all_category=[]
		temp={}
		#t=Tree()
		for categorych in allch:
			if categorych.category_father is None:
				category=Categories.objects.get(id=categorych.category_id)
				#print("adding child node to ",t,category)
				#t.add_child(Tree(name='',obj=category))
				if category not in temp.keys():
					temp[category]={}
				
			else:
				child_category = Categories.objects.get(id=categorych.category_id)
				father_category= Categories.objects.get(id=categorych.category_father_id)
				print(father_category,child_category)
				#print(t.get_object_node(father_category))
				#obj_node=t.get_object_node(father_category)
				# if obj_node is not None:
				#   print("adding")
				#   obj_node.add_child(Tree(child_category))
				
				if temp.get(father_category,None) is None:
					print("no entry found for ", father_category)
					for key,values in temp.items():
						if father_category in values:
							# father is actually child
							print("father is actually child")
							t=temp[key]
							if father_category in t.keys():
								t[father_category].update({child_category:{}})
							else:
								t[father_category]={child_category:{}}
					#temp[father_category]=[]
				else:
					if father_category in temp.keys():
						temp[father_category].update({child_category:{}})
					else:
						temp[father_category]={child_category:{}}
		print(temp)
		return temp



class CategoriesView(View):
	form_class= CategoryForm
	template_name='customadmin/categories.html'

	def get(self,request,*args,**kwargs):
		#cateh=CategoriesHirerchy.objects.all()
		dic={}
		cate = Categories.objects.all()
		initial={}
		category_father=kwargs.get('category_father',None)
		if category_father is not None:
			initial['category_type']='subcategory'
		form = self.form_class(initial=initial)
		# list_of_father={}
		# for cat in cate:
			
		#   if cat.category_type =='category':
		#       list_of_child={}
		#       all_child=CategoriesHirerchy.objects.filter(category_father_id=cat.id)
		#       #list_of_child.append(all_child)
		#       #print(all_child)
		#       for child in all_child:
		#           list_of_subchild=[]
		#           sub_child=CategoriesHirerchy.objects.filter(category_father_id=child.category_id)
		#           if len(sub_child):
		#               for obj in sub_child:
		#                   list_of_subchild.append(Categories.objects.get(id=obj.category_id))
		#           #list_of_child[]
		#           list_of_child[Categories.objects.get(id=child.category_id)]=list_of_subchild

		#       list_of_father[cat]=list_of_child
			
		
		# print(list_of_father)
		return render(request,'customadmin/categories.html',{'form':form})

	def post(self,request,*args,**kwargs):
		dic={}
		if request.user.is_superuser:
			category_father=kwargs.get('category_father',None)
			#print('category father is ',category_father)
			form=self.form_class(request.POST)
			if form.is_valid():
				#print(form)
				category_type=form.cleaned_data['category_type']
				if category_type=='subcategory' and category_father is not None:
					form.save(category_father=category_father)
				else:
					form.save(commit=True)
			
			return render(request,'customadmin/categories.html',{'categories':dic,'form':form})
		raise Http404("Page Does not Found")







