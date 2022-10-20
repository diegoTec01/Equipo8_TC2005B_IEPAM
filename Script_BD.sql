CREATE TABLE usuarios
(
	id_usuario SERIAL PRIMARY KEY,
	tipo_usuario CHAR(1) NOT NULL,
	nombre_usuario VARCHAR(20) NOT NULL UNIQUE,
	nombres VARCHAR(20) NOT NULL,
	apellidos VARCHAR(30) NOT NULL,
	correo VARCHAR(30) NOT NULL UNIQUE,
	contraseña VARCHAR(20) NOT NULL
);

-- INSERT USUARIOS:
CREATE OR REPLACE PROCEDURE sp_usuarios_insert(tipoUs_I char(1), nombreUs_I varchar(20), nombres_I varchar(20), apellidos_I varchar(30), correo_I varchar(30), contraseña_I varchar(20))
AS $$
	INSERT INTO usuarios (tipo_usuario, nombre_usuario, nombres, apellidos, correo, contraseña)
	VALUES (tipoUs_I, nombreUs_I, nombres_I, apellidos_I, correo_I, contraseña_I)
$$ LANGUAGE SQL;

-- FUNCTION OBTENER ID USUARIO:
CREATE OR REPLACE FUNCTION fun_usuarios_obtener_id_usuario(NombreUsuario_I varchar(20))
	RETURNS INT
	AS $$
		SELECT id_usuario FROM usuarios WHERE nombre_usuario = NombreUsuario_I;
	$$ LANGUAGE SQL;

-- FUNCTION VALIDAR CREDENCIALES BANDERA:
CREATE OR REPLACE FUNCTION fun_usuarios_validar_bandera(nomUsu_I varchar(20), contraseña_I varchar(20))
	RETURNS TABLE(bandera integer)
	AS $$
		SELECT id_usuario FROM usuarios WHERE nombre_usuario = nomUsu_I AND contraseña = contraseña_I
	$$ LANGUAGE SQL;
	
-- FUNCTION VALIDAR CREDENCIALES TIPO USUARIO:
CREATE OR REPLACE FUNCTION fun_usuarios_validar_tipo_usuario(nomUsu_I varchar(20), contraseña_I varchar(20))
	RETURNS TABLE(tipo_usuario character varying)
	AS $$
		SELECT tipo_usuario FROM usuarios WHERE nombre_usuario = nomUsu_I AND contraseña = contraseña_I
	$$ LANGUAGE SQL;
	
	
CREATE TABLE creadores
(
	id_creador SERIAL PRIMARY KEY,
	id_usuario SERIAL,
	paypal text NOT NULL
);

-- FK CREADORES
ALTER TABLE creadores ADD CONSTRAINT FK_creadores_id_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario);

-- INSERT CREADORES:
CREATE OR REPLACE PROCEDURE sp_creadores_insert(nombreUs_I varchar(20), paypal_I text)
	AS $$
	INSERT INTO creadores (id_usuario, paypal)
	VALUES (fun_usuarios_obtener_id_usuario(nombreUs_I), paypal_I)
$$ LANGUAGE SQL

-- FUNCTION OBTENER DATOS CREADOR:
CREATE OR REPLACE FUNCTION fun_creadores_obtener()
	RETURNS TABLE(id_creador integer, nombres character varying, apellidos character varying, paypal text)
	AS $$
		SELECT a.id_creador, b.nombres, b.apellidos, a.paypal
		FROM creadores as a
		JOIN usuarios as b ON a.id_usuario = b.id_usuario
	$$ LANGUAGE SQL;

CREATE TABLE cursos
(
	id_curso SERIAL PRIMARY KEY,
	id_creador SERIAL,
	nombre VARCHAR(50) NOT NULL,
	area VARCHAR(50) NOT NULL,
	tema VARCHAR(50) NOT NULL,
	dificultad VARCHAR(15) NOT NULL,
	titulo TEXT NOT NULL,
	frase_inicio TEXT NOT NULL,
	subtitulo_1 TEXT NOT NULL,
	contenido_sub_1 TEXT NOT NULL,
	subtitulo_2 TEXT NOT NULL,
	contenido_sub_2 TEXT NOT NULL,
	subtitulo_3 TEXT NOT NULL,
	contenido_sub_3 TEXT NOT NULL,
	frase_1 TEXT NOT NULL,
	frase_2 TEXT NOT NULL,
	video_1 TEXT NOT NULL,
	video_2 TEXT NOT NULL,
	img TEXT NOT NULL
);



