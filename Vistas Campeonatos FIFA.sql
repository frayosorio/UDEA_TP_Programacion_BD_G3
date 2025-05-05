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
		
CREATE VIEW vEstadio
AS
	SELECT C.ciudad || ' (' || P.pais || ')' ciudad,
		E.*
		FROM Estadio E
			JOIN ciudad C ON E.idciudad=C.id
			JOIN pais P ON p.id=C.idpais;


SELECT *
	FROM vEncuentro
	WHERE campeonato='FIFA World Cup 2022';

SELECT *
	FROM vEstadio
	WHERE ciudad LIKE '%Catar%'


	