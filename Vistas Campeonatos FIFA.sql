CREATE VIEW vEncuentro
AS
	SELECT P1.pais pais1, E.goles1 || '-' || E.goles2 marcador, P2.pais pais2, C.campeonato, P.pais paisSede, S.estadio,
		E.*
		FROM encuentro E
			JOIN pais P1 ON E.idpais1=P1.id
			JOIN pais P2 ON E.idpais2=P2.id
			JOIN campeonato C ON E.idcampeonato=C.id
			JOIN pais P ON C.idpais=P.id
			JOIN estadio S ON E.idestadio = S.id;
		

SELECT *
	FROM vEncuentro
	WHERE campeonato='FIFA U-20 Women''s World Cup Colombia 2024';
	