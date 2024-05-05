from django.db import models
from django.contrib.auth.models import AbstractUser
from core.models import *

class UsuarioCustom(AbstractUser):
    run = models.CharField(max_length=12)
    pnombre = models.CharField(max_length=20)
    snombre = models.CharField(max_length=20)
    ap_paterno = models.CharField(max_length=24)
    ap_materno = models.CharField(max_length=24)
    correo_usuario = models.CharField(max_length=60)
    fecha_nacimiento = models.DateField()
    direccion = models.CharField(max_length=40)
    

    def __str__(self):
        return self.username
