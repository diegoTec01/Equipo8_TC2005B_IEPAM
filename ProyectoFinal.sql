PGDMP         :            	    z           ProyectoFinal    14.4    14.4 .    !           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            "           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            #           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            $           1262    26588    ProyectoFinal    DATABASE     Z   CREATE DATABASE "ProyectoFinal" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';
    DROP DATABASE "ProyectoFinal";
                postgres    false            ?            1255    26621    fun_creadores_obtener()    FUNCTION     8  CREATE FUNCTION public.fun_creadores_obtener() RETURNS TABLE(id_creador integer, nombres character varying, apellidos character varying, paypal text)
    LANGUAGE sql
    AS $$
		SELECT a.id_creador, b.nombres, b.apellidos, a.paypal
		FROM creadores as a
		JOIN usuarios as b ON a.id_usuario = b.id_usuario
	$$;
 .   DROP FUNCTION public.fun_creadores_obtener();
       public          postgres    false            ?            1255    26639    fun_cursos_obtener()    FUNCTION     ?  CREATE FUNCTION public.fun_cursos_obtener() RETURNS TABLE(id_curso integer, id_creador integer, nombre character varying, area character varying, tema character varying, dificultad character varying, titulo text, frase_inicio text, subtitulo_1 text, contenido_sub_1 text, subtitulo_2 text, contenido_sub_2 text, subtitulo_3 text, contenido_sub_3 text, frase_1 text, frase_2 text, video_1 text, video_2 text, img text)
    LANGUAGE sql
    AS $$
		SELECT a.id_curso, a.id_creador, a.nombre, a.area, a.tema, 
		a.dificultad, a.titulo, a.frase_inicio, 
		a.subtitulo_1, a.contenido_sub_1, 
		a.subtitulo_2, a.contenido_sub_2,
		a.subtitulo_3, a.contenido_sub_3, a.frase_1, a.frase_2, a.video_1, a.video_2, a.img
		FROM cursos as a
	$$;
 +   DROP FUNCTION public.fun_cursos_obtener();
       public          postgres    false            ?            1255    26640 $   fun_cursos_obtener_completo(integer)    FUNCTION     ?  CREATE FUNCTION public.fun_cursos_obtener_completo(idcurso_i integer) RETURNS TABLE(id_curso integer, id_creador integer, nombres character varying, apellidos character varying, nombre character varying, area character varying, tema character varying, dificultad character varying, titulo text, frase_inicio text, subtitulo_1 text, contenido_sub_1 text, subtitulo_2 text, contenido_sub_2 text, subtitulo_3 text, contenido_sub_3 text, frase_1 text, frase_2 text, video_1 text, video_2 text, img text)
    LANGUAGE sql
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
	$$;
 E   DROP FUNCTION public.fun_cursos_obtener_completo(idcurso_i integer);
       public          postgres    false            ?            1255    26601 2   fun_usuarios_obtener_id_usuario(character varying)    FUNCTION     ?   CREATE FUNCTION public.fun_usuarios_obtener_id_usuario(nombreusuario_i character varying) RETURNS integer
    LANGUAGE sql
    AS $$
		SELECT id_usuario FROM usuarios WHERE nombre_usuario = NombreUsuario_I;
	$$;
 Y   DROP FUNCTION public.fun_usuarios_obtener_id_usuario(nombreusuario_i character varying);
       public          postgres    false            ?            1255    26602 B   fun_usuarios_validar_bandera(character varying, character varying)    FUNCTION       CREATE FUNCTION public.fun_usuarios_validar_bandera(nomusu_i character varying, "contraseña_i" character varying) RETURNS TABLE(bandera integer)
    LANGUAGE sql
    AS $$
		SELECT id_usuario FROM usuarios WHERE nombre_usuario = nomUsu_I AND contraseña = contraseña_I
	$$;
 r   DROP FUNCTION public.fun_usuarios_validar_bandera(nomusu_i character varying, "contraseña_i" character varying);
       public          postgres    false            ?            1255    26603 G   fun_usuarios_validar_tipo_usuario(character varying, character varying)    FUNCTION     *  CREATE FUNCTION public.fun_usuarios_validar_tipo_usuario(nomusu_i character varying, "contraseña_i" character varying) RETURNS TABLE(tipo_usuario character varying)
    LANGUAGE sql
    AS $$
		SELECT tipo_usuario FROM usuarios WHERE nombre_usuario = nomUsu_I AND contraseña = contraseña_I
	$$;
 w   DROP FUNCTION public.fun_usuarios_validar_tipo_usuario(nomusu_i character varying, "contraseña_i" character varying);
       public          postgres    false            ?            1255    26620 ,   sp_creadores_insert(character varying, text) 	   PROCEDURE     ?   CREATE PROCEDURE public.sp_creadores_insert(IN nombreus_i character varying, IN paypal_i text)
    LANGUAGE sql
    AS $$
	INSERT INTO creadores (id_usuario, paypal)
	VALUES (fun_usuarios_obtener_id_usuario(nombreUs_I), paypal_I)
