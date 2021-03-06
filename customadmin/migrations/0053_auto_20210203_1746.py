# Generated by Django 3.1.1 on 2021-02-03 12:16

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('customadmin', '0052_auto_20210203_1732'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='assignmentactivity',
            name='answer_file',
        ),
        migrations.CreateModel(
            name='AssignmentAnswer',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('answer_file', models.FileField(upload_to='assignment_file/')),
                ('answer_date', models.DateTimeField(default=django.utils.timezone.now)),
                ('activity', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='customadmin.assignmentactivity')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
