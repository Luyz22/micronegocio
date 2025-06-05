<?php
// controlador/usuarios.php

// Configuración de errores (solo para desarrollo)
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Headers para API JSON
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Incluir archivo de conexión
require_once __DIR__ . '/../conexion/conexion.php';

try {
    $conexion = Conexion::obtenerConexion();
    
    // Obtener método HTTP
    $metodo = $_SERVER['REQUEST_METHOD'] ?? 'GET';
    $accion = $_GET['accion'] ?? '';

    if ($metodo === 'POST') {
        $datos = json_decode(file_get_contents('php://input'), true);
        
        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new Exception("Error en el formato de los datos");
        }

        switch ($accion) {
            case 'registrar':
                // Validar campos requeridos
                $camposRequeridos = ['nombre_completo', 'correo_electronico', 'contrasena', 'nombre_negocio', 'telefono'];
                foreach ($camposRequeridos as $campo) {
                    if (empty($datos[$campo])) {
                        throw new Exception("El campo $campo es requerido");
                    }
                }

                // Validar formato de email
                if (!filter_var($datos['correo_electronico'], FILTER_VALIDATE_EMAIL)) {
                    throw new Exception("Formato de email inválido");
                }

                // Validar fortaleza de contraseña
                if (strlen($datos['contrasena']) < 8) {
                    throw new Exception("La contraseña debe tener al menos 8 caracteres");
                }

                // Verificar si el email ya existe
                $stmt = $conexion->prepare("SELECT id_usuario FROM usuarios WHERE correo_electronico = ?");
                $stmt->execute([$datos['correo_electronico']]);
                
                   // En la sección donde verificas si el correo existe
                    if ($stmt->rowCount() > 0) {
                        http_response_code(409); // Conflict
                        
                        // Verificar si el usuario está activo
                        $stmt = $conexion->prepare("SELECT id_usuario FROM usuarios WHERE correo_electronico = ?");
                        $stmt->execute([$datos['correo_electronico']]);
                        $usuario = $stmt->fetch();
                        
                        $mensaje = 'El correo electrónico ya está registrado.';
                        $suggestion = '¿Quieres iniciar sesión o recuperar tu contraseña?';
                        
                        echo json_encode([
                            'success' => false,
                            'error' => $mensaje,
                            'suggestion' => $suggestion,
                            'email' => $datos['correo_electronico']
                        ]);
                    exit;
                }


                // Insertar nuevo usuario
                $stmt = $conexion->prepare("INSERT INTO usuarios 
                    (nombre_completo, correo_electronico, contrasena_hash, nombre_negocio, telefono) 
                    VALUES (?, ?, ?, ?, ?)");
                
                $resultado = $stmt->execute([
                    $datos['nombre_completo'],
                    $datos['correo_electronico'],
                    password_hash($datos['contrasena'], PASSWORD_DEFAULT),
                    $datos['nombre_negocio'],
                    $datos['telefono']
                ]);

                if ($resultado) {
                    echo json_encode([
                        'success' => true,
                        'message' => 'Usuario registrado exitosamente',
                        'user_id' => $conexion->lastInsertId()
                    ]);
                } else {
                    throw new Exception("Error al registrar el usuario");
                }
                break;

            default:
                throw new Exception("Acción no válida");
        }
    } else {
        throw new Exception("Método no permitido");
    }
// En el catch del try-catch principal, modifica:
} catch (Exception $e) {
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage(),
        'code' => $e->getCode(),
        'type' => get_class($e)
    ]);
    exit;
}
?>