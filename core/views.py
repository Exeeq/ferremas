from django.shortcuts import render, redirect
from .models import *
from .forms import *
from django.contrib.auth import get_user_model
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AuthenticationForm



# VIEWS
def index(request):
	return render(request, 'core/index.html')

@login_required
def shop(request):
	return render(request, 'core/shop.html')

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
            form.save()
            return redirect("index")

    return render(request, 'registration/register.html', { 'form': form })

def login_view(request):
    if request.method == 'POST':
        form = CustomAuthenticationForm(request, request.POST)
        if form.is_valid():
            # Autenticar al usuario
            return redirect('index')  # Redirigir a la página de inicio
    else:
        form = CustomAuthenticationForm(request)
    return render(request, 'tu_template.html', {'form': form})
