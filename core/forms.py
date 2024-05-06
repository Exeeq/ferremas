from django import forms
from usuario.models import UsuarioCustom
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.forms import AuthenticationForm
from django.utils.translation import gettext, gettext_lazy as _
from django.contrib.auth import authenticate


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

