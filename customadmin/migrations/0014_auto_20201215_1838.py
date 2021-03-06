# Generated by Django 3.1.1 on 2020-12-15 13:08

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0013_auto_20201215_1731'),
    ]

    operations = [
        migrations.CreateModel(
            name='Country',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=250, unique=True)),
                ('status', models.IntegerField(blank=True, choices=[(1, 'Active'), (0, 'In-Active')])),
            ],
        ),
        migrations.CreateModel(
            name='State',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=250, unique=True)),
                ('status', models.IntegerField(blank=True, choices=[(1, 'Active'), (0, 'In-Active')])),
                ('country', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='customadmin.country')),
            ],
        ),
        migrations.CreateModel(
            name='City',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=250, unique=True)),
                ('status', models.IntegerField(blank=True, choices=[(1, 'Active'), (0, 'In-Active')])),
                ('state', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='customadmin.state')),
            ],
        ),
        migrations.AddField(
            model_name='organization',
            name='city',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='customadmin.city'),
        ),
        migrations.AddField(
            model_name='organization',
            name='country',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='customadmin.country'),
        ),
        migrations.AddField(
            model_name='organization',
            name='state',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='customadmin.state'),
        ),
    ]
