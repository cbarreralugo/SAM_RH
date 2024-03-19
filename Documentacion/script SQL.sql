--Catalogo Estados
CREATE TABLE tb_sam_estatus_c (
    ID_Estatus INT PRIMARY KEY,
    Nombre_Estatus VARCHAR2(50)
);

insert into tb_sam_estatus_c (ID_ESTATUS,NOMBRE_ESTATUS)VALUES(1,'Pendiente');
insert into tb_sam_estatus_c (ID_ESTATUS,NOMBRE_ESTATUS)VALUES(2,'En Proceso');
insert into tb_sam_estatus_c (ID_ESTATUS,NOMBRE_ESTATUS)VALUES(3,'Completado');
insert into tb_sam_estatus_c (ID_ESTATUS,NOMBRE_ESTATUS)VALUES(4,'Aprovado');
insert into tb_sam_estatus_c (ID_ESTATUS,NOMBRE_ESTATUS)VALUES(5,'No aprovado');
select * from tb_sam_estatus_c;

--Catalogo Tipo Usuarios
CREATE TABLE tb_sam_tipo_usuario_c (
    ID_TipoUsuario INT PRIMARY KEY,
    Nombre_Tipo VARCHAR2(50)
);

insert into tb_sam_tipo_usuario_c (ID_TIPOUSUARIO,NOMBRE_TIPO) VALUES (1,'Admin');
insert into tb_sam_tipo_usuario_c (ID_TIPOUSUARIO,NOMBRE_TIPO) VALUES (2,'Empleado');
select * from tb_sam_tipo_usuario_c;


-- Tabla Usuarios
CREATE TABLE tb_sam_usuarios_w (
    ID_Usuario INT PRIMARY KEY,
    ID_TipoUsuario INT,
    Nombre VARCHAR2(100),
    Puesto VARCHAR2(150),
    Departamento VARCHAR2(150),
    UsrLocal VARCHAR2(100),
    FechaCreacion DATE,
    Habilitado CHAR(1),
    CONSTRAINT fk_usuarios_tipousuario FOREIGN KEY (ID_TipoUsuario)
        REFERENCES tb_sam_tipo_usuario_c (ID_TipoUsuario)
);

insert into tb_sam_usuarios_w (ID_USUARIO,ID_TIPOUSUARIO,NOMBRE,PUESTO,DEPARTAMENTO,USRLOCAL,FECHACREACION,HABILITADO) 
VALUES (1,1,'Administrador','General','General','General',SYSDATE,1); 
select * from tb_sam_usuarios_w;

--Catalogo Tipo Evaluacion
CREATE TABLE tb_sam_tipo_evaluacion_c (
    ID_TipoEvaluacion INT PRIMARY KEY,
    Nombre VARCHAR2(100),
    FechaCreada DATE,
    Habilitada CHAR(1)
);

--Tabla Evaluaciones
CREATE TABLE tb_sam_evaluaciones_w (
    ID_Evaluacion INT PRIMARY KEY,
    ID_TipoEvaluacion INT,
    Nombre_Evaluacion VARCHAR2(100),
	Version INT,
    FechaCreacion DATE,
    Habilitada CHAR(1),
    CONSTRAINT fk_evaluaciones_tipoevaluacion FOREIGN KEY (ID_TipoEvaluacion)
        REFERENCES tb_sam_tipo_evaluacion_c (ID_TipoEvaluacion)
);

--Tabla Preguntas Evaluaciones
CREATE TABLE tb_sam_preguntas_evaluacion_w (
    ID_Pregunta INT PRIMARY KEY,
    ID_Evaluacion INT,
    Pregunta VARCHAR2(500),
    Puntaje INT,
    CONSTRAINT fk_preguntas_evaluacion FOREIGN KEY (ID_Evaluacion)
        REFERENCES tb_sam_evaluaciones_w (ID_Evaluacion)
);

--Tabla Opciones de Respuestas
CREATE TABLE tb_sam_respuestas_opcion_w (
    ID_Respuesta INT PRIMARY KEY,
    ID_Pregunta INT,
    Respuesta VARCHAR2(500),
    EsCorrecta CHAR(1),
    CONSTRAINT fk_respuestas_pregunta FOREIGN KEY (ID_Pregunta)
        REFERENCES tb_sam_preguntas_evaluacion_w (ID_Pregunta)
);

--Tabla Evaluaciones asignadas
CREATE TABLE tb_sam_evaluaciones_asignadas_w (
    ID_EvaluacionAsignada INT PRIMARY KEY,
    ID_Evaluacion INT,
    ID_Usuario INT,
    FechaInicio DATE,
    FechaFin DATE,
    ID_Estatus INT,
    Habilitado CHAR(1),
    CONSTRAINT fk_evalasignada_evaluacion FOREIGN KEY (ID_Evaluacion)
        REFERENCES tb_sam_evaluaciones_w (ID_Evaluacion),
    CONSTRAINT fk_evalasignada_usuario FOREIGN KEY (ID_Usuario)
        REFERENCES tb_sam_usuarios_w (ID_Usuario),
    CONSTRAINT fk_evalasignada_estatus FOREIGN KEY (ID_Estatus)
        REFERENCES tb_sam_estatus_c (ID_Estatus)
);

--Tabla Usuario
CREATE TABLE tb_sam_respuestas_usuario_w (
    ID_RespuestaUsuario INT PRIMARY KEY,
    ID_EvaluacionAsignada INT,
    ID_Pregunta INT,
    ID_RespuestaSeleccionada INT,
    FechaHoraRespuesta DATE,
    CONSTRAINT fk_respusuario_evalasignada FOREIGN KEY (ID_EvaluacionAsignada)
        REFERENCES tb_sam_evaluaciones_asignadas_w (ID_EvaluacionAsignada),
    CONSTRAINT fk_respusuario_pregunta FOREIGN KEY (ID_Pregunta)
        REFERENCES tb_sam_preguntas_evaluacion_w (ID_Pregunta),
    CONSTRAINT fk_respusuario_respuesta FOREIGN KEY (ID_RespuestaSeleccionada)
        REFERENCES tb_sam_respuestas_opcion_w (ID_Respuesta)
);
