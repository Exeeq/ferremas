# Generated by Django 3.1.2 on 2024-05-26 18:47

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0011_auto_20240526_1432'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='pedido',
            name='apellido_retiro',
        ),
        migrations.RemoveField(
            model_name='pedido',
            name='nombre_retiro',
        ),
    ]
