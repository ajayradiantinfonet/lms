from django.db import models

# Create your models here.

from .base import BasePerm
from .managers import RelatedPermManager


class Perm(BasePerm):


    related_manager = RelatedPermManager()

    class Meta:
        base_manager_name = 'related_manager'