$$;
 ^   DROP PROCEDURE public.sp_creadores_insert(IN nombreus_i character varying, IN paypal_i text);
       public          postgres    false            ?            1255    26638 ?   sp_guardar_cursos(integer, character varying, character varying, character varying, character varying, text, text, text, text, text, text, text, text, text, text, text, text, text) 	   PROCEDURE     ?  CREATE PROCEDURE public.sp_guardar_cursos(IN idcre_i integer, IN nombre_i character varying, IN area_i character varying, IN tema_i character varying, IN dificultad_i character varying, IN titulo_i text, IN frase_inicio_i text, IN subtitulo1_i text, IN contenidosub1_i text, IN subtitulo2_i text, IN contenidosub2_i text, IN subtitulo3_i text, IN contenidosub3_i text, IN frase1_i text, IN frase2_i text, IN video1_i text, IN video2_i text, IN img_i text)
    LANGUAGE sql
    AS $$
	INSERT INTO cursos (id_creador, nombre, area, tema, dificultad, titulo, frase_inicio, subtitulo_1, contenido_sub_1, subtitulo_2, contenido_sub_2, subtitulo_3, contenido_sub_3, frase_1, frase_2, video_1, video_2, img)
	VALUES (idCre_I, nombre_I, area_I, tema_I, dificultad_I, titulo_I, frase_inicio_I, subtitulo1_I, contenidoSub1_I, subtitulo2_I, contenidoSub2_I, subtitulo3_I, contenidoSub3_I, frase1_i, frase2_I, video1_I, video2_I, img_I)
