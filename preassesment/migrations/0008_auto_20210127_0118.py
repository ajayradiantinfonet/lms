# Generated by Django 3.1 on 2021-01-26 19:48

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('preassesment', '0007_remove_quiz_start_date_time'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='quiz',
            name='is_trial',
        ),
        migrations.RemoveField(
            model_name='quiz',
            name='view_answerpaper',
        ),
    ]
