# Generated by Django 3.1.1 on 2020-11-03 10:59

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('customadmin', '0023_auto_20201102_1447'),
    ]

    operations = [
        migrations.CreateModel(
            name='Categories',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=125)),
                ('category_type', models.CharField(choices=[('category', 'category'), ('subcategory', 'subcategory')], max_length=25)),
            ],
        ),
        migrations.CreateModel(
            name='SubCategories',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=125)),
                ('category_details', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='subcategories', to='customadmin.categories')),
            ],
        ),
        migrations.CreateModel(
            name='FileActivity',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('file', models.FileField(upload_to='file_activity/')),
                ('description', models.CharField(max_length=125)),
                ('activity_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='customadmin.activitycategory')),
            ],
        ),
        migrations.AddField(
            model_name='courses',
            name='courses_category',
            field=models.ManyToManyField(related_name='courses_categories', to='customadmin.Categories'),
        ),
    ]