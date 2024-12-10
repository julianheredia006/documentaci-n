<?php
include("connection.php");
$con = connection();

if (isset($_GET['id'])) {
    // Obtener el ID desde la URL
    $id = $_GET['id'];

    // Consulta para obtener los datos del usuario específico
    $sql = "SELECT * FROM personal WHERE id='$id'";
    $query = mysqli_query($con, $sql);
    $row = mysqli_fetch_array($query);
}

if (isset($_POST['update'])) {
    // Capturar los datos del formulario editado
    $id = $_POST["id"];
    $nombre = $_POST['nombre'];
    $apellido = $_POST['apellido'];
    $numero_documento = $_POST['numero_documento'];
    $estado = $_POST['estado'];
    $correo = $_POST['correo'];
    $contraseña = $_POST['contraseña'];
    $rol_id = $_POST['rol_id'];

    // Consulta para actualizar los datos en la tabla personal
    $sql = "UPDATE personal SET nombre='$nombre', apellido='$apellido', numero_documento='$numero_documento', estado='$estado', correo='$correo', contraseña='$contraseña', rol_id='$rol_id' WHERE id='$id'";
    $query = mysqli_query($con, $sql);

    if ($query) {
        Header("Location: index.php");
    } else {
        echo "Error al actualizar el registro";
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="personal.css">
    <title>Editar Personal</title>
</head>
<body>

    <h1>Editar Personal</h1>
    <form action="edit_user.php" method="POST">
        <input type="hidden" name="id" value="<?php echo $row['id']; ?>">
        
        <label>Nombre:</label>
        <input type="text" name="nombre" value="<?php echo $row['nombre']; ?>" required>
        
        <label>Apellido:</label>
        <input type="text" name="apellido" value="<?php echo $row['apellido']; ?>" required>
        
        <label>Documento:</label>
        <input type="text" name="numero_documento" value="<?php echo $row['numero_documento']; ?>" required>
        
        <label>Estado:</label>
        <select name="estado">
            <option value="Activo" <?php echo ($row['estado'] == 'Activo') ? 'selected' : ''; ?>>Activo</option>
            <option value="Inactivo" <?php echo ($row['estado'] == 'Inactivo') ? 'selected' : ''; ?>>Inactivo</option>
        </select>
        
        <label>Correo:</label>
        <input type="email" name="correo" value="<?php echo $row['correo']; ?>" required>
        
        <label>Contraseña:</label>
        <input type="password" name="contraseña" value="<?php echo $row['contraseña']; ?>" required>
        
        <label>Rol ID:</label>
        <select name="rol_id" required>
            <option value="1" <?php echo ($row['rol_id'] == '1') ? 'selected' : ''; ?>>1</option>
            <option value="2" <?php echo ($row['rol_id'] == '2') ? 'selected' : ''; ?>>2</option>
        </select>
        
        <button type="submit" name="update">Actualizar</button>
    </form>
</body>
</html>
