from django.core.validators import MinLengthValidator
from django import forms
from customadmin.models import Organization

position_choices=(('student','student'),('teacher','teacher'))

class CreateOrganizationForm(forms.ModelForm):
	position = forms.ChoiceField(choices=position_choices)
	class Meta:
		model=Organization
		fields=('__all__')

	def __init__(self):
		super(CreateOrganizationForm,self).__init__()
		for field_name,fields in self.fields.items():
			fields.required=True

	def clean_website(self):
		return self.cleaned_data['website']