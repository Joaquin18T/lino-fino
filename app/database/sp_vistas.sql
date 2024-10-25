DROP PROCEDURE IF EXISTS sp_obtener_permisos;
DELIMITER $$
CREATE PROCEDURE sp_obtener_permisos
(
	IN _idperfil INT
)
BEGIN
	SELECT 
		PRM.idpermiso,
        M.modulo,
        V.idvista, V.ruta, V.isVisible, V.texto, V.icono
        FROM permisos PRM
		INNER JOIN vistas V ON PRM.idvista = V.idvista
        LEFT JOIN modulos M ON V.idmodulo = M.idmodulo
        WHERE PRM.idperfil = _idperfil;
END $$

CALL sp_obtener_permisos(1);

