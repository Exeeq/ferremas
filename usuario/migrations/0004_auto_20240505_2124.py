# Generated by Django 3.1.2 on 2024-05-06 01:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('usuario', '0003_auto_20240505_1648'),
    ]

    operations = [
        migrations.AlterField(
            model_name='usuariocustom',
            name='correo_usuario',
            field=models.EmailField(max_length=254, unique=True, verbose_name='email address'),
        ),
    ]