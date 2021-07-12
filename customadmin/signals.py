#from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Topic,TopicRelation,ContentVideo
from django.conf import settings
import os 

@receiver(post_save, sender=Topic)
def save_topic_relation(sender, instance, **kwargs):
	if instance is not None:
		#print(instance._topicid)
		if instance.topic_type==None:
			pass
		if instance.topic_type=="subtopic":
			try:
				topicid=instance._topicid
				if TopicRelation.objects.filter(topic_id_id=instance.id,topic_father_id=topicid).exists():
					pass
				else:
					TopicRelation.objects.create(topic_id_id=instance.id,topic_father_id=topicid)
			except:
				print("probably editing topic")
				#if TopicRelation.objects.filter(topic_id_id=instance.id)

		else:
			trs=TopicRelation.objects.filter(topic_id_id=instance.id,topic_father_id=None)
			if len(trs) > 0:
				for tr in trs:
					tr.delete()

			if TopicRelation.objects.filter(topic_id_id=instance.id,topic_father_id=None).exists():
				pass
			else:
				TopicRelation.objects.create(topic_id_id=instance.id,topic_father_id=None)
		

			#TopicRelation.objects.create(topic_id_id=instance.id,topic_father_id=None)




def convert_into_minute_second(seconds):
	minute = seconds//60
	second = seconds%60
	return minute,second

@receiver(post_save, sender=ContentVideo)
def save_video_thumbnail(sender, instance, **kwargs):
	if instance is not None:
		#print(instance.thumbnail)
		if not instance.thumbnail:
			from moviepy.editor import VideoFileClip
			from PIL import Image
			from functools import reduce
			from pathlib import Path
			#print(settings.BASE_DIR)
			try:
				video_i=os.path.join(settings.BASE_DIR,"uploads/")
				# print(video_i)
				# print(os.path.join(Path(os.getcwd()).resolve().parent,'uploads',instance.video.url.replace("/media",'')))
				video_input_path = os.path.join(video_i,instance.video.name)
				clip = VideoFileClip(video_input_path)
				video_duration = int(clip.duration)
				fps = clip.reader.fps
				nframes = clip.reader.nframes
				duration = clip.duration
				max_duration = int(duration)+1
				from random import randint
				frame_at_second = 28
				frame=clip.get_frame(frame_at_second)
				# print(video_input_path)
				img_output_path = os.path.join(video_i,Path('course_video_thumbnail/'))

				new_image = Image.fromarray(frame)
				image_name = f'{randint(1,10000)}.jpg'
				new_image.save(os.path.join(img_output_path,image_name))
				instance.thumbnail = 'course_video_thumbnail/'+image_name
				#minu,second=convert_into_minute_second(duration)
				instance.duration = video_duration
				instance.save()
			except:
				pass
			# print(img_output_path)
			#import subprocess
			#from ffvideo import VideoStream
			#pil_image = VideoStream('0.flv').get_frame_at_sec(5).image()
			#pil_image.save('frame5sec.jpeg')
			#subprocess.call(['ffmpeg', '-i', video_input_path, '-ss', '00:00:00.000', '-vframes', '1',
			# img_output_path])
		else:
			pass
			# print("inside yes")
			# from functools import reduce
			# from pathlib import Path
			# video_i=os.path.join(settings.BASE_DIR,"uploads/")
			# video_input_path = os.path.join(video_i,instance.video.name)
			# img_output_path = os.path.join(video_i,'/course_video_thumbnail/image.jpg')
			# # print(img_output_path)
			# import subprocess
			# subprocess.call(['ffmpeg', '-i', video_input_path, '-ss', '00:00:00.000', '-vframes', '1',
			#  img_output_path])


#instance.profile.save
#print("topic created")


