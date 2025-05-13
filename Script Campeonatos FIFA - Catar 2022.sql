DO $$
DECLARE nuevoIdCampeonato INTEGER; nuevoIdPais INTEGER; nuevoIdCiudad INTEGER; nuevoIdEstadio INTEGER; 
	nuevoIdGrupo INTEGER; nuevoIdEncuentro INTEGER;
	idPaisSede INTEGER;
	idciudad1 INTEGER; idciudad2 INTEGER; idciudad3 INTEGER; idciudad4 INTEGER; idciudad5 INTEGER;
	idEstadio1 INTEGER; idEstadio2 INTEGER; idEstadio3 INTEGER; idEstadio4 INTEGER;
	idEstadio5 INTEGER; idEstadio6 INTEGER; idEstadio7 INTEGER; idEstadio8 INTEGER;
	idPais1Grupo INTEGER;idPais2Grupo INTEGER;idPais3Grupo INTEGER;idPais4Grupo INTEGER;
	totalPaisesGrupo INTEGER;

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

	--validar si ya existe el estadio 'Estadio Al Janoub'
	SELECT id INTO idEstadio8 FROM estadio WHERE estadio='Estadio Al Janoub';
	IF idEstadio8 IS NULL THEN
		SELECT id INTO idciudad5 FROM ciudad WHERE ciudad='Al Wakrah';
		IF idciudad5 IS NULL THEN
			INSERT INTO ciudad
				(id, ciudad, idpais)
				VALUES(nuevoIdCiudad, 'Al Wakrah', idPaisSede);
			idciudad5 := nuevoIdCiudad;
			--nuevoIdCiudad := nuevoIdCiudad + 1;
		END IF;
		INSERT INTO estadio
			(id, estadio, capacidad, idciudad)
			VALUES(nuevoIdEstadio, 'Estadio Al Janoub', 44325, idciudad5);
		idEstadio8 := nuevoIdEstadio;
		--nuevoIdEstadio := nuevoIdEstadio + 1;
	END IF;

	--validar si ya estan los grupos
	SELECT id INTO nuevoIdGrupo FROM grupo 
		WHERE grupo='A' AND idcampeonato=nuevoIdCampeonato;

	IF nuevoIdGrupo IS NULL THEN
		SELECT MAX(Id)+1 INTO nuevoIdGrupo FROM grupo;

		INSERT INTO grupo
			(id, grupo, idcampeonato)
			VALUES
			(nuevoIdGrupo, 'A', nuevoIdCampeonato),
			(nuevoIdGrupo+1, 'B', nuevoIdCampeonato),
			(nuevoIdGrupo+2, 'C', nuevoIdCampeonato),
			(nuevoIdGrupo+3, 'D', nuevoIdCampeonato),
			(nuevoIdGrupo+4, 'E', nuevoIdCampeonato),
			(nuevoIdGrupo+5, 'F', nuevoIdCampeonato),
			(nuevoIdGrupo+6, 'G', nuevoIdCampeonato),
			(nuevoIdGrupo+7, 'H', nuevoIdCampeonato);
	END IF;

	--***** Encuentros Grupo A ******
	idPais1Grupo = idPaisSede;

	--validar si ya existe el pais 'Ecuador'
	SELECT id INTO idPais2Grupo FROM pais WHERE pais='Ecuador';
	IF idPais2Grupo IS NULL THEN
		INSERT INTO pais
			(id, pais, entidad)
			VALUES(nuevoIdPais, 'Ecuador', '');
		idPais2Grupo := nuevoIdPais;
		nuevoIdPais := nuevoIdPais + 1;
	END IF;

	--validar si ya existe el pais 'Senegal'
	SELECT id INTO idPais3Grupo FROM pais WHERE pais='Senegal';
	IF idPais3Grupo IS NULL THEN
		INSERT INTO pais
			(id, pais, entidad)
			VALUES(nuevoIdPais, 'Senegal', '');
		idPais3Grupo := nuevoIdPais;
		nuevoIdPais := nuevoIdPais + 1;
	END IF;

	--validar si ya existe el pais 'Países Bajos'
	SELECT id INTO idPais4Grupo FROM pais WHERE pais='Países Bajos';
	IF idPais4Grupo IS NULL THEN
		INSERT INTO pais
			(id, pais, entidad)
			VALUES(nuevoIdPais, 'Países Bajos', '');
		idPais4Grupo := nuevoIdPais;
		nuevoIdPais := nuevoIdPais + 1;
	END IF;

	--Validar si ya estan los paises en el grupo
	SELECT COUNT(*) INTO totalPaisesGrupo
		FROM grupopais
		WHERE idgrupo=nuevoIdGrupo;

	IF totalPaisesGrupo=0 THEN
		INSERT INTO grupopais
			(idgrupo, idpais)
			VALUES
			(nuevoIdGrupo, idPais1Grupo),
			(nuevoIdGrupo, idPais2Grupo),
			(nuevoIdGrupo, idPais3Grupo),
			(nuevoIdGrupo, idPais4Grupo);
	END IF;

	SELECT MAX(Id)+1 INTO nuevoIdEncuentro FROM encuentro;

	--Catar 0:2 Ecuador
	IF NOT EXISTS(SELECT * FROM encuentro
				WHERE idpais1=idPais1Grupo AND idpais2=idPais2Grupo
					AND idfase=1 AND idcampeonato=nuevoIdCampeonato) THEN
		INSERT INTO encuentro
			(id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
			VALUES(nuevoIdEncuentro, idPais1Grupo, 0, idPais2Grupo, 2, '2022-11-20', idEstadio1, 1, nuevoIdCampeonato);
		nuevoIdEncuentro := nuevoIdEncuentro + 1;
	END IF;

	--Senegal 0:2 Países Bajos
	IF NOT EXISTS(SELECT * FROM encuentro
				WHERE idpais1=idPais3Grupo AND idpais2=idPais4Grupo
					AND idfase=1 AND idcampeonato=nuevoIdCampeonato) THEN
		INSERT INTO encuentro
			(id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
			VALUES(nuevoIdEncuentro, idPais3Grupo, 0, idPais4Grupo, 2, '2022-11-21', idEstadio4, 1, nuevoIdCampeonato);
			nuevoIdEncuentro := nuevoIdEncuentro + 1;
	END IF;

	--Catar 1:3 Senegal
	IF NOT EXISTS(SELECT * FROM encuentro
				WHERE idpais1=idPais1Grupo AND idpais2=idPais3Grupo
					AND idfase=1 AND idcampeonato=nuevoIdCampeonato) THEN
		INSERT INTO encuentro
			(id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
			VALUES(nuevoIdEncuentro, idPais1Grupo, 1, idPais3Grupo, 3, '2022-11-25', idEstadio4, 1, nuevoIdCampeonato);
			nuevoIdEncuentro := nuevoIdEncuentro + 1;
	END IF;
	
	--Países Bajos 1:1 Ecuador
	IF NOT EXISTS(SELECT * FROM encuentro
				WHERE idpais1=idPais4Grupo AND idpais2=idPais2Grupo
					AND idfase=1 AND idcampeonato=nuevoIdCampeonato) THEN
		INSERT INTO encuentro
			(id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
			VALUES(nuevoIdEncuentro, idPais4Grupo, 1, idPais2Grupo, 1, '2022-11-25', idEstadio7, 1, nuevoIdCampeonato);
			nuevoIdEncuentro := nuevoIdEncuentro + 1;
	END IF;
	
	--Ecuador 1:2 Senegal
	IF NOT EXISTS(SELECT * FROM encuentro
				WHERE idpais1=idPais2Grupo AND idpais2=idPais3Grupo
					AND idfase=1 AND idcampeonato=nuevoIdCampeonato) THEN
		INSERT INTO encuentro
			(id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
			VALUES(nuevoIdEncuentro, idPais2Grupo, 1, idPais3Grupo, 2, '2022-11-29', idEstadio7, 1, nuevoIdCampeonato);
			nuevoIdEncuentro := nuevoIdEncuentro + 1;
	END IF;

	--Países Bajos 2:0 Catar
	IF NOT EXISTS(SELECT * FROM encuentro
				WHERE idpais1=idPais4Grupo AND idpais2=idPais1Grupo
					AND idfase=1 AND idcampeonato=nuevoIdCampeonato) THEN
		INSERT INTO encuentro
			(id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
			VALUES(nuevoIdEncuentro, idPais4Grupo, 2, idPais1Grupo, 0, '2022-11-29', idEstadio1, 1, nuevoIdCampeonato);
			nuevoIdEncuentro := nuevoIdEncuentro + 1;
	END IF;

	--***** Encuentros Grupo B ******
	
	--validar si ya existe el pais 'Inglaterra'
	SELECT id INTO idPais1Grupo FROM pais WHERE pais='Inglaterra';
	IF idPais1Grupo IS NULL THEN
		INSERT INTO pais
			(id, pais, entidad)
			VALUES(nuevoIdPais, 'Inglaterra', '');
		idPais1Grupo := nuevoIdPais;
		nuevoIdPais := nuevoIdPais + 1;
	END IF;

	--validar si ya existe el pais 'Irán'
	SELECT id INTO idPais2Grupo FROM pais WHERE pais='Irán';
	IF idPais2Grupo IS NULL THEN
		INSERT INTO pais
			(id, pais, entidad)
			VALUES(nuevoIdPais, 'Irán', '');
		idPais2Grupo := nuevoIdPais;
		nuevoIdPais := nuevoIdPais + 1;
	END IF;

	--validar si ya existe el pais 'Estados Unidos'
	SELECT id INTO idPais3Grupo FROM pais WHERE pais='Estados Unidos';
	IF idPais3Grupo IS NULL THEN
		INSERT INTO pais
			(id, pais, entidad)
			VALUES(nuevoIdPais, 'Estados Unidos', '');
		idPais3Grupo := nuevoIdPais;
		nuevoIdPais := nuevoIdPais + 1;
	END IF;

	--validar si ya existe el pais 'Gales'
	SELECT id INTO idPais4Grupo FROM pais WHERE pais='Gales';
	IF idPais4Grupo IS NULL THEN
		INSERT INTO pais
			(id, pais, entidad)
			VALUES(nuevoIdPais, 'Gales', '');
		idPais4Grupo := nuevoIdPais;
		nuevoIdPais := nuevoIdPais + 1;
	END IF;

	--Validar si ya estan los paises en el grupo
	SELECT COUNT(*) INTO totalPaisesGrupo
		FROM grupopais
		WHERE idgrupo=nuevoIdGrupo+1;

	IF totalPaisesGrupo=0 THEN
		INSERT INTO grupopais
			(idgrupo, idpais)
			VALUES
			(nuevoIdGrupo+1, idPais1Grupo),
			(nuevoIdGrupo+1, idPais2Grupo),
			(nuevoIdGrupo+1, idPais3Grupo),
			(nuevoIdGrupo+1, idPais4Grupo);
	END IF;

	--Inglaterra 6:2 Irán
	IF NOT EXISTS(SELECT * FROM encuentro
				WHERE idpais1=idPais1Grupo AND idpais2=idPais2Grupo
					AND idfase=1 AND idcampeonato=nuevoIdCampeonato) THEN
		INSERT INTO encuentro
			(id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
			VALUES(nuevoIdEncuentro, idPais1Grupo, 6, idPais2Grupo, 2, '2022-11-21', idEstadio7, 1, nuevoIdCampeonato);
			nuevoIdEncuentro := nuevoIdEncuentro + 1;
	END IF;

	--Estados Unidos 1:1 Gales
	IF NOT EXISTS(SELECT * FROM encuentro
				WHERE idpais1=idPais3Grupo AND idpais2=idPais4Grupo
					AND idfase=1 AND idcampeonato=nuevoIdCampeonato) THEN
		INSERT INTO encuentro
			(id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
			VALUES(nuevoIdEncuentro, idPais3Grupo, 1, idPais4Grupo, 1, '2022-11-21', idEstadio6, 1, nuevoIdCampeonato);
			nuevoIdEncuentro := nuevoIdEncuentro + 1;
	END IF;

	--Inglaterra 0:0 Estados Unidos
	IF NOT EXISTS(SELECT * FROM encuentro
				WHERE idpais1=idPais1Grupo AND idpais2=idPais3Grupo
					AND idfase=1 AND idcampeonato=nuevoIdCampeonato) THEN
		INSERT INTO encuentro
			(id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
			VALUES(nuevoIdEncuentro, idPais1Grupo, 0, idPais3Grupo, 0, '2022-11-25', idEstadio1, 1, nuevoIdCampeonato);
			nuevoIdEncuentro := nuevoIdEncuentro + 1;
	END IF;
	
	--Gales 0:2 Irán
	IF NOT EXISTS(SELECT * FROM encuentro
				WHERE idpais1=idPais4Grupo AND idpais2=idPais2Grupo
					AND idfase=1 AND idcampeonato=nuevoIdCampeonato) THEN
		INSERT INTO encuentro
			(id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
			VALUES(nuevoIdEncuentro, idPais4Grupo, 0, idPais2Grupo, 2, '2022-11-25', idEstadio6, 1, nuevoIdCampeonato);
			nuevoIdEncuentro := nuevoIdEncuentro + 1;
	END IF;
	
	--Irán 0:1 Estados Unidos
	IF NOT EXISTS(SELECT * FROM encuentro
				WHERE idpais1=idPais2Grupo AND idpais2=idPais3Grupo
					AND idfase=1 AND idcampeonato=nuevoIdCampeonato) THEN
		INSERT INTO encuentro
			(id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
			VALUES(nuevoIdEncuentro, idPais2Grupo, 0, idPais3Grupo, 1, '2022-11-29', idEstadio4, 1, nuevoIdCampeonato);
			nuevoIdEncuentro := nuevoIdEncuentro + 1;
	END IF;

	--Gales 0:3 Inglaterra
	IF NOT EXISTS(SELECT * FROM encuentro
				WHERE idpais1=idPais4Grupo AND idpais2=idPais1Grupo
					AND idfase=1 AND idcampeonato=nuevoIdCampeonato) THEN
		INSERT INTO encuentro
			(id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
			VALUES(nuevoIdEncuentro, idPais4Grupo, 0, idPais1Grupo, 3, '2022-11-29', idEstadio6, 1, nuevoIdCampeonato);
			nuevoIdEncuentro := nuevoIdEncuentro + 1;
	END IF;

--***** Encuentros GRUPO F *****

	--validar si ya existe el pais 'Portugal'
	SELECT id INTO idPais1Grupo FROM pais WHERE pais='Portugal';
	IF idPais1Grupo IS NULL THEN
		INSERT INTO pais
			(id, pais, entidad)
			VALUES(nuevoIdPais, 'Portugal', '');
		idPais1Grupo := nuevoIdPais;
		nuevoIdPais := nuevoIdPais + 1;
	END IF;

	--validar si ya existe el pais 'Corea del Sur'
	SELECT id INTO idPais2Grupo FROM pais WHERE pais='Corea del Sur';
	IF idPais2Grupo IS NULL THEN
		INSERT INTO pais
			(id, pais, entidad)
			VALUES(nuevoIdPais, 'Corea del Sur', '');
		idPais2Grupo := nuevoIdPais;
		nuevoIdPais := nuevoIdPais + 1;
	END IF;

	--validar si ya existe el pais 'Uruguay'
	SELECT id INTO idPais3Grupo FROM pais WHERE pais='Uruguay';
	IF idPais3Grupo IS NULL THEN
		INSERT INTO pais
			(id, pais, entidad)
			VALUES(nuevoIdPais, 'Uruguay', '');
		idPais3Grupo := nuevoIdPais;
		nuevoIdPais := nuevoIdPais + 1;
	END IF;

	--validar si ya existe el pais 'Ghana'
	SELECT id INTO idPais4Grupo FROM pais WHERE pais='Ghana';
	IF idPais4Grupo IS NULL THEN
		INSERT INTO pais
			(id, pais, entidad)
			VALUES(nuevoIdPais, 'Ghana', '');
		idPais4Grupo := nuevoIdPais;
		nuevoIdPais := nuevoIdPais + 1;
	END IF;

	--Validar si ya estan los paises en el grupo
	SELECT COUNT(*) INTO totalPaisesGrupo
		FROM grupopais
		WHERE idgrupo=nuevoIdGrupo+7;

	IF totalPaisesGrupo=0 THEN
		INSERT INTO grupopais
			(idgrupo, idpais)
			VALUES
			(nuevoIdGrupo+7, idPais1Grupo),
			(nuevoIdGrupo+7, idPais2Grupo),
			(nuevoIdGrupo+7, idPais3Grupo),
			(nuevoIdGrupo+7, idPais4Grupo);
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
END $$;




