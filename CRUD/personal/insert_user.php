<?php
include("connection.php");
$con = connection();

$id = null;
$nombre = $_POST['nombre'];
$apellido = $_POST['apellido'];
$numero_documento = $_POST['numero_documento'];
$estado = $_POST['estado'];
$correo = $_POST['correo'];
$contraseña = $_POST['contraseña'];
$rol_id = $_POST['rol_id'];

$sql = "INSERT INTO personal (id, nombre, apellido, numero_documento, estado, correo, contraseña, rol_id) VALUES('$id', '$nombre', '$apellido', '$numero_documento', '$estado', '$correo', '$contraseña', '$rol_id')";
$query = mysqli_query($con, $sql);

if($query){
    Header("Location: index.php");
} else {
    echo "Error al insertar el registro";
}
?>
