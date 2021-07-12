from django.forms import ModelForm
from django.contrib.auth.forms import UserCreationForm
#from django.contrib.auth.models import User
from django import forms
from django.contrib.auth import (
    authenticate, get_user_model, password_validation,
)
from django.utils.translation import gettext, gettext_lazy as _

#from .models import Order


# class OrderForm(ModelForm):
# 	class Meta:
# 		model = Order
# 		fields = '__all__'


fc = 'form-control'
class CreateUserForm(UserCreationForm):

	first_name = forms.CharField(
		label=("email"),
		widget=forms.TextInput(attrs={
			'id':'exampleInputAmount','class':fc}),
		strip=False,
		help_text=_("Enter the first name"),
	)

	last_name = forms.CharField(
		label=("email"),
		widget=forms.TextInput(attrs={
			'id':'exampleInputAmount','class':fc}),
		strip=False,
		help_text=_("Enter the last_name"),
	)

	phone = forms.CharField(
		label=("email"),
		max_length=10,
		widget=forms.TextInput(attrs={
			'id':'exampleInputAmount','class':fc}),
		strip=False,
		help_text=_("Enter the phone"),
	)

	password1 = forms.CharField(
		label=_("Password"),
		strip=False,
		widget=forms.PasswordInput(attrs={'autocomplete': 'new-password',
			'id':'exampleInputAmount','class':fc}),
		help_text=password_validation.password_validators_help_text_html(),
	)
	password2 = forms.CharField(
		label=("Password confirmation"),
		widget=forms.PasswordInput(attrs={'autocomplete': 'new-password',
			'id':'exampleInputAmount','class':fc}),
		strip=False,
		help_text=_("Enter the same password as before, for verification."),
	)

	email = forms.CharField(
		label=("email"),
		widget=forms.TextInput(attrs={
			'id':'exampleInputAmount','class':fc}),
		strip=False,
		help_text=_("Enter the email"),
	)

	

	# username = forms.CharField(
 #        label=("User name "),
 #        widget=forms.TextInput(attrs={'autocomplete': 'new-password',
 #        	'id':'exampleInputAmount','class':fc}),
 #        strip=False,
 #        help_text=_("username should be unique"),
 #    )



	class Meta:
		model = get_user_model()
		fields = [ 'email', 'password1', 'password2','phone','first_name','last_name']

		

