# Generated by Django 3.1.1 on 2020-12-03 12:24

import datetime
from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
from django.utils.timezone import utc
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('customadmin', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Assesments',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=125)),
                ('about', models.CharField(max_length=125)),
                ('start_date_time', models.DateTimeField(default=django.utils.timezone.now, null=True, verbose_name='Start Date and Time of the quiz')),
                ('end_date_time', models.DateTimeField(default=datetime.datetime(2198, 12, 31, 18, 7, tzinfo=utc), null=True, verbose_name='End Date and Time of the quiz')),
                ('duration', models.IntegerField(default=20, verbose_name='Duration of quiz in minutes')),
                ('active', models.BooleanField(default=True)),
                ('description', models.CharField(max_length=256, null=True)),
                ('pass_criteria', models.FloatField(default=40, verbose_name='Passing percentage')),
                ('attempts_allowed', models.IntegerField(choices=[(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (-1, 'Infinite')], default=1)),
                ('time_between_attempts', models.FloatField(default=0.0, verbose_name='Time Between Quiz Attempts in hours')),
                ('is_trial', models.BooleanField(default=False)),
                ('instructions', models.TextField(blank=True, default=None, null=True, verbose_name='Instructions for Students')),
                ('view_answerpaper', models.BooleanField(default=False, verbose_name='Allow student to view their answer\t\t\t\t\t\t\t\t\t\t\tpaper')),
                ('allow_skip', models.BooleanField(default=True, verbose_name='Allow students to skip questions')),
                ('weightage', models.FloatField(default=100, help_text='Will be considered as percentage')),
                ('is_exercise', models.BooleanField(default=False)),
                ('creator', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='assesment_author', to=settings.AUTH_USER_MODEL)),
                ('topics', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='assesment_topics', to='customadmin.topic')),
            ],
            options={
                'managed': True,
            },
        ),
        migrations.CreateModel(
            name='Question',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('summary', models.CharField(max_length=256)),
                ('description', models.TextField(null=True)),
                ('points', models.FloatField(default=1.0)),
                ('topic', models.CharField(blank=True, max_length=50, null=True)),
                ('type', models.CharField(choices=[('mcq', 'Single Correct Choice'), ('mcc', 'Multiple Correct Choices'), ('code', 'Code'), ('upload', 'Assignment Upload'), ('integer', 'Answer in Integer'), ('string', 'Answer in String'), ('float', 'Answer in Float'), ('arrange', 'Arrange in Correct Order')], default='mcq', max_length=24)),
                ('active', models.BooleanField(default=True)),
                ('partial_grading', models.BooleanField(default=False)),
                ('grade_assignment_upload', models.BooleanField(default=False)),
                ('min_time', models.IntegerField(default=0, verbose_name='time in minutes')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='user', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='QuestionSet',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('marks', models.FloatField()),
                ('num_questions', models.IntegerField()),
                ('questions', models.ManyToManyField(to='preassesment.Question')),
            ],
        ),
        migrations.CreateModel(
            name='QuestionPaper',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('shuffle_questions', models.BooleanField(default=False)),
                ('total_marks', models.FloatField(blank=True, default=0.0)),
                ('fixed_question_order', models.TextField(blank=True)),
                ('shuffle_testcases', models.BooleanField(default=True, verbose_name='Shuffle testcase for each user')),
                ('fixed_questions', models.ManyToManyField(to='preassesment.Question')),
                ('quiz', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='preassesment.assesments')),
                ('random_questions', models.ManyToManyField(to='preassesment.QuestionSet')),
            ],
        ),
        migrations.CreateModel(
            name='QuestionOption',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('option_a', models.CharField(max_length=125, null=True)),
                ('option_b', models.CharField(max_length=125, null=True)),
                ('option_c', models.CharField(max_length=125, null=True)),
                ('option_d', models.CharField(max_length=125, null=True)),
                ('option_e', models.CharField(max_length=125)),
                ('question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='preassesment.question')),
            ],
        ),
        migrations.CreateModel(
            name='FileUpload',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('file', models.FileField(blank=True, upload_to='question_file')),
                ('extract', models.BooleanField(default=False)),
                ('hide', models.BooleanField(default=False)),
                ('question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='question', to='preassesment.question')),
            ],
        ),
        migrations.CreateModel(
            name='Answer',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('answer', models.TextField(blank=True, null=True)),
                ('error', models.TextField()),
                ('marks', models.FloatField(default=0.0)),
                ('correct', models.BooleanField(default=False)),
                ('skipped', models.BooleanField(default=False)),
                ('comment', models.TextField(blank=True, null=True)),
                ('question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='preassesment.question')),
            ],
        ),
        migrations.CreateModel(
            name='AnswerPaper',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('attempt_number', models.IntegerField()),
                ('start_time', models.DateTimeField()),
                ('end_time', models.DateTimeField()),
                ('user_ip', models.CharField(max_length=15)),
                ('comments', models.TextField()),
                ('marks_obtained', models.FloatField(default=0.0, null=True)),
                ('percent', models.FloatField(default=0.0, null=True)),
                ('passed', models.BooleanField(default=False)),
                ('status', models.CharField(choices=[('inprogress', 'Inprogress'), ('completed', 'Completed')], default='inprogress', max_length=20)),
                ('questions_order', models.TextField(blank=True, default='')),
                ('extra_time', models.FloatField(default=0.0, verbose_name='Additional time in mins')),
                ('is_special', models.BooleanField(default=False)),
                ('answers', models.ManyToManyField(to='preassesment.Answer')),
                ('question_paper', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='preassesment.questionpaper')),
                ('questions', models.ManyToManyField(related_name='questions', to='preassesment.Question')),
                ('questions_answered', models.ManyToManyField(related_name='questions_answered', to='preassesment.Question')),
                ('questions_unanswered', models.ManyToManyField(related_name='questions_unanswered', to='preassesment.Question')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'unique_together': {('user', 'question_paper', 'attempt_number')},
            },
        ),
    ]