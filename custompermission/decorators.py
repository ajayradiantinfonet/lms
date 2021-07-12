from django.http import HttpResponse
from django.shortcuts import redirect

from .models import Perm
from django.contrib import messages
from django.shortcuts import HttpResponseRedirect
from django.urls import reverse_lazy



def has_generic_permission(perms,redirect=None):
	def decorator(view_func):
		def wrapper_function(request,*args,**kwargs):
			if request.user.is_superuser:
				return view_func(request,*args,**kwargs)
			if isinstance(perms, list):
				for perm in perms:
					if not request.user.perms.has_perm(perm):
						if redirect is not None:
							return HttpResponseRedirect(reverse_lazy(redirect))
						else:
							return redirect('accounts:login')
				return view_func(request,*args,**kwargs)
			else:
				if request.user.perms.has_perm(perms):
					return view_func(request,*args,**kwargs)
				else:
					if redirect is not None:
						return HttpResponse(redirect)
					else:
						return HttpResponseRedirect(reverse_lazy('accounts:login'))
		return wrapper_function
	return decorator



'''def unauthenticated_user(view_func):
	def wrapper_func(request, *args, **kwargs):
		if request.user.is_authenticated:
			return redirect('home')
		else:
			return view_func(request, *args, **kwargs)

	return wrapper_func

def allowed_users(allowed_roles=[]):
	def decorator(view_func):
		def wrapper_func(request, *args, **kwargs):

			group = None
			if request.user.groups.exists():
				group = request.user.groups.all()[0].name

			if group in allowed_roles:
				return view_func(request, *args, **kwargs)
			else:
				return HttpResponse('You are not authorized to view this page')
		return wrapper_func
	return decorator

def admin_only(view_func):
	def wrapper_function(request, *args, **kwargs):
		group = None
		if request.user.groups.exists():
			group = request.user.groups.all()[0].name

		if group == 'customer':
			return redirect('user-page')

		if group == 'admin':
			return view_func(request, *args, **kwargs)

	return wrapper_function'''


