# Generated by Django 3.1.1 on 2021-01-21 10:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('organization', '0002_auto_20210121_1543'),
    ]

    operations = [
        migrations.AddField(
            model_name='userinformation',
            name='image',
            field=models.ImageField(null=True, upload_to='user_profile'),
        ),
    ]
