# Generated by Django 3.1.1 on 2021-04-12 12:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0083_auto_20210403_0910'),
    ]

    operations = [
        migrations.AlterField(
            model_name='organization',
            name='course',
            field=models.ManyToManyField(related_name='organization_course', to='customadmin.CoursesEndUser'),
        ),
    ]
