--1 Generar Preguntas para evaluaciones
CREATE OR REPLACE PROCEDURE sp_generar_pregunta (
    p_ID_Pregunta IN tb_sam_preguntas_evaluacion_w.ID_Pregunta%TYPE,
    p_ID_Evaluacion IN tb_sam_preguntas_evaluacion_w.ID_Evaluacion%TYPE,
    p_Pregunta IN tb_sam_preguntas_evaluacion_w.Pregunta%TYPE,
    p_Puntaje IN tb_sam_preguntas_evaluacion_w.Puntaje%TYPE
) AS
BEGIN
    IF p_ID_Pregunta IS NOT NULL THEN
        UPDATE tb_sam_preguntas_evaluacion_w
        SET Pregunta = p_Pregunta,
            Puntaje = p_Puntaje
        WHERE ID_Pregunta = p_ID_Pregunta;
    ELSE
        INSERT INTO tb_sam_preguntas_evaluacion_w (ID_Evaluacion, Pregunta, Puntaje)
        VALUES (p_ID_Evaluacion, p_Pregunta, p_Puntaje);
    END IF;
END sp_generar_pregunta;
/

--2 Asignar opciones de respuestas a preguntas
CREATE OR REPLACE PROCEDURE sp_asignar_opcion_respuesta (
    p_ID_Pregunta IN tb_sam_respuestas_opcion_w.ID_Pregunta%TYPE,
    p_Respuesta IN tb_sam_respuestas_opcion_w.Respuesta%TYPE,
    p_EsCorrecta IN tb_sam_respuestas_opcion_w.EsCorrecta%TYPE
) AS
BEGIN
    INSERT INTO tb_sam_respuestas_opcion_w (ID_Pregunta, Respuesta, EsCorrecta)
    VALUES (p_ID_Pregunta, p_Respuesta, p_EsCorrecta);
END sp_asignar_opcion_respuesta;
/

--3 Asignar Respuesta Correcta a una pregunta
CREATE OR REPLACE PROCEDURE sp_asignar_respuesta_correcta (
    p_ID_Respuesta IN tb_sam_respuestas_opcion_w.ID_Respuesta%TYPE,
    p_ID_Pregunta IN tb_sam_respuestas_opcion_w.ID_Pregunta%TYPE
) AS
BEGIN
    UPDATE tb_sam_respuestas_opcion_w
    SET EsCorrecta = 'N'
    WHERE ID_Pregunta = p_ID_Pregunta;

    UPDATE tb_sam_respuestas_opcion_w
    SET EsCorrecta = 'Y'
    WHERE ID_Respuesta = p_ID_Respuesta;
END sp_asignar_respuesta_correcta;
/

--4 Asignar evaluaciones a Usuarios
CREATE OR REPLACE PROCEDURE sp_asignar_evaluacion_usuario (
    p_ID_Evaluacion IN tb_sam_evaluaciones_asignadas_w.ID_Evaluacion%TYPE,
    p_ID_Usuario IN tb_sam_evaluaciones_asignadas_w.ID_Usuario%TYPE,
    p_FechaInicio IN tb_sam_evaluaciones_asignadas_w.FechaInicio%TYPE,
    p_FechaFin IN tb_sam_evaluaciones_asignadas_w.FechaFin%TYPE,
    p_ID_Estatus IN tb_sam_evaluaciones_asignadas_w.ID_Estatus%TYPE
) AS
BEGIN
    INSERT INTO tb_sam_evaluaciones_asignadas_w (ID_Evaluacion, ID_Usuario, FechaInicio, FechaFin, ID_Estatus, Habilitado)
    VALUES (p_ID_Evaluacion, p_ID_Usuario, p_FechaInicio, p_FechaFin, p_ID_Estatus, 'Y');
END sp_asignar_evaluacion_usuario;
/

--5 Mostrar evaluaciones asignadas a un usuario de tipo empleado 
CREATE OR REPLACE PROCEDURE sp_mostrar_evaluaciones_asignadas (
    p_ID_Usuario IN tb_sam_usuarios_w.ID_Usuario%TYPE,
    p_Resultado OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Resultado FOR
        SELECT e.ID_Evaluacion, e.Nombre_Evaluacion, ea.FechaInicio, ea.FechaFin, es.Nombre_Estatus
        FROM tb_sam_evaluaciones_asignadas_w ea
        JOIN tb_sam_evaluaciones_w e ON ea.ID_Evaluacion = e.ID_Evaluacion
        JOIN tb_sam_estatus_c es ON ea.ID_Estatus = es.ID_Estatus
        WHERE ea.ID_Usuario = p_ID_Usuario;
END sp_mostrar_evaluaciones_asignadas;
/

--Mostrar resultados de evaluaciones
CREATE OR REPLACE PROCEDURE sp_mostrar_resultados_evaluacion (
    p_ID_EvaluacionAsignada IN tb_sam_evaluaciones_asignadas_w.ID_EvaluacionAsignada%TYPE,
    p_Resultado OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Resultado FOR
        SELECT p.Pregunta, ro.Respuesta, ro.EsCorrecta
        FROM tb_sam_preguntas_evaluacion_w p
        JOIN tb_sam_respuestas_opcion_w ro ON p.ID_Pregunta = ro.ID_Pregunta
        JOIN tb_sam_respuestas_usuario_w ru ON ro.ID_Respuesta = ru.ID_RespuestaSeleccionada
        WHERE ru.ID_EvaluacionAsignada = p_ID_EvaluacionAsignada;
END sp_mostrar_resultados_evaluacion;
/

--Monitoreo de todas las evaluaciones de los usuarios
CREATE OR REPLACE PROCEDURE sp_monitoreo_evaluaciones (
    p_Resultado OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Resultado FOR
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
END sp_monitoreo_evaluaciones;
/