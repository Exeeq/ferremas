from django import forms
from usuario.models import UsuarioCustom
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.forms import AuthenticationForm
from django.utils.translation import gettext, gettext_lazy as _
from django.contrib.auth import authenticate


class RegisterForm(UserCreationForm):
    fecha_nacimiento = forms.DateField(
        label='Fecha de Nacimiento',
        widget=forms.DateInput(attrs={'type': 'date'})
    )

    class Meta:
        model = UsuarioCustom
        fields = ['username', 'run', 'correo_usuario', 'pnombre', 'ap_paterno', 'fecha_nacimiento', 'direccion']

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
class ProductForm(forms.Form):
    idProducto = forms.IntegerField(label='ID del Producto')
    nombreProducto = forms.CharField(label='Nombre del Producto', max_length=255)
    precioProducto = forms.IntegerField(label='Precio del Producto')
    imagenProducto = forms.ImageField(label='Imagen del Producto')
    descripcionProducto = forms.CharField(label='Descripción del Producto', widget=forms.Textarea)
    idcategoriaProducto = forms.IntegerField(label='ID de la Categoría del Producto')
    idmarcaProducto = forms.IntegerField(label='ID de la Marca del Producto')

