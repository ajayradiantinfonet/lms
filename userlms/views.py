from django.shortcuts import render,redirect

# Create your views here.

from customadmin.models import (CoursesEndUser,UserCategories,Topic,TopicRelation,
TopicWiseAnswerpaper,SpinActivityAnswer,Activities,SessionActivity)
from django.views.generic.detail import DetailView
from django.views.generic import ListView
from django.http import HttpResponse,HttpResponseRedirect
from django.urls import reverse_lazy
from django.conf import settings
from customadmin.views import all_available_topic_and_subtopic
from django.db.models import Q
from organization.models import UserInformation
from .models import Discussion,ForumAnswer
from django.contrib.auth.models import User
from chat.models import Room,Room_User,Layer
from django.middleware import csrf
import logging
from django.contrib.auth import get_user_model

from django.contrib.auth.decorators import login_required
from .decorators import is_profile_complete
logger = logging.getLogger('django')



def trending_course():
	trending_course=None
	total_views=0
	course_list=CoursesEndUser.objects.filter(access='PUBLIC',state='PUBLISHED')
	for course in course_list:
		if course.total_view > total_views:
			trending_course = course
			total_views=course.total_view
	return trending_course



@is_profile_complete(next='/home')
def home(request):
	#return render(request,'user_lms/student_dashboard.html',{})
	#is_profile_completed(request,next=None)
	all_courses=[]
	#trending_course=trending_course()
	#print(request.get_full_path())
	all_cuser_categories=UserCategories.objects.all()
	if len(all_cuser_categories) > 10:
		all_cuser_categories = all_cuser_categories[0:10]
	uc=None
	course_list=[]
	if request.GET.get('category',None) is not None:
		category = request.GET['category']
		uc = UserCategories.objects.get(name=category)
		if request.user.is_authenticated:
			if request.user.groups.filter(name=settings.END_USER_GROUP).exists():
				#print("org user")
				#ui=UserInformation.objects.filter(user_id=request.user.id)
				orgs=request.user.organization_student.all()
				if len(orgs) > 0:
					org=orgs[0]
				#if len(ui) > 0:
					#org=ui[0].organization
					course_list.extend(org.get_all_published_course_for_student(request.user.id))
					for c in CoursesEndUser.objects.filter(category_id=uc.id,access='PUBLIC',state='PUBLISHED'):
						if c not in course_list:
							course_list.append(c)
			if request.user.is_superuser:
				for c in CoursesEndUser.objects.filter(category_id=uc.id,access='PUBLIC',state='PUBLISHED'):
					if c not in course_list:
						course_list.append(c)
				#CoursesEndUser.objects.filter(Q(category_id=uc.id) | Q(=True))
			else:
				for c in CoursesEndUser.objects.filter(category_id=uc.id,access='PUBLIC',state='PUBLISHED'):
					if c not in course_list:
						course_list.append(c)
		else:
			course_list.extend(CoursesEndUser.objects.filter(category_id=uc.id,state='PUBLISHED',access='PUBLIC'))
			print("user not logged in",course_list)

		
		if trending_course is not None:
			return render(request,'user_lms/first.html',{'user':request.user,'object_list':course_list,
				'categories':all_cuser_categories,'trending':trending_course})
		else:
			return render(request,'user_lms/first.html',{'user':request.user,'object_list':course_list,
				'categories':all_cuser_categories})
	 
	if request.user.is_authenticated:
		if request.user.groups.filter(name=settings.END_USER_GROUP).exists():
			#print("org user")
			#ui=UserInformation.objects.filter(user_id=request.user.id)
			orgs=request.user.organization_student.all()
			if len(orgs) > 0:
				org=orgs[0]
			#if len(ui) > 0:
				#org=ui[0].organization
				all_courses.extend(org.get_all_published_course_for_student(request.user.id))
				for c in CoursesEndUser.objects.filter(access='PUBLIC',state='PUBLISHED'):
					if c not in all_courses:
						all_courses.append(c)
			else:
				all_courses.extend(CoursesEndUser.objects.filter(access='PUBLIC',state='PUBLISHED'))
				#CoursesEndUser.objects.filter(Q(category_id=uc.id) | Q(=True))
		else:
			all_courses.extend(CoursesEndUser.objects.filter(access='PUBLIC',state='PUBLISHED'))
	else:
		all_courses.extend(CoursesEndUser.objects.filter(access='PUBLIC',state='PUBLISHED'))

	for c in course_list:
		if c not in all_courses:
			all_courses.append(c)

	all_students = UserInformation.objects.filter(position='student').count()
	all_course = CoursesEndUser.objects.filter(access='public').count()
	all_instructor = UserInformation.objects.filter(position='teacher').count()

	total_views=0

	if trending_course is not None:

		return render(request,'user_lms/first.html',{'user':request.user,'object_list':all_courses,
				'categories':all_cuser_categories,'all_students':all_students,
				'all_course':all_course,'all_instructor':all_instructor,'trending':trending_course
				})
	else:
		return render(request,'user_lms/first.html',{'user':request.user,'object_list':all_courses,
				'categories':all_cuser_categories,'all_students':all_students,
				'all_course':all_course,'all_instructor':all_instructor,
				})


	# try:
	# 	all_cuser_categories=UserCategories.objects.all()
	# 	if request.GET.get('category',None) is not None:
	# 		category = request.GET['category']
	# 		uc = UserCategories.objects.get(name=category)
	# 		if uc is not None:
	# 			course_list = CoursesEndUser.objects.filter(category_id=uc.id)
	# 			print(course_list)
	# 		return render(request,'user_lms/first.html',{'user':request.user,'object_list':course_list,
	# 			'categories':all_cuser_categories,'user':request.user})
		
	# 	#print(course_list)
	# 	course_list=CoursesEndUser.objects.filter(state='PUBLISHED')
	# 	if request.user.is_authenticated:

	# 	return render(request,'user_lms/first.html',{'user':request.user,'object_list':course_list,
	# 		'categories':all_cuser_categories,'user':request.user})
	# except:
	# 	return HttpResponse('reverse url problem', status=401)

class AllCourse(ListView):
	template_name = 'user_lms/first.html'

	def get_queryset(self,request=None):
		#print(self.kwargs.get('category'))
		all_cuser_categories = UserCategories.objects.all()
		#print(self.request)
		if self.request.GET.get('category',None) is not None:
			category = self.request.GET['category']
			#print(category)
			uc = UserCategories.objects.get(name=category)
			course_list = CoursesEndUser.objects.filter(category_id=uc.id)
			return render(self.request,'user_lms/first.html',{'user':self.request.user,'object_list':course_list,
				'categories':all_cuser_categories,'user':request.user})

		course_list = CoursesEndUser.objects.all()
		
		#return render(self.request,'user_lms/first.html',{})
		return render(self.request,'user_lms/first.html',
			{'user':self.request.user,'object_list':course_list,
				'categories':all_cuser_categories,'user':request.user})


