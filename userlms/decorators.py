

from django.urls import reverse_lazy
from django.shortcuts import HttpResponseRedirect,render
from django.conf import settings


def is_profile_complete(next=None):
	def decorator(view_func):
		def wrapper_function(request,*args,**kwargs):
			if request.user.is_authenticated:
				if not request.user.profile_complete:
					#if next is not None:
					#print(next)
					url = reverse_lazy('userlms:user_profile')+'?next='+settings.EXTRA_URL
					return HttpResponseRedirect(url)
				else:
					return view_func(request,*args,**kwargs)
			return render(request,'user_lms/first.html')
		return wrapper_function
	return decorator