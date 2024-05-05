from django import forms
from usuario.models import UsuarioCustom
from django.contrib.auth.forms import UserCreationForm

class RegisterForm(UserCreationForm):
    # Personaliza los nombres de los campos y hazlos obligatorios
    run = forms.CharField(label='RUN', required=True)
    pnombre = forms.CharField(label='Primer Nombre', required=True)
    snombre = forms.CharField(label='Segundo Nombre', required=False)
    ap_paterno = forms.CharField(label='Apellido Paterno', required=True)
    ap_materno = forms.CharField(label='Apellido Materno', required=False)
    correo_usuario = forms.EmailField(label='Correo Electrónico', required=True)
    fecha_nacimiento = forms.DateField(label='Fecha de Nacimiento', required=True, widget=forms.DateInput(attrs={'type': 'date'}))
    direccion = forms.CharField(label='Dirección', required=False)

    class Meta:
        model = UsuarioCustom
        fields = ['run', 'pnombre', 'snombre', 'ap_paterno', 'ap_materno', 'correo_usuario', 'fecha_nacimiento', 'direccion']

