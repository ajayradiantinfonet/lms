from django.shortcuts import render,redirect
# Create your views here.
from django.http import HttpResponse,Http404
from random import random
from django.shortcuts import render
from .models import Room,FileInformation
from django.views.decorators.csrf import csrf_exempt

# import websocket
from django.conf import settings
#ws = websocket.WebSocket()

def user_list(request):
    return render(request, 'index.html')

def index(request):
	if request.user.is_superuser:
		#if request.user is already in room he can't create a room
		
		return render(request,'create_room.html',{})
	return HttpResponse('please go to url like http://host/chat/room_name')


def room(request, room_name):
	#user_name=str(random.randInt(1,100))
	#print(user_name)
	# if request.user.is_superuser:
	# 	return redirect(request,'create_room.html',{})
	# else:
	try:
		rm=Room.objects.get(room_id=room_name)
		print(rm)
		#if not request.user.is_anonymous:
		di={'room_name': room_name,'user':request.user.username}
		if not request.user.is_anonymous:
			print(request.user.username)
			return render(request, 'room.html', di)
		return HttpResponse("you can't access this page")
	except:
		return HttpResponse("room does not exist")

import json

@csrf_exempt
def upload_file(request):
	if request.method == 'POST' and request.FILES['file']:
		myfile = request.FILES['file']
		size=request.POST['size']
		name=request.POST['name']
		froms=request.POST['from']
		to=request.POST['to']
		room_id=request.POST['room']

		newdoc = FileInformation(file = myfile,file_name=name,
			file_size=size,sent_from=froms,sent_to=to,room_id=room_id)
		newdoc.save()
		#ws.connect('ws://127.0.0.1:8000/ws/chat/'+room_id+'/'+froms+'/')
		#ws.send(json.dumps(
			#{'name':name,'from':froms,'to_send':to,'type':'file','message':'fsend'}))
		#fs = FileSystemStorage()
		#filename = fs.save(myfile.name, myfile)
		#uploaded_file_url = fs.url(filename)
		# return render(request, 'core/simple_upload.html', {
  #           'uploaded_file_url': uploaded_file_url
  #       })
		return HttpResponse("done")
	else:
		return HttpResponse("not accesible")
		#return render(request, 'core/simple_upload.html')


import os
import mimetypes
from os import listdir
from os.path import isfile, join


def get_file(request,file_name):
	# fl_path = os.path.join(settings.BASE_DIR,'uploads/')+file_name
	# fl = open(fl_path, 'r')
	# mime_type, _ = mimetypes.guess_type(fl_path)
	# response = HttpResponse(fl, content_type=mime_type)
	# response['Content-Disposition'] = "attachment; filename=%s" % file_name
	# return response
	file_path = os.path.join(settings.MEDIA_ROOT, 'uploads/')+file_name
	if os.path.exists(file_path):
		with open(file_path, 'rb') as fh:
			response = HttpResponse(fh.read(), content_type="application/vnd.ms-excel")
			response['Content-Disposition'] = 'inline; filename=' + os.path.basename(file_path)
			return response
	else:
		mypath=os.path.join(settings.MEDIA_ROOT, 'uploads/')
		onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
		html='<ul>'
		for item in onlyfiles:
			html+='<li><a href="/chat/get_file/'+item+'">'+item+'</li>'
		html+='</ul>'
		return HttpResponse(html)
	#raise Http404
	
	
