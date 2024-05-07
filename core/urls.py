from django.urls import path, include
from .views import *
from .views import CustomLoginView

urlpatterns = [
    path('', index, name="index"),
    path('shop/', shop, name="shop"),
    path('about/', about, name="about"),
    path('services/', services, name="services"),
    path('contact/', contact, name="contact"),
    path('cart/', cart, name="cart"),
    path('checkout/', checkout, name="checkout"),
    path('thankyou/', thankyou, name="thankyou"),
    path('register/', register, name="register"),

]