-- FK CURSOS
ALTER TABLE cursos ADD CONSTRAINT FK_cursos_id_creador FOREIGN KEY (id_creador) REFERENCES creadores(id_creador);

-- Generar curso:
CREATE OR REPLACE PROCEDURE sp_guardar_cursos(idCre_I int, nombre_I varchar(50), area_I varchar(50), tema_I varchar(50), dificultad_I varchar(15), titulo_I text, frase_inicio_I text, subtitulo1_I text, contenidoSub1_I text, subtitulo2_I text, contenidoSub2_I text, subtitulo3_I text, contenidoSub3_I text, frase1_i text, frase2_I text, video1_I text, video2_I text, img_I text)
AS $$
	INSERT INTO cursos (id_creador, nombre, area, tema, dificultad, titulo, frase_inicio, subtitulo_1, contenido_sub_1, subtitulo_2, contenido_sub_2, subtitulo_3, contenido_sub_3, frase_1, frase_2, video_1, video_2, img)
	VALUES (idCre_I, nombre_I, area_I, tema_I, dificultad_I, titulo_I, frase_inicio_I, subtitulo1_I, contenidoSub1_I, subtitulo2_I, contenidoSub2_I, subtitulo3_I, contenidoSub3_I, frase1_i, frase2_I, video1_I, video2_I, img_I)
$$ LANGUAGE SQL


-- Despliegue Cursos cartas:
CREATE OR REPLACE FUNCTION fun_cursos_obtener()
	RETURNS TABLE(id_curso integer, id_creador integer, nombre character varying, area character varying, tema character varying, dificultad character varying, titulo text, frase_inicio text, subtitulo_1 text, contenido_sub_1 text, subtitulo_2 text, contenido_sub_2 text, subtitulo_3 text, contenido_sub_3 text, frase_1 text, frase_2 text, video_1 text, video_2 text, img text)
	AS $$
		SELECT a.id_curso, a.id_creador, a.nombre, a.area, a.tema, 
		a.dificultad, a.titulo, a.frase_inicio, 
		a.subtitulo_1, a.contenido_sub_1, 
		a.subtitulo_2, a.contenido_sub_2,
		a.subtitulo_3, a.contenido_sub_3, a.frase_1, a.frase_2, a.video_1, a.video_2, a.img
		FROM cursos as a
	$$ LANGUAGE SQL;
	
-- Despliegue curso completo:
CREATE OR REPLACE FUNCTION fun_cursos_obtener_completo(idCurso_I int)
	RETURNS TABLE(id_curso integer, id_creador integer, nombres character varying, apellidos character varying, nombre character varying, area character varying, tema character varying, dificultad character varying, titulo text, frase_inicio text, subtitulo_1 text, contenido_sub_1 text, subtitulo_2 text, contenido_sub_2 text, subtitulo_3 text, contenido_sub_3 text, frase_1 text, frase_2 text, video_1 text, video_2 text, img text)
	AS $$
		SELECT a.id_curso, a.id_creador, d.nombres, d.apellidos, a.nombre, a.area, a.tema, 
		a.dificultad, a.titulo, a.frase_inicio, 
		a.subtitulo_1, a.contenido_sub_1, 
		a.subtitulo_2, a.contenido_sub_2,
		a.subtitulo_3, a.contenido_sub_3, a.frase_1, a.frase_2, a.video_1, a.video_2, a.img
		FROM cursos as a 
		JOIN creadores as b on a.id_creador = b.id_creador 
		JOIN usuarios as d on b.id_usuario = d.id_usuario 
		WHERE idCurso_I = a.id_curso
	$$ LANGUAGE SQL;