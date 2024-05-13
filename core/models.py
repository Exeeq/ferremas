from django.db import models
from django.contrib.auth.models import AbstractUser

#MODELOS RELACIONADOS AL USUARIOS
class rolUsuario(models.Model):
    idRol = models.AutoField(primary_key=True)
    nombreRol = models.CharField(max_length=20, blank=False, null=False)

    def __str__(self):
        return self.nombreRol

class region(models.Model):
    idRegion = models.AutoField(primary_key=True)
    nombreRegion = models.CharField(max_length=80, blank=False, null=False)

    def __str__(self):
        return self.nombreRegion

class comuna(models.Model):
    idComuna = models.AutoField(primary_key=True)
    nombreComuna = models.CharField(max_length=80, blank=False, null=False)
    idRegion = models.ForeignKey(region, on_delete=models.CASCADE)

    def __str__(self):
        return self.nombreComuna

class usuarioCustom(AbstractUser):
    run = models.CharField(max_length=12, blank=False, null=False)
    pnombre = models.CharField(max_length=20, blank=False, null=False)
    snombre = models.CharField(max_length=20, blank=True)
    ap_paterno = models.CharField(max_length=24, blank=False, null=False)
    ap_materno = models.CharField(max_length=24, blank=True)
    correo_usuario = models.EmailField(blank=False, null=False)
    fecha_nacimiento = models.DateField(null=True, blank=True)
    direccion = models.CharField(blank=False, null=False, max_length=100)
    idRol = models.ForeignKey(rolUsuario, on_delete=models.CASCADE, blank=True, null=True)
    idComuna = models.ForeignKey(comuna, on_delete=models.CASCADE, blank=True, null=True)

    def __str__(self):
        return self.username    

#MODELOS RELACIONADOS A LOS PRODUCTOS
class marca(models.Model):
    idMarca = models.AutoField(primary_key=True)
    nombreMarca = models.CharField(max_length=20, blank=False, null=False)

    def __str__(self):
        return self.nombreMarca
    
class categoriaProducto(models.Model):
    idcategoriaProducto = models.AutoField(primary_key=True)
    nombrecategoriaProducto = models.CharField(max_length=60, blank=False, null=False)

    def __str__(self):
        return self.nombrecategoriaProducto
    
class producto(models.Model):
    idProducto = models.AutoField(primary_key=True)
    nombreProducto = models.CharField(max_length=50, blank=False, null=False)
    precioProducto = models.IntegerField(blank=False, null=False)
    stockProducto = models.IntegerField(blank=False, null=False)
    imagenProducto = models.BinaryField(blank=True, null=True)
    descripcionProducto = models.CharField(max_length=200, blank=False, null=False)
    idcategoriaProducto = models.ForeignKey(categoriaProducto, on_delete=models.CASCADE, blank=False, null=False)
    idMarca = models.ForeignKey(marca, on_delete=models.CASCADE, blank=False, null=False)

    def __str__(self):
        return self.nombreProducto

#MODELOS RELACIONADOS A LA SUCURSAL
class sucursal(models.Model):
    idSucursal = models.AutoField(primary_key=True)
    nombreSucursal = models.CharField(max_length=50, blank=False, null=False)
    direccionSucursal = models.CharField(max_length=60, blank=False, null=False)
    idComuna = models.ForeignKey(comuna, on_delete=models.CASCADE)

    def __str__(self):
        return self.nombreSucursal


#MODELOS RELACIONADOS AL CARRITO DE COMPRA



