# Generated by Django 3.1.1 on 2021-01-19 13:09

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0035_auto_20210115_1238'),
    ]

    operations = [
        migrations.AddField(
            model_name='sessionactivity',
            name='organization',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='org_session', to='customadmin.organization'),
        ),
        migrations.AlterField(
            model_name='sessionactivity',
            name='course',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='course_session', to='customadmin.coursesenduser'),
        ),
    ]
