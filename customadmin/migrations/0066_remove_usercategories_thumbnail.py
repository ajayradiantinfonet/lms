# Generated by Django 3.1.1 on 2021-02-18 07:28

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0065_auto_20210218_1256'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='usercategories',
            name='thumbnail',
        ),
    ]
