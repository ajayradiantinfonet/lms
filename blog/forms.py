from django import forms

from .models import Post


class PostForm(forms.ModelForm):
    # title = forms.CharField(max_length=100,required=False)
    # content = forms.CharField(max_length=1000,required=False)
    blog_img = forms.ImageField(required=False)

    class Meta:
        model = Post

        fields = ['title', 'content','blog_img']

        widgets = {
            'content': forms.Textarea(attrs={'class': 'editable medium-editor-textarea'})
        }
