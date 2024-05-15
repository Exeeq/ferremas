from django.shortcuts import render, redirect
from .models import *
from .forms import *
from django.contrib.auth import login
from django.contrib.auth.decorators import login_required
from django.contrib.auth.views import LoginView
from django.urls import reverse_lazy
from .forms import CustomAuthenticationForm
from django.shortcuts import render
from django.db import connection
from django.urls import reverse
from django.conf import settings
from django.shortcuts import render, redirect, get_object_or_404

# VIEWS
def index(request):
	return render(request, 'core/index.html')

@login_required
def shop(request):

    data = {
        'listado': lista_productos(),
        'MEDIA_URL': settings.MEDIA_URL,
    }
    return render(request, 'core/shop.html', data)

def about(request):
	return render(request, 'core/about.html')

def services(request):
	return render(request, 'core/services.html')

@login_required
def contact(request):
	return render(request, 'core/contact.html')

@login_required
def cart(request):
	return render(request, 'core/cart.html')

@login_required
def checkout(request):
	return render(request, 'core/checkout.html')

@login_required
def thankyou(request):
	return render(request, 'core/thankyou.html')

def register(request):
    form = RegisterForm()
    if request.method == 'POST':
        form = RegisterForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            # Asignar el rol por defecto Cliente
            user.idRol = rolUsuario.objects.get(nombreRol='Cliente')
            user.idComuna = form.cleaned_data['comuna']
            user.save()
            return redirect("index")

    return render(request, 'registration/register.html', {'form': form})

class CustomLoginView(LoginView):
    authentication_form = CustomAuthenticationForm
    template_name = 'registration/register.html'
    success_url = reverse_lazy('core/index.html')

    def form_valid(self, form):
        user = form.get_user()
        login(self.request, user)
        return super().form_valid(form)

def handle_uploaded_file(f):
    with open('media/productos/' + f.name, 'wb+') as destination:
        for chunk in f.chunks():
            destination.write(chunk)

#VISTAS CRUD PRODUCTOS (AÑADIR, ACTUALIZAR, ELIMINAR)
def addProduct(request):
    if request.method == 'POST':
        form = ProductoForm(request.POST, request.FILES)
        if form.is_valid():
            nombreProducto = form.cleaned_data['nombreProducto']
            precioProducto = form.cleaned_data['precioProducto']
            stockProducto = form.cleaned_data['stockProducto']
            imagenProducto = request.FILES['imagenProducto']
            descripcionProducto = form.cleaned_data['descripcionProducto']
            idcategoriaProducto = form.cleaned_data['idcategoriaProducto'].pk  
            idMarca = form.cleaned_data['idMarca'].pk  

            with open('media/productos/' + imagenProducto.name, 'wb+') as destination:
                for chunk in imagenProducto.chunks():
                    destination.write(chunk)
                    
            error_msg = agregar_producto(nombreProducto, precioProducto, stockProducto, imagenProducto.name, descripcionProducto, idcategoriaProducto, idMarca)
            if error_msg:
                form.save()
                return render(request, 'core/shop.html', {'form': form, 'error_msg': error_msg})
            else:
                return redirect("shop")

    else:
        form = ProductoForm()
    return render(request, 'core/addproduct.html', {'form': form})


#LISTAR PRODUCTOS:
def lista_productos():
    django_cursor = connection.cursor()
    cursor = django_cursor.connection.cursor()

    cursor.callproc("SP_GET_PRODUCTOS", [""])

    lista = []
    for fila in cursor:
         lista.append(fila)

    return lista

def agregar_producto(nombreProducto, precioProducto, stockProducto, imagenProducto, descripcionProducto, idcategoriaProducto, idMarca):
    try:
        django_cursor = connection.cursor()
        cursor = django_cursor.connection.cursor()

        # Llamar al procedimiento almacenado
        cursor.callproc("SP_POST_PRODUCTO", [nombreProducto, precioProducto, stockProducto, imagenProducto, descripcionProducto, idcategoriaProducto, idMarca])
        return None 
    
    except Exception as e:
        error_msg = "Hubo un error al agregar el producto. Por favor, inténtalo de nuevo más tarde."
        print("ERROR EN AGREGAR PRODUCTO: ", e)
        return error_msg
    
def detalle_producto(request, idProducto):
    producto_instance = producto.objects.get(idProducto=idProducto) 
    data = {
         'producto':producto_instance,
         'MEDIA_URL': settings.MEDIA_URL,
    }
    return render(request, 'core/detalle_producto.html', data)

def modificar_producto(request, idProducto):
    producto_instance = producto.objects.get(idProducto=idProducto) 
    if request.method == 'POST':
        form = ProductoForm(request.POST, instance=producto_instance)
        if form.is_valid():
            # Obtener los datos del formulario
            nombreProducto = form.cleaned_data['nombreProducto']
            precioProducto = form.cleaned_data['precioProducto']
            stockProducto = form.cleaned_data['stockProducto']
            imagenProducto = form.cleaned_data['imagenProducto']
            descripcionProducto = form.cleaned_data['descripcionProducto']
            idMarca = form.cleaned_data['idMarca'].pk
            idcategoriaProducto = form.cleaned_data['idcategoriaProducto'].pk
            
            # Llamar al procedimiento almacenado para actualizar el producto
            with connection.cursor() as cursor:
                cursor.callproc('SP_PUT_PRODUCTO', [
                    idProducto,
                    nombreProducto,
                    precioProducto,
                    stockProducto,
                    imagenProducto,
                    descripcionProducto,
                    idMarca,
                    idcategoriaProducto
                ])
            return redirect('detalle_producto', idProducto=idProducto)
    else:
        form = ProductoForm(instance=producto_instance)  
    return render(request, 'core/modificar_producto.html', {'form': form})

def eliminar_producto(request, idProducto):
    with connection.cursor() as cursor:
        cursor.callproc('SP_DELETE_PRODUCTO', [idProducto])
    return redirect(to='shop')


#PANEL DE ADMINISTRACIÓN (ROL ADMINISTRADOR):
def panel_administracion(request):
    return render(request, 'core/panel_administracion.html') 

def gestion_usuarios(request):
    data = {
        'usuarios': lista_usuarios()
    }
    return render(request, 'core/gestion_usuarios.html', data)

def lista_usuarios():
    django_cursor = connection.cursor()
    cursor = django_cursor.connection.cursor()

    cursor.callproc("SP_GET_USUARIOS", [""])
    lista = []
    for fila in cursor:
         lista.append(fila)
    return lista



