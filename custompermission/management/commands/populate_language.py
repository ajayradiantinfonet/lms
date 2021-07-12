from django.core.management.base import BaseCommand, CommandError
from customadmin.models import Language
import argparse
from django.apps import apps
import os
import csv

class Command(BaseCommand):
    help = 'insert all custom permission'
 
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.model_name = Language
 
    def add_arguments(self, parser):
        parser.add_argument('csvfile', type=str, help='language csv file')
 
    def get_current_app_path(self):
        return apps.get_app_config('custompermission').path
 
    def get_csv_file(self, filename):
        app_path = self.get_current_app_path()
        file_path = os.path.join(app_path, "management",
                                 "commands", filename)
        return file_path
 
    def clear_model(self):
        try:
            self.model_name.objects.all().delete()
        except Exception as e:
            raise CommandError(
                f'Error in clearing {self.model_name}: {str(e)}'
            )
 
    def insert_permission_to_db(self, data):
        try:
            #print(data)
            self.model_name.objects.create(
                language_name=data["language"],
                language_code=data["language_code"],
            )
        except Exception as e:
            raise CommandError(
                f'Error in inserting {self.model_name}: {str(e)}'
            )
 
    def handle(self, *args, **kwargs):
        filename = kwargs['csvfile']
        self.stdout.write(self.style.SUCCESS(f'filename:{filename}'))
        file_path = self.get_csv_file(filename)
        line_count = 0
        languages = []
        try:
            with open(file_path) as csv_file:
                csv_reader = csv.reader(csv_file, delimiter=',')
                self.clear_model()
                for row in csv_reader:
                    if row != '' and line_count >= 1:
                        data = {}
                        #print(row)
                        data['language_code'] = row[0]
                        data['language'] = row[1]

                        if data['language_code'] not in languages:
                            languages.append(data['language_code'])
                            self.insert_permission_to_db(data)
                    line_count += 1
            self.stdout.write(
                self.style.SUCCESS(
                    f'{line_count-1} entries added to Language Table'
                )
            )
        except FileNotFoundError:
            raise CommandError(f'File {file_path} does not exist')

        