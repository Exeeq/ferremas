# Generated by Django 3.1.2 on 2024-05-22 19:36

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0005_auto_20240522_1529'),
    ]

    operations = [
        migrations.AlterField(
            model_name='producto',
            name='descripcionProducto',
            field=models.TextField(),
        ),
        migrations.AlterField(
            model_name='producto',
            name='nombreProducto',
            field=models.TextField(),
        ),
    ]
