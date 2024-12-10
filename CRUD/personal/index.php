<?php
include("connection.php");
$con = connection();

$sql = "SELECT * FROM personal";
$query = mysqli_query($con, $sql);
?> 

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Personal</title>
    <link rel="stylesheet" href="personal.css"> <!-- Asegura que esta ruta sea correcta -->
</head>
<body>
    <div class="container">
        <h1>Gestión de Personal</h1>
        
        <!-- Contenedor del formulario -->
      <!-- Formulario para agregar nuevo personal -->
<div class="form-container">
    <form action="insert_user.php" method="POST">
        <input type="text" name="nombre" placeholder="Nombre" required>
        <input type="text" name="apellido" placeholder="Apellido" required>
        <input type="text" name="numero_documento" placeholder="Documento" required>
        
        <select name="estado">
            <option value="Activo">Activo</option>
            <option value="Inactivo">Inactivo</option>
        </select>
        
        <input type="email" name="correo" placeholder="Correo" required>
        <input type="password" name="contraseña" placeholder="Contraseña" required>

        <!-- Menú desplegable para el Rol ID con opciones "1" y "2" -->
        <select name="rol_id" required>
            <option value="1">1</option>
            <option value="2">2</option>
        </select>
        
        <button type="submit">Agregar Personal</button>
    </form>
</div>


        <!-- Contenedor de la tabla -->
        <div class="table-container">
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Documento</th>
                    <th>Estado</th>
                    <th>Correo</th>
                    <th>Rol</th>
                    <th>Acciones</th>
                </tr>
                <?php while($row = mysqli_fetch_array($query)): ?>
                <tr>
                    <td><?php echo $row['id']; ?></td>
                    <td><?php echo $row['nombre']; ?></td>
                    <td><?php echo $row['apellido']; ?></td>
                    <td><?php echo $row['numero_documento']; ?></td>
                    <td><?php echo $row['estado']; ?></td>
                    <td><?php echo $row['correo']; ?></td>
                    <td><?php echo $row['rol_id']; ?></td>
                    <td>
                        <a href="edit_user.php?id=<?php echo $row['id']; ?>">Editar</a>
                        <a href="delete_user.php?id=<?php echo $row['id']; ?>" onclick="return confirm('¿Estás seguro de eliminar este registro?');">Eliminar</a>
                    </td>
                </tr>
                <?php endwhile; ?>
            </table>
        </div>
    </div>
</body>
</html>
