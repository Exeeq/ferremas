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
    data = {
        'listado': lista_productos()
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
            descripcionProducto = form.cleaned_data['descripcionProducto']
            idMarca = form.cleaned_data['idMarca'].idMarca
            idcategoriaProducto = form.cleaned_data['idcategoriaProducto'].idcategoriaProducto
            stockProducto = form.cleaned_data['stockProducto']
            imagenProducto = form.cleaned_data['imagenProducto']
            
            if imagenProducto: 
                imagen_path = default_storage.save('productos/' + imagenProducto.name, imagenProducto)
            else:
                imagen_path = ""

            try:
                cursor = connection.cursor()
                out = cursor.var(cx_Oracle.NUMBER)
                cursor.callproc("SP_POST_PRODUCTO", [None,
                                                     nombreProducto,
                                                     precioProducto,
                                                     imagen_path,
                                                     descripcionProducto,
                                                     idMarca,
                                                     idcategoriaProducto,
                                                     stockProducto,
                                                     ""])
                
                connection.commit()
                form.save()
                redirect(to="shop")
                    
            except Exception as e:
                print(f"ERROR EN ADDPRODUCTO: {e}")
    else:
        form = ProductoForm()
    return render(request, 'core/addproduct.html', {'form': form})


#LISTAR PRODUCTOS:
def lista_productos():
    django_cursor = connection.cursor()
    cursor = django_cursor.connection.cursor()
    out_cur = django_cursor.connection.cursor()

    cursor.callproc("SP_GET_PRODUCTOS", [out_cur])

    lista = []
    for fila in out_cur:
         lista.append(fila)

    return lista    
    



    

    

