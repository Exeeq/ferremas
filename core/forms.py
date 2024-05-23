from django import forms
from .models import *
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.forms import AuthenticationForm
from django.utils.translation import gettext, gettext_lazy as _
from django.contrib.auth import authenticate




class UsuarioForm(forms.ModelForm):
    username = forms.CharField(label='Nombre de usuario', help_text='Mínimo 6 caracteres')
    run = forms.CharField(label='RUN (Rol Único Nacional)', help_text='Ejemplo: 12345678-9')
    pnombre = forms.CharField(label='Primer Nombre')
    ap_paterno = forms.CharField(label='Apellido Paterno')
    correo_usuario = forms.EmailField(label='Correo electrónico')
    fecha_nacimiento = forms.DateField(label='Fecha de Nacimiento', widget=forms.DateInput(attrs={'type': 'date'}))
    direccion = forms.CharField(label='Dirección', widget=forms.TextInput(attrs={'placeholder': 'Calle, número, comuna'}))
    idComuna = forms.ModelChoiceField(queryset=comuna.objects.all(), label='Comuna')
    idRol = forms.ModelChoiceField(queryset=rolUsuario.objects.all(), label='Rol')

    class Meta:
        model = usuarioCustom
        fields = ['username', 'run', 'pnombre', 'ap_paterno', 'correo_usuario', 'fecha_nacimiento', 'direccion', 'idComuna', 'idRol']

class RegisterUserAdminForm(UserCreationForm):
    username = forms.CharField(label='Nombre de usuario', help_text='Mínimo 6 caracteres')
    run = forms.CharField(label='RUN (Rol Único Nacional)', help_text='Ejemplo: 12345678-9')
    pnombre = forms.CharField(label='Primer Nombre')
    ap_paterno = forms.CharField(label='Apellido Paterno')
    correo_usuario = forms.EmailField(label='Correo electrónico')
    fecha_nacimiento = forms.DateField(label='Fecha de Nacimiento', widget=forms.DateInput(attrs={'type': 'date'}))
    direccion = forms.CharField(label='Dirección', widget=forms.TextInput(attrs={'placeholder': 'Calle, número, comuna'}))
    idComuna = forms.ModelChoiceField(queryset=comuna.objects.all(), label='Comuna')
    idRol = forms.ModelChoiceField(queryset=rolUsuario.objects.all(), label='Rol')
    password1 = forms.CharField(label='Contraseña', widget=forms.PasswordInput, help_text='Mínimo 8 caracteres')
    password2 = forms.CharField(label='Confirmar Contraseña', widget=forms.PasswordInput, help_text='Repite la contraseña para confirmar')

    class Meta:
        model = usuarioCustom
        fields = ['username', 'run', 'pnombre', 'ap_paterno', 'correo_usuario', 'fecha_nacimiento', 'direccion', 'idComuna', 'idRol', 'password1', 'password2']

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
class ProductoForm(forms.ModelForm):
    class Meta:
        model = producto
        fields = '__all__'
        labels = {
            'nombreProducto': 'Nombre del Producto',
            'precioProducto': 'Precio del Producto',
            'stockProducto': 'Stock del Producto',
            'imagenProducto': 'Imagen del Producto',
            'descripcionProducto': 'Descripción del Producto',
            'idcategoriaProducto': 'Categoría del Producto',
            'idMarca': 'Marca del Producto',
        }
        widgets = {
            'nombreProducto': forms.TextInput(attrs={'class': 'form-control'}),
            'precioProducto': forms.NumberInput(attrs={'class': 'form-control'}),
            'stockProducto': forms.NumberInput(attrs={'class': 'form-control'}),
            'imagenProducto': forms.ClearableFileInput(attrs={'class': 'form-control'}),
            'descripcionProducto': forms.Textarea(attrs={'class': 'form-control', 'rows': 4}),
            'idcategoriaProducto': forms.Select(attrs={'class': 'form-control'}),
            'idMarca': forms.Select(attrs={'class': 'form-control'}),
        }

class SeguimientoForm(forms.Form):
    numero_orden = forms.CharField(max_length=100, widget=forms.TextInput(attrs={"placeholder":"INGRESE NÚMERO DE PEDIDO"}))
    numero_orden.widget.attrs['class'] = 'text-center'
    numero_orden.label = ''

ESTADOS_PEDIDO = [
    ('EN PREPARACIÓN', 'EN PREPARACIÓN'),
    ('LISTO PARA ENVÍO', 'LISTO PARA ENVÍO'),
    ('EN REPARTO', 'EN REPARTO'),
    ('ENTREGADO', 'ENTREGADO'),
    ]

class EstadoPedido(forms.Form):
    pedido_numero = forms.CharField(widget=forms.HiddenInput())
    estado = forms.ModelChoiceField(queryset=Seguimiento.objects.all(), empty_label=None)

class CheckoutForm(forms.Form):
    nombre = forms.CharField(max_length=100)
    apellido = forms.CharField(max_length=100)
    direccion = forms.CharField(max_length=255)
    region = forms.ModelChoiceField(queryset=region.objects.all())
    comuna = forms.ModelChoiceField(queryset=comuna.objects.all())
    correo = forms.EmailField()




