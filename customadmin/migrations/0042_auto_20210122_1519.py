# Generated by Django 3.1 on 2021-01-22 09:49

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0041_auto_20210122_1311'),
    ]

    operations = [
        migrations.AddField(
            model_name='contentvideo',
            name='language',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='customadmin.language'),
        ),
        migrations.AlterUniqueTogether(
            name='courseenroll',
            unique_together=set(),
        ),
        migrations.AddConstraint(
            model_name='courseenroll',
            constraint=models.UniqueConstraint(fields=('user', 'course'), name='one time enroll for user'),
        ),
    ]
