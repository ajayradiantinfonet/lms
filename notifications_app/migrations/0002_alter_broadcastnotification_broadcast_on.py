# Generated by Django 3.2.6 on 2021-08-17 16:30

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('notifications_app', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='broadcastnotification',
            name='broadcast_on',
            field=models.DateTimeField(),
        ),
    ]