# Generated by Django 3.1.1 on 2020-11-05 23:09

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0031_topic_topic_type'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='language',
            options={'ordering': ('id',)},
        ),
    ]
