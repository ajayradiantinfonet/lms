# Generated by Django 3.1.1 on 2021-04-03 05:25

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0002_remove_user_username'),
    ]

    operations = [
        migrations.RenameField(
            model_name='user',
            old_name='is_verified',
            new_name='profile_complete',
        ),
    ]
