# Generated by Django 3.1.1 on 2020-12-15 07:29

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0011_auto_20201209_1440'),
    ]

    operations = [
        migrations.AddField(
            model_name='courseenroll',
            name='is_completed',
            field=models.BooleanField(default=False),
        ),
        migrations.AddField(
            model_name='courseenroll',
            name='topic',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='customadmin.topic'),
        ),
        migrations.AddField(
            model_name='topic',
            name='ordering',
            field=models.PositiveIntegerField(null=True),
        ),
    ]