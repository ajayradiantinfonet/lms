# Generated by Django 3.1.1 on 2021-01-20 04:49

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0036_auto_20210119_1839'),
    ]

    operations = [
        migrations.AlterField(
            model_name='sessionactivity',
            name='duration',
            field=models.CharField(help_text='in minutes', max_length=10),
        ),
    ]
