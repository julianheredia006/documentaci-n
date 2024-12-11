-- Consulta 1: Ocupación por categoría de ambulancia
SELECT a.categoria_ambulancia, COUNT(*) AS cantidad_asignaciones
FROM ambulancia a
WHERE EXISTS (
    -- Verifica si la ambulancia tiene asignaciones registradas
    SELECT 1
    FROM asignacion_ambulancia aa
    WHERE aa.ambulancia_id = a.id
)
GROUP BY a.categoria_ambulancia; -- Agrupa por categoría de ambulancia para contar las asignaciones

-- Consulta 2: Hospital con más ambulancias asignadas
SELECT h.nombre, COUNT(a.id) AS ambulancias_asignadas
FROM hospitales h
JOIN ambulancia a ON h.id = a.hospital_id
WHERE EXISTS (
    -- Verifica si las ambulancias están asignadas
    SELECT 1
    FROM asignacion_ambulancia aa
    WHERE aa.ambulancia_id = a.id
)
GROUP BY h.nombre -- Agrupa por nombre del hospital
ORDER BY ambulancias_asignadas DESC -- Ordena por el número de ambulancias asignadas
LIMIT 1; -- Obtiene solo el hospital con más ambulancias asignadas

-- Consulta 3: Cantidad de reportes de accidentes por estado
SELECT fa.estado, COUNT(*) AS total_reportes
FROM formularioaccidente fa
WHERE EXISTS (
    -- Verifica si el reporte está asociado a una ambulancia existente
    SELECT 1
    FROM ambulancia a
    WHERE a.id = fa.ambulancia_id
)
GROUP BY fa.estado; -- Agrupa por estado del reporte

-- Consulta 4: Personal con más asignaciones
SELECT p.nombre, COUNT(aa.id) AS asignaciones
FROM personal p
JOIN asignacion_ambulancia aa ON p.id = aa.personal_id
GROUP BY p.nombre -- Agrupa por nombre del personal
ORDER BY asignaciones DESC -- Ordena en orden descendente por la cantidad de asignaciones
LIMIT 1; -- Selecciona al personal con más asignaciones


-- Consulta 5: Reporte de accidentes recientes por categoría de ambulancia
SELECT a.categoria_ambulancia, COUNT(fa.id) AS accidentes
FROM ambulancia a
JOIN formularioaccidente fa ON a.id = fa.ambulancia_id
WHERE fa.fecha_reporte >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) -- Filtra reportes en los últimos 7 días
GROUP BY a.categoria_ambulancia; -- Agrupa por categoría de ambulancia

-- Consulta 6: Capacidad de hospitales con ambulancias activas
SELECT h.nombre, h.capacidad_atencion, COUNT(a.id) AS ambulancias_activas
FROM hospitales h
JOIN ambulancia a ON h.id = a.hospital_id
WHERE EXISTS (
    -- Verifica si las ambulancias están asignadas
    SELECT 1
    FROM asignacion_ambulancia aa
    WHERE aa.ambulancia_id = a.id
)
GROUP BY h.nombre, h.capacidad_atencion; -- Agrupa por hospital para contar ambulancias activas

-- Consulta 7: Email del personal con roles específicos asignados a ambulancias
SELECT DISTINCT p.email
FROM personal p
WHERE p.id IN (
    -- Selecciona el personal que tiene asignaciones registradas
    SELECT aa.personal_id
    FROM asignacion_ambulancia aa
) 
AND p.personal_rol IN ('CONDUCTOR', 'PARAMEDICO'); -- Filtra por roles específicos del personal

-- Consulta 8: Porcentaje de ambulancias activas por categoría
SELECT a.categoria_ambulancia, 
       (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ambulancia)) AS porcentaje_activo
FROM ambulancia a
WHERE EXISTS (
    -- Verifica si la ambulancia está asignada
    SELECT 1
    FROM asignacion_ambulancia aa
    WHERE aa.ambulancia_id = a.id
)
GROUP BY a.categoria_ambulancia; -- Agrupa por categoría de ambulancia

-- Consulta 9: Hospital con menor capacidad disponible y ambulancias asignadas
SELECT h.nombre, h.capacidad_atencion - COUNT(a.id) AS capacidad_restante
FROM hospitales h
JOIN ambulancia a ON h.id = a.hospital_id
WHERE EXISTS (
    -- Verifica si las ambulancias están asignadas
    SELECT 1
    FROM asignacion_ambulancia aa
    WHERE aa.ambulancia_id = a.id
)
GROUP BY h.nombre, h.capacidad_atencion -- Agrupa por hospital
ORDER BY capacidad_restante ASC -- Ordena por capacidad restante en orden ascendente
LIMIT 1; -- Selecciona el hospital con menor capacidad restante

-- Consulta 10: Detalle de accidentes no atendidos por hospital
SELECT h.nombre, COUNT(fa.id) AS accidentes_no_atendidos
FROM hospitales h
JOIN ambulancia a ON h.id = a.hospital_id
JOIN formularioaccidente fa ON a.id = fa.ambulancia_id
WHERE fa.estado = 'Pendiente' -- Filtra reportes de accidentes no atendidos
GROUP BY h.nombre; -- Agrupa por nombre del hospital
