# Generated by Django 3.1.1 on 2021-03-02 09:52

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('organization', '0008_auto_20210225_1111'),
        ('customadmin', '0079_auto_20210225_1111'),
    ]

    operations = [
        migrations.AlterField(
            model_name='sessionactivity',
            name='teacher',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='organization.userinformation'),
        ),
    ]