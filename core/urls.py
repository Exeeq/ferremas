from django.urls import path, include
from .views import *
from .views import CustomLoginView
from django.conf import settings
from django.contrib.staticfiles.urls import static

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

    #URLS CRUD PRODUCTOS (AÑADIR, ACTUALIZAR, ELIMINAR):
    path('addProduct/', addProduct, name="addProduct"),
    path('detalle_producto/<int:idProducto>/', detalle_producto, name='detalle_producto'),
    path('producto/<int:idProducto>/modificar/', modificar_producto, name='modificar_producto'),
    path('producto/<int:idProducto>/eliminar/', eliminar_producto, name='eliminar_producto'),

    #PANEL DE ADMINISTRACIÓN (ROL ADMINISTRADOR):
    path('panel_administracion/', panel_administracion, name='panel_administracion'),

    #GESTIÓN DE USUARIOS
    path('gestion_usuarios/', gestion_usuarios, name='gestion_usuarios'),
    path('adduser/', add_user, name="adduser"),
    path('eliminar_usuario/<id>/', eliminar_usuario, name='eliminar_usuario'),
    path('<p_id>/modificar_usuario/', modificar_usuario, name='modificar_usuario'),


]

