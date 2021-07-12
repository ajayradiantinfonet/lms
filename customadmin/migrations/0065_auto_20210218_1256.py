# Generated by Django 3.1.1 on 2021-02-18 07:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0064_auto_20210218_0018'),
    ]

    operations = [
        migrations.AddField(
            model_name='usercategories',
            name='thumbnail',
            field=models.ImageField(null=True, upload_to='categories_file'),
        ),
        migrations.AlterField(
            model_name='activities',
            name='activity_type',
            field=models.CharField(choices=[('quiz', 'quiz'), ('spin_activity', 'spin_activity'), ('Assignment', 'Assignment'), ('drag_and_drop', 'Drag and Drop'), ('mcq', 'mcq')], max_length=50),
        ),
    ]
