# Generated by Django 3.1.1 on 2020-10-19 06:54

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('organization', '0001_initial'),
        ('customadmin', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='courses',
            name='teacher',
            field=models.ForeignKey(blank=True, default=None, null=True, on_delete=django.db.models.deletion.CASCADE, to='organization.userinformation'),
        ),
    ]
