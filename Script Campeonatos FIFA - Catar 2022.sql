DO $$
DECLARE nuevoIdCampeonato INTEGER; nuevoIdPais INTEGER; nuevoIdCiudad INTEGER; nuevoIdEstadio INTEGER; nuevoIdGrupo INTEGER;
	idPaisSede INTEGER;
	idciudad1 INTEGER; idciudad2 INTEGER; idciudad3 INTEGER; idciudad4 INTEGER; idciudad5 INTEGER;
	idEstadio1 INTEGER; idEstadio2 INTEGER; idEstadio3 INTEGER; idEstadio4 INTEGER;
	idEstadio5 INTEGER; idEstadio6 INTEGER; idEstadio7 INTEGER; idEstadio8 INTEGER;

BEGIN
	SELECT MAX(Id)+1 INTO nuevoIdPais FROM pais;

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

-- Ciudades y estadios
-- 1: Jor       - 1: Estadio Al Bayt
-- 2: Lusail    - 2: Estadio de Lusail
-- 3: Doha      - 3: Estadio 974, 
--                4: Estadio Al Thumama 
-- 4: Rayán     - 5: Estadio Ciudad de la Educación,
--                6: Estadio Áhmad bin Ali,
--                7: Estadio Internacional Khalifa
-- 5: Al Wakrah - 8: Estadio Al Janoub
	SELECT MAX(Id)+1 INTO nuevoIdCiudad FROM ciudad;
	SELECT MAX(Id)+1 INTO nuevoIdEstadio FROM estadio;

	--validar si ya existe el estadio 'Estadio Al Bayt'
	SELECT id INTO idEstadio1 FROM estadio WHERE estadio='Estadio Al Bayt';
	IF idEstadio1 IS NULL THEN
		SELECT id INTO idciudad1 FROM ciudad WHERE ciudad='Jor';
		IF idciudad1 IS NULL THEN
			INSERT INTO ciudad
				(id, ciudad, idpais)
				VALUES(nuevoIdCiudad, 'Jor', idPaisSede);
			idciudad1 := nuevoIdCiudad;
			nuevoIdCiudad := nuevoIdCiudad + 1;
		END IF;
		INSERT INTO estadio
			(id, estadio, capacidad, idciudad)
			VALUES(nuevoIdEstadio, 'Estadio Al Bayt', 68895, idciudad1);
		idEstadio1 := nuevoIdEstadio;
		nuevoIdEstadio := nuevoIdEstadio + 1;
	END IF;
	
	--validar si ya existe el estadio 'Estadio de Lusail'
	SELECT id INTO idEstadio2 FROM estadio WHERE estadio='Estadio de Lusail';
	IF idEstadio2 IS NULL THEN
		SELECT id INTO idciudad2 FROM ciudad WHERE ciudad='Lusail';
		IF idciudad2 IS NULL THEN
			INSERT INTO ciudad
				(id, ciudad, idpais)
				VALUES(nuevoIdCiudad, 'Lusail', idPaisSede);
			idciudad2 := nuevoIdCiudad;
			nuevoIdCiudad := nuevoIdCiudad + 1;
		END IF;
		INSERT INTO estadio
			(id, estadio, capacidad, idciudad)
			VALUES(nuevoIdEstadio, 'Estadio de Lusail', 88966, idciudad2);
		idEstadio2 := nuevoIdEstadio;
		nuevoIdEstadio := nuevoIdEstadio + 1;
	END IF;

	--validar si ya existe la ciudad 'Doha'
	SELECT id INTO idciudad3 FROM ciudad WHERE ciudad='Doha';
	IF idciudad3 IS NULL THEN
		INSERT INTO ciudad
			(id, ciudad, idpais)
			VALUES(nuevoIdCiudad, 'Doha', idPaisSede);
		idciudad3 := nuevoIdCiudad;
		nuevoIdCiudad := nuevoIdCiudad + 1;
	END IF;
	--validar si ya existe el estadio 'Estadio 974'
	SELECT id INTO idEstadio3 FROM estadio WHERE estadio='Estadio 974';
	IF idEstadio3 IS NULL THEN
		INSERT INTO estadio
			(id, estadio, capacidad, idciudad)
			VALUES(nuevoIdEstadio, 'Estadio 974', 44089, idciudad3);
		idEstadio3 := nuevoIdEstadio;
		nuevoIdEstadio := nuevoIdEstadio + 1;
	END IF;
	--validar si ya existe el estadio 'Estadio Al Thumama'
	SELECT id INTO idEstadio4 FROM estadio WHERE estadio='Estadio Al Thumama';
	IF idEstadio4 IS NULL THEN
		INSERT INTO estadio
			(id, estadio, capacidad, idciudad)
			VALUES(nuevoIdEstadio, 'Estadio Al Thumama', 44400, idciudad3);
		idEstadio4 := nuevoIdEstadio;
		nuevoIdEstadio := nuevoIdEstadio + 1;
	END IF;

	--validar si ya existe la ciudad 'Rayán'
	SELECT id INTO idciudad4 FROM ciudad WHERE ciudad='Rayán';
		IF idciudad4 IS NULL THEN
			INSERT INTO ciudad
				(id, ciudad, idpais)
				VALUES(nuevoIdCiudad, 'Rayán', idPaisSede);
			idciudad4 := nuevoIdCiudad;
			nuevoIdCiudad := nuevoIdCiudad + 1;
		END IF;
	--validar si ya existe el estadio 'Estadio Ciudad de la Educación'
	SELECT id INTO idEstadio5 FROM estadio WHERE estadio='Estadio Ciudad de la Educación';
	IF idEstadio5 IS NULL THEN
		INSERT INTO estadio
			(id, estadio, capacidad, idciudad)
			VALUES(nuevoIdEstadio, 'Estadio Ciudad de la Educación', 44667, idciudad4);
		idEstadio5 := nuevoIdEstadio;
		nuevoIdEstadio := nuevoIdEstadio + 1;
	END IF;
	--validar si ya existe el estadio 'Estadio Áhmad bin Ali'
	SELECT id INTO idEstadio6 FROM estadio WHERE estadio='Estadio Áhmad bin Ali';
	IF idEstadio6 IS NULL THEN
		INSERT INTO estadio
			(id, estadio, capacidad, idciudad)
			VALUES(nuevoIdEstadio, 'Estadio Áhmad bin Ali', 45032, idciudad4);
		idEstadio6 := nuevoIdEstadio;
		nuevoIdEstadio := nuevoIdEstadio + 1;
	END IF;
	--validar si ya existe el estadio 'Estadio Internacional Khalifa'
	SELECT id INTO idEstadio7 FROM estadio WHERE estadio='Estadio Internacional Khalifa';
	IF idEstadio7 IS NULL THEN
		INSERT INTO estadio
			(id, estadio, capacidad, idciudad)
			VALUES(nuevoIdEstadio, 'Estadio Internacional Khalifa', 45857, idciudad4);
		idEstadio7 := nuevoIdEstadio;
		nuevoIdEstadio := nuevoIdEstadio + 1;
	END IF;


END $$;




