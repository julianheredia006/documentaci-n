<?php
include("connection.php");
$con = connection();

$id = $_POST["id"];
$nombre = $_POST['nombre'];
$apellido = $_POST['apellido'];
$numero_documento = $_POST['numero_documento'];
$estado = $_POST['estado'];
$correo = $_POST['correo'];
$contraseña = $_POST['contraseña'];
$rol_id = $_POST['rol_id'];

$sql = "UPDATE personal SET nombre='$nombre', apellido='$apellido', numero_documento='$numero_documento', estado='$estado', correo='$correo', contraseña='$contraseña', rol_id='$rol_id' WHERE id='$id'";
$query = mysqli_query($con, $sql);

if($query){
    Header("Location: index.php");
} else {
    echo "Error al actualizar el registro";
}
?>
