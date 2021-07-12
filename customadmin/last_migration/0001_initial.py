# Generated by Django 3.1.1 on 2020-10-13 11:23

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='AcitivityCategory',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('start_date', models.DateField(default=django.utils.timezone.now)),
                ('end_date', models.DateField()),
                ('activity_type', models.CharField(max_length=255, unique=True)),
                ('activity_name', models.CharField(max_length=255)),
            ],
            options={
                'ordering': ('id',),
            },
        ),
        migrations.CreateModel(
            name='Courses',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('start_date', models.DateField(default=django.utils.timezone.now)),
                ('end_date', models.DateField()),
                ('name', models.CharField(max_length=255)),
                ('about', models.CharField(max_length=255)),
                ('thumbnail', models.ImageField(default=None, upload_to='course_images/')),
                ('type', models.CharField(choices=[('course', 'course'), ('subtopic', 'subtopic')], default='course', max_length=10)),
                ('duration', models.DurationField(default=None)),
                ('author', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('id',),
            },
        ),
        migrations.CreateModel(
            name='Language',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('language_name', models.CharField(max_length=125)),
                ('language_code', models.CharField(default=None, max_length=2, unique=True)),
            ],
        ),
        migrations.CreateModel(
            name='Organization',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255, unique=True)),
                ('website', models.URLField(max_length=255, unique=True)),
                ('address', models.TextField()),
                ('start_date', models.DateField(default=django.utils.timezone.now)),
                ('end_date', models.DateField(blank=True, null=True)),
                ('no_of_candidates', models.IntegerField(blank=True, null=True)),
                ('company_logo', models.ImageField(upload_to='uploads/')),
                ('email', models.EmailField(max_length=254, unique=True)),
                ('phone', models.CharField(max_length=10, unique=True)),
                ('password', models.CharField(max_length=256)),
            ],
            options={
                'ordering': ('id',),
            },
        ),
        migrations.CreateModel(
            name='Question',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('start_date', models.DateField(default=django.utils.timezone.now)),
                ('end_date', models.DateField()),
                ('question_name', models.CharField(max_length=255, unique=True)),
                ('question_type', models.CharField(choices=[('radio', 'radio'), ('checkboxes', 'checkboxes'), ('text', 'text')], max_length=20)),
                ('option_a', models.CharField(max_length=200)),
                ('option_b', models.CharField(max_length=200)),
                ('option_c', models.CharField(max_length=200)),
                ('option_d', models.CharField(max_length=200)),
                ('answer_option', models.CharField(max_length=1)),
                ('answer_text', models.CharField(max_length=225)),
                ('author', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('question_language', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='customadmin.language')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='Topic',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('start_date', models.DateField(default=django.utils.timezone.now)),
                ('end_date', models.DateField()),
                ('name', models.CharField(max_length=255)),
                ('about', models.CharField(default=None, max_length=255)),
                ('thumbnail', models.ImageField(default=None, upload_to='topic_images/')),
                ('duration', models.DurationField(default=None)),
                ('author', models.ForeignKey(default=None, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('course', models.ForeignKey(default=None, on_delete=django.db.models.deletion.CASCADE, to='customadmin.courses')),
            ],
            options={
                'ordering': ('id',),
            },
        ),
        migrations.CreateModel(
            name='QuestionActivity',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('start_date', models.DateField(default=django.utils.timezone.now)),
                ('end_date', models.DateField()),
                ('activity_type', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='customadmin.acitivitycategory')),
                ('author', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('course', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='customadmin.courses')),
                ('question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='customadmin.question')),
                ('topic', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='questionactivity_topic', to='customadmin.topic')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='PdfActivity',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('start_date', models.DateField(default=django.utils.timezone.now)),
                ('end_date', models.DateField()),
                ('pdf_file', models.FileField(upload_to='pdf_activity/')),
                ('activity_type', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='customadmin.acitivitycategory')),
                ('author', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('course', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='customadmin.courses')),
                ('topic', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='pdfactivity_topic', to='customadmin.topic')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='LanguageCourse',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('course', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='customadmin.courses')),
                ('lang', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='customadmin.language')),
            ],
        ),
        migrations.AddField(
            model_name='courses',
            name='organization',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='customadmin.organization'),
        ),
        migrations.CreateModel(
            name='Answer',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('answer', models.CharField(max_length=225)),
                ('question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='customadmin.question')),
            ],
        ),
    ]
