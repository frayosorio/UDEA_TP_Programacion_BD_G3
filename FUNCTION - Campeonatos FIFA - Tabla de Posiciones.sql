--Version IMPERATIVA
CREATE OR REPLACE FUNCTION fObtenerTablaPosiciones(
    idGrupoTabla BIGINT --Parametro de entrada
)
RETURNS TABLE(
    Id INTEGER,
    Pais VARCHAR(100),
    PJ INTEGER,
    PG INTEGER,
    PE INTEGER,
    PP INTEGER,
    GF INTEGER,
    GC INTEGER,
    Puntos INTEGER
) -- Estructura de la tabla de retorno
AS $$
    DECLARE idCampeonatoGrupo INTEGER; --Almacenará la clave primaria del campeonato
        cEquipo CURSOR FOR
            SELECT T.id
                FROM tablaPosiciones T; -- Cursor con consulta que obtiene las claves primarias de los equipos del grupo
        registro RECORD; --Almacenará temporalmente registro del cursor
        valor INTEGER; --Almacenará valores calculados
BEGIN
    DROP TABLE IF EXISTS tablaPosiciones;
    CREATE TEMP TABLE tablaPosiciones AS
        --Poblar la tabla temporal con los equipos que conforman el grupo y valores predeterminados
        SELECT P.id, P.Pais Pais, 0 PJ, 0 PG, 0 PE, 0 PP, 0 GF, 0 GC, 0 Puntos
            FROM Pais P
                JOIN GrupoPais GP ON P.id=GP.idPais
            WHERE GP.idGrupo=idGrupoTabla;
    
    --Obtener el campeonato del grupo
    SELECT G.idCampeonato INTO idCampeonatoGrupo
        FROM Grupo G
        WHERE G.id=idGrupoTabla;
    
    --Abrir el Cursor con consulta que obtiene las claves primarias de los equipos
    OPEN cEquipo;
    
    --Recorrer el cursor
    LOOP
        --Obtener el registro desde el cursor
        FETCH cEquipo INTO registro;
        --Salida del ciclo
        EXIT WHEN NOT FOUND;
        
        -- Calcular Encuentros Jugados
        SELECT COUNT(*) INTO valor
            FROM Encuentro
            WHERE (idPais1=registro.id OR idPais2=registro.id)
                AND idFase=1 AND idCampeonato=idCampeonatoGrupo
                AND goles1 IS NOT NULL
                AND goles2 IS NOT NULL;
        
        --Actualizar la tabla temporal
        UPDATE tablaPosiciones
            SET PJ=valor
            WHERE tablaPosiciones.id=registro.id;
            
        -- Calcular Encuentros Ganados
        SELECT SUM(CASE WHEN (idPais1=registro.id AND goles1>goles2)
                            OR (idPais2=registro.id AND goles2>goles1)
                    THEN 1
                    ELSE 0
                    END) INTO valor
            FROM Encuentro
            WHERE (idPais1=registro.id OR idPais2=registro.id)
                AND idFase=1 AND idCampeonato=idCampeonatoGrupo
                AND goles1 IS NOT NULL
                AND goles2 IS NOT NULL;
        
        --Actualizar la tabla temporal
        UPDATE tablaPosiciones
            SET PG=valor
            WHERE tablaPosiciones.id=registro.id;
    
        -- Calcular Encuentros Empatados
        SELECT SUM(CASE WHEN goles1=goles2
                    THEN 1
                    ELSE 0
                    END) INTO valor
            FROM Encuentro
            WHERE (idPais1=registro.id OR idPais2=registro.id)
                AND idFase=1 AND idCampeonato=idCampeonatoGrupo
                AND goles1 IS NOT NULL
                AND goles2 IS NOT NULL;
        
        --Actualizar la tabla temporal
        UPDATE tablaPosiciones
            SET PE=valor
            WHERE tablaPosiciones.id=registro.id;
            
        -- Calcular Encuentros Perdidos
        SELECT SUM(CASE WHEN (idPais1=registro.id AND goles1<goles2)
                            OR (idPais2=registro.id AND goles2<goles1)
                    THEN 1
                    ELSE 0
                    END) INTO valor
            FROM Encuentro
            WHERE (idPais1=registro.id OR idPais2=registro.id)
                AND idFase=1 AND idCampeonato=idCampeonatoGrupo
                AND goles1 IS NOT NULL
                AND goles2 IS NOT NULL;
        
        --Actualizar la tabla temporal
        UPDATE tablaPosiciones
            SET PP=valor
            WHERE tablaPosiciones.id=registro.id;
            
        -- Calcular Goles a Favor
        SELECT SUM(CASE WHEN idPais1=registro.id
                    THEN goles1
                    ELSE goles2
                    END) INTO valor
            FROM Encuentro
            WHERE (idPais1=registro.id OR idPais2=registro.id)
                AND idFase=1 AND idCampeonato=idCampeonatoGrupo
                AND goles1 IS NOT NULL
                AND goles2 IS NOT NULL;
        
        --Actualizar la tabla temporal
        UPDATE tablaPosiciones
            SET GF=valor
            WHERE tablaPosiciones.id=registro.id;
            
        -- Calcular Goles en Contra
        SELECT SUM(CASE WHEN idPais1=registro.id
                    THEN goles2
                    ELSE goles1
                    END) INTO valor
            FROM Encuentro
            WHERE (idPais1=registro.id OR idPais2=registro.id)
                AND idFase=1 AND idCampeonato=idCampeonatoGrupo
                AND goles1 IS NOT NULL
                AND goles2 IS NOT NULL;
        
        --Actualizar la tabla temporal
        UPDATE tablaPosiciones
            SET GC=valor
            WHERE tablaPosiciones.id=registro.id;
    END LOOP;
    
    --cerrar el cursor
	CLOSE cEquipo;
    
    --terminar retornando una consulta a la tabla temporal
    RETURN QUERY
        SELECT T.id, T.pais, T.PJ, T.PG, T.PE, T.PP, T.GF, T.GC, T.PG*3+T.PE Puntos
            FROM tablaPosiciones T
            ORDER BY Puntos DESC, T.GF-T.GC DESC;
    
