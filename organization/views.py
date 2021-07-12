from django.shortcuts import render
from django.shortcuts import render,redirect,reverse
from custompermission import enums
from custompermission.models import Perm
from django.contrib.auth.decorators import login_required
from custompermission.decorators import has_generic_permission
from django.http import HttpResponse
from django.views import View
from .forms import CreateOrganizationForm
from django.shortcuts import HttpResponseRedirect
from django.views.decorators.cache import cache_control
from django.views.decorators.csrf import csrf_exempt
from customadmin.models import Organization

from django.views.generic.edit import CreateView


from django.views import View
from django.urls import reverse_lazy



class CreateOrganization(CreateView):
	model = Organization
	template_name_suffix = '_create_form'
	fields = '__all__'
	#template_name = 'organization'
	form = CreateOrganizationForm
	success_url = 'http://google.com'

	def get_initial(self):
		initial_data = super(CreateOrganization, self).get_initial()
		#initial_data['first_name'] = 'from initial data'
		#initial_data['title']='Create Organization'
		return initial_data

	def get_context_data(self, **kwargs):
		ctx = super(CreateOrganization, self).get_context_data(**kwargs)
		ctx['desc'] = 'Create Organization'
		#print(ctx)
		return ctx

	def form_valid(self, form):
		model = form.save(commit=True)
		#print(type(model))
		return super(CreateOrganization, self).form_valid(form)
