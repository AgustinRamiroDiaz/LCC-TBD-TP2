-- Díaz, Agustín. Legajo: D-4094/1
-- Farizano, Juan Ignacio. Legajo: F-3562/9
-- Mellino, Natalia. Legajo: M-6686/9

-- Ejercicio 5

-- a

SELECT nombre FROM Persona
WHERE Persona.codigo IN
                     (SELECT Propietario.codigo FROM Propietario);

-- b

SELECT codigo FROM Inmueble
WHERE precio >= 600000 AND precio <= 700000;

-- c

SELECT nombre FROM Persona
WHERE Persona.codigo IN
                     (SELECT Cliente.codigo FROM Cliente
                      WHERE Cliente.codigo NOT  IN
                                           (SELECT codigo_cliente FROM PrefiereZona
                                            WHERE NOT (nombre_poblacion = "Santa Fe" AND nombre_zona = "Norte")));

-- d

SELECT DISTINCT Persona.nombre FROM Persona
JOIN Vendedor ON Persona.codigo = Vendedor.codigo
JOIN Cliente ON Cliente.vendedor = Vendedor.codigo
JOIN PrefiereZona ON PrefiereZona.codigo_cliente = Cliente.codigo
WHERE PrefiereZona.nombre_zona = 'Centro' AND PrefiereZona.nombre_poblacion = 'Rosario';

-- e

SELECT Zona.nombre_zona, COUNT(Inmueble.precio), AVG(Inmueble.precio) FROM Zona
JOIN Inmueble ON Zona.nombre_zona = Inmueble.nombre_zona AND Zona.nombre_poblacion = Inmueble.nombre_poblacion
WHERE Inmueble.nombre_poblacion = 'Rosario'
GROUP BY Zona.nombre_zona;

-- f

SELECT Persona.nombre From Persona
JOIN Cliente ON Cliente.codigo = Persona.codigo
WHERE NOT EXISTS
    (SELECT * FROM Zona
     WHERE Zona.nombre_poblacion = "Santa Fe"
     AND Zona.nombre_zona NOT IN
                              (SELECT PrefiereZona.nombre_zona FROM PrefiereZona
                                WHERE PrefiereZona.codigo_cliente = Cliente.codigo AND PrefiereZona.nombre_poblacion = "Santa Fe"));