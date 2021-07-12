from django import forms
from .models import (
	Question,QuestionPaper,Quiz
)
from textwrap import dedent


form_input_class = "form-control"

from .models import question_types

class QuestionForm(forms.ModelForm):
	"""Creates a form to add or edit a Question.
	It has the related fields and functions required."""
	# description = forms.CharField(widget=forms.Textarea,required=False)
	
	solution = forms.CharField(widget=forms.Textarea,required=False)
	def __init__(self, *args, **kwargs):
		super(QuestionForm, self).__init__(*args, **kwargs)
		self.fields['question_name'].widget.attrs.update(
			{'class': form_input_class, 'placeholder': 'Question'}
		)
		# self.fields['language'].widget.attrs.update(
		# 	{'class': 'custom-select'}
		# )
		# self.fields['topic'].widget.attrs.update(
		# 	{'class': form_input_class, 'placeholder': 'Topic name'}
		# )
		self.fields['type'].widget.attrs.update(
			{'class': 'custom-select'}
		)
		# self.fields['description'].widget.attrs.update(
		# 	{'class': form_input_class, 'placeholder': 'Description'}
		# )
		# self.fields['tags'].widget.attrs.update(
		# 	{'class': form_input_class, 'placeholder': 'Tags'}
		# )
		self.fields['solution'].widget.attrs.update(
			{'class': form_input_class, 'placeholder': '''Right Option Value for Question'''}
		)
		# self.fields['snippet'].widget.attrs.update(
		# 	{'class': form_input_class, 'placeholder': 'Snippet'}
		# )
		self.fields['min_time'].widget.attrs.update(
			{'class': form_input_class}
		)

	class Meta:
		model = Question
		exclude = ['user', 'active', 'description','topic']


class FileForm(forms.Form):
	file_field = forms.FileField(widget=forms.ClearableFileInput(
								attrs={
									'multiple': True,
									'class': 'custom-file-input'
									}
								),
								required=False)


class UploadFileForm(forms.Form):
	file = forms.FileField(
		widget=forms.FileInput(attrs={'class': 'custom-file-input'})
	)


# class quesform(forms.Form):
# 	# file = forms.Button('submit', 'Save', css_class="btn btn-outline-success")


# 	#  FormActions(
#     #     Submit('submit', 'Save', css_class="btn btn-outline-success"),
#     # btn = forms.CharField()

# # 	FormActions(
# #     Submit('save', 'Save changes'),
# #     Button('cancel', 'Cancel')
# # )


class QuestionPaperForm(forms.ModelForm):
	class Meta:
		model = QuestionPaper
		#fields = ['shuffle_questions', 'shuffle_testcases']
		fields =('__all__')


class QuestionFilterForm(forms.Form):

	question_type = forms.ChoiceField(
		choices=question_types,
		widget=forms.Select(attrs={'class': 'custom-select'}),
		required=False
	)

	def __init__(self, *args, **kwargs):
		user = kwargs.pop("user")
		lang = kwargs.pop("language") if "language" in kwargs else None
		que_type = kwargs.pop("type") if "type" in kwargs else None
		marks = kwargs.pop("marks") if "marks" in kwargs else None
		super(QuestionFilterForm, self).__init__(*args, **kwargs)
		points = Question.objects.filter(
			user_id=user.id).values_list('points', flat=True).distinct()
		points_options = [('', 'Select Marks')]
		points_options.extend([(point, point) for point in points])
		self.fields['marks'] = forms.ChoiceField(
			choices=points_options,
			widget=forms.Select(attrs={'class': 'custom-select'}),
			required=False
		)
		self.fields['marks'].required = False
		#self.fields['language'].initial = lang
		self.fields['question_type'].initial = que_type
		self.fields['marks'].initial = marks



from customadmin.models import Topic,CoursesEndUser
from django.conf import settings
class QuizForm(forms.ModelForm):

	course = forms.ModelChoiceField(queryset=CoursesEndUser.objects.all(),required=False,widget=forms.HiddenInput())
	topic = forms.ModelChoiceField(queryset=Topic.objects.all(),required=False,widget=forms.HiddenInput())
	attempts_allowed = forms.ChoiceField(choices=settings.ATTEMPTS_CHOICES,required=True)
	def __init__(self, *args, **kwargs):
		super(QuizForm, self).__init__(*args, **kwargs)

		initial=kwargs.get('initial',None)
		if initial is not None:
			self.fields['topic'].initial  = initial.get('topicid',None)
			self.fields['course'].queryset = initial.get('courseid',None)

		# self.fields['start_date_time'].widget.attrs.update(
		# 	{'class': form_input_class}
		# )
		# self.fields['end_date_time'].widget.attrs.update(
		# 	{'class': form_input_class}
		# )

		# self.fields['description'].widget.attrs.update(
		# 	{'class': form_input_class }
		# )
		# self.fields['duration'].widget.attrs.update(
		# 	{'class': form_input_class }
		# )
		
		# self.fields['attempts_allowed'].widget.attrs.update(
		# 	{'class': form_input_class }
		# )
		# self.fields['time_between_attempts'].widget.attrs.update(
		# 	{'class': form_input_class }
		# )
		# self.fields['instructions'].widget.attrs.update(
		# 	{'class': form_input_class }
		# )
		# # self.fields['weightage'].widget.attrs.update(
		# #     {'class': form_input_class}
		# # )
		# self.fields['pass_criteria'].widget.attrs.update(
		# 	{'class': form_input_class }
		# )

		self.fields["instructions"].initial = dedent("""\
			
			</p><p>Please read instruction carefully</p>
			<ul>
			<li> <strong>You are not allowed to use any internet 
			i.e. no google etc.</strong>
			</li>
			<li> Do not copy </strong>.
			</li></ul>
			<p>We hope you enjoy taking this exam !!!</p>
		""")

	class Meta:
		model = Quiz
		exclude = ["creator", "is_exercise","active"]

from .models import QuestionOption
class QuestionOptionForm(forms.ModelForm):
	class Meta:
		model = QuestionOption
		exclude = ['question']
	def __init__(self, *args, **kwargs):
		super(QuestionOptionForm, self).__init__(*args, **kwargs)
		self.fields['option_e'].required=False
		self.fields['option_c'].required=False
		self.fields['option_d'].required=False



