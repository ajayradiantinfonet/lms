# Generated by Django 3.1.1 on 2021-01-20 10:12

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0038_contentvideo_thumbnail'),
    ]

    operations = [
        migrations.AlterField(
            model_name='topic',
            name='about',
            field=models.CharField(default=None, max_length=255),
        ),
        migrations.AlterField(
            model_name='topic',
            name='duration',
            field=models.CharField(default=None, max_length=20, null=True),
        ),
    ]