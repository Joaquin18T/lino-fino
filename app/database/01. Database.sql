CREATE DATABASE linofino;
USE linofino;
-- DROP DATABASE linofino;
CREATE TABLE personas
(
	idpersona 		INT AUTO_INCREMENT PRIMARY KEY,
    apellidos 		VARCHAR(40)		NOT NULL,
    nombres 		VARCHAR(40)		NOT NULL,
    telefono 		CHAR(9) 		NOT NULL,
    dni 			CHAR(8) 		NOT NULL,
    direccion		VARCHAR(100) 	NULL,
    CONSTRAINT uk_dni_per UNIQUE (dni)
)ENGINE = INNODB;

-- ALTER TABLE personas ADD `direccion` VARCHAR(100) NOT NULL AFTER `dni`;
-- ALTER TABLE personas ADD `telefono` CHAR(9) NOT NULL AFTER `nombres`;

create TABLE perfiles
(
	idperfil 	INT AUTO_INCREMENT PRIMARY KEY,
    perfil      VARCHAR(30) NOT NULL,
    nombrecorto CHAR(3) NOT NULL,
    create_at	DATETIME NOT NULL DEFAULT NOW(),
    CONSTRAINT uk_perfil UNIQUE(perfil),
    CONSTRAINT uk_nombrecorto UNIQUE(nombrecorto)
)ENGINE = INNODB;

create TABLE usuarios 
(
	idusuario 		INT AUTO_INCREMENT PRIMARY KEY,
    idpersona 		INT 			NOT NULL,
    nomusuario		VARCHAR(30)		NOT NULL,
    claveacceso 	VARCHAR(70) 	NOT NULL,
    perfil 			CHAR(3) 		NOT NULL, -- ADM | COL | AST
    idperfil 		INT NOT NULL,
    CONSTRAINT fk_idpersona_usu FOREIGN KEY (idpersona) REFERENCES personas (idpersona),
    CONSTRAINT uk_nomusuario_usu UNIQUE (nomusuario),
    CONSTRAINT ck_perfil_usu CHECK (perfil IN ('ADM','COL','SUP')),
    CONSTRAINT fk_idperfil_usu FOREIGN KEY (idperfil) REFERENCES perfiles(idperfil)
)ENGINE = INNODB;


create TABLE tareas
(
	idtarea 		INT AUTO_INCREMENT PRIMARY KEY,
    nombretarea	 	VARCHAR(100)	NOT NULL,
    precio 			DECIMAL(5,2)	NOT NULL,
    idusuregistra	INT 			NOT NULL,
    idusuactualiza	INT 			NULL,
    create_at 		DATETIME 		NOT NULL DEFAULT NOW(),
    update_at 		DATETIME 		NULL,
    CONSTRAINT uk_nombretarea_tar UNIQUE (nombretarea),
    CONSTRAINT ck_precio_tar CHECK (precio > 0),
    CONSTRAINT fk_idusuregistra_tar FOREIGN KEY (idusuregistra) REFERENCES usuarios (idusuario),
    CONSTRAINT fk_idusuactualiza_tar FOREIGN KEY (idusuactualiza) REFERENCES usuarios (idusuario)
)ENGINE = INNODB;

CREATE TABLE jornadas
(
	idjornada 		INT AUTO_INCREMENT PRIMARY KEY,
    idpersona 		INT 			NOT NULL,
    horainicio		DATETIME 		NOT NULL,
    horatermino		DATETIME 		NULL,
    CONSTRAINT fk_idpersona_jor FOREIGN KEY (idpersona) REFERENCES personas (idpersona),
    CONSTRAINT ck_horas_jor CHECK (horainicio < horatermino)
)ENGINE = INNODB;

create TABLE detalletareas
(
	iddetalle		INT AUTO_INCREMENT PRIMARY KEY,
    idususupervisor	INT 			NOT NULL, -- Encargado de agregar este registro
    idjornada 		INT 			NOT NULL, -- Día, trabajador
    idtarea 		INT 			NOT NULL, -- Operación realizada
    cantidad 		SMALLINT 		NOT NULL,
    preciotarea 	DECIMAL(5,2) 	NOT NULL,
    idusucaja 		INT 			NULL,	 -- Encargado de realizar el pago
    pagado 			CHAR(1) 		NOT NULL DEFAULT 'N',
    create_at 		DATETIME 		NOT NULL DEFAULT NOW(),
    update_at 		DATETIME 		NULL,
    CONSTRAINT fk_idususupervisor_dta FOREIGN KEY (idususupervisor) REFERENCES usuarios (idusuario),
    CONSTRAINT fk_idjornada_dta FOREIGN KEY (idjornada) REFERENCES jornadas (idjornada),
    CONSTRAINT fk_idtarea_dta FOREIGN KEY (idtarea) REFERENCES tareas (idtarea),
    CONSTRAINT fk_idusucaja_dta FOREIGN KEY (idusucaja) REFERENCES usuarios (idusuario),
    CONSTRAINT ck_pagado_dta CHECK (pagado IN ('S','N'))
)ENGINE = INNODB;



