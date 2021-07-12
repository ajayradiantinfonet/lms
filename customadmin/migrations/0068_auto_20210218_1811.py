# Generated by Django 3.1.1 on 2021-02-18 12:41

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('customadmin', '0067_auto_20210218_1300'),
    ]

    operations = [
        migrations.AddField(
            model_name='assignmentanswer',
            name='answer_file1',
            field=models.FileField(null=True, upload_to='assignment_file/'),
        ),
        migrations.AddField(
            model_name='assignmentanswer',
            name='answer_file2',
            field=models.FileField(null=True, upload_to='assignment_file/'),
        ),
        migrations.AlterField(
            model_name='assignmentactivity',
            name='no_of_submission',
            field=models.CharField(help_text='how many time user can submit assignment', max_length=2),
        ),
        migrations.AlterField(
            model_name='assignmentanswer',
            name='activity',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='customadmin.assignmentactivity'),
        ),
        migrations.AlterField(
            model_name='assignmentanswer',
            name='submission',
            field=models.CharField(default=0, help_text='how many time user has submitted assignment', max_length=2),
        ),
        migrations.AlterField(
            model_name='assignmentanswer',
            name='user',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to=settings.AUTH_USER_MODEL),
        ),
    ]
