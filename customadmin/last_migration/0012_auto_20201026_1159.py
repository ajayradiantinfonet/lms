# Generated by Django 3.1.1 on 2020-10-26 11:59

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0011_sessionactivity_author'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='sessionactivity',
            name='end_date',
        ),
        migrations.AlterField(
            model_name='sessionactivity',
            name='start_date',
            field=models.DateTimeField(default=django.utils.timezone.now),
        ),
    ]