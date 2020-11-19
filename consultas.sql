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

SELECT Persona.nombre FROM Persona, Vendedor, Cliente, PrefiereZona
WHERE Persona.codigo = Vendedor.codigo
AND   Cliente.vendedor = Vendedor.codigo
AND   PrefiereZona.codigo_cliente = Cliente.codigo
AND   PrefiereZona.nombre_zona = 'Centro' AND PrefiereZona.nombre_poblacion = 'Rosario';

--TODO ELEGIR ENTRE ESTAS 2
-- CAPAZ SE PUEDE MEJORAR ESTA SACANDO ALGUNOS IN
SELECT Persona.nombre FROM Persona
WHERE Persona.codigo IN 
    (SELECT Vendedor.codigo FROM Vendedor
     WHERE Vendedor.codigo IN 
        (SELECT Cliente.codigo FROM  Cliente
         WHERE Cliente.codigo IN 
            (SELECT PrefiereZona.codigo_cliente FROM PrefiereZona
             WHERE nombre_zona = 'Centro' AND nombre_poblacion = 'Rosario')));

-- e

SELECT Zona.nombre_zona, COUNT(Inmueble.precio), AVG(Inmueble.precio) FROM Zona, Inmueble
WHERE Zona.nombre_zona = Inmueble.nombre_zona AND Zona.nombre_poblacion = Inmueble.nombre_poblacion
AND   Inmueble.nombre_poblacion = 'Rosario'
GROUP BY Zona.nombre_zona;

-- f

SELECT Persona.nombre From Persona, Cliente
WHERE Cliente.codigo = Persona.codigo
AND NOT EXISTS
    (SELECT * FROM Zona
     WHERE Zona.nombre_poblacion = "Santa Fe"
     AND Zona.nombre_zona NOT IN
                              (SELECT PrefiereZona.nombre_zona FROM PrefiereZona
                                WHERE PrefiereZona.codigo_cliente = Cliente.codigo 
                                AND PrefiereZona.nombre_poblacion = "Santa Fe"));