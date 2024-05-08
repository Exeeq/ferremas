from django.db import models
from django.contrib.auth.models import AbstractUser
from core.models import *

class UsuarioCustom(AbstractUser):
    run = models.CharField(max_length=12, blank=False, null=False)
    pnombre = models.CharField(max_length=20, blank=False, null=False)
    snombre = models.CharField(max_length=20, blank=True)
    ap_paterno = models.CharField(max_length=24, blank=False, null=False)
    ap_materno = models.CharField(max_length=24, blank=True)
    correo_usuario = models.EmailField('correo electrónico')
    fecha_nacimiento = models.DateField(null=True)
    direccion = models.CharField(max_length=40)

    def __str__(self):
        return self.username
