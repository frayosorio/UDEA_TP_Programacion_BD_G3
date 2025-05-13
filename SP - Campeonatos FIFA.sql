--Version IMPERATIVA
CREATE OR REPLACE PROCEDURE spGenerarEncuentrosGrupo(
	idgrupogeneracion INTEGER
)
LANGUAGE plpgsql
AS $$
	DECLARE idcampeonatogrupo INTEGER;
		registropais1 RECORD;
		registropais2 RECORD;
		cursorPaises CURSOR FOR
			SELECT idpais
				FROM grupopais 
				WHERE idgrupo = idgrupogeneracion
				ORDER BY idpais;

		cursorOtrosPaises CURSOR(idpaisprocesado INTEGER) FOR
			SELECT idpais
				FROM grupopais 
				WHERE idgrupo = idgrupogeneracion
					AND idpais > idpaisprocesado
				ORDER BY idpais;
BEGIN
	SELECT idcampeonato INTO idcampeonatogrupo
		FROM grupo
		WHERE id = idgrupogeneracion;

	--abrir cursor con la lista de paises del GRUPO
	OPEN cursorPaises;
	
	--Repetir mientras haya equipos
	LOOP
		--Obtener el registro desde el cursor
		FETCH cursorPaises INTO registropais1;
		--Salida del ciclo
		EXIT WHEN NOT FOUND;

		--abrir cursor con la lista de los otros paises del GRUPO
		OPEN cursorOtrosPaises(registropais1.idpais);

		--Repetir mientras haya equipos
		LOOP
			--Obtener el registro desde el cursor
			FETCH cursorOtrosPaises INTO registropais2;
			--Salida del ciclo
			EXIT WHEN NOT FOUND;

			IF NOT EXISTS(SELECT * FROM encuentro
				WHERE ((idpais1=registropais1.idpais AND idpais2=registropais2.idpais) OR
					(idpais1=registropais2.idpais AND idpais2=registropais1.idpais)) 
					AND idfase=1 AND idcampeonato=idcampeonatogrupo) THEN
				INSERT INTO encuentro
					(idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
					VALUES(registropais1.idpais, null, registropais2.idpais, null, null, 0, 1, idcampeonatogrupo);
			END IF;
		END LOOP;
		CLOSE cursorOtrosPaises;
	END LOOP;
	CLOSE cursorPaises;
END;
$$;

--Version DECLARATIVA
CREATE OR REPLACE PROCEDURE spGenerarEncuentrosGrupo(
	idgrupogeneracion INTEGER
)
LANGUAGE plpgsql
AS $$
	DECLARE idcampeonatogrupo INTEGER;
	
BEGIN
	SELECT idcampeonato INTO idcampeonatogrupo
		FROM grupo
		WHERE id = idgrupogeneracion;

	INSERT INTO encuentro
		(idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
		SELECT GP1.idpais, null, GP2.idpais, null, null, 0, 1, idcampeonatogrupo
			FROM grupopais GP1
				JOIN grupopais GP2 ON GP1.idgrupo = GP2.idgrupo
					AND GP1.idpais < GP2.idpais
			WHERE GP1.idgrupo = idgrupogeneracion
				AND NOT EXISTS(SELECT * FROM encuentro
							WHERE ((idpais1=GP1.idpais AND idpais2=GP2.idpais) OR
								(idpais1=GP2.idpais AND idpais2=GP1.idpais)) 
								AND idfase=1 AND idcampeonato=idcampeonatogrupo);
END;
$$;