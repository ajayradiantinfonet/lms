# from channels import Group
# def ws_connect(message):
#     Group('users').add(message.reply_channel)


# def ws_disconnect(message):
#     Group('users').discard(message.reply_channel)   

# chat/consumers.py

import json
from asgiref.sync import async_to_sync
from channels.generic.websocket import WebsocketConsumer
from .models import Layer,Room_User,Room,Chatmessage
from organization.models import UserInformation
from customadmin.models import CoursesEndUser
from channels.layers import get_channel_layer
from django.contrib.auth import get_user_model
#from django.contrib.auth.models import User
channel_layer = get_channel_layer()
total_user=[]



class ChatConsumer(WebsocketConsumer):
	def connect(self):
		self.room_name = self.scope['url_route']['kwargs']['room_name']
		self.user_name = self.scope['url_route']['kwargs']['user_name']
		self.room_group_name = 'chat_%s' % self.room_name
		print('in room ',self.room_name)
		print('in user name ',self.user_name)
		try:
			#print("here",self.room_name)
			rm=Room.objects.get(room_id=self.room_name)
			#print(rm)
			Layer.objects.filter(user_name=self.user_name,course=rm.course)
			if Layer.objects.filter(user_name=self.user_name,course=rm.course).exists():
				print("same user with same course already existed ")
				layer=Layer.objects.get(user_name=self.user_name,course=rm.course)
				layer.layer_name=self.channel_name
				layer.save()

				room,created=Room_User.objects.get_or_create(room_id=self.room_name,
					course=rm.course,user_id=self.user_name)
				room.channel_name=self.channel_name
				room.status=True
				room.save()
			else:
				print("first time connect user")
				Layer.objects.create(layer_name=self.channel_name,user_name=self.user_name,course=rm.course)
				Room_User.objects.create(room_id=self.room_name,channel_name=self.channel_name,
						user_id=self.user_name,course=rm.course,status=True)
		except:
			pass
		finally:
			total_user=[]
			query=Room_User.objects.filter(room_id=self.room_name,status=True)
			for obj in query:
				temp={}
				u=get_user_model().objects.filter(id=obj.user_id)
				
				
				if len(u) > 0:
					ui=UserInformation.objects.filter(user=u[0])
					if len(ui) > 0:
						temp['first_name'] = ui[0].first_name
						temp['last_name'] = ui[0].last_name
						temp['email'] = ui[0].email
					temp['username'] = u[0].username
					temp['user_id'] = u[0].id
					total_user.append(temp)
			#print(total_user)
			async_to_sync(self.channel_layer.group_add)(
					self.room_group_name,
					self.channel_name
			)
			self.accept()

			import json
			async_to_sync(self.channel_layer.group_send)(
				self.room_group_name,
				{
					'type': 'chat_userlist',
					'message': total_user
				}
			)

	def disconnect(self, close_code):
		# Leave room group
		#self.user_name
		#print("disconnect")
		async_to_sync(self.channel_layer.group_discard)(
			self.room_group_name,
			self.channel_name
		)
		try:
			room=Room_User.objects.filter(channel_name=self.channel_name)
			print("disconnect",room)
			if len(room) > 0:
				print("disconnect",room)
				room[0].status=False
				room[0].save()
				course=room[0].course
		#room.delete()
		# #room.channel_name=self.channel_name
		# room.delete()
				total_user=[]
				query=Room_User.objects.filter(room_id=self.room_name,status=True,course=course)
			#print(query)
				for obj in query:
					total_user.append(obj.user_id)
				async_to_sync(self.channel_layer.group_send)(
						self.room_group_name,
						{
							'type': 'chat_userlist',
							'message': total_user
						}
				)
		except :
			print("error")


	# Receive message from WebSocket
	def receive(self, text_data):
		text_data_json = json.loads(text_data)
		message = text_data_json['message']
		user=text_data_json['to_send']
		from_user=text_data_json['from']
		course = text_data_json['course']
		typeoftext=text_data_json['type']
		#print(text_data_json['ArrayBuffer'])
		print(str(from_user),"sent",message,"to",str(user))
		#print("chat",user)
		if user is not None:
			#print(user)
			#uid=User.objects.get(username=user).id
			#lay=Layer.objects.get(user_name=uid)
			lay=Layer.objects.get(user_name=user,course_id=course)
			print(lay)

			#print(uid)
			# if typeoftext is not None and typeoftext=='file':
			#     name=text_data_json['name']
				
			#     async_to_sync(self.channel_layer.send)(lay.layer_name, {
			#         "type": "chat.file",
			#         "message": uid+': '+name,
					
			#     });
				

			# else:
			Chatmessage.objects.create(userfrom=User.objects.get(id=from_user),
				userto=get_user_model().objects.get(id=user),chatmessage=message,
				course=CoursesEndUser.objects.get(id=course))
			async_to_sync(self.channel_layer.send)(lay.layer_name, {
					"type": "chat.message",
					"message": str(from_user)+': '+message,
			});
		else:
			async_to_sync(self.channel_layer.group_send)(
			   self.room_group_name,
			   {
				   'type': 'chat_message',
				   'message': message
			   }
			)



	# Receive message from room group
	def chat_message(self, event):
		message = event['message']
		# Send message to WebSocket
		self.send(text_data=json.dumps({
			'message': message
	}))

	def chat_file(self, event):
		message = event['message']
		#file=event['file']
		# Send message to WebSocket
		self.send(text_data=json.dumps({
			'message': message,
			'file':True
	}))

	def chat_userlist(self, event):
		message = event['message']
		self.send(text_data=json.dumps({
			'userlist': message
	}))