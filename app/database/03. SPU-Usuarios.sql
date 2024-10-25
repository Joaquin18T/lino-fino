USE linofino;

DROP PROCEDURE IF EXISTS `spu_usuarios_registrar`;
DELIMITER //
CREATE PROCEDURE `spu_usuarios_registrar`
(
	OUT _idusuario		INT, -- Negativo cuando CATCH|restricción
	IN _idpersona 		INT,
    IN _nomusuario 		VARCHAR(30),
    IN _claveacceso		CHAR(70),
    IN _perfil 			CHAR(3)
)
BEGIN
	-- Declaración de variables
	DECLARE existe_error INT DEFAULT 0;
	
    -- Manejador de excepciones
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
        SET existe_error = 1;
        END;
	
    -- Instrucción a ejecutar
    INSERT INTO usuarios (idpersona, nomusuario, claveacceso, perfil) VALUES
		(_idpersona, _nomusuario, _claveacceso, _perfil);
	
    -- Retornar un valor por la variable OUT
	IF existe_error = 1 THEN
		SET _idusuario = -1;
	ELSE
        SET _idusuario = LAST_INSERT_ID();
    END IF;
END //


DROP PROCEDURE IF EXISTS `spu_usuarios_listar`;
DELIMITER //
CREATE PROCEDURE `spu_usuarios_listar`()
BEGIN
	SELECT
		US.idusuario,
        PE.apellidos, PE.nombres, PE.telefono, PE.dni, PE.direccion,
        US.nomusuario, US.perfil
		FROM usuarios US
        INNER JOIN personas PE ON PE.idpersona = US.idpersona
        ORDER BY US.idusuario DESC;
END //

-- Creado: Viernes 04-Oct-2024
-- Login (2 pasos)
--  Step 1: Validar la existencia del usuario (MySQL)
-- 	Step 2: Validar la contraseña (depende Step1) - Backend
DROP PROCEDURE IF EXISTS `spu_usuarios_login`;
DELIMITER //
CREATE PROCEDURE `spu_usuarios_login`(IN _nomusuario VARCHAR(30))
BEGIN
	SELECT
		US.idusuario,
        PE.apellidos, PE.nombres,
        US.nomusuario,
        US.claveacceso,
        US.perfil
		FROM usuarios US
        INNER JOIN personas PE ON PE.idpersona = US.idpersona
        WHERE US.nomusuario = _nomusuario;
END //

