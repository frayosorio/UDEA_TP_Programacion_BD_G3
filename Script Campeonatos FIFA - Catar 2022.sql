DO $$
DECLARE nuevoIdCampeonato INTEGER; nuevoIdPais INTEGER; nuevoIdCiudad INTEGER; nuevoIdEstadio INTEGER; nuevoIdGrupo INTEGER;
	idPaisSede INTEGER;

BEGIN
	SELECT MAX(Id)+1 INTO nuevoIdPais
		FROM pais;

	--validar si ya está el País Sede
	SELECT id INTO idPaisSede FROM pais WHERE pais='Catar';
	IF idPaisSede IS NULL THEN
		INSERT INTO pais
			(id, pais, entidad)
			VALUES(nuevoIdPais, 'Catar', '');
		idPaisSede := nuevoIdPais;
		nuevoIdPais := nuevoIdPais + 1;
	END IF;

	--validar si ya está el Campeonato
	SELECT id INTO nuevoIdCampeonato FROM campeonato 
		WHERE campeonato='FIFA World Cup 2022';
	IF nuevoIdCampeonato IS NULL THEN
		SELECT MAX(Id)+1 INTO nuevoIdCampeonato FROM campeonato;
		INSERT INTO campeonato
			(id, campeonato, idpais, año)
			VALUES(nuevoIdCampeonato, 'FIFA World Cup 2022', idPaisSede, 2022);
	END IF;

END $$;




