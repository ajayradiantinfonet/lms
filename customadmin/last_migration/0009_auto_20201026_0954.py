# Generated by Django 3.1.1 on 2020-10-26 09:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0008_auto_20201026_0937'),
    ]

    operations = [
        migrations.AlterField(
            model_name='sessionactivity',
            name='enable_private_chat',
            field=models.BooleanField(default=False),
        ),
        migrations.AlterField(
            model_name='sessionactivity',
            name='photo_attendence',
            field=models.BooleanField(default=True),
        ),
    ]