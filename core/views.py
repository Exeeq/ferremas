from django.shortcuts import render, redirect
from .models import *
from .forms import *
from django.contrib.auth import get_user_model


# VIEWS
def index(request):
	return render(request, 'core/index.html')

def shop(request):
	return render(request, 'core/shop.html')

def about(request):
	return render(request, 'core/about.html')

def services(request):
	return render(request, 'core/services.html')

def contact(request):
	return render(request, 'core/contact.html')

def cart(request):
	return render(request, 'core/cart.html')

def checkout(request):
	return render(request, 'core/checkout.html')

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