class CourseDetails(DetailView):
	""" Show Course Details """
	model=CoursesEndUser
	template_name='user_lms/course_detail.html'

	def get_object(self):
		#obj = super(CourseDetails, self).get_object(queryset=queryset)
		self.obj = super().get_object()
		#self.increase_views()
		return self.obj

	def increase_views(self):
		#self.obj = self.get_object()
		self.obj.total_view += 1
		self.obj.save()

	def get_context_data(self,**kwargs):
		ctx = super(CourseDetails, self).get_context_data(**kwargs)
		ctx['desc']='Course Datails'
		self.obj=self.get_object()
		self.increase_views()
		#ctx['topic']=Topic.objects.all()
		all_topics=Topic.objects.filter(topic_type='topic',course_id=self.obj.id)
		#print(all_topics)
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
		ctx['topic_list'] = object_list
		ctx['object_list'] = CoursesEndUser.objects.all()
		all_cuser_categories=UserCategories.objects.all()
		if len(all_cuser_categories) > 10:
			all_cuser_categories = all_cuser_categories[0:10]
		ctx['categories'] = all_cuser_categories
		ctx['trending'] = trending_course()
		#print("hh",object_list)
		#ctx['user']=self.request.user
		return ctx

		#queryset = super(CourseDetails, self).get_queryset()
		#queryset.filter()
		#return queryset

def check_course(request):
	return render(request,'user_lms/course_dashboard.html',{'user':request.user})


from customadmin.models import AssignmentAnswer,AssignmentActivity

def submit_assignment(request):
	if request.method=="POST":
		d=dict(request.POST.lists())
		#print(d)
		user_id=d.pop('user')[0]
		file=request.FILES.get('file',None)
		print(file)
		activity_id=d.pop('activity_id',None)[0]
		if activity_id is not None:
			ac=Activities.objects.get(id=activity_id)
			ass=AssignmentActivity.objects.get(id=ac.content_id)
			aans=AssignmentAnswer.objects.filter(activity=ass,user=request.user).order_by('-id')
			if len(aans) > 0:
				if ass.no_of_submission is not None  and int(ass.no_of_submission) > -1:
					if int(ass.no_of_submission) > len(aans):
						#print(**d)
						TopicWiseAnswerpaper.objects.filter(activity=ac,user=request.user).update(is_completed=1)
						AssignmentAnswer.objects.create(activity=ass,user=request.user,
							submission=int(aans[0].submission)+1,answer_file=file)
						ac=open_next(request.user,ac.topic.id,None)
						res= json.dumps({"message":"Done","activity":ac})
					else:
						res= json.dumps({"message":"no of attempts exceed","activity":activity_id})
					return HttpResponse(res,content_type='application/json')
			else:
				AssignmentAnswer.objects.create(activity=ass,user=request.user,
						submission=1)
				ac=open_next(request.user,ac.topic.id,None)
				res= json.dumps({"message":"Done","activity":activity_id})
				return HttpResponse(res,content_type='application/json')
	res= json.dumps({"message":"could not submit","activity":None})
	return HttpResponse(res,content_type='application/json')
	#return HttpResponse("error")



from django.utils import timezone
def useradmin(request):
	if request.user.is_authenticated:
		#check if user is already enrolled
		#enrolled_courses=request.user.end_user_course_students.all()
		#print(list(CoursesEndUser.objects.filter(students=request.user.id).values_list()))
		#CourseEnroll.objects.create(user=request.user,is_completed=0,course_id=)
		enrolled_course=CourseEnroll.objects.filter(user=request.user,is_completed=0)
		enrolled_courses=[]

		for en in enrolled_course:
			en.percentage= course_overall_completion_percentage(en.course,request.user)
			enrolled_courses.append(en)

		all_session_activity=[]
		logger.info(SessionActivity.objects.all())
		all_session_activity.extend(SessionActivity.objects.all())

		# for ce in enrolled_courses:

		# 	all_session_activity.extend(SessionActivity.objects.filter(course=ce.course,
		# 	start_date__gte=timezone.now()))

		# ui=UserInformation.objects.filter(user_id=request.user.id)
		# if len(ui) > 0:
		# 	all_session_activity.extend(SessionActivity.objects.filter(
		# 		organization=ui[0].organization,start_date__gte=timezone.now()))
		# all_session_activity.extend(SessionActivity.objects.filter(Q(organization=None),Q(course=None),
		# 	Q(start_date__gte=timezone.now())))

		all_cuser_categories=UserCategories.objects.all()
		if len(all_cuser_categories) > 10:
			all_cuser_categories = all_cuser_categories[0:10]
		trending=trending_course()
		#print("""""""")
		#print(all_session_activity)
	#if request.user.groups.filter(name=settings.END_USER_GROUP).exists():
		return render(request,'user_lms/student_dashboard.html',{'user':request.user,
			'enrolled_courses':enrolled_courses,'all_session':all_session_activity,
			'categories':all_cuser_categories,
			'trending':trending,'media_url':settings.MEDIA_URL })
	else:
		return redirect(reverse_lazy('accounts:login'))

from customadmin.models import CourseEnroll,SpinActivity,AssignmentActivity
from django.shortcuts import get_object_or_404


def get_activity(request,pk):
	if request.method=="POST":
		def get_object(id):
			obj = get_object_or_404(Activities, id = id) 
			return obj

		act=get_object(pk)

		if act.activity_type=="Assignment":
			ass=AssignmentActivity.objects.filter(id=act.content_id)
			if len(ass) > 0:
				return HttpResponse(ass[0].question_file.url)
	return HttpResponse("error")

def show_spin_activity(request,pk):
	if request.method=="POST":
		def get_object(id):
			obj = get_object_or_404(SpinActivity, id = id) 
			return obj
		sp=get_object(pk)
		topics=[]
		for topic in sp.topic_details.all():
					#print(topic)
			temp={}
			temp['label']=topic.topic_name
			temp['value'] = 1
			tq=[]
			print(topic.questions.all())
			for q in topic.questions.all():
				tq.append({'qid':q.id,'q':q.question_name,'op1':q.option_a,
							'op2':q.option_b,'op3':q.option_c,'op4':q.option_d})
			temp['question']=tq
			topics.append(temp)
			#print(topics)
		import json
		a={'show_spin':True,'alltopics':topics,'spinactivity_id':pk}
		return HttpResponse(json.dumps(a))

def get_online_user(request):
	if request.method=="POST":
		courseid=request.POST.get('course',None)
		userlist=[]
		if courseid is not None:
			c=CoursesEndUser.objects.get(id=int(courseid))
			rm=Room_User.objects.filter(room_id=str(c.id)+str(c.name),status=True)
			for r in rm:
				userlist.append(str(User.objects.get(id=r.user_id)))
			#print(userlist)
			import json
			return HttpResponse(json.dumps({"users":userlist}))
	return HttpResponse({"error":[]})

def get_all_topic(courseid):
	t=Topic.objects.filter(course_id=courseid)
	for course_activity in t:
		yield course_activity.topic



@login_required
def certificate(request):
	courses=CourseEnroll.objects.filter(user=request.user)
	all_courses=[]
	#orgs = Organization.objects.get(id=8)
	#print(orgs)
	for course in courses:
		#all_org=course.course.organization_set.all()
		all_org=course.course.organization_course.all()
		if len(all_org) > 1:
			#it has more than one org , course is assigned 
			# will take root certificate
			course.course.certificate=all_org[0].certificate
			#course.course.certificate=orgs.certificate
		elif len(all_org)==1:
			course.course.certificate=all_org[0].certificate
			course.orgid = all_org[0].id

		elif len(all_org) < 1:
			course.course.certificate=None
			#course.course.certificate=orgs.certificate
			# course is public course
		per=course_overall_completion_percentage(course.course,request.user)
		#print(per)
		course.course.percentage=per
		all_courses.append(course.course)

	is_mobile = request.user_agent.is_mobile
	return render(request,'user_lms/certificate.html',
		{'all_course':all_courses,'user':request.user,'is_mobile':is_mobile})