$$;
 ?  DROP PROCEDURE public.sp_guardar_cursos(IN idcre_i integer, IN nombre_i character varying, IN area_i character varying, IN tema_i character varying, IN dificultad_i character varying, IN titulo_i text, IN frase_inicio_i text, IN subtitulo1_i text, IN contenidosub1_i text, IN subtitulo2_i text, IN contenidosub2_i text, IN subtitulo3_i text, IN contenidosub3_i text, IN frase1_i text, IN frase2_i text, IN video1_i text, IN video2_i text, IN img_i text);
       public          postgres    false            ?            1255    26600 |   sp_usuarios_insert(character, character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     ?  CREATE PROCEDURE public.sp_usuarios_insert(IN tipous_i character, IN nombreus_i character varying, IN nombres_i character varying, IN apellidos_i character varying, IN correo_i character varying, IN "contraseña_i" character varying)
    LANGUAGE sql
    AS $$
	INSERT INTO usuarios (tipo_usuario, nombre_usuario, nombres, apellidos, correo, contraseña)
	VALUES (tipoUs_I, nombreUs_I, nombres_I, apellidos_I, correo_I, contraseña_I)
$$;
 ?   DROP PROCEDURE public.sp_usuarios_insert(IN tipous_i character, IN nombreus_i character varying, IN nombres_i character varying, IN apellidos_i character varying, IN correo_i character varying, IN "contraseña_i" character varying);
       public          postgres    false            ?            1259    26606 	   creadores    TABLE     ~   CREATE TABLE public.creadores (
    id_creador integer NOT NULL,
    id_usuario integer NOT NULL,
    paypal text NOT NULL
);
    DROP TABLE public.creadores;
       public         heap    postgres    false            ?            1259    26604    creadores_id_creador_seq    SEQUENCE     ?   CREATE SEQUENCE public.creadores_id_creador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.creadores_id_creador_seq;
       public          postgres    false    213            %           0    0    creadores_id_creador_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.creadores_id_creador_seq OWNED BY public.creadores.id_creador;
          public          postgres    false    211            ?            1259    26605    creadores_id_usuario_seq    SEQUENCE     ?   CREATE SEQUENCE public.creadores_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.creadores_id_usuario_seq;
       public          postgres    false    213            &           0    0    creadores_id_usuario_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.creadores_id_usuario_seq OWNED BY public.creadores.id_usuario;
          public          postgres    false    212            ?            1259    26624    cursos    TABLE     ?  CREATE TABLE public.cursos (
    id_curso integer NOT NULL,
    id_creador integer NOT NULL,
    nombre character varying(50) NOT NULL,
    area character varying(50) NOT NULL,
    tema character varying(50) NOT NULL,
    dificultad character varying(15) NOT NULL,
    titulo text NOT NULL,
    frase_inicio text NOT NULL,
    subtitulo_1 text NOT NULL,
    contenido_sub_1 text NOT NULL,
    subtitulo_2 text NOT NULL,
    contenido_sub_2 text NOT NULL,
    subtitulo_3 text NOT NULL,
    contenido_sub_3 text NOT NULL,
    frase_1 text NOT NULL,
    frase_2 text NOT NULL,
    video_1 text NOT NULL,
    video_2 text NOT NULL,
    img text NOT NULL
);
    DROP TABLE public.cursos;
       public         heap    postgres    false            ?            1259    26623    cursos_id_creador_seq    SEQUENCE     ?   CREATE SEQUENCE public.cursos_id_creador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.cursos_id_creador_seq;
       public          postgres    false    216            '           0    0    cursos_id_creador_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.cursos_id_creador_seq OWNED BY public.cursos.id_creador;
          public          postgres    false    215            ?            1259    26622    cursos_id_curso_seq    SEQUENCE     ?   CREATE SEQUENCE public.cursos_id_curso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.cursos_id_curso_seq;
       public          postgres    false    216            (           0    0    cursos_id_curso_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.cursos_id_curso_seq OWNED BY public.cursos.id_curso;
          public          postgres    false    214            ?            1259    26590    usuarios    TABLE     T  CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    tipo_usuario character(1) NOT NULL,
    nombre_usuario character varying(20) NOT NULL,
    nombres character varying(20) NOT NULL,
    apellidos character varying(30) NOT NULL,
    correo character varying(30) NOT NULL,
    "contraseña" character varying(20) NOT NULL
);
    DROP TABLE public.usuarios;
       public         heap    postgres    false            ?            1259    26589    usuarios_id_usuario_seq    SEQUENCE     ?   CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.usuarios_id_usuario_seq;
       public          postgres    false    210            )           0    0    usuarios_id_usuario_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;
          public          postgres    false    209            |           2604    26609    creadores id_creador    DEFAULT     |   ALTER TABLE ONLY public.creadores ALTER COLUMN id_creador SET DEFAULT nextval('public.creadores_id_creador_seq'::regclass);
 C   ALTER TABLE public.creadores ALTER COLUMN id_creador DROP DEFAULT;
       public          postgres    false    211    213    213            }           2604    26610    creadores id_usuario    DEFAULT     |   ALTER TABLE ONLY public.creadores ALTER COLUMN id_usuario SET DEFAULT nextval('public.creadores_id_usuario_seq'::regclass);
 C   ALTER TABLE public.creadores ALTER COLUMN id_usuario DROP DEFAULT;
       public          postgres    false    212    213    213            ~           2604    26627    cursos id_curso    DEFAULT     r   ALTER TABLE ONLY public.cursos ALTER COLUMN id_curso SET DEFAULT nextval('public.cursos_id_curso_seq'::regclass);
 >   ALTER TABLE public.cursos ALTER COLUMN id_curso DROP DEFAULT;
       public          postgres    false    214    216    216                       2604    26628    cursos id_creador    DEFAULT     v   ALTER TABLE ONLY public.cursos ALTER COLUMN id_creador SET DEFAULT nextval('public.cursos_id_creador_seq'::regclass);
 @   ALTER TABLE public.cursos ALTER COLUMN id_creador DROP DEFAULT;
       public          postgres    false    215    216    216            {           2604    26593    usuarios id_usuario    DEFAULT     z   ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);
 B   ALTER TABLE public.usuarios ALTER COLUMN id_usuario DROP DEFAULT;
       public          postgres    false    210    209    210                      0    26606 	   creadores 
   TABLE DATA           C   COPY public.creadores (id_creador, id_usuario, paypal) FROM stdin;
    public          postgres    false    213   ?I                 0    26624    cursos 
   TABLE DATA           ?   COPY public.cursos (id_curso, id_creador, nombre, area, tema, dificultad, titulo, frase_inicio, subtitulo_1, contenido_sub_1, subtitulo_2, contenido_sub_2, subtitulo_3, contenido_sub_3, frase_1, frase_2, video_1, video_2, img) FROM stdin;
    public          postgres    false    216   ?I                 0    26590    usuarios 
   TABLE DATA           w   COPY public.usuarios (id_usuario, tipo_usuario, nombre_usuario, nombres, apellidos, correo, "contraseña") FROM stdin;
    public          postgres    false    210   J       *           0    0    creadores_id_creador_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.creadores_id_creador_seq', 1, true);
          public          postgres    false    211            +           0    0    creadores_id_usuario_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.creadores_id_usuario_seq', 1, false);
          public          postgres    false    212            ,           0    0    cursos_id_creador_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.cursos_id_creador_seq', 1, false);
          public          postgres    false    215            -           0    0    cursos_id_curso_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.cursos_id_curso_seq', 1, false);
          public          postgres    false    214            .           0    0    usuarios_id_usuario_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 2, true);
          public          postgres    false    209            ?           2606    26614    creadores creadores_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.creadores
    ADD CONSTRAINT creadores_pkey PRIMARY KEY (id_creador);
 B   ALTER TABLE ONLY public.creadores DROP CONSTRAINT creadores_pkey;
       public            postgres    false    213            ?           2606    26632    cursos cursos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT cursos_pkey PRIMARY KEY (id_curso);
 <   ALTER TABLE ONLY public.cursos DROP CONSTRAINT cursos_pkey;
       public            postgres    false    216            ?           2606    26599    usuarios usuarios_correo_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);
 F   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_correo_key;
       public            postgres    false    210            ?           2606    26597 $   usuarios usuarios_nombre_usuario_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_nombre_usuario_key UNIQUE (nombre_usuario);
 N   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_nombre_usuario_key;
       public            postgres    false    210            ?           2606    26595    usuarios usuarios_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public            postgres    false    210            ?           2606    26615 !   creadores fk_creadores_id_usuario    FK CONSTRAINT     ?   ALTER TABLE ONLY public.creadores
    ADD CONSTRAINT fk_creadores_id_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);
 K   ALTER TABLE ONLY public.creadores DROP CONSTRAINT fk_creadores_id_usuario;
       public          postgres    false    3461    210    213            ?           2606    26633    cursos fk_cursos_id_creador    FK CONSTRAINT     ?   ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT fk_cursos_id_creador FOREIGN KEY (id_creador) REFERENCES public.creadores(id_creador);
 E   ALTER TABLE ONLY public.cursos DROP CONSTRAINT fk_cursos_id_creador;
       public          postgres    false    213    216    3463               O   x?3?4??())(???///?+H?,H??K???O??K,Iշ??/.IM?O*-)?ϋ?L?5q775???pv4?r?????? eI?            x?????? ? ?         T   x?3?t?L?LMϏ70?t18]???!?鹉?9z?????F?\F?N???iE???ΉE9?Ŝn@v~q>gF~N"??=... ?{r     