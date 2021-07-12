# Generated by Django 3.1.1 on 2021-01-13 10:30

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0030_auto_20210113_1549'),
    ]

    operations = [
        migrations.AlterUniqueTogether(
            name='topicwiseanswerpaper',
            unique_together=None,
        ),
        migrations.RemoveField(
            model_name='topicwiseanswerpaper',
            name='activity',
        ),
        migrations.RemoveField(
            model_name='topicwiseanswerpaper',
            name='course',
        ),
        migrations.RemoveField(
            model_name='topicwiseanswerpaper',
            name='topic',
        ),
        migrations.RemoveField(
            model_name='topicwiseanswerpaper',
            name='user',
        ),
        migrations.RemoveConstraint(
            model_name='courseenroll',
            name='one time enroll for user',
        ),
        migrations.AddField(
            model_name='courseenroll',
            name='activity',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='customadmin.activities'),
        ),
        migrations.AddField(
            model_name='courseenroll',
            name='topic',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='customadmin.topic'),
        ),
        migrations.DeleteModel(
            name='TopicWiseAnswerpaper',
        ),
    ]