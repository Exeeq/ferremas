from django.shortcuts import render, redirect
from .models import *
from .forms import *
from django.contrib.auth import get_user_model
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth import login
from django.contrib.auth.views import LoginView
from django.urls import reverse_lazy
from .forms import CustomAuthenticationForm
from django.shortcuts import render
from django.db import connection
import cx_Oracle
import oracledb
from django.core.files.storage import default_storage

# VIEWS
def index(request):
	return render(request, 'core/index.html')

@login_required
def shop(request):
    lista = []
    try:
        cursor = connection.cursor()
        cursor_productos = cursor.var(oracledb.CURSOR)
        out = cursor.var(int)
        cursor.callproc("SP_GET_PRODUCTOS",[cursor_productos, out])
        if out.getvalue() == 1:
            for fila in cursor_productos.getvalue():
                json = {}
                json['idProducto'] = fila[0]
                json['nombreProducto'] = fila[1]
                json['precioProducto'] = fila[2]
                json['stockProducto'] = fila[3]
                json['imagenProducto'] = fila[4]
                json['idMarca'] = fila[5]
                json['idcategoriaProducto'] = fila[6]
                lista.append(json)
                print("JSON:", json)  
                print("LISTA:", lista)  
            return render(request, 'core/shop.html', {'productos': lista}) 
    except Exception as e:
        print("ERROR EN SHOP: ", e)

    return render(request, 'core/shop.html', {'productos': lista})

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
            descripcionProducto = form.cleaned_data['descripcionProducto']
            idMarca = form.cleaned_data['idMarca'].idMarca
            idcategoriaProducto = form.cleaned_data['idcategoriaProducto'].idcategoriaProducto
            stockProducto = form.cleaned_data['stockProducto']
            imagenProducto = form.cleaned_data['imagenProducto']
            imagen_path = default_storage.save('productos/' + imagenProducto.name, imagenProducto)
            
        try:
            cursor = connection.cursor()
            out = cursor.var(int)
            cursor.callproc("SP_GET_POST",[nombreProducto, precioProducto, descripcionProducto, idMarca, idcategoriaProducto, stockProducto, imagen_path, out])
            if out.getvalue()==1:
                connection.commit()
        except Exception as e:
            print("ERROR EN ADDPRODUCTO: ", e)

    else:
        form = ProductoForm()
    return render(request, 'core/addproduct.html', {'form': form})





    

    

