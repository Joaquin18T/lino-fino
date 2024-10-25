USE linofino;

DROP PROCEDURE IF EXISTS sp_add_vista;
DELIMITER $$
CREATE PROCEDURE sp_add_vista
(
	OUT _idvista INT,
    IN _idperfil INT,
    IN _idmodulo INT,
    IN _ruta	 VARCHAR(50),
    IN _isVisible CHAR(1),
    IN _texto	VARCHAR(50),
    IN _icono	VARCHAR(80)
)
BEGIN
	DECLARE existe_error INT DEFAULT 0;
    
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		SET existe_error = 1;
	END;
    
    INSERT INTO vistas(idperfil, idmodulo, ruta, isVisible, texto, icono) VALUES
		(_idperfil, _idmodulo, _ruta, _isVisible, NULLIF(_texto,''), NULLIF(_icono,''));
        
	IF existe_error = 1 THEN
		SET _idvista = -1;
	ELSE
		SET _idvista = last_insert_id();
	END IF;
END $$

DROP PROCEDURE IF EXISTS sp_listar_vistas;
DELIMITER $$
CREATE PROCEDURE sp_listar_vistas
(
)
BEGIN
	SELECT
		V.idvista,
		P.perfil,
		M.modulo,
        V.ruta,
        V.isVisible,
        V.texto,
        V.icono
        FROM vistas V
        INNER JOIN perfiles P ON V.idperfil = P.idperfil
        INNER JOIN modulos M ON V.idmodulo = M.idmodulo;
END $$