def download_certificate(request):
	otype=request.GET.get('otype',False)
	courseid = request.GET.get('courseid',False)
	userid = request.GET.get('userid',False)
	from django.contrib.auth.models import User

	if otype=="image":
		try:

			logger.info("userid is "+str(userid))
			u=User.objects.get(id=userid)
			if u.first_name is not None:
				name= u.first_name
			else: name = u.username
			orgs = Organization.objects.get(id=8)
			certificate= None
			if courseid is not None:
				c=CoursesEndUser.objects.get(id=courseid)
				ce=CourseEnroll.objects.filter(course=c,user=u)
				if len(ce) < 0 :
					return render(request,'user_lms/download_certificate.html',{'certificate':None})
				course_org=c.organization_set.all()
				if len(course_org) > 1:
					#shared course
					certificate = orgs.certificate
				elif len(course_org)==1:
					certificate= course_org[0].certificate
				elif len(course_org) < 1:
					#none organization
					certificate = orgs.certificate
				return render(request,'user_lms/download_certificate.html',{'certificate':certificate,
					'user':u})
			else:
				#org is superuser
				pass
		except User.ObjectDoesNotExist:
			pass
	else:
		return HttpResponse("working for other cases")



# def is_profile_completed(request,next=None):
# 	user=request.user
# 	print(user.profile_complete)
# 	if not user.profile_complete:
# 		return HttpResponseRedirect(reverse_lazy('userlms:user_profile'))

def course_list(request):
	all_course=CoursesEndUser.objects.filter(state='PUBLISHED')
	all_cuser_categories=UserCategories.objects.all()
	if len(all_cuser_categories) > 10:
		all_cuser_categories = all_cuser_categories[0:10]
	return render(request,'user_lms/course_list.html',
		{'all_course':all_course,'total_course':len(all_course),
		'categories':all_cuser_categories})






from django.views.generic.edit import UpdateView
class ProfileSubmit(UpdateView):
	model = get_user_model()
	fields = ['first_name','last_name','gender','email','phone','address',
		'address1','pincode']
	template_name = 'user_lms/profile.html'
	success_url = reverse_lazy('userlms:home')


	# def form_valid(self,form):
	# 	print("form is valid")
	# 	self.obj=form.save(commit=False)
	# 	self.obj.profile_complete=1
	# 	self.obj.save()
	# 	message.success(self.request,"profile updated successfully")


	# def form_invalid(self,form):
	# 	print("form invalid",form.errors)
	# 	return render(self.request,template_name)

	def post(self, request, **kwargs):
		obj = self.get_object()
		#print(obj)
		dic=request.POST.copy()
		#from accounts.forms import UserCreationForm
		#print(obj.first_name)
		image=request.FILES.get('image',None)
		import os
		if image is not None:
			from django.core.files.storage import FileSystemStorage
			fs = FileSystemStorage()
			filename = fs.save(os.path.join(settings.MEDIA_ROOT,'profile_image/',image.name), image)
			obj.image = 'profile_image/'+image.name
		#form = UserCreationForm(request.POST or None, instance = obj)
		#print(form)
		# if form.is_valid():
		# 	print("fjfjfjj")
		# 	obj=form.save(coomit=False)
		# 	obj.profile_complete=1
		# 	obj.save()
		# else:
		# 	print(form.errors)
		#print(dic)
		for key,val in dic.items():
			if val!='' and val is not None:
				setattr(obj, key, val)
				#print(key,val)
		obj.profile_complete=1
		obj.save()
		from django.contrib import messages
		messages.success(request,"profile has been updated")
		return super(ProfileSubmit, self).post(request, **kwargs)

@login_required
def user_profile(request):
	context = {}
	context['user'] = request.user
	if request.GET.get('next',None) is not None:
		next = request.GET.get('next',None)
		context['next'] = next
	if request.user.is_superuser and not request.user.has_organization:
		from customadmin.forms import CreateOrganizationForm
		form = CreateOrganizationForm()
		context['form'] = form
	return render(request,'user_lms/profile.html',context)


#course completion percentage for perticuler user
def course_overall_completion_percentage(course,user):
	#check if user is enrolled in it 
	try:
		ce=CourseEnroll.objects.filter(course=course,user=user)
		all_topic=0
		all_subtopic=0
		data_report ={}
		all_activity=0
		all_video=0

		completed_activity=0
		completed_video = 0
		completed_topic=0
		completed_subtopic=0

		for topic in course.course_topic.all():
			all_topic+=1
			#check video
			#completed_video=0
			#topic_activity =0

			# for v in topic.topic_content.all():
			# 	all_video+=1
			# 	completed_video+=TopicWiseAnswerpaper.objects.filter(content_video=v,is_completed=1,user=user).count()

			#data_report[topic]={}
			#data_report[topic]['completed_video']=completed_video
			#for ac in topic.activity_topic.all():
			acs=Activities.objects.filter(topic=topic)
			all_activity+=len(acs)
			for ac in acs:
				completed_activity+=TopicWiseAnswerpaper.objects.filter(activity=ac,is_completed=1,user=user).count()

			trs=TopicRelation.objects.filter(topic_father=topic)
			for tr in trs:
				all_subtopic+=1
				subt=Topic.objects.get(id=tr.topic_id_id)
				# for v in subt.topic_content.all():
				# 	all_video+=1
				# 	completed_video+=TopicWiseAnswerpaper.objects.filter(content_video=v,is_completed=1,user=user).count()
				acs=Activities.objects.filter(topic=subt)
				#all_activity+=len(acs)
				for ac in acs:
					all_activity+=1
					completed_activity+=TopicWiseAnswerpaper.objects.filter(activity=ac,is_completed=1,user=user).count()

			try:
				print("all_activity",all_activity)
				print("completed_activity",completed_activity)
				percentage = ((completed_activity)/(all_activity))*100
				print("percentage",percentage)

			except ZeroDivisionError:
				return 0
			return int(percentage)


	except CourseEnroll.ObjectDoesNotExist:
		print("user is not enrolled")
		return 0

from customadmin.models import Organization

#activity_report
#eye blink on the time of registration
#configurable password change
#court report mein chart 
#report web or excel
#teacher dashboard 
#grading of assignment
#user 
#maximum number on assignment , percentage 





