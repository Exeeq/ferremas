# Generated by Django 3.1.2 on 2024-05-10 02:24

import django.contrib.auth.models
import django.contrib.auth.validators
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
    ]

    operations = [
        migrations.CreateModel(
            name='bodega',
            fields=[
                ('idBodega', models.AutoField(primary_key=True, serialize=False)),
                ('nombreBodega', models.CharField(max_length=50)),
            ],
        ),
        migrations.CreateModel(
            name='categoriaProducto',
            fields=[
                ('idcategoriaProducto', models.AutoField(primary_key=True, serialize=False)),
                ('nombrecategoriaProducto', models.CharField(max_length=60)),
            ],
        ),
        migrations.CreateModel(
            name='comuna',
            fields=[
                ('idComuna', models.AutoField(primary_key=True, serialize=False)),
                ('nombreComuna', models.CharField(max_length=80)),
            ],
        ),
        migrations.CreateModel(
            name='marca',
            fields=[
                ('idMarca', models.AutoField(primary_key=True, serialize=False)),
                ('nombreMarca', models.CharField(max_length=20)),
            ],
        ),
        migrations.CreateModel(
            name='region',
            fields=[
                ('idRegion', models.AutoField(primary_key=True, serialize=False)),
                ('nombreRegion', models.CharField(max_length=80)),
            ],
        ),
        migrations.CreateModel(
            name='rolUsuario',
            fields=[
                ('idRol', models.AutoField(primary_key=True, serialize=False)),
                ('nombreRol', models.CharField(max_length=20)),
            ],
        ),
        migrations.CreateModel(
            name='sucursal',
            fields=[
                ('idSucursal', models.AutoField(primary_key=True, serialize=False)),
                ('nombreSucursal', models.CharField(max_length=50)),
                ('direccionSucursal', models.CharField(max_length=60)),
                ('idComuna', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.comuna')),
            ],
        ),
        migrations.CreateModel(
            name='producto',
            fields=[
                ('idProducto', models.AutoField(primary_key=True, serialize=False)),
                ('nombreProducto', models.CharField(max_length=50)),
                ('precioProducto', models.IntegerField()),
                ('imagenProducto', models.ImageField(blank=True, null=True, upload_to='productos/')),
                ('descripcionProducto', models.CharField(max_length=200)),
                ('idMarca', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.marca')),
                ('idcategoriaProducto', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.categoriaproducto')),
            ],
        ),
        migrations.CreateModel(
            name='inventario',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('stock', models.IntegerField()),
                ('idBodega', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.bodega')),
                ('idProducto', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.producto')),
            ],
        ),
        migrations.AddField(
            model_name='comuna',
            name='idRegion',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.region'),
        ),
        migrations.AddField(
            model_name='bodega',
            name='idSucursal',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.sucursal'),
        ),
        migrations.CreateModel(
            name='usuarioCustom',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('password', models.CharField(max_length=128, verbose_name='password')),
                ('last_login', models.DateTimeField(blank=True, null=True, verbose_name='last login')),
                ('is_superuser', models.BooleanField(default=False, help_text='Designates that this user has all permissions without explicitly assigning them.', verbose_name='superuser status')),
                ('username', models.CharField(error_messages={'unique': 'A user with that username already exists.'}, help_text='Required. 150 characters or fewer. Letters, digits and @/./+/-/_ only.', max_length=150, unique=True, validators=[django.contrib.auth.validators.UnicodeUsernameValidator()], verbose_name='username')),
                ('first_name', models.CharField(blank=True, max_length=150, verbose_name='first name')),
                ('last_name', models.CharField(blank=True, max_length=150, verbose_name='last name')),
                ('email', models.EmailField(blank=True, max_length=254, verbose_name='email address')),
                ('is_staff', models.BooleanField(default=False, help_text='Designates whether the user can log into this admin site.', verbose_name='staff status')),
                ('is_active', models.BooleanField(default=True, help_text='Designates whether this user should be treated as active. Unselect this instead of deleting accounts.', verbose_name='active')),
                ('date_joined', models.DateTimeField(default=django.utils.timezone.now, verbose_name='date joined')),
                ('run', models.CharField(max_length=12)),
                ('pnombre', models.CharField(max_length=20)),
                ('snombre', models.CharField(blank=True, max_length=20)),
                ('ap_paterno', models.CharField(max_length=24)),
                ('ap_materno', models.CharField(blank=True, max_length=24)),
                ('correo_usuario', models.EmailField(max_length=254)),
                ('fecha_nacimiento', models.DateField()),
                ('direccion', models.CharField(max_length=100)),
                ('groups', models.ManyToManyField(blank=True, help_text='The groups this user belongs to. A user will get all permissions granted to each of their groups.', related_name='user_set', related_query_name='user', to='auth.Group', verbose_name='groups')),
                ('idComuna', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.comuna')),
                ('idRol', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.rolusuario')),
                ('user_permissions', models.ManyToManyField(blank=True, help_text='Specific permissions for this user.', related_name='user_set', related_query_name='user', to='auth.Permission', verbose_name='user permissions')),
            ],
            options={
                'verbose_name': 'user',
                'verbose_name_plural': 'users',
                'abstract': False,
            },
            managers=[
                ('objects', django.contrib.auth.models.UserManager()),
            ],
        ),
    ]