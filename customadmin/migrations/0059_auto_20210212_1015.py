# Generated by Django 3.1.1 on 2021-02-12 04:45

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0058_auto_20210209_1234'),
    ]

    operations = [
        migrations.AlterField(
            model_name='organization',
            name='sector_type',
            field=models.CharField(choices=[('government', 'Government'), ('private', 'Private')], default='government', max_length=125),
        ),
    ]