def get_last_opened_topic(request):
	import json
	courseid=request.POST.get('courseid',None)
	c=CoursesEndUser.objects.get(id=courseid)

	#all_topics = c.course_topic.all()
	ce=CourseEnroll.objects.filter(course=c,user=request.user)
	if len(ce) > 0:
		if ce[0].is_completed:
			return HttpResponse(json.dumps({"message":False}))

	found_topic=None
	tws=TopicWiseAnswerpaper.objects.filter(~Q(topic=None),Q(course=c),Q(user=request.user),Q(is_open=1)).order_by('-topic__id')
	print("tws",tws)
	if len(tws) > 0:
		found_topic=tws[0].topic

	print("found_topic",found_topic)

	# for topic in all_topics[::-1]:
	# 	if TopicWiseAnswerpaper.objects.filter(topic=topic,user=request.user,is_open=1,is_completed=1).exists():
	# 		found_topic=topic
	# 		break

	if found_topic is not None:
		completed_activity=TopicWiseAnswerpaper.objects.filter(Q(topic=found_topic),Q(user=request.user),
			Q(is_open=1),~Q(activity=None)).order_by('-id')

		if len(completed_activity) > 0:
			#next_learning=found_topic.remaining_learning_unit(request.user,activityid=completed_activity[0].activity_id)
			#if next_learning is not None:
			return HttpResponse(json.dumps({"activity":completed_activity[0].activity_id,
				"activity_type":completed_activity[0].activity.activity_type}))
		else:
			#check topic type
			if found_topic.topic_type=="subtopic":
				ac=found_topic.open_first_activity_of_subtopic(user=request.user)
			else:
				ac=found_topic.open_first_activity_of_topic(user=request.user)
			if ac is not None:
				return HttpResponse(json.dumps({"activity":ac.id,"activity_type":ac.activity_type}))
	return HttpResponse(json.dumps({"activity":None,"activity_type":None}))

		# for ac in all_ac[::-1]:
		# 	if TopicWiseAnswerpaper.objects.filter(topic=topic,user=request.user,activity=ac,is_completed=1).exists():
		# 		found_activity=ac
		# 		break

		# if found_activity is not None:
		# 	next_learning=found_topic.remaining_learning_unit(request.user,activityid=found_activity.id)
		# 	opened_subtopic=None
		# 	all_subtopic = found_topic.get_all_subtopic()[::-1]
		# 	for sub in all_subtopic:
		# 		if TopicWiseAnswerpaper.objects.filter(topic=topic,user=request.user,is_open=1).exists():
		# 			opened_subtopic = sub
		# 			break

		# 	if next_learning is None:
		# 		if opened_subtopic is not None:
		# 			print("opened subtopic",opened_subtopic)
		# 			ac=opened_subtopic.open_first_activity_of_subtopic(request.user)
		# 			if ac is not None:
		# 				#print("here")
		# 				return HttpResponse(json.dumps({"activity":ac.id,
		# 					"activity_type":ac.activity_type}))
		# 		else:
		# 			ac=all_subtopic[len(all_subtopic)-1].open_first_activity_of_subtopic(request.user)
		# 			if ac is not None:
		# 				return HttpResponse(json.dumps({"activity":ac.id}))
		# 	else:
		# 		#print("major last item ")
		# 		if TopicWiseAnswerpaper.objects.filter(topic=topic,user=user,activity=next_learning,
		# 			is_completed=1).exists():
		# 			if opened_subtopic is not None:
		# 				ac=opened_subtopic.open_first_activity_of_subtopic(request.user)
		# 				if ac is not None:
		# 					return HttpResponse(json.dumps({"activity":ac.id}))
		# 			else:
		# 				ac=all_subtopic[len(all_subtopic)-1].open_first_activity_of_subtopic(request.user)
		# 				if ac is not None:
		# 					return HttpResponse(json.dumps({"activity":ac.id}))
		# 		else:
		# 			return HttpResponse(json.dumps({"activity":found_activity.id}))
		# else:
		# 	opened_subtopic=None
		# 	all_subtopic = found_topic.get_all_subtopic()[::-1]
		# 	for sub in all_subtopic:
		# 		if TopicWiseAnswerpaper.objects.filter(topic=topic,user=request.user,is_open=1).exists():
		# 			opened_subtopic = sub
		# 			break
		# 	if opened_subtopic is not None:
		# 		ac=opened_subtopic.open_first_activity_of_subtopic(request.user)
		# 		if ac is not None:
		# 			return HttpResponse(json.dumps({"activity":ac.id}))
		# 		else:
		# 			ac=all_subtopic[len(all_subtopic)-1].open_first_activity_of_subtopic(request.user)
		# 			if ac is not None:
		# 				return HttpResponse(json.dumps({"activity":ac.id}))





# @login_required
# def get_last_opened_topic(course,user,course_content=None):
# 	#logger.info(course_content)
# 	all_topics = course.course_topic.all()
# 	ce=CourseEnroll.objects.filter(course=course,user=user)
# 	if len(ce) > 0:
# 		if ce[0].is_completed:
# 			return None


# 	for topic in all_topics[::-1]:
# 		if TopicWiseAnswerpaper.objects.filter(topic=topic,user=user,is_completed=1).exists():
# 			found_topic=topic
# 			break

# 	if found_topic is not None:
# 		all_ac=Activities.objects.filter(topic=found_topic)
# 		for ac in all_ac[::-1]:
# 			if TopicWiseAnswerpaper.objects.filter(topic=topic,user=user,activity=ac,is_completed=1).exists():
# 				found_activity=ac
# 				break

# 		open_next_activity(found_activity)
# 	else:
# 		return None
	# found_video=None
	# found_topic=None
	# found_last_video= None
	# found_activity = None
	# found_subtopic = None
	# all_topics=course.course_topic.all()

	# for topic in all_topics[::-1]:
	# 	if TopicWiseAnswerpaper.objects.filter(topic=topic,user=user,is_completed=1).exists():
	# 		found_topic=topic
	# 		break
	# 	elif TopicWiseAnswerpaper.objects.filter(topic=topic,user=user).exists():
	# 		found_topic=topic
	# 		break
	# 	else:
	# 		continue

	# if found_topic is not None:
	# 	#get topic video , activity ,subtopic
	# 	for v in found_topic.topic_content.all()[::-1]:
	# 		if TopicWiseAnswerpaper.objects.filter(content_video=v,user=user,
	# 			is_completed=1).exists():
	# 			found_video=v
	# 			break
	# 		elif TopicWiseAnswerpaper.objects.filter(content_video=v,user=user).exists():
	# 			found_video=v
	# 			break
	# 		else:continue

	# 	if found_video is None:
	# 		for subt in found_topic.get_all_subtopic()[::-1]:
	# 			if TopicWiseAnswerpaper.objects.filter(topic=subt,user=user).exists():
	# 				found_subtopic=subt
	# 				break
	# 			else:continue
	# 		if found_subtopic is not None:
	# 			found_video=None
	# 			for v in found_subtopic.topic_content.all()[::-1]:
	# 				if TopicWiseAnswerpaper.objects.filter(content_video=v,user=user,
	# 					is_completed=1).exists():
	# 					found_video=v
	# 					break
	# 				elif TopicWiseAnswerpaper.objects.filter(content_video=v,user=user).exists():
	# 					found_video=v
	# 					break
	# 				else:continue
	# 			if found_video is not None:
	# 				#go to this video 
	# 				pass
	# 			else:
	# 				pass
	# 	else:
	# 		pass
			#next_video(found_video)

	# for topic,inner_content in course_content.items():
	# 	if TopicWiseAnswerpaper.objects.filter(topic=topic,user=user).exists():
	# 		#logger.info(inner_content)
	# 		topics_video=inner_content.get('video',list())
	# 		topics_subtopic=inner_content.get('subtopic',{})



	# 		for v in topics_video:
	# 			if TopicWiseAnswerpaper.objects.filter(content_video=v,
	# 				user=request.user,is_completed=1).exists():
	# 				continue
	# 			elif TopicWiseAnswerpaper.objects.filter(content_video=v,
	# 				user=user).exists():
	# 				found_video=v
	# 			else:
	# 				found_video=None
			
	# 		for subtopic,subtopic_content in topics_subtopic.items():
	# 			if TopicWiseAnswerpaper.objects.filter(topic=subtopic,user=user).exists():

	# 			else:
	# 				found_subtopic=None

	# 	else:
	# 		break

			#TopicWiseAnswerpaper.objects.filter()


