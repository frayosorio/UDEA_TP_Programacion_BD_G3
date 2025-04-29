SELECT P1.pais, E.goles1, P2.pais, E.goles2, E.fecha, C.campeonato, P.pais
	FROM encuentro E
		JOIN pais P1 ON E.idpais1=P1.id
		JOIN pais P2 ON E.idpais2=P2.id
		JOIN campeonato C ON E.idcampeonato=C.id
		JOIN pais P ON C.idpais=P.id
	WHERE goles1>3 OR goles2>3;

--Total de goles marcados por Colombia en el campeonato femenino sub20
SELECT SUM(CASE WHEN P1.pais='Colombia' THEN E.goles1 
			WHEN P2.pais='Colombia' THEN E.goles2 
			ELSE 0
			END)
	FROM encuentro E
		JOIN pais P1 ON E.idpais1=P1.id
		JOIN pais P2 ON E.idpais2=P2.id
		JOIN campeonato C ON E.idcampeonato=C.id
	WHERE C.campeonato='FIFA U-20 Women''s World Cup Colombia 2024'
		AND (P1.pais='Colombia' OR P2.pais='Colombia')

SELECT P1.pais, E.goles1, P2.pais, E.goles2, E.fecha, C.campeonato
	FROM encuentro E
		JOIN pais P1 ON E.idpais1=P1.id
		JOIN pais P2 ON E.idpais2=P2.id
		JOIN campeonato C ON E.idcampeonato=C.id
	WHERE C.campeonato='FIFA U-20 Women''s World Cup Colombia 2024'
		AND (P1.pais='Colombia' OR P2.pais='Colombia')

