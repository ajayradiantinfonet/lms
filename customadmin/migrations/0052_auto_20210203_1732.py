# Generated by Django 3.1.1 on 2021-02-03 12:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0051_coursesenduser_course_tag'),
    ]

    operations = [
        migrations.AlterField(
            model_name='assignmentactivity',
            name='answer_file',
            field=models.FileField(upload_to='assignment_file/'),
        ),
        migrations.AlterField(
            model_name='assignmentactivity',
            name='question_file',
            field=models.FileField(upload_to='assignment_file/'),
        ),
    ]