def course_dashboard(request,*args,**kwargs):
	if request.user.is_authenticated:
		courseid=kwargs.get('courseid',None)
		if courseid is not None:
			obj=CoursesEndUser.objects.get(id=courseid)
			is_org_course=False
			#uis=UserInformation.objects.filter(user=request.user)
			#print(uis)
			certificate=None
			first_name = None
			last_name = None

			#uis=UserInformation.objects.filter(user=request.user)
			#if len(uis) > 0:
				#first_name=uis[0].first_name
				#last_name = uis[0].last_name
			# if len(uis) > 0:
			# 	is_org_course=True
			# 	certificate=uis[0].organization.certificate
			all_org=Organization.objects.filter(is_active=1)
			for org in all_org:
				#print("Fffffffffffffffffffffffff",org,org.course.all())
				## this will not work for user who are signed up by himself/herself
				if obj in org.course.all():
					#print("dfjbdjbjbbbbbbbbbbbbbbbbbbbbbbbbbbbbbf")
					#if len(uis) > 0 and uis[0].organization==org:
						#is_org_course=True
						#certificate=org.certificate
						break


			# for co in CoursesEndUser.objects.prefetch_related('organization_set').all():
			# 	if co==obj:
			# 		is_org_course=True
			# 		Organization.objects.filter(id=course)		
			#print(is_org_course)
			discussions=Discussion.objects.filter(course=obj)
			#ui=UserInformation.objects.all()
			ce,created = CourseEnroll.objects.get_or_create(course_id=courseid,
				user=request.user,is_completed=0)
			rm,created1=Room.objects.get_or_create(room_id=str(obj.id)+str(obj.name).replace(" ",''),course=obj,status=True)
			#print(rm.room_id)
			# rmu=Room_User.objects.filter(room_id=rm.room_id,user_id=request.user.id)
			# if len(rmu) > 0:
			# 	rmu[0].status=True
			# 	rmu[0].save()
			# else:
			# 	Room_User.objects.create(room_id=rm.room_id,user_id=request.user.id,
			# 		course=obj,status=True)
			all_online_user=Room_User.objects.filter(room_id=rm.room_id,course=obj,status=True)
			#print(all_online_user)
			#if created == True:
			ce.create_topic_answerpaper(courseid,request.user.id)
			all_content=all_available_topic_and_subtopic(courseid=courseid,user=True)

			#get_last_opened_topic(obj,request.user,all_content)

			length,total_duration=obj.get_total_lession_and_duration()
			#print(total_duration)
			total_minute= int(total_duration // 60)
			total_second= int(total_duration % 60)

			all_cuser_categories=UserCategories.objects.all()
			if len(all_cuser_categories) > 10:
				all_cuser_categories = all_cuser_categories[0:10]


			#get_total_percentage
			per=course_overall_completion_percentage(obj,request.user)

			#TopicWiseAnswerpaper.objects.filter(course=obj)

			#TopicWiseAnswerpaper.objects.filter(topic=topic,is_completed=1).count()

	#if request.user.groups.filter(name=settings.END_USER_GROUP).exists():
			return render(request,'user_lms/course_dashboard.html',{'user':request.user,'all_content':all_content,
				'content_length':length,'total_minute':total_minute,
				'total_second':total_second,'media_url':settings.MEDIA_URL,
				'object':obj,'discussions':discussions,'room':rm, "cst": csrf.get_token(request),
				'all_online_user':all_online_user,'extra_url':settings.EXTRA_URL,
				'is_org_course':is_org_course,
				'certificate':certificate,'first_name':first_name,'last_name':last_name,
				'categories':all_cuser_categories,'trending':trending_course(),'percentage':per})
		else:
			return HttpResponse("not appreooved")
	else:
		return HttpResponseRedirect(reverse_lazy("accounts:login"))

def add_discussion(request):
	if request.method=="POST":
		#print(request.POST)
		try:
			discuss=request.POST.get('discuss',None)
			course=CoursesEndUser.objects.get(id=int(request.POST.get('course',None)))
			author=get_user_model().objects.get(id=int(request.POST.get('author',None)))
			Discussion.objects.create(discuss=discuss,course=course,author=author)
			return HttpResponse("query has been submitted")
		except Exception as e:
			print(e)
			return HttpResponse("error occured")


from customadmin.models import ContentVideo
def is_open(request):
	import json
	if request.method=="POST":
		topic=request.POST.get('topic',None)
		video=request.POST.get('video',None)
		if video is not None:
			#tw=TopicWiseAnswerpaper.objects.filter(topic_id=topic,
				#content_video_id=video,is_open=1,user=request.user)
			tw=TopicWiseAnswerpaper.objects.filter(topic_id=topic,
				activity_id=video,is_open=1,user=request.user)
			act=Activities.objects.filter(id=video)
			video_href=None
			if len(act) > 0:
				if act[0].activity_type == "video":
					cv=ContentVideo.objects.filter(id=act[0].content_id)
					#print(cv)
					if len(cv) > 0:
						video_href= cv[0].video.url

			#ContentVideo.objects.filter(id=video)
			if len(tw) > 0:
				res={'message':True,'video_href':video_href}
			else:
				res={'message':False}
			return HttpResponse(json.dumps(res))
	return HttpResponse("No")


# def get_next_topic_or_activity(course,topic,video=None,activity=None):
# 	if video is not None:
# 		if topic.topic_type=="subtopic":
# 			topic.topic_content.all()
# 			course.course_topic.filter(topic=topic).order_by('id')

import json
# def open_next(user,topic,video):
# 	if topic is not None:
# 		t=Topic.objects.get(id=topic)
# 		#print(t.name)
# 		if t.topic_type=="subtopic":
# 			tr=TopicRelation.objects.get(topic_id=t)
# 			course=tr.topic_father.course
# 		else:
# 			course=t.course
# 		next_video=t.next_video_of_topic(video)
# 		#print("next video",next_video)
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
# 			print(next_learning,'here till now next learning')
# 			if next_learning is not None:
# 				tw=TopicWiseAnswerpaper.objects.filter(topic=t,course=course,is_open=1,
# 					user=user,activity_id=next_learning.id)
# 				if len(tw) < 1:
# 					TopicWiseAnswerpaper.objects.create(topic=t,course=course,is_open=1,
# 						user=user,is_completed=0,activity_id=next_learning.id)
# 				return HttpResponse({"activity":next_learning.id})
# 			else:
# 				next_topic=t.get_next_topic(user.id)
# 				#print('next_topic is',next_topic)
# 				all_subtopic=[]
# 				if next_topic is not None:
# 					all_subt=next_topic.get_all_subtopic()
# 					print("all subtopic",all_subt)
# 					all_video=next_topic.topic_content.all()

# 					if all_video is not None and len(all_video) > 0:
# 						tws=TopicWiseAnswerpaper.objects.filter(user=user,topic=next_topic,
# 								course=next_topic.course,is_open=1,content_video=all_video[0])
# 						if len(tws) < 1:
# 							TopicWiseAnswerpaper.objects.create(user=user,topic=next_topic,
# 								course=next_topic.course,is_completed=0,is_open=1,content_video=all_video[0])
# 					#print(all_subtopic)
# 					elif all_subt is not None and len(all_subt) > 0:
# 						first_learning_unit=all_subt[0].remaining_learning_unit(user)
# 					# if TopicWiseAnswerpaper.objects.filter(user=user,topic=next_topic,
# 					# 		course=next_topic.course,is_open=1,is_completed=0).exists():
# 					# 	print("already open",next_topic.name)
# 					# else:
# 					# 	TopicWiseAnswerpaper.objects.update_or_create(user=user,topic=next_topic,
# 					# 		course=next_topic.course,is_open=1,is_completed=0)
# 						if not TopicWiseAnswerpaper.objects.filter(user=user,topic=all_subtopic[0],
# 								course=next_topic.course,is_open=1,is_completed=0).exists():
# 							TopicWiseAnswerpaper.objects.update_or_create(user=user,topic=all_subtopic[0],
# 								course=next_topic.course,is_open=1,is_completed=0)
# 							TopicWiseAnswerpaper.objects.update_or_create(user=user,topic=next_topic,
# 								course=next_topic.course,is_open=1,is_completed=0)
# 						else:
# 							print("already open",next_topic.name)
# 						if not TopicWiseAnswerpaper.objects.filter(user=user,topic=all_subtopic[0],
# 								course=next_topic.course,is_open=1,activity=first_learning_unit,is_completed=0).exists():
# 							TopicWiseAnswerpaper.objects.update_or_create(user=user,topic=all_subtopic[0],
# 								course=next_topic.course,is_open=1,activity=first_learning_unit,is_completed=0)
# 					else:
# 						if next_topic.topic_type=="subtopic":
# 							next_topic.open_first_activity_of_topic(user)
# 						print("topic is subtopic and now will open its activiti")
# 						#print(all_subtopic[0])
# 					#all_subtopic[0].open_first_activity_of_topic(user)
# 				else:
# 					print("nothing topic found .. opening another")
# 					open_next(user,next_topic,None)


def open_next(user,topic,activity,msg=None):
	''' only for topic (changed) '''
	import json
	if topic is not None:
		t=Topic.objects.get(id=topic)
		topic_type="topic"

		if t.topic_type=="subtopic":
			topic_type="subtopic"
			tr=TopicRelation.objects.get(topic_id=t)
			course=tr.topic_father.course
			topic_father = tr.topic_father
		else:
			course=t.course
			topic_father = t

		if activity is not None:
			''' will use if anything comes '''
			# TopicWiseAnswerpaper.objects.filter(topic=t,activity_id=activity,
			# 	user=user).update(is_completed=1)
			# next_learning = t.remaining_learning_unit(user,activityid=activity)

			# if next_learning is not None:
			# 	TopicWiseAnswerpaper.objects.get_or_create(topic=t,course=course,is_completed=0,is_open=1,user=user,
			# 		activity_id=next_learning.id)
			# 	return HttpResponse({"activity":next_learning.id})
			# else:
			# 	all_subtopic=t.get_all_subtopic()
			# 	if len(all_subtopic) > 0:
			# 		TopicWiseAnswerpaper.objects.get_or_create(topic=all_subtopic[0],course=course,is_completed=0,
			# 			is_open=1,user=user)
			# 		all_subtopic[0].open_first_activity_of_subtopic(user)
			# 	else:
			# 		next_topic = t.get_next_topic(user)
			# 		if next_topic is not None:
			# 			open_next(user,next_topic,None)
		else:
			if topic_type == "subtopic":
				TopicWiseAnswerpaper.objects.filter(topic=t,course=course,is_open=1,user=user).update(is_completed=1)
				tr=TopicRelation.objects.get(topic_id=t)
				next_subtopic=tr.topic_father.get_next_subtopic(subtopicid=t)
				if next_subtopic is not None:
					trs=TopicRelation.objects.filter(topic_id=next_subtopic)
					ts=TopicWiseAnswerpaper.objects.filter(topic=next_subtopic,
						user=user,course=trs[0].topic_father.course,is_open=1,
						activity=None)
					if len(ts)> 0:
						pass
					else:
						TopicWiseAnswerpaper.objects.create(topic=next_subtopic,
						user=user,course=trs[0].topic_father.course,is_open=1,activity=None)

					open_activity=next_subtopic.open_first_activity_of_subtopic(user)
					if open_activity is not None:
						return json.dumps({"message":"Done",'activity':open_activity.id})
					else:return json.dumps({"message":"Done","activity":None})						
				else:
					TopicWiseAnswerpaper.objects.filter(Q(topic=tr.topic_father),Q(user=user),
						Q(course=course),Q(activity=None)).update(is_completed=1)
					next_topic = tr.topic_father.get_next_topic(user)
					#print("next_topic",next_topic)
					if next_topic is not None:
						return open_next(user,next_topic.id,None)
						#return json.dumps({"message":"Done"})
					else:
						TopicWiseAnswerpaper.objects.filter(Q(topic=t),Q(user=user),
							Q(activity=None),Q(course=course)).update(is_completed=1)
						TopicWiseAnswerpaper.objects.filter(Q(topic=topic_father),Q(user=user),
							Q(activity=None),Q(course=course)).update(is_completed=1)
						return json.dumps({"message":"Done",'activity':None})
			else:
				# if there is no next learnig unit of topic then check for its subtopic
				#all_ac=Activities.objects.filter(topic=t)
				next_learning=t.remaining_learning_unit(user,activityid=None)
				#print('tttttttttttttt',t)
				#print('next_learning issssssss',next_learning)
				#if len(all_ac) > 0:
				if next_learning is not None and not TopicWiseAnswerpaper.objects.filter(topic=t,course=course,user=user,
						activity=next_learning).exists():
					#print(next_learning.id)
					ac=t.open_first_activity_of_topic(user)
					#print('sssssssssssssss',ac)
					if ac is not None:
						return json.dumps({"message":"Done","activity":ac.id})
					else:return json.dumps({"message":"Done","activity":None})

				# elif next_learning is not None:
				# 	ac=t.open_first_activity_of_topic(user)
				# 	if ac is not None:
				# 		return json.dumps({"message":"Done","activity":ac.id})
				# 	else:return json.dumps({"message":"Done","activity":None})
				else:
					all_subtopic=t.get_all_subtopic()
					if len(all_subtopic) > 0:
						#print("herererererrre")
						TopicWiseAnswerpaper.objects.get_or_create(topic=all_subtopic[0],course=course,
							is_completed=0,is_open=1,user=user,activity=None)
						open_activity=all_subtopic[0].open_first_activity_of_subtopic(user)
						if open_activity is not None:
							return json.dumps({"message":"Done",'activity':open_activity.id})
						else: return json.dumps({"message":"Done","activity":None})
				# else:
				# 	next_topic=t.get_next_topic(request.user)
				# 	if next_topic is not None:
				# 		open_next(user,next_topic.id,None)
				# 		#return json.dumps({"message":"Done"})
				# 	else:
				# 		TopicWiseAnswerpaper.objects.filter(Q(topic=t),Q(user=request.user),
				# 			Q(activity=None),Q(course=course)).update(is_completed=1)
				# 		return json.dumps({"message":"completed"})

		#return json.dumps({"message":"Nothing Found"})
			# all_ac=Activities.objects.filter(topic=t)
			# if len(all_ac) > 0:
			# 	t.open_first_activity_of_topic(user)
			# else:
			# 	all_subtopic=t.get_all_subtopic()
			# 	if len(all_subtopic) > 0:
			# 		TopicWiseAnswerpaper.objects.get_or_create(topic=all_subtopic[0],course=course,is_completed=0,
			# 			is_open=1,user=user)
			# 		all_subtopic[0].open_first_activity_of_subtopic(user)






def open_next_topic(request):
	import json
	if request.method=="POST":
		topic = request.POST.get('topic',None)
		activity = request.POST.get('activity',None)

		if activity is not None and topic is not None:
			topic_type=None
			t=Topic.objects.get(id=topic)
			topic_father=t
			if t.topic_type=="subtopic":
				tr=TopicRelation.objects.get(topic_id=t)
				topic_father=tr.topic_father
				course=tr.topic_father.course
				topic_type = 'subtopic'
			else:
				course=t.course
				topic_type = 'topic'
			#print("here , vjnvvnjfnj")
			# TopicWiseAnswerpaper.objects.filter(topic=t,activity_id=activity,
			# 	user=request.user,course=course,is_open=1).update(is_completed=1)
			ts=TopicWiseAnswerpaper.objects.filter(topic=t,activity_id=activity,
				user=request.user,course=course,is_open=1)
			#print("djcnnjdcnjdcnjdc----------",ts)
			if len(ts) > 0:
				ts[0].is_completed=1
				ts[0].save()

			next_learning = t.remaining_learning_unit(request.user,activityid=activity)
			if next_learning is not None:
				tw=TopicWiseAnswerpaper.objects.update_or_create(topic=t,course=course,is_open=1,user=request.user,activity_id=next_learning.id)
				return HttpResponse(json.dumps({"message":"Done","activity":next_learning.id}),content_type='application/json')

			else:
				response = open_next(request.user,t.id,None)
				print('response is',response)
				if response is not None:
					#res=json.loads(response)
					#print(res)
					#msg=res.get('message',False)
					#if msg:
					return HttpResponse(response,content_type="application/json")
							# TopicWiseAnswerpaper.objects.filter(Q(topic=topic_father),Q(user=request.user),
							# 	Q(activity=None),Q(course=course)).update(is_completed=1)

		return HttpResponse("error")


# def open_next_topic(request):
# 	if request.method=="POST":
# 		topic=request.POST.get('topic',None)
# 		video=request.POST.get('video',None)
# 		if video is not None and topic is not None:
# 			t=Topic.objects.get(id=topic)
# 			if t.topic_type=="subtopic":
# 				tr=TopicRelation.objects.get(topic_id=t)
# 				course=tr.topic_father.course
# 			else:
# 				course=t.course
# 			print('sent video',video)
# 			#mark as complete for perticuler user
# 			TopicWiseAnswerpaper.objects.filter(topic=t,content_video_id=video,
# 				user=request.user).update(is_completed=1)
# 			next_video=t.next_video_of_topic(video)
# 			print('next video',next_video)
# 			if next_video is not None:
# 				TopicWiseAnswerpaper.objects.update_or_create(topic=t,course=course,is_completed=0,is_open=1,user=request.user,content_video_id=next_video.id)
# 			#get_next_topic_or_activity(course,t,video)
# 				js={'video':next_video}
# 				return HttpResponse(js)
# 			else:
# 				tw=TopicWiseAnswerpaper.objects.filter(Q(topic=t) & Q(is_completed=1)& Q(user=request.user) & ~Q(activity_id=None)).order_by('-id')
# 				print(tw)
# 				if len(tw) > 0:
# 					activity_id=tw[0].activity_id
# 					next_learning=t.remaining_learning_unit(request.user,activityid=activity_id)
# 				else:
# 					next_learning=t.remaining_learning_unit(request.user)
# 				print('next_learning',next_learning)
# 				if next_learning is not None:
# 					#TopicWiseAnswerpaper.objects.get()
# 					tw=TopicWiseAnswerpaper.objects.update_or_create(topic=t,course=course,is_completed=0,is_open=1,user=request.user,activity_id=next_learning.id)
# 					#response_data={}
# 					#response_data['activity']=next_learning.id
# 					return HttpResponse({"activity":next_learning.id})
# 				else:
# 					all_subtopic=[]
# 					if t.topic_type=="topic":
# 						next_subtopic = t.get_next_subtopic()
# 						#print("next subtopic is ",next_subtopic)
# 						if next_subtopic is not None:
# 							tws=TopicWiseAnswerpaper.objects.filter(user=request.user,topic=next_subtopic,
# 								course=t.course,is_open=1)
# 							if len(tws) > 0:	
# 								pass
# 							else:
# 								TopicWiseAnswerpaper.objects.create(user=request.user,
# 									topic=next_subtopic,
# 									course=t.course,is_open=1,is_completed=0)
# 							next_subtopic.open_first_activity_of_topic(request.user)
# 							return HttpResponse("Done")
# 						else:
# 							next_topic=t.get_next_topic(request.user.id)
# 							if next_topic is not None and next_topic.topic_type == "topic": 
# 								all_subtopic=next_topic.get_all_subtopic()

							
# 					else:
# 						print("going forward")
# 						next_topic=t.get_next_topic(request.user.id)
# 						print("after forward met with next_topic",next_topic)
# 						if next_topic is not None:
# 							if next_topic.topic_type =='subtopic':
# 								trs=TopicRelation.objects.filter(topic_id=next_topic)
# 								if len(trs) > 0:
# 									course=trs[0].topic_father.course
# 								print("got here .........")
# 								all_v=next_topic.topic_content.all()
# 								all_ac = next_topic.activity_topic.all()
# 								if len(all_v) > 0:
# 									print("found video of next subtopic")
# 									TopicWiseAnswerpaper.objects.get_or_create(user=request.user,topic=next_topic,
# 										course=course,is_open=1,is_completed=0)
# 									tws=TopicWiseAnswerpaper.objects.filter(user=request.user,topic=next_topic,
# 										course=course,content_video=all_v[0],is_open=1)
# 									if len(tws) < 1:
# 										TopicWiseAnswerpaper.objects.create(user=request.user,topic=next_topic,
# 										course=course,is_open=1,content_video=all_v[0],is_completed=0)
# 									return HttpResponse("Done")
# 								elif len(all_ac) > 0:
# 									print("found activity")
# 									TopicWiseAnswerpaper.objects.get_or_create(user=request.user,topic=next_topic,
# 										course=course,is_open=1,is_completed=0)
# 									tws=TopicWiseAnswerpaper.objects.filter(user=request.user,topic=next_topic,
# 										course=course,activity=all_ac[0],is_open=1)
# 									if len(tws) < 1:
# 										TopicWiseAnswerpaper.objects.create(user=request.user,topic=next_topic,
# 										course=course,is_open=1,activity=all_ac[0],is_completed=0)
# 									return HttpResponse("Done")
					
# 					#print(next_topic)
# 							else:
# 								print("found topic here ")
# 								all_subtopic=next_topic.get_all_subtopic()
# 								#print(all_subtopic)
# 								if len(all_subtopic) > 0:
# 									all_v=all_subtopic[0].topic_content.all()
# 								#print("allalallaaaa",all_v)
# 									if all_v is not None and len(all_v) > 0:
# 										print("found video of next subtopic")
# 										TopicWiseAnswerpaper.objects.get_or_create(user=request.user,topic=all_subtopic[0],
# 												course=next_topic.course,is_open=1,is_completed=0)
# 										tws=TopicWiseAnswerpaper.objects.filter(user=request.user,topic=all_subtopic[0],
# 												course=next_topic.course,content_video=all_v[0],is_open=1)
# 										if len(tws) < 1:
# 											TopicWiseAnswerpaper.objects.create(user=request.user,topic=all_subtopic[0],
# 												course=next_topic.course,is_open=1,content_video=all_v[0],is_completed=0)
# 										return HttpResponse("Done")

										
# 					# elif all_subtopic is not None and len(all_subtopic) > 0:
# 					# 	TopicWiseAnswerpaper.objects.get_or_create(user=request.user,topic=next_topic,
# 					# 			course=next_topic.course,is_open=1,is_completed=0)
# 					# 	TopicWiseAnswerpaper.objects.get_or_create(user=request.user,topic=all_subtopic[0],
# 					# 			course=next_topic.course,is_open=1,is_completed=0)
# 					# 	all_subtopic[0].open_first_activity_of_topic(request.user)
# 					# 	return HttpResponse("Done")
					
# 						else:
# 						#print("how to do ")
# 						#check direct video
# 							return HttpResponse("nothing in next topic and this topic")
# 	return HttpResponse("error")

def course_details(request):
	try:
		return render(request,'user_lms/course_detail.html',{'user':request.user})
	except:
		return HttpResponse("")

def view_spin_activity(request):
	spin_activity_id=request.GET.get('spinactivity',None)
	if spin_activity_id is None:
		return Http404("You can't access this page")
	return HttpResponse("test")


def activity_completed(request):
	if request.method=="POST":
		activityid=request.POST.get('activityid',None)
		userid=request.POST.get('userid',None)
		activity_type=request.POST.get('type',None)
		# if userid!=request.user.id:
		# 	return HttpResponse("New kind of issue")
		if activity_type=="spin_activity":
			answers=SpinActivityAnswer.objects.filter(spinactivity_id=activityid)
			total_right=0
			total_answers=len(answers)

			for ans in answers:
				if ans.question.answer_option==ans.answer_option:
					total_right+=1

			percentage = (total_right/total_answers)*100

			if percentage > 20:
				act=Activities.objects.get(content_id=activityid,activity_type='spin_activity')
				TopicWiseAnswerpaper.objects.filter(activity=act,user=request.user).update(is_completed=1)
				next_learning=act.topic.remaining_learning_unit(request.user,activityid=act.id)
				topic_type="topic"
				topic_father = act.topic
				topic = act.topic
				if topic.topic_type == "topic":
					course = topic.course
				else:
					trf=TopicRelation.objects.get(topic_id=topic)
					topic_father = trf.topic_father
					course= trf.topic_father.course
					topic_type = "subtopic"
				#print("after activity completed")
				#print("next learning is ",next_learning,next_learning.activity_type)
				json_data={'message':f"your percentage is {percentage}, new activity will be unlocked"}
				if next_learning is None:
					ac=open_next(request.user,topic.id,None)
					print('ac is',ac,type(ac))
					if ac is not None:
						json_data['activity']=json.loads(ac).get('activity',None)
					else: json_data['activity']=None

					''' just commented '''
					# tws=TopicWiseAnswerpaper.objects.filter(Q(topic=act.topic),Q(user=request.user),
					# 	Q(is_open=1),Q(activity=None))
					# if len(tws) > 0:
					# 	tws[0].is_completed=1
					# 	tws[0].save()

					# if topic_type=="topic":
					# 	next_topic=act.topic.get_next_topic(request.user)
					# 	#print("hererer",next_topic)
					# else:
					# 	tr=TopicRelation.objects.get(topic_id=act.topic)
					# 	next_topic=tr.topic_father.get_next_subtopic(act.topic)
					# 	if next_topic is None:
					# 		next_topic = tr.topic_father.get_next_topic(request.user)


					# if next_topic is not None and next_topic.topic_type=="topic":
					# 	TopicWiseAnswerpaper.objects.create(topic_id=next_topic.id,
					# 		is_completed=0,course_id=next_topic.course.id,is_open=1,user_id=request.user.id)
					# 	#topic_videos=next_topic.topic_content.all()
					# 	open_next(request.user,next_topic.id,None)
					# elif next_topic is not None and next_topic.topic_type=="subtopic":
					# 	tr=TopicRelation.objects.filter(topic_id=next_topic)
					# 	if len(tr) > 0:
					# 		TopicWiseAnswerpaper.objects.create(topic_id=next_topic.id,
					# 			is_completed=0,is_open=1,course_id=tr[0].topic_father.course.id,user_id=request.user.id)
					# 		next_topic.open_first_activity_of_subtopic(request.user)

					# else:
					# 	pass
					''' just commened ended '''

						# topic_activity = next_topic.activity_topic.all()
						# if len(topic_activity) > 0:
						# 	tws=TopicWiseAnswerpaper.objects.filter(topic_id=next_topic.id,activity=topic_activity[0],course_id=next_topic.course.id,
						# 		is_open=1,user_id=request.user.id)
						# 	if len(tws) < 1:
						# 		TopicWiseAnswerpaper.objects.create(topic_id=next_topic.id,content_video=topic_activity[0],course_id=next_topic.course.id,
						# 		is_open=1,is_completed=0,user_id=request.user.id)
						#if len(topic_videos) > 0:
							#tws=TopicWiseAnswerpaper.objects.filter(topic_id=next_topic.id,content_video=topic_videos[0],course_id=next_topic.course.id,
								#is_open=1,user_id=request.user.id)
							#if len(tws) < 1:
								#TopicWiseAnswerpaper.objects.create(topic_id=next_topic.id,content_video=topic_videos[0],course_id=next_topic.course.id,
								#is_open=1,is_completed=0,user_id=request.user.id)

						#elif len(topic_activity) > 0:
							#print("direct activity in topic in activity completed method")
						# else:
						# 	trs=TopicRelation.objects.filter(topic_father=next_topic)
						# 	#for tr in trs:
						# 	if len(trs) > 0:
						# 		print("new all active topic ",trs)
						# 		TopicWiseAnswerpaper.objects.create(topic=trs[0].topic_id,
						# 		is_completed=0,course_id=next_topic.course.id,is_open=1,user_id=request.user.id)
						# 		next_st=trs[0].topic_id
						# 		#all_v=next_st.topic_content.all()
						# 		#all_ac = next_st.activity_topic.all()
						# 		#all_sub= next_st.get_all_subtopic()
						# 		if all_v is not None and len(all_v) > 0:
						# 			tws=TopicWiseAnswerpaper.objects.filter(topic_id=next_st.id,content_video=all_v[0],course_id=next_topic.course.id,
						# 			is_open=1,user_id=request.user.id)
						# 			if len(tws) < 1:
						# 				TopicWiseAnswerpaper.objects.create(topic_id=next_st.id,content_video=all_v[0],course_id=next_topic.course.id,
						# 				is_open=1,is_completed=0,user_id=request.user.id)
						# 		if all_ac is not None and len(all_ac) > 0:
						# 			tws=TopicWiseAnswerpaper.objects.filter(topic_id=next_st.id,activity=all_ac[0],course_id=next_topic.course.id,
						# 			is_open=1,user_id=request.user.id)
						# 			if len(tws) < 1:
						# 				TopicWiseAnswerpaper.objects.create(topic_id=next_st.id,activity=all_ac[0],course_id=next_topic.course.id,
						# 				is_open=1,is_completed=0,user_id=request.user.id)

						# 		elif all_sub is not None and len(all_sub) > 0:
						# 			all_sub[0].open_first_activity_of_topic(request.user)
						# 		else:
						# 			print("somthing new occured")

									
					# else:
					# 	#print("here jcdjcnjdnc  dcjdcdcndcnnjdcnj ")
					# 	tr=TopicRelation.objects.filter(topic_id=next_topic)
					# 	if len(tr) > 0:
					# 		TopicWiseAnswerpaper.objects.create(topic_id=next_topic.id,
					# 			is_completed=0,is_open=1,course_id=tr[0].topic_father.course.id,user_id=request.user.id)
					# 		next_topic.open_first_activity_of_topic(request.user)
				else:
					TopicWiseAnswerpaper.objects.get_or_create(topic=act.topic,
						user=request.user,activity=next_learning,is_completed=0,is_open=1,course=course)
					json_data['activity']=next_learning.id
					# if act.topic.topic_type=="subtopic":
					# 	# get next_subtopic of topic
					# 	topic.get_next_topic(request.user)
					# else:
					# 	# get next topic of course 
				#print(t.remaining_learning_unit)
				return HttpResponse(json.dumps(json_data),content_type='application/json')
			return HttpResponse(json.dumps({"message":"you need to play this activity again","activity":None}),content_type='application/json')


