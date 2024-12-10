<?php
if (isset($_POST['correo']) && isset($_POST['contraseña'])) {
    $usuario = $_POST['correo'];
    $contraseña = $_POST['contraseña'];
    session_start();
    $_SESSION['usuario'] = $usuario;
    
    // Conexión a la base de datos
    $conexion = mysqli_connect("localhost", "root", "", "ambusos");
    
    if (!$conexion) {
        die("Error de conexión: " . mysqli_connect_error());
    }
    
    $consulta = "SELECT * FROM personal WHERE correo='$usuario' AND contraseña='$contraseña'";
    $resultado = mysqli_query($conexion, $consulta);
    
    if ($resultado && $filas = mysqli_fetch_array($resultado)) {
        switch ($filas['rol_id']) {
            case 1: // Administrador
                header("location: ../Fronent/gestion.html");
                exit();
            case 2: // Cliente
                header("location: ../Fronent/tabla_auxilio.html");
                exit();
            case 3: // Conductor
                header("location: ../Fronent/apartados_ambu.html");
                exit();
            case 4: // Paramédico
                header("location: ../Fronent/terminos.html");
                exit();
            default:
                echo '<h1 class="bad">ERROR EN LA AUTENTIFICACION</h1>';
                break;
        }
    } else {
        echo '<h1 class="bad">ERROR EN LA AUTENTIFICACION</h1>';
    }
    
    mysqli_free_result($resultado);
    mysqli_close($conexion);
} else {
    echo "Por favor, complete los campos.";
}
?>
