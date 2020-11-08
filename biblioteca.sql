-- Díaz, Agustín. Legajo: D-4094/1
-- Farizano, Juan Ignacio. Legajo: F-3562/9
-- Mellino, Natalia. Legajo: M-6686/9

-- Ejercicio 1

CREATE DATABASE IF NOT EXISTS Biblioteca;

USE Biblioteca;

DROP TABLE IF EXISTS Escribe;
DROP TABLE IF EXISTS Autor;
DROP TABLE IF EXISTS Libro;

CREATE TABLE Autor(
    ID            INT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    Nombre        VARCHAR(20)     NOT NULL,
    Apellido      VARCHAR(20)     NOT NULL,
    Nacionalidad  VARCHAR(20)     NOT NULL,
    Residencia    VARCHAR(20)     NOT NULL,
    PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE Libro(
    ISBN          int (13) UNSIGNED   NOT NULL,
    Titulo        VARCHAR(100)        NOT NULL,
    Editorial     VARCHAR(20)         NOT NULL,
    Precio        DECIMAL(8, 2)       NOT NULL,
    PRIMARY KEY (ISBN)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE Escribe(
    ID_autor       INT UNSIGNED   NOT NULL,
    ISBN_libro     INT UNSIGNED   NOT NULL,
    Año            INT UNSIGNED   NOT NULL,
    PRIMARY KEY (ID_Autor, ISBN_libro),
    FOREIGN KEY (ID_autor) REFERENCES Autor (ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ISBN_libro) REFERENCES Libro (ISBN) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Ejercicio 2

CREATE INDEX titulo_libro
ON Libro (Titulo);

CREATE INDEX apellido_autor
ON Autor (Apellido);


-- Ejercicio 3
INSERT INTO Autor VALUES(DEFAULT, 'Julio', 'Cortázar', 'Argentina', 'Buenos Aires');
INSERT INTO Autor VALUES(DEFAULT, 'Abelardo', 'Castillo', 'Argentina', 'Rosario');
INSERT INTO Autor VALUES(DEFAULT, 'Natalia', 'Mellino', 'Argentina', 'Buenos Aires');
INSERT INTO Autor VALUES(DEFAULT, 'Agustín', 'Díaz', 'Rusia', 'Moscú');
INSERT INTO Autor VALUES(DEFAULT, 'Juan Ignacio', 'Farizano', 'Francia', 'París');
INSERT INTO Autor VALUES(DEFAULT, 'Stephen', 'Kinga', 'Estados Unidos', 'Portland');
INSERT INTO Autor VALUES(DEFAULT, 'Eduardo', 'Galeano', 'Uruguay', 'Montevideo');


INSERT INTO Libro VALUES(420, 'LOTR', 'UNR', 62.73);
INSERT INTO Libro VALUES(42, 'Farry Potter y el misterio del recursado', 'Salamandra', 500);
INSERT INTO Libro VALUES(123, 'Cómo leer un libro', 'Anonymus', 999.99);
INSERT INTO Libro VALUES(1230, 'Rayuela', 'Alfaguara', 350);


INSERT INTO Escribe VALUES(5, 420, 1940);
INSERT INTO Escribe VALUES(3, 42, 2019);
INSERT INTO Escribe VALUES(4, 123, 1998);
INSERT INTO Escribe VALUES(1, 1230, 1967);

-- Ejercicio 4

-- a
UPDATE Autor
SET
    Residencia = 'Buenos Aires'
WHERE 
    Nombre = 'Abelardo' AND Apellido = 'Castillo';

-- b

UPDATE Libro
SET
    Precio = Precio * 1.1
WHERE
    Editorial = 'UNR';

-- c

UPDATE Libro
SET 
    Precio = Precio * 1.1
WHERE 
    Precio > 200 AND ISBN IN
                          (SELECT ISBN_Libro FROM Escribe 
                           WHERE ID_autor IN
                                          (SELECT ID From Autor 
                                           WHERE Nacionalidad <> 'Argentina'));

UPDATE Libro
SET 
    Precio = Precio * 1.2
WHERE 
    Precio <= 200 AND ISBN IN
                          (SELECT ISBN_Libro FROM Escribe 
                           WHERE ID_autor IN
                                          (SELECT ID From Autor 
                                           WHERE Nacionalidad <> 'Argentina'));


-- UPDATE Libro
-- JOIN Escribe ON Libro.ISBN = Escribe.ISBN_libro
-- JOIN Autor ON Escribe.ID_autor = Autor.ID
-- SET 
--     Libro.Precio = Libro.Precio * 1.1
-- WHERE 
--     Libro.Precio > 200 AND Autor.Nacionalidad <> 'Argentina'


-- UPDATE Libro
-- JOIN Escribe ON Libro.ISBN = Escribe.ISBN_libro
-- JOIN Autor ON Escribe.ID_autor = Autor.ID
-- SET 
--     Libro.Precio = Libro.Precio * 1.2
-- WHERE 
--     Libro.Precio <= 200 AND Autor.Nacionalidad <> 'Argentina'

-- d

DELETE FROM Libro
WHERE ISBN IN 
           (SELECT ISBN_libro FROM Escribe
           WHERE Año = 1998);
