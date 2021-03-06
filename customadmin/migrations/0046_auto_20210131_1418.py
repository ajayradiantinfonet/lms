# Generated by Django 3.1.1 on 2021-01-31 08:48

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('customadmin', '0045_auto_20210127_0020'),
    ]

    operations = [
        migrations.AlterField(
            model_name='activities',
            name='activity_type',
            field=models.CharField(choices=[('mcq', 'mcq'), ('spin activity', 'spin activity'), ('Resource', 'Resource')], max_length=50),
        ),
        migrations.CreateModel(
            name='ResourceActivity',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('description', models.CharField(max_length=125)),
                ('activity', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='customadmin.activities')),
                ('creator', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
