from django.db import models


class LanguageManager(models.Manager):

    def get_queryset(self):
        return super(LanguageManager, self).get_queryset().all()


    def get_language_choice_tuple(self):
        language_choice_list=[]
        for item in self.get_queryset():
            temp=(item.language_code,item.language_name)
            language_choice_list.append(temp)
        return language_choice_list

    
