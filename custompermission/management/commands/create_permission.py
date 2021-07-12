from django.core.management.base import BaseCommand, CommandError
from custompermission.models import Perm
import argparse
from django.apps import apps
import os
import csv

class Command(BaseCommand):
    help = 'insert all custom permission'
 
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.model_name = Perm
 
    def add_arguments(self, parser):
        parser.add_argument('csvfile', type=str, help='permission for csv file')
 
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
                codename=data["codename"],
                name=data["name"],
                type=data['type'],
                description=data['description']
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
        permissions = []
        try:
            with open(file_path) as csv_file:
                csv_reader = csv.reader(csv_file, delimiter=',')
                self.clear_model()
                for row in csv_reader:
                    if row != '' and line_count >= 1:
                        data = {}
                        #print(row)
                        data['codename'] = row[0]
                        data['name'] = row[1]
                        data['type'] = row[2]
                        data['description'] = row[3]

                        if data['codename'] not in permissions:
                            permissions.append(data['codename'])
                            self.insert_permission_to_db(data)
                    line_count += 1
            self.stdout.write(
                self.style.SUCCESS(
                    f'{line_count-1} entries added to Custom Permission'
                )
            )
        except FileNotFoundError:
            raise CommandError(f'File {file_path} does not exist')

        