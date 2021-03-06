# Generated by Django 3.1.1 on 2021-02-02 04:52

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0046_auto_20210131_1418'),
    ]

    operations = [
        migrations.CreateModel(
            name='AssignmentActivity',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('description', models.CharField(max_length=125)),
                ('question_file', models.FileField(upload_to='assignment_file')),
                ('answer_file', models.FileField(upload_to='assignment_file')),
                ('no_of_submission', models.CharField(max_length=2)),
                ('activity', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='customadmin.activities')),
            ],
        ),
        migrations.DeleteModel(
            name='ResourceActivity',
        ),
    ]
