# Generated by Django 3.1.1 on 2020-11-05 06:41

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0029_auto_20201104_1201'),
    ]

    operations = [
        migrations.CreateModel(
            name='TopicRelation',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('topic_father', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='topic_father', to='customadmin.topic')),
                ('topic_id', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='customadmin.topic')),
            ],
        ),
    ]
