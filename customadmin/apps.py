from django.apps import AppConfig


class CustomadminConfig(AppConfig):
    name = 'customadmin'

    def ready(self):
    	import customadmin.signals
