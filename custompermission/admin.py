from django.contrib import admin
from django.contrib.admin import ModelAdmin
from django.contrib.admin.views.main import ChangeList

from django.utils.functional import cached_property

from custompermission import get_perm_model, enums
from .utils import get_content_type


Perm = get_perm_model()


