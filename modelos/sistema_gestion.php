<?php
    function crear_usuario($conn) {

        $nombre_completo = $_POST['nombre_completo'];
        $correo = $_POST['correo'];
        $nombre_negocio = $_POST['nombre_negocio'];
        $telefono = $_POST['telefono'];
        $password_true = $_POST['password_true'];

        $sql_insertar = "INSERT INTO usuarios       (nombre_completo,
                                                        correo_electronico, 
                                                        nombre_negocio, 
                                                        telefono, 
                                                        contrasena_hash) 
                                                VALUES ('$nombre_completo', 
                                                        '$correo', 
                                                        '$nombre_negocio', 
                                                        '$telefono',  
                                                        '$password_true')";

        if (mysqli_query($conn, $sql_insertar)) {
            return [
                    "response" => true,
                    "message" => "Usuario creado con exito"
                ];
            } else {
               return [
                    "response" => false,
                    "message" => "Error al crear el usuario"
               ];
            }
    }

    function login_sistema($conn, $usuario, $contrasena) {
        $sql = "SELECT * FROM usuarios WHERE nombre_completo = '$usuario' AND contrasena_hash = '$contrasena'";

        $resultado = mysqli_query($conn, $sql);

        if (!$resultado) {
            return [
                'response' => false,
                'error' => 'Error en la consulta SQL'
            ];
        }

        if (mysqli_num_rows($resultado) > 0) {
            return [
                'response' => true,
                'redirect' => 'http://localhost/sistema_gestion/dashboard.html'
            ];
        } else {
            return [
                'response' => false,
                'error' => 'Credenciales incorrectas'
            ];
        }
    }
?>