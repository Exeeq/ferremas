function eliminarProductoCarrito(id) {
    Swal.fire({
        title: '¿Desea eliminar este Producto del carrito?',
        icon: 'warning', 
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Confirmar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire('Eliminado!', 'Producto Eliminado Correctamente', 'success').then(function() {
                window.location.href = "/eliminar_del_carrito/" + id + "/";
            });
        }
    });
}

