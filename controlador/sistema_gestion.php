<?php
header("Access-Control-Allow-Origin: *");
// header("Content-Type: application/json; charset=UTF-8");

include("../conexion/conexion.php");
include("../modelos/sistema_gestion.php");

@$metodo = $_GET['metodo'];
if (isset($metodo)) {
    //PARA METODOS GET CONSULTAR INFO
    switch($metodo) {
        case "getEjemplo":
        break;
    }
}else{
    $origen = (int)$_POST["origen"];
    //PARA METODOS POST INSERTAR, ACTUALIZAR, ELIMINAR INFO
    switch ($origen) {
        case 1:
            $response = crear_usuario($conn);

            mysqli_close($conn);

            echo json_encode($response);
        break;
        case 2:
            $usuario = $_POST['user'];
            $contrasena = $_POST['pass'];

            $response = login_sistema($conn, $usuario, $contrasena);

            mysqli_close($conn);

            echo json_encode($response);
        break;
    }
}
?>