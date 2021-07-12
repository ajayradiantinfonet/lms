from django.db.models.signals import post_save
from django.conf import settings
from django.dispatch import receiver
from django.utils.crypto import get_random_string
from .models import AccountVerify

@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def send_email(sender,instance,**kwargs):
	import base64
	if instance is not None:
		#message=instance.email+str(instance.date_joined.timestamp())+instance.first_name+instance.phone
		#link = base64.b64encode(message.encode('ascii'))
		#link = instance.email+
		link = get_random_string(20)
		acs=AccountVerify.objects.filter(user=instance)
		if len(acs) < 1:
		#if not created:
			AccountVerify.objects.create(user=instance,token=link)
		#instance.token = link
		#instance.save()
		#print("sending email to user .... ")
		