
-- Catalogo Estados
CREATE TABLE tb_sam_estatus_c (
    ID_Estatus INT PRIMARY KEY,
    Nombre_Estatus VARCHAR(50)
);

INSERT INTO tb_sam_estatus_c (ID_ESTATUS, NOMBRE_ESTATUS) VALUES (1, 'Pendiente');
INSERT INTO tb_sam_estatus_c (ID_ESTATUS, NOMBRE_ESTATUS) VALUES (2, 'En Proceso');
INSERT INTO tb_sam_estatus_c (ID_ESTATUS, NOMBRE_ESTATUS) VALUES (3, 'Completado');
INSERT INTO tb_sam_estatus_c (ID_ESTATUS, NOMBRE_ESTATUS) VALUES (4, 'Aprobado');
INSERT INTO tb_sam_estatus_c (ID_ESTATUS, NOMBRE_ESTATUS) VALUES (5, 'No aprobado');
SELECT * FROM tb_sam_estatus_c;

-- Catalogo Tipo Usuarios
CREATE TABLE tb_sam_tipo_usuario_c (
    ID_TipoUsuario INT PRIMARY KEY,
    Nombre_Tipo VARCHAR(50)
);

INSERT INTO tb_sam_tipo_usuario_c (ID_TIPOUSUARIO, NOMBRE_TIPO) VALUES (1, 'Admin');
INSERT INTO tb_sam_tipo_usuario_c (ID_TIPOUSUARIO, NOMBRE_TIPO) VALUES (2, 'Empleado');
SELECT * FROM tb_sam_tipo_usuario_c;

-- Tabla Usuarios
CREATE TABLE tb_sam_usuarios_w (
    ID_Usuario INT PRIMARY KEY,
    ID_TipoUsuario INT,
    Nombre VARCHAR(100),
    Puesto VARCHAR(150),
    Departamento VARCHAR(150),
    UsrLocal VARCHAR(100),
    FechaCreacion DATETIME,
    Habilitado CHAR(1),
    CONSTRAINT fk_usuarios_tipousuario FOREIGN KEY (ID_TipoUsuario)
        REFERENCES tb_sam_tipo_usuario_c (ID_TipoUsuario)
);

INSERT INTO tb_sam_usuarios_w (ID_USUARIO, ID_TIPOUSUARIO, NOMBRE, PUESTO, DEPARTAMENTO, USRLOCAL, FECHACREACION, HABILITADO) 
VALUES (1, 1, 'Administrador', 'General', 'General', 'General', GETDATE(), '1'); 
SELECT * FROM tb_sam_usuarios_w;

-- Catalogo Tipo Evaluacion
CREATE TABLE tb_sam_tipo_evaluacion_c (
    ID_TipoEvaluacion INT PRIMARY KEY,
    Nombre VARCHAR(100),
    FechaCreada DATETIME,
    Habilitada CHAR(1)
);

-- Tabla Evaluaciones
CREATE TABLE tb_sam_evaluaciones_w (
    ID_Evaluacion INT PRIMARY KEY,
    ID_TipoEvaluacion INT,
    Nombre_Evaluacion VARCHAR(100),
    Version INT,
    FechaCreacion DATETIME,
    Habilitada CHAR(1),
    CONSTRAINT fk_evaluaciones_tipoevaluacion FOREIGN KEY (ID_TipoEvaluacion)
        REFERENCES tb_sam_tipo_evaluacion_c (ID_TipoEvaluacion)
);

-- Tabla Preguntas Evaluaciones
CREATE TABLE tb_sam_preguntas_evaluacion_w (
    ID_Pregunta INT PRIMARY KEY,
    ID_Evaluacion INT,
    Pregunta VARCHAR(500),
    Puntaje INT,
    CONSTRAINT fk_preguntas_evaluacion FOREIGN KEY (ID_Evaluacion)
        REFERENCES tb_sam_evaluaciones_w (ID_Evaluacion)
);

-- Tabla Opciones de Respuestas
CREATE TABLE tb_sam_respuestas_opcion_w (
    ID_Respuesta INT PRIMARY KEY,
    ID_Pregunta INT,
    Respuesta VARCHAR(500),
    EsCorrecta CHAR(1),
    CONSTRAINT fk_respuestas_pregunta FOREIGN KEY (ID_Pregunta)
        REFERENCES tb_sam_preguntas_evaluacion_w (ID_Pregunta)
);

-- Tabla Evaluaciones asignadas
CREATE TABLE tb_sam_evaluaciones_asignadas_w (
    ID_EvaluacionAsignada INT PRIMARY KEY,
    ID_Evaluacion INT,
    ID_Usuario INT,
    FechaInicio DATETIME,
    FechaFin DATETIME,
    ID_Estatus INT,
    Habilitado CHAR(1),
    CONSTRAINT fk_evalasignada_evaluacion FOREIGN KEY (ID_Evaluacion)
        REFERENCES tb_sam_evaluaciones_w (ID_Evaluacion),
    CONSTRAINT fk_evalasignada_usuario FOREIGN KEY (ID_Usuario)
        REFERENCES tb_sam_usuarios_w (ID_Usuario),
    CONSTRAINT fk_evalasignada_estatus FOREIGN KEY (ID_Estatus)
        REFERENCES tb_sam_estatus_c (ID_Estatus)
);

-- Tabla Usuario
CREATE TABLE tb_sam_respuestas_usuario_w (
    ID_RespuestaUsuario INT PRIMARY KEY,
    ID_EvaluacionAsignada INT,
    ID_Pregunta INT,
    ID_RespuestaSeleccionada INT,
    FechaHoraRespuesta DATETIME,
    CONSTRAINT fk_respusuario_evalasignada FOREIGN KEY (ID_EvaluacionAsignada)
        REFERENCES tb_sam_evaluaciones_asignadas_w (ID_EvaluacionAsignada),
    CONSTRAINT fk_respusuario_pregunta FOREIGN KEY (ID_Pregunta)
        REFERENCES tb_sam_preguntas_evaluacion_w (ID_Pregunta),
    CONSTRAINT fk_respusuario_respuesta FOREIGN KEY (ID_RespuestaSeleccionada)
        REFERENCES tb_sam_respuestas_opcion_w (ID_Respuesta)
);
