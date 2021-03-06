# Generated by Django 3.1.1 on 2020-10-26 09:37

from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('organization', '0001_initial'),
        ('customadmin', '0007_courseenroll'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='activitycategory',
            name='course',
        ),
        migrations.CreateModel(
            name='SessionActivity',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('start_date', models.DateField(default=django.utils.timezone.now)),
                ('end_date', models.DateField()),
                ('description', models.TextField()),
                ('duration', models.CharField(max_length=10)),
                ('auto_attendence', models.BooleanField(default=False)),
                ('photo_attendence', models.BooleanField(default=False)),
                ('record_session', models.BooleanField(default=False)),
                ('enable_private_chat', models.BooleanField(default=True)),
                ('enable_group_chat', models.BooleanField(default=False)),
                ('raise_query', models.BooleanField(default=False)),
                ('download_record_session_video', models.BooleanField(default=False)),
                ('download_session_resource', models.BooleanField(default=False)),
                ('capture_photo_after_every', models.CharField(max_length=5)),
                ('activity_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='customadmin.activitycategory')),
                ('teacher', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='organization.userinformation')),
            ],
            options={
                'abstract': False,
            },
        ),
    ]
