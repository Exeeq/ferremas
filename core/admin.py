from django.contrib import admin
from usuario.models import UsuarioCustom

class UsuarioAdmin(admin.ModelAdmin):
    list_display = ['username','run', 'pnombre', 'snombre', 'ap_paterno', 'ap_materno', 'correo_usuario', 'fecha_nacimiento', 'direccion']
    search_fields = ['run']
    list_per_page = 10
    list_filter = ['ap_paterno']
    list_editable = ['pnombre', 'run', 'snombre', 'ap_paterno', 'ap_materno', 'correo_usuario', 'fecha_nacimiento', 'direccion']

admin.site.register(UsuarioCustom, UsuarioAdmin)