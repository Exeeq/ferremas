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

        # Crear variables de salida para el cursor y el valor
        cursor_productos = cursor.var(cx_Oracle.CURSOR)
        out = cursor.var(int)

        # Llamar al procedimiento almacenado con las variables de salida
        cursor.callproc("SP_GET_PRODUCTOS", (cursor_productos, out))

        # Obtener el valor de la variable de salida
        out_value = out.getvalue()

        # Verificar si el procedimiento se ejecutó correctamente
        if out_value == 1:
            # Obtener el cursor y los resultados
            cursor_productos_value = cursor_productos.getvalue()
            productos = cursor_productos_value.fetchall()
            for fila in productos:
                json = {
                    'idProducto': fila[0],
                    'nombreProducto': fila[1],
                    'precioProducto': fila[2],
                    'imagenProducto': fila[3],
                    'descripcionProducto': fila[4],
                    'stockProducto': fila[5],
                    'idMarca': fila[6],
                    'idcategoriaProducto': fila[7]
                }
                lista.append(json)
        else:
            print("El procedimiento almacenado no devolvió datos")
    except Exception as e:
        # Registra el error para fines de depuración
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





    

    

