CREATE DATABASE IF NOT EXISTS `Biblioteca`;

USE `Biblioteca`;

DROP TABLE IF EXISTS `Escribe`;
DROP TABLE IF EXISTS `Autor`;
DROP TABLE IF EXISTS `Libro`;

CREATE TABLE `Autor`(
    `ID`            INT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    `Nombre`        VARCHAR(20)     NOT NULL,
    `Apellido`      VARCHAR(20)     NOT NULL,
    `Nacionalidad`  VARCHAR(20)     NOT NULL,
    `Residencia`    VARCHAR(20)     NOT NULL,
    PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Libro`(
    `ISBN`          int (13) UNSIGNED   NOT NULL,
    `Titulo`        VARCHAR(30)         NOT NULL,
    `Editorial`     VARCHAR(20)         NOT NULL,
    `Precio`        INT UNSIGNED        NOT NULL,
    PRIMARY KEY (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Escribe`(
    `ID_autor`       INT UNSIGNED   NOT NULL REFERENCES `Autor` (`ID`)  ON DELETE CASCADE ON UPDATE CASCADE,
    `ISBN_libro`     INT UNSIGNED   NOT NULL REFERENCES `Libro`(`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`ID_autor`, `ISBN_libro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
