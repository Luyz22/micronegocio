<?php
   header('Access-Control-Allow-Origin: *');
        header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
        header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');

   include("/conexion/conexion.php");


// Obtener datos
$data = json_decode(file_get_contents("php://input"), true);

if ($data && $data['action'] === 'registrar') {
    $name = $data['name'];
    $email = $data['email'];
    $business = $data['business'];
    $phone = $data['phone'];
    $password = password_hash($data['password'], PASSWORD_DEFAULT); // Cifrado seguro

    if ($conn->connect_error) {
        echo json_encode(['success' => false, 'message' => 'Error de conexión']);
        exit;
    }

    $stmt = $conn->prepare("INSERT INTO usuarios (nombre_completo, email, password_hash, telefono) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("sssss", $name, $email, $password, $phone);

    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Error al registrar']);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Solicitud inválida']);
}

?>
