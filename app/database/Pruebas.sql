USE linofino;

CALL spu_personas_registrar(@idpersona, 'Torres Condo', 'Joaquin', '933958993', '74840779', '');
SELECT @idpersona AS 'idpersona';

CALL spu_personas_registrar(@idpersona, 'Tayasco Torres', 'Raul', '967824233', '78234324', '');
CALL spu_personas_registrar(@idpersona, 'Quispe Morales', 'Nadia', '987234323', '62783233', '');

CALL spu_usuarios_registrar (@id, 1, 'jtorres56', 'encriptada', 'ADM');
CALL spu_usuarios_registrar (@id, 2, 'rtasayco', 'encriptada', 'COL');
CALL spu_usuarios_registrar (@id, 3, 'nquispe', 'encriptada', 'SUP');

SELECT * FROM personas;
SELECT * FROM usuarios;

-- clave: SENATI123
UPDATE usuarios SET claveacceso = '$2y$10$j3INO2ee/CtUuzrfomP1neu7yb1wKnydsGepzdHUs9xy0o0.uHT3m' WHERE idusuario = 3;

