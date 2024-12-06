 -- Consulta que identifica los hospitales donde se reportaron accidentes graves.
SELECT h.nombre, h.categoria
FROM hospitales h
WHERE h.id IN (
    -- Subconsulta que selecciona los hospitales asociados a ambulancias con accidentes graves
    SELECT DISTINCT a.hospital_id
    FROM ambulancia a
    JOIN formularioaccidente f ON a.id = f.ambulancia_id
    WHERE f.estado = 'grave'
);




-- Consulta para obtener el conteo de accidentes según la categoría de ambulancia.
SELECT a.categoria_ambulancia, COUNT(f.id) AS total_accidentes
FROM ambulancia a
LEFT JOIN formularioaccidente f ON a.id = f.ambulancia_id
GROUP BY a.categoria_ambulancia;



-- Consulta que lista pacientes atendidos en hospitales con alta capacidad.
SELECT f.nombre, f.estado
FROM formularioaccidente f
WHERE f.ambulancia_id IN (
    -- Subconsulta que obtiene ambulancias asignadas a hospitales con capacidad > 200
    SELECT a.id
    FROM ambulancia a
    JOIN hospitales h ON a.hospital_id = h.id
    WHERE h.capacidad_atencion > 200
);



-- Consulta para calcular el promedio de accidentes por hospital.
SELECT AVG(accidentes) AS promedio_accidentes
FROM (
    -- Subconsulta que cuenta los accidentes por cada hospital
    SELECT h.id, COUNT(f.id) AS accidentes
    FROM hospitales h
    LEFT JOIN ambulancia a ON h.id = a.hospital_id
    LEFT JOIN formularioaccidente f ON a.id = f.ambulancia_id
    GROUP BY h.id
) AS sub;



-- Consulta para encontrar las ubicaciones con más accidentes moderados.
SELECT f.ubicacion, COUNT(f.id) AS total
FROM formularioaccidente f
WHERE f.estado = 'moderado'
GROUP BY f.ubicacion
ORDER BY total DESC
LIMIT 5;



-- Consulta que determina el hospital con más ambulancias.
SELECT h.nombre, COUNT(a.id) AS total_ambulancias
FROM hospitales h
JOIN ambulancia a ON h.id = a.hospital_id
GROUP BY h.id
ORDER BY total_ambulancias DESC
LIMIT 1;




-- Consulta para listar accidentes del hospital menos capacitado.
SELECT f.*
FROM formularioaccidente f
WHERE f.ambulancia_id IN (
    -- Subconsulta que obtiene ambulancias del hospital con menor capacidad
    SELECT a.id
    FROM ambulancia a
    WHERE a.hospital_id = (
        SELECT h.id
        FROM hospitales h
        ORDER BY h.capacidad_atencion ASC
        LIMIT 1
    )
);




-- Consulta para calcular la proporción de estados en accidentes.
SELECT f.estado, COUNT(f.id) * 100.0 / (
    SELECT COUNT(*) FROM formularioaccidente
) AS porcentaje
FROM formularioaccidente f
GROUP BY f.estado;




-- Consulta para listar pacientes según categoría de ambulancia.
SELECT f.nombre, f.apellido
FROM formularioaccidente f
JOIN ambulancia a ON f.ambulancia_id = a.id
WHERE a.categoria_ambulancia = 'Medicalizada';




-- Consulta para encontrar hospitales sin ambulancias.
SELECT h.nombre
FROM hospitales h
WHERE NOT EXISTS (
    -- Subconsulta que verifica si hay ambulancias asignadas al hospital
    SELECT 1
    FROM ambulancia a
    WHERE a.hospital_id = h.id
);
