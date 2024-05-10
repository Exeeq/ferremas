from django import forms
from .models import *
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.forms import AuthenticationForm
from django.utils.translation import gettext, gettext_lazy as _
from django.contrib.auth import authenticate


class RegisterForm(UserCreationForm):
    username = forms.CharField(label='Nombre de usuario', help_text='Mínimo 6 caracteres')
    run = forms.CharField(label='RUN (Rol Único Nacional)', help_text='Ejemplo: 12345678-9')
    correo_usuario = forms.EmailField(label='Correo electrónico')
    pnombre = forms.CharField(label='Primer Nombre')
    ap_paterno = forms.CharField(label='Apellido Paterno')
    fecha_nacimiento = forms.DateField(label='Fecha de Nacimiento', widget=forms.DateInput(attrs={'type': 'date'}))
    direccion = forms.CharField(label='Dirección', widget=forms.TextInput(attrs={'placeholder': 'Calle, número, comuna'}))
    comuna = forms.ModelChoiceField(queryset=comuna.objects.all(), label='Comuna')

    class Meta:
        model = usuarioCustom
        fields = ['username', 'run', 'correo_usuario', 'pnombre', 'ap_paterno', 'fecha_nacimiento', 'direccion', 'comuna']

class CustomAuthenticationForm(AuthenticationForm):
    email = forms.EmailField(
        label=_("Correo Electrónico"),
        widget=forms.EmailInput(attrs={'autofocus': True}),
    )
    password = forms.CharField(
        label=_("Contraseña"),
        strip=False,
        widget=forms.PasswordInput(attrs={'autocomplete': 'current-password'}),
    )

    error_messages = {
        'invalid_login': _(
            "Por favor, ingrese un %(username)s y contraseña correctos. Note que ambos campos pueden ser sensibles a mayúsculas."
        ),
        'inactive': _("Esta cuenta está inactiva."),
    }

    def clean(self):
        email = self.cleaned_data.get('email')
        password = self.cleaned_data.get('password')

        if email is not None and password:
            self.user_cache = authenticate(self.request, email=email, password=password)
            if self.user_cache is None:
                raise self.get_invalid_login_error()
            else:
                self.confirm_login_allowed(self.user_cache)

        return self.cleaned_data
    
#FORM CRUD PRODUCTOS (AÑADIR, ACTUALIZAR):


