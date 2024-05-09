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
from django.db import connection
from django.shortcuts import render
from django.db import connection
from django.http import HttpResponse
import base64

# VIEWS
def index(request):
	return render(request, 'core/index.html')

@login_required
def shop(request):
    try:
        # Llamar al procedimiento almacenado para obtener los productos 
        with connection.cursor() as cursor:
            cursor.callproc("SP_GET_PRODUCTOS", [""])
            productos = cursor.fetchall()
            
            for producto in productos:
                imagen_binaria = producto[3]
                imagen_base64 = base64.b64encode(imagen_binaria).decode('utf-8')
                producto[3] = f"data:image/jpeg;base64,{imagen_base64}"
        
    except Exception as e:
        print("Error al obtener los productos:", e)
        productos = []

    return render(request, 'core/shop.html', {'productos': productos})



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
    #TOMAR EL FORMULARIO DE FORM.PY
    form = RegisterForm()
    if request.method == 'POST':
        form = RegisterForm(request.POST)
        if form.is_valid():
            #SI FORMULARIO ES VALIDO SE GUARDA.
            form.save()
            return redirect("index")

    return render(request, 'registration/register.html', { 'form': form })

class CustomLoginView(LoginView):
    authentication_form = CustomAuthenticationForm
    template_name = 'registration/register.html'
    success_url = reverse_lazy('core/index.html')

    def form_valid(self, form):
        user = form.get_user()
        login(self.request, user)
        return super().form_valid(form)

#VISTAS CRUD PRODUCTOS (AÑADIR, ACTUALIZAR, ELIMINAR)
def addProduct(request):
    #Inicializar el formulario
    form = ProductForm() 
    if request.method == 'POST':
        form = ProductForm(request.POST, request.FILES)
        if form.is_valid():
            try:
                # Obtener los datos del formulario
                idProducto = form.cleaned_data['idProducto']
                nombreProducto = form.cleaned_data['nombreProducto']
                precioProducto = form.cleaned_data['precioProducto']
                imagenProducto = form.cleaned_data['imagenProducto']
                descripcionProducto = form.cleaned_data['descripcionProducto']
                idcategoriaProducto = form.cleaned_data['idcategoriaProducto']
                idmarcaProducto = form.cleaned_data['idmarcaProducto']
                
                # Llamar al procedimiento almacenado para insertar el producto
                with connection.cursor() as cursor:
                    cursor.callproc("SP_POST_PRODUCTO", [
                        idProducto,
                        nombreProducto,
                        precioProducto,
                        imagenProducto,  
                        descripcionProducto,
                        idcategoriaProducto,
                        idmarcaProducto,
                        [""]
                    ])
                
                # Redireccionar a shop.html después de la inserción exitosa
                return redirect("shop")
                
            except Exception as e:
                print("Error:", e)
    
    return render(request, 'core/addproduct.html', {'form': form})

    

    

