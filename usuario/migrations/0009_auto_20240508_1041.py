# Generated by Django 3.1.2 on 2024-05-08 14:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('usuario', '0008_auto_20240506_2104'),
    ]

    operations = [
        migrations.AlterField(
            model_name='usuariocustom',
            name='ap_materno',
            field=models.CharField(blank=True, max_length=24),
        ),
        migrations.AlterField(
            model_name='usuariocustom',
            name='snombre',
            field=models.CharField(blank=True, max_length=20),
        ),
    ]