END
$$ LANGUAGE plpgsql

--Version DECLARATIVA
CREATE OR REPLACE FUNCTION fObtenerTablaPosiciones(
    idGrupoTabla INTEGER --Parametro de entrada
)
RETURNS TABLE(
    Id INTEGER,
    Pais VARCHAR(100),
    PJ INTEGER,
    PG INTEGER,
    PE INTEGER,
    PP INTEGER,
    GF INTEGER,
    GC INTEGER,
    Puntos INTEGER
) -- Estructura de la tabla de retorno
AS $$
    DECLARE idCampeonatoGrupo INTEGER;
BEGIN
	--Obtener el campeonato del grupo
    SELECT G.idCampeonato INTO idCampeonatoGrupo
        FROM Grupo G
        WHERE G.id=idGrupoTabla;

	RETURN QUERY
        SELECT P.id, P.pais, CAST(COUNT(E.id) AS INTEGER) PJ,
				CAST(SUM(CASE WHEN (E.idpais1=P.id AND E.goles1>E.goles2)
                            OR (E.idPais2=P.id AND E.goles2>E.goles1)
                    THEN 1
                    ELSE 0
                    END) AS INTEGER) PG,
				CAST(SUM(CASE WHEN E.goles1=E.goles2
                    THEN 1
                    ELSE 0
                    END) AS INTEGER) PE, 
				CAST(SUM(CASE WHEN (E.idpais1=P.id AND E.goles1<E.goles2)
                            OR (E.idPais2=P.id AND E.goles2<E.goles1)
                    THEN 1
                    ELSE 0
                    END) AS INTEGER) PP, 
				CAST(SUM(CASE WHEN E.idpais1=P.id
                    THEN E.goles1
                    ELSE E.goles2
                    END) AS INTEGER) GF, 
				CAST(SUM(CASE WHEN E.idpais1=P.id
                    THEN E.goles2
                    ELSE E.goles1
                    END) AS INTEGER) GC, 
				CAST(SUM(CASE WHEN (E.idpais1=P.id AND E.goles1>E.goles2)
                            OR (E.idPais2=P.id AND E.goles2>E.goles1)
                   	THEN 3
					WHEN E.goles1=E.goles2
					THEN 1
                    ELSE 0
                    END) AS INTEGER) Puntos
			FROM pais P
                JOIN grupopais GP ON P.id=GP.idpais
				LEFT JOIN encuentro E ON (P.id = E.idpais1 OR P.id = E.idpais2)
										AND E.idfase =1 AND E.idcampeonato = idCampeonatoGrupo
										AND E.goles1 IS NOT NULL AND E.goles2 IS NOT NULL
			WHERE GP.idgrupo = idGrupoTabla 
			GROUP BY P.id, P.pais;
END
$$ LANGUAGE plpgsql
