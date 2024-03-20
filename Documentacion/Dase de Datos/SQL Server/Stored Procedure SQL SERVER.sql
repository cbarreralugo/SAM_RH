-- 1. Generate Questions for Evaluations
IF OBJECT_ID('sp_generar_pregunta', 'P') IS NOT NULL
    DROP PROCEDURE sp_generar_pregunta;
GO

CREATE PROCEDURE sp_generar_pregunta 
    @p_ID_Pregunta INT,
    @p_ID_Evaluacion INT,
    @p_Pregunta VARCHAR(500),
    @p_Puntaje INT
AS
BEGIN
    IF @p_ID_Pregunta IS NOT NULL
    BEGIN
        UPDATE tb_sam_preguntas_evaluacion_w
        SET Pregunta = @p_Pregunta,
            Puntaje = @p_Puntaje
        WHERE ID_Pregunta = @p_ID_Pregunta;
    END
    ELSE
    BEGIN
        INSERT INTO tb_sam_preguntas_evaluacion_w (ID_Evaluacion, Pregunta, Puntaje)
        VALUES (@p_ID_Evaluacion, @p_Pregunta, @p_Puntaje);
    END
END;
GO

-- 2. Assign response options to questions
IF OBJECT_ID('sp_asignar_opcion_respuesta', 'P') IS NOT NULL
    DROP PROCEDURE sp_asignar_opcion_respuesta;
GO

CREATE PROCEDURE sp_asignar_opcion_respuesta
    @p_ID_Pregunta INT,
    @p_Respuesta VARCHAR(500),
    @p_EsCorrecta CHAR(1)
AS
BEGIN
    INSERT INTO tb_sam_respuestas_opcion_w (ID_Pregunta, Respuesta, EsCorrecta)
    VALUES (@p_ID_Pregunta, @p_Respuesta, @p_EsCorrecta);
END;
GO

-- 3. Assign Correct Response to a question
IF OBJECT_ID('sp_asignar_respuesta_correcta', 'P') IS NOT NULL
    DROP PROCEDURE sp_asignar_respuesta_correcta;
GO

CREATE PROCEDURE sp_asignar_respuesta_correcta
    @p_ID_Respuesta INT,
    @p_ID_Pregunta INT
AS
BEGIN
    UPDATE ro
    SET EsCorrecta = CASE WHEN ro.ID_Respuesta = @p_ID_Respuesta THEN 'Y' ELSE 'N' END
    FROM tb_sam_respuestas_opcion_w ro
    WHERE ro.ID_Pregunta = @p_ID_Pregunta;
END;
GO

-- 4. Assign evaluations to Users
IF OBJECT_ID('sp_asignar_evaluacion_usuario', 'P') IS NOT NULL
    DROP PROCEDURE sp_asignar_evaluacion_usuario;
GO

CREATE PROCEDURE sp_asignar_evaluacion_usuario
    @p_ID_Evaluacion INT,
    @p_ID_Usuario INT,
    @p_FechaInicio DATETIME,
    @p_FechaFin DATETIME,
    @p_ID_Estatus INT
AS
BEGIN
    INSERT INTO tb_sam_evaluaciones_asignadas_w (ID_Evaluacion, ID_Usuario, FechaInicio, FechaFin, ID_Estatus, Habilitado)
    VALUES (@p_ID_Evaluacion, @p_ID_Usuario, @p_FechaInicio, @p_FechaFin, @p_ID_Estatus, 'Y');
END;
GO

-- 5. Show evaluations assigned to an employee type user
IF OBJECT_ID('sp_mostrar_evaluaciones_asignadas', 'P') IS NOT NULL
    DROP PROCEDURE sp_mostrar_evaluaciones_asignadas;
GO

CREATE PROCEDURE sp_mostrar_evaluaciones_asignadas
    @p_ID_Usuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT e.ID_Evaluacion, e.Nombre_Evaluacion, ea.FechaInicio, ea.FechaFin, es.Nombre_Estatus
    FROM tb_sam_evaluaciones_asignadas_w ea
    JOIN tb_sam_evaluaciones_w e ON ea.ID_Evaluacion = e.ID_Evaluacion
    JOIN tb_sam_estatus_c es ON ea.ID_Estatus = es.ID_Estatus
    WHERE ea.ID_Usuario = @p_ID_Usuario;
END;
GO

-- Show evaluation results
IF OBJECT_ID('sp_mostrar_resultados_evaluacion', 'P') IS NOT NULL
    DROP PROCEDURE sp_mostrar_resultados_evaluacion;
GO

CREATE PROCEDURE sp_mostrar_resultados_evaluacion
    @p_ID_EvaluacionAsignada INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT p.Pregunta, ro.Respuesta, ro.EsCorrecta
    FROM tb_sam_preguntas_evaluacion_w p
    JOIN tb_sam_respuestas_opcion_w ro ON p.ID_Pregunta = ro.ID_Pregunta
    JOIN tb_sam_respuestas_usuario_w ru ON ro.ID_Respuesta = ru.ID_RespuestaSeleccionada
    WHERE ru.ID_EvaluacionAsignada = @p_ID_EvaluacionAsignada;
END;
GO

-- Monitoring of all evaluations of users
IF OBJECT_ID('sp_monitoreo_evaluaciones', 'P') IS NOT NULL
    DROP PROCEDURE sp_monitoreo_evaluaciones;
GO

CREATE PROCEDURE sp_monitoreo_evaluaciones
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        e.ID_Evaluacion,
        e.Nombre_Evaluacion,
        u.Nombre AS Usuario,
        es.Nombre_Estatus,
        ea.FechaInicio,
        ea.FechaFin
    FROM 
        tb_sam_evaluaciones_asignadas_w ea
        JOIN tb_sam_evaluaciones_w e ON ea.ID_Evaluacion = e.ID_Evaluacion
        JOIN tb_sam_usuarios_w u ON ea.ID_Usuario = u.ID_Usuario
        JOIN tb_sam_estatus_c es ON ea.ID_Estatus = es.ID_Estatus
    ORDER BY 
        ea.FechaInicio DESC;
END;
GO