CREATE TABLE modulos
(
	idmodulo	INT AUTO_INCREMENT PRIMARY KEY,
    modulo 		VARCHAR(30) NOT NULL,
    create_at	DATETIME NOT NULL DEFAULT NOW(),
    CONSTRAINT uk_modulo UNIQUE(modulo)
)ENGINE=INNODB;

CREATE TABLE vistas
(
	idvista	INT AUTO_INCREMENT PRIMARY KEY,
    -- idperfil	INT NOT NULL,
    idmodulo 	INT NULL,
    ruta		VARCHAR(50) NOT NULL,
    isVisible   CHAR(1) NOT NULL,
    texto		VARCHAR(20) NULL,
    icono		VARCHAR(20) NULL,
    -- CONSTRAINT fk_idperfil FOREIGN KEY (idperfil) REFERENCES perfiles(idperfil),
    CONSTRAINT fk_idmodulo FOREIGN KEY (idmodulo) REFERENCES modulos (idmodulo),
    CONSTRAINT uk_ruta	UNIQUE(ruta),
    CONSTRAINT chk_isVisible CHECK (isVisible IN('1','0'))
)ENGINE = INNODB;


CREATE TABLE permisos
(
	idpermiso 	INT AUTO_INCREMENT PRIMARY KEY,
    idperfil 	INT NOT NULL,
    idvista 	INT NOT NULL,
    create_at 	DATETIME NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_idperfil_per FOREIGN KEY(idperfil) REFERENCES perfiles(idperfil),
    CONSTRAINT fk_idvista_per FOREIGN KEY(idvista) REFERENCES vistas(idvista),
    CONSTRAINT uk_idperfil_idvista UNIQUE(idperfil, idvista)
)ENGINE=INNODB;

INSERT INTO vistas (idmodulo, ruta, isVisible, texto, icono) VALUES
	(7, 'prueba1', '1', 'SERVER SIDE','fa-solid fa-wallet');

INSERT INTO vistas (idmodulo, ruta, isVisible, texto, icono) VALUES
	(null, 'home', '1', 'Inicio','fa-solid fa-wallet');

-- Jornadas
INSERT INTO vistas (idmodulo, ruta, isVisible, texto, icono) VALUES
	(1, 'listar-jornada', '1', 'Jornadas','fa-solid fa-wallet');
    
-- Pagos
INSERT INTO vistas (idmodulo, ruta, isVisible, texto, icono) VALUES
	(2, 'listar-pago', '1', 'Pagos','fa-solid fa-wallet');
    
-- Produccion
INSERT INTO vistas (idmodulo, ruta, isVisible, texto, icono) VALUES
	(3, 'listar-produccion', '1', 'Produccion','fa-solid fa-wallet');
    
-- Reportes
INSERT INTO vistas (idmodulo, ruta, isVisible, texto, icono) VALUES
	(4, 'listar-reporte', '1', 'Reportes','fa-solid fa-wallet');

-- Usuarios
INSERT INTO vistas (idmodulo, ruta, isVisible, texto, icono) VALUES
	(5, 'listar-usuario', '1', 'Usuario','fa-solid fa-wallet'),
	(5, 'registrar-usuario', '0', NULL, NULL),
	(5, 'actualizar-usuario', '0', NULL, NULL);
    
-- Tareas
INSERT INTO vistas (idmodulo, ruta, isVisible, texto, icono) VALUES
	(6, 'listar-tarea', '1', 'Tareas','fa-solid fa-wallet'),
	(6, 'registrar-tarea', '0', NULL, NULL);
    


INSERT INTO perfiles (perfil, nombrecorto) VALUES
	('Administrador', 'ADM'),
	('Supervisor', 'SUP'),
	('Colaborador', 'COL');

    


SELECT*FROM vistas;
SELECT*FROM permisos;

-- Administrador
INSERT INTO permisos(idperfil, idvista) VALUES
(1,11),
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 8),
(1, 9),
(1, 10);

-- Supervisor
INSERT INTO permisos(idperfil, idvista) VALUES
(2,1),
(2,4),
(2,5),
(2,9),
(2,3);

-- Colaborador
INSERT INTO permisos(idperfil, idvista) VALUES
	(3,1),
	(3,9);
