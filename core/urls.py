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

    #CARRITO DE COMPRAS:
    path('agregar/<idProducto>/', agregar_al_carrito, name='agregar_al_carrito'),
    path('eliminar_del_carrito/<int:itemcarrito_id>/', eliminar_del_carrito, name='eliminar_del_carrito'),

    #PEDIDO
    path('crear_pedido/', crear_pedido, name='crear_pedido'),
    path('boleta/<numero_pedido>', boleta, name='boleta'),

    #MIS PEDIDOS
    path('mis_pedidos/', mis_pedidos, name="mis_pedidos"),

    #ADMINISTRAR PEDIDOS:
    path('administrar_pedidos/', administrar_pedidos, name="administrar_pedidos"),
    path('cambiar_estado/<str:numero_orden>/', cambiar_estado, name='cambiar_estado'),

    #SOPORTE CONTACTO:
    path('soporte_contacto', soporte_contacto, name="soporte_contacto"),
    path('generar_informes', generar_informes, name="generar_informes")
]

