# Generated by Django 3.1.1 on 2021-02-21 05:19

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0070_organization_is_active'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='coursesenduser',
            options={'ordering': ['id']},
        ),
    ]
