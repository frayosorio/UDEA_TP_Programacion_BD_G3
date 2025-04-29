--Consultar datos de los encuentros con los datos relacionados
SELECT E.id, P1.pais, E.goles1, P2.pais, E.goles2, E.fecha, C.campeonato, P.pais, S.estadio
	FROM encuentro E
		JOIN pais P1 ON E.idpais1=P1.id
		JOIN pais P2 ON E.idpais2=P2.id
		JOIN campeonato C ON E.idcampeonato=C.id
		JOIN pais P ON C.idpais=P.id
		JOIN estadio S ON E.idestadio = S.id
	WHERE C.campeonato='FIFA U-20 Women''s World Cup Colombia 2024'

--Total de goles marcados por "Brasil" en el campeonato femenino sub20
SELECT SUM(CASE WHEN P.id=E.idpais1 THEN E.goles1 
			WHEN P.id=E.idpais2 THEN E.goles2 
			ELSE 0
			END) TotalGoles
	FROM encuentro E
		JOIN pais P ON P.id IN (E.idpais1, E.idpais2)
		JOIN campeonato C ON E.idcampeonato=C.id
	WHERE C.campeonato='FIFA U-20 Women''s World Cup Colombia 2024'
		AND P.pais='Brasil'

--Consulta de verificacón de la anterior suamtoria
SELECT P1.pais, E.goles1, P2.pais, E.goles2, E.fecha, C.campeonato
	FROM encuentro E
		JOIN pais P1 ON E.idpais1=P1.id
		JOIN pais P2 ON E.idpais2=P2.id
		JOIN campeonato C ON E.idcampeonato=C.id
	WHERE C.campeonato='FIFA U-20 Women''s World Cup Colombia 2024'
		AND (P1.pais='Brasil' OR P2.pais='Brasil')

--Totalizar los goles marcados por cada selección del campeonato femenino sub20
SELECT P.pais,
	SUM(CASE WHEN P.id=E.idpais1 THEN E.goles1 
			WHEN P.id=E.idpais2 THEN E.goles2 
			ELSE 0
			END) TotalGoles
	FROM encuentro E
		JOIN pais P ON P.id IN (E.idpais1, E.idpais2)
		JOIN campeonato C ON E.idcampeonato=C.id
	WHERE C.campeonato='FIFA U-20 Women''s World Cup Colombia 2024'
	GROUP BY P.pais

--Total de partidos jugados en cada estadio del campeonato femenino sub20
SELECT S.estadio, COUNT(*) TotalEncuentros
	FROM encuentro E
		JOIN estadio S ON E.idestadio=S.id
		JOIN campeonato C ON E.idcampeonato=C.id
	WHERE C.campeonato='FIFA U-20 Women''s World Cup Colombia 2024'
	GROUP BY S.estadio

--En cuales estadios se jugaron mas de 5 encuentros en el campeonato femenino sub20
SELECT S.estadio, COUNT(*) TotalEncuentros
	FROM encuentro E
		JOIN estadio S ON E.idestadio=S.id
		JOIN campeonato C ON E.idcampeonato=C.id
	WHERE C.campeonato='FIFA U-20 Women''s World Cup Colombia 2024'
	GROUP BY S.estadio
	HAVING COUNT(*)>5

--Mostrar las selecciones que marcaron más de 10 goles en el campeonato femenino sub20
SELECT P.pais,
	SUM(CASE WHEN P.id=E.idpais1 THEN E.goles1 
			WHEN P.id=E.idpais2 THEN E.goles2 
			ELSE 0
			END) TotalGoles
	FROM encuentro E
		JOIN pais P ON P.id IN (E.idpais1, E.idpais2)
		JOIN campeonato C ON E.idcampeonato=C.id
	WHERE C.campeonato='FIFA U-20 Women''s World Cup Colombia 2024'
	GROUP BY P.pais
	HAVING SUM(CASE WHEN P.id=E.idpais1 THEN E.goles1 
			WHEN P.id=E.idpais2 THEN E.goles2 
			ELSE 0
			END)>10

--Agregar el encuentro: 1 Septiembre 2024, Alemania 5–2 Venezuela, Estadio El Techo, Bogotá
-- del campeonato femenino sub20

SELECT * FROM encuentro
SELECT * FROM pais WHERE pais IN ('Alemania', 'Venezuela')
SELECT * FROM fase
SELECT * FROM campeonato WHERE campeonato='FIFA U-20 Women''s World Cup Colombia 2024'
SELECT * FROM estadio WHERE estadio LIKE '%Techo%'

SELECT MAX(id) FROM encuentro

INSERT INTO encuentro
	(id, idpais1, idpais2, idfase, idcampeonato, idestadio, goles1, goles2)
	VALUES(31, 4, 17, 1, 12, 62, 5, 2)

--Actualizar la fecha del anterior partido
UPDATE encuentro
	SET fecha='2024-09-01'
	WHERE id=31

--Averiguar nombre del gestor de autonumericos de la tabla 'encuentro'
SELECT pg_get_serial_sequence('encuentro', 'id');

ALTER SEQUENCE encuentro_id_seq RESTART 32

--Agregar el encuentro: 1 Septiembre 2024, Nigeria 1–0 Coreal del Sur, Estadio El Techo, Bogotá
-- del campeonato femenino sub20

SELECT * FROM pais WHERE pais IN ('Nigeria', 'Corea del Sur')

INSERT INTO encuentro
	(idpais1, idpais2, idfase, idcampeonato, idestadio, goles1, goles2)
	VALUES(52, 47, 1, 12, 62, 1, 0)
