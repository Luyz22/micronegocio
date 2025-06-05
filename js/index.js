const server = "controlador/sistema_gestion.php"

var app = angular.module('myApp', []);

app.controller('indexControlador', function($scope, $http){

    $(document).ready(function(){
        var d = new Date();
        var n = d.getFullYear();
        var m = d.getMonth()+1;

    });

    $scope.crearUsuario = function () {

        var formData = new FormData($("#register-form")[0]);

        if (!$scope.nombre_completo) {
            Swal.fire('Error!', 'El campo nombre completo no debe estar vacío.', 'error');
            return;
        } else if (!$scope.correo) {
            Swal.fire('Error!', 'El campo correo electronico no debe de estar vacio.', 'error');
            return;
        } else if (!$scope.nombre_negocio) {
            Swal.fire('Error!', 'El campo nombre del negocio no debe de estar vacio.', 'error');
            return;
        } else if (!$scope.telefono) {
            Swal.fire('Error!', 'El campo telefono no debe de estar vacio', 'error');
            return;
        } else if (!$scope.password) {
            Swal.fire('Error!', 'El campo contraseña no debe de estar vacio', 'error');
            return;
        } else if (!$scope.password_true) {
            Swal.fire('Error!', 'El campo confirmar contraseña no debe de estar vacio', 'error');
            return;
        } else if ($scope.password !== $scope.password_true) {
            Swal.fire('Error!', "Las contraseñas no son iguales", "warning")
            return
        }

        Swal.fire({
            title: 'Crear Usuario',
            text: "¿Está seguro de crear este usuario?",
            icon: "question",
            showCancelButton: true,
            cancelButtonColor: '#F44336',
            cancelButtonText: 'No, Cancelar!',
            confirmButtonColor: '#4CAF50',
            confirmButtonText: "Sí, Crear!",
        }).then((result) => {
            if (result.value) {
                formData.append('origen', 1);
                formData.append('nombre_completo', $scope.nombre_completo);
                formData.append('correo', $scope.correo);
                formData.append('nombre_negocio', $scope.nombre_negocio);
                formData.append('telefono', $scope.telefono);
                formData.append('password_true', $scope.password_true);

                $.ajax({
                    url: server,
                    type: "POST",
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        data = JSON.parse(data);
                        if (data.response === true) {
                            Swal.fire('Usuario Creado!', 'El usuario fue creado correctamente.', 'success');
                            $scope.Limpiar()
                        } else if (data.response === false) {
                            Swal.fire('Error!', 'Ocurrio un error al crear el usuario.', 'error');
                        }
                    },
                    error: function (data) {
                       console.log("El error es:", data);
                    }
                });
            } else {
                Swal.fire("Cancelado", "La acción se canceló", "info");
            }
        });    
    }

    $scope.login = function () {
        var formData = new FormData($("#formLogin")[0]);

        if (!$scope.user) {
            Swal.fire('Error!', 'El campo Usuario no debe estar vacío.', 'error');
            return;
        } else if (!$scope.pass) {
            Swal.fire('Error!', 'El campo Contraseña no debe de estar vacío.', 'error');
            return;
        }

        formData.append('origen', 2);
        formData.append('user', $scope.user);
        formData.append('pass', $scope.pass);

        $.ajax({
            url: server,
            type: "POST",
            data: formData,
            contentType: false,
            processData: false,
            success: function (data) {
                data = JSON.parse(data);
                if (data.response === true) {
                    // Swal.fire('Exito!', 'Inicio de sesion exitoso.', 'success');
                    $('#login_modal').modal('hide');
                    window.location.href = data.redirect;
                } else if (data.response === false) {
                    Swal.fire('Error!', 'Credenciales Incorrectas.', 'error');
                }
            },
            error: function (data) {
                console.log("El error es:", data);
            }
        });
    }

    $scope.Limpiar = function() {
        $scope.nombre_completo = "";
        $scope.correo = "";
        $scope.nombre_negocio = "";
        $scope.telefono = "";
        $scope.password = "";
        $scope.password_true = "";
        $scope.password = "";
    }

    $scope.abrirModalLogin = function() {
        $('#login_modal').modal('show');
    }

})