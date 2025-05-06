DO $$
DECLARE totalPaises INTEGER;
    nuevoIdCampeonato INTEGER; nuevoIdGrupo INTEGER; nuevoIdPais INTEGER;
    nuevoIdCiudad INTEGER; nuevoIdEstadio INTEGER; nuevoIdEncuentro INTEGER;
    idPais1Grupo INTEGER; idPais2Grupo INTEGER; idPais3Grupo INTEGER; idPais4Grupo INTEGER;
    idMedellin INTEGER; idCali INTEGER; idBogota INTEGER; idColombia INTEGER;
    idEstadio1 INTEGER; idEstadio2 INTEGER; idEstadio3 INTEGER; idEstadio4 INTEGER;
BEGIN
    SELECT MAX(Id)+1 INTO nuevoIdPais
        FROM pais;
        
    SELECT id INTO idColombia FROM pais WHERE pais='Colombia';
    IF idColombia IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Colombia', '');
        idColombia := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    --validar si ya está el campeonato
    SELECT id INTO nuevoIdCampeonato 
        FROM campeonato
        WHERE campeonato='FIFA U-20 Women''s World Cup Colombia 2024';
    IF nuevoIdCampeonato IS NULL THEN
        SELECT MAX(Id)+1 INTO nuevoIdCampeonato FROM campeonato;
        INSERT INTO campeonato
            (id, campeonato, idpais, año)
            VALUES(nuevoIdCampeonato, 'FIFA U-20 Women''s World Cup Colombia 2024', idColombia, 2024);
    END IF;
    
    SELECT MAX(Id)+1 INTO nuevoIdCiudad
        FROM ciudad;
        
    SELECT MAX(Id)+1 INTO nuevoIdEstadio
        FROM estadio;
    
    SELECT id INTO idEstadio1 FROM estadio WHERE estadio='Estadio Atanasio Girardot';
    IF idEstadio1 IS NULL THEN
        SELECT id INTO idMedellin FROM ciudad WHERE ciudad='Medellín';
        IF idMedellin IS NULL THEN
            INSERT INTO ciudad
                (id, ciudad, idpais) VALUES(nuevoIdCiudad, 'Medellín', idColombia);
            idMedellin := nuevoIdCiudad;
            nuevoIdCiudad := nuevoIdCiudad + 1;
        END IF;
        INSERT INTO estadio
            (id, estadio, capacidad, idciudad) VALUES(nuevoIdEstadio, 'Estadio Atanasio Girardot', 0, idMedellin);
        idEstadio1 := nuevoIdEstadio;
        nuevoIdEstadio := nuevoIdEstadio + 1;
    END IF;
    
    SELECT id INTO idEstadio2 FROM estadio WHERE estadio='Estadio Olímpico Pascual Guerrero';
    IF idEstadio2 IS NULL THEN
        SELECT id INTO idCali FROM ciudad WHERE ciudad='Cali';
        IF idCali IS NULL THEN
            INSERT INTO ciudad
                (id, ciudad, idpais) VALUES(nuevoIdCiudad, 'Cali', idColombia);
            idCali := nuevoIdCiudad;
            nuevoIdCiudad := nuevoIdCiudad + 1;
        END IF;
        INSERT INTO estadio
            (id, estadio, capacidad, idciudad) VALUES(nuevoIdEstadio, 'Estadio Olímpico Pascual Guerrero', 0, idCali);
        idEstadio2 := nuevoIdEstadio;
        nuevoIdEstadio := nuevoIdEstadio + 1;
    END IF;

    SELECT id INTO idEstadio3 FROM estadio WHERE estadio='Estadio Nemesio Camacho El Campín';
    IF idEstadio3 IS NULL THEN
        SELECT id INTO idBogota FROM ciudad WHERE ciudad='Bogotá';
        IF idBogota IS NULL THEN
            INSERT INTO ciudad
                (id, ciudad, idpais) VALUES(nuevoIdCiudad, 'Bogotá', idColombia);
            idBogota := nuevoIdCiudad;
            nuevoIdCiudad := nuevoIdCiudad + 1;
        END IF;
        INSERT INTO estadio
            (id, estadio, capacidad, idciudad) VALUES(nuevoIdEstadio, 'Estadio Nemesio Camacho El Campín', 0, idBogota);
        idEstadio3 := nuevoIdEstadio;
        nuevoIdEstadio := nuevoIdEstadio + 1;
    END IF;
    
    SELECT id INTO idEstadio4 FROM estadio WHERE estadio='Estadio Metropolitano de Techo';
    IF idEstadio4 IS NULL THEN
        IF idBogota IS NULL THEN
            SELECT id INTO idBogota FROM ciudad WHERE ciudad='Bogotá';
        END IF;
        INSERT INTO estadio
            (id, estadio, capacidad, idciudad) VALUES(nuevoIdEstadio, 'Estadio Metropolitano de Techo', 0, idBogota);
        idEstadio4 := nuevoIdEstadio;
    END IF;

    --validar si ya estan los grupos
    SELECT id INTO nuevoIdGrupo
        FROM grupo
        WHERE idCampeonato = nuevoIdCampeonato
            AND grupo='A';
    IF nuevoIdGrupo IS NULL THEN
        SELECT MAX(Id)+1 INTO nuevoIdGrupo FROM grupo;

        INSERT INTO grupo
            (id, grupo, idcampeonato)
            VALUES
            (nuevoIdGrupo,'A', nuevoIdCampeonato),
            (nuevoIdGrupo+1,'B', nuevoIdCampeonato),
            (nuevoIdGrupo+2,'C', nuevoIdCampeonato),
            (nuevoIdGrupo+3,'D', nuevoIdCampeonato),
            (nuevoIdGrupo+4,'E', nuevoIdCampeonato),
            (nuevoIdGrupo+5,'F', nuevoIdCampeonato);
    END IF;
       
    idPais1Grupo := idColombia;
    
    SELECT id INTO idPais2Grupo FROM pais WHERE pais='Australia';
    IF idPais2Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Australia', '');
        idPais2Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    SELECT id INTO idPais3Grupo FROM pais WHERE pais='Camerún';
    IF idPais3Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Camerún', '');
        idPais3Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    SELECT id INTO idPais4Grupo FROM pais WHERE pais='México';
    IF idPais4Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'México', '');
        idPais4Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    SELECT COUNT(*) INTO totalPaises
        FROM grupopais
        WHERE idgrupo=nuevoIdGrupo;
    IF totalPaises=0 THEN
        INSERT INTO grupopais
            (idgrupo, idpais)
            VALUES
            (nuevoIdGrupo, idPais1Grupo),
            (nuevoIdGrupo, idPais2Grupo),
            (nuevoIdGrupo, idPais3Grupo),
            (nuevoIdGrupo, idPais4Grupo);
    END IF;
    
    SELECT MAX(Id)+1 INTO nuevoIdEncuentro
        FROM encuentro;
    
    -- Camerún vs México
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais3Grupo AND idpais2 = idPais4Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais3Grupo, 2, idPais4Grupo, 2, '2024-08-31', idEstadio3, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
    -- Colombia vs Australia
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais1Grupo AND idpais2 = idPais2Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais1Grupo, 2, idPais2Grupo, 0, '2024-08-31', idEstadio3, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
    -- México vs Australia
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais4Grupo AND idpais2 = idPais2Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais4Grupo, 2, idPais2Grupo, 0, '2024-09-03', idEstadio3, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
    -- Colombia vs Camerún
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais1Grupo AND idpais2 = idPais3Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais1Grupo, 1, idPais3Grupo, 0, '2024-09-03', idEstadio3, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
     -- México vs Colombia
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais4Grupo AND idpais2 = idPais1Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais4Grupo, 0, idPais1Grupo, 1, '2024-09-06', idEstadio1, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
     -- Australia vs Camerún
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais2Grupo AND idpais2 = idPais3Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais2Grupo, 0, idPais3Grupo, 2, '2024-09-03', idEstadio3, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
    
    SELECT id INTO idPais1Grupo FROM pais WHERE pais='Francia';
    IF idPais1Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Francia', '');
        idPais1Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;
    
    SELECT id INTO idPais2Grupo FROM pais WHERE pais='Canadá';
    IF idPais2Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Canadá', '');
        idPais2Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    SELECT id INTO idPais3Grupo FROM pais WHERE pais='Brasil';
    IF idPais3Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Brasil', '');
        idPais3Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    SELECT id INTO idPais4Grupo FROM pais WHERE pais='Fiyi';
    IF idPais4Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Fiyi', '');
        idPais4Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    SELECT COUNT(*) INTO totalPaises
        FROM grupopais
        WHERE idgrupo=nuevoIdGrupo+1;
    IF totalPaises=0 THEN
        INSERT INTO grupopais
            (idgrupo, idpais)
            VALUES
            (nuevoIdGrupo+1, idPais1Grupo),
            (nuevoIdGrupo+1, idPais2Grupo),
            (nuevoIdGrupo+1, idPais3Grupo),
            (nuevoIdGrupo+1, idPais4Grupo);
    END IF;
    
    -- Francia vs Canadá
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais1Grupo AND idpais2 = idPais2Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais1Grupo, 3, idPais2Grupo, 3, '2024-08-31', idEstadio1, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
    -- Brasil vs Fiyi
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais3Grupo AND idpais2 = idPais4Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais3Grupo, 9, idPais4Grupo, 0, '2024-08-31', idEstadio1, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
    -- Francia vs Brasil
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais1Grupo AND idpais2 = idPais3Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais1Grupo, 0, idPais3Grupo, 3, '2024-09-03', idEstadio1, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
    -- Fiyi vs Canadá
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais4Grupo AND idpais2 = idPais2Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais4Grupo, 0, idPais2Grupo, 9, '2024-09-03', idEstadio1, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
    -- Fiyi vs Francia
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais4Grupo AND idpais2 = idPais1Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais4Grupo, 0, idPais1Grupo, 11, '2024-09-06', idEstadio1, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
     -- Canadá vs Brasil
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais2Grupo AND idpais2 = idPais3Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais2Grupo, 0, idPais3Grupo, 2, '2024-09-06', idEstadio3, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;

    SELECT id INTO idPais1Grupo FROM pais WHERE pais='España';
    IF idPais1Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'España', '');
        idPais1Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;
    
    SELECT id INTO idPais2Grupo FROM pais WHERE pais='Estados Unidos';
    IF idPais2Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Estados Unidos', '');
        idPais2Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    SELECT id INTO idPais3Grupo FROM pais WHERE pais='Paraguay';
    IF idPais3Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Paraguay', '');
        idPais3Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    SELECT id INTO idPais4Grupo FROM pais WHERE pais='Marruecos';
    IF idPais4Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Marruecos', '');
        idPais4Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    SELECT COUNT(*) INTO totalPaises
        FROM grupopais
        WHERE idgrupo=nuevoIdGrupo+2;
    IF totalPaises=0 THEN
        INSERT INTO grupopais
            (idgrupo, idpais)
            VALUES
            (nuevoIdGrupo+2, idPais1Grupo),
            (nuevoIdGrupo+2, idPais2Grupo),
            (nuevoIdGrupo+2, idPais3Grupo),
            (nuevoIdGrupo+2, idPais4Grupo);
    END IF;

    -- España vs Estados Unidos
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais1Grupo AND idpais2 = idPais2Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais1Grupo, 1, idPais2Grupo, 0, '2024-09-01', idEstadio2, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
    -- Paraguay vs Marruecos
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais3Grupo AND idpais2 = idPais4Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais3Grupo, 2, idPais4Grupo, 0, '2024-09-01', idEstadio2, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
    -- España vs Paraguay
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais1Grupo AND idpais2 = idPais3Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais1Grupo, 2, idPais3Grupo, 0, '2024-09-04', idEstadio2, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
    -- Marruecos vs Estados Unidos
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais4Grupo AND idpais2 = idPais2Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais4Grupo, 0, idPais2Grupo, 2, '2024-09-04', idEstadio2, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
    -- Marruecos vs España
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais4Grupo AND idpais2 = idPais1Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais4Grupo, 0, idPais1Grupo, 2, '2024-09-07', idEstadio2, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;
     -- Estados Unidos vs Paraguay
    IF NOT EXISTS(SELECT * FROM encuentro
                WHERE idpais1 = idPais2Grupo AND idpais2 = idPais3Grupo
                    AND idfase =1 AND idcampeonato = nuevoIdCampeonato ) THEN
        INSERT INTO Encuentro
            (id, idpais1, goles1, idpais2, goles2, fecha, idestadio, idfase, idcampeonato)
            VALUES(nuevoIdEncuentro, idPais2Grupo, 7, idPais3Grupo, 0, '2024-09-07', idEstadio4, 1, nuevoIdCampeonato);
        nuevoIdEncuentro := nuevoIdEncuentro + 1;
    END IF;


	SELECT id INTO idPais1Grupo FROM pais WHERE pais='Alemania';
    IF idPais1Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Alemania', '');
        idPais1Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;
    
    SELECT id INTO idPais2Grupo FROM pais WHERE pais='Venezuela';
    IF idPais2Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Venezuela', '');
        idPais2Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    SELECT id INTO idPais3Grupo FROM pais WHERE pais='Nigeria';
    IF idPais3Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Nigeria', '');
        idPais3Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    SELECT id INTO idPais4Grupo FROM pais WHERE pais='Corea del Sur';
    IF idPais4Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Corea del Sur', '');
        idPais4Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;
	
	SELECT COUNT(*) INTO totalPaises
		FROM grupopais 
		WHERE idgrupo=nuevoIdGrupo+3;
	IF totalPaises=0 THEN
        INSERT INTO grupopais
        (idgrupo, idpais)
        VALUES
        (nuevoIdGrupo+3, idPais1Grupo),
        (nuevoIdGrupo+3, idPais2Grupo),
        (nuevoIdGrupo+3, idPais3Grupo),
        (nuevoIdGrupo+3, idPais4Grupo);
    END IF;       
    	
	SELECT id INTO idPais1Grupo FROM pais WHERE pais='Japón';
    IF idPais1Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Japón', '');
        idPais1Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;
    
    SELECT id INTO idPais2Grupo FROM pais WHERE pais='Nueva Zelanda';
    IF idPais2Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Nueva Zelanda', '');
        idPais2Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    SELECT id INTO idPais3Grupo FROM pais WHERE pais='Ghana';
    IF idPais3Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Ghana', '');
        idPais3Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    SELECT id INTO idPais4Grupo FROM pais WHERE pais='Austria';
    IF idPais4Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Austria', '');
        idPais4Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;
	
	SELECT COUNT(*) INTO totalPaises
		FROM grupopais 
		WHERE idgrupo=nuevoIdGrupo+4;
	IF totalPaises=0 THEN
        INSERT INTO grupopais
        (idgrupo, idpais)
        VALUES
        (nuevoIdGrupo+4, idPais1Grupo),
        (nuevoIdGrupo+4, idPais2Grupo),
        (nuevoIdGrupo+4, idPais3Grupo),
        (nuevoIdGrupo+4, idPais4Grupo);
    END IF; 
	
	SELECT id INTO idPais1Grupo FROM pais WHERE pais='Corea del Norte';
    IF idPais1Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Corea del Norte', '');
        idPais1Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;
    
    SELECT id INTO idPais2Grupo FROM pais WHERE pais='Argentina';
    IF idPais2Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Argentina', '');
        idPais2Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    SELECT id INTO idPais3Grupo FROM pais WHERE pais='Costa Rica';
    IF idPais3Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Costa Rica', '');
        idPais3Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;

    SELECT id INTO idPais4Grupo FROM pais WHERE pais='Holanda';
    IF idPais4Grupo IS NULL THEN
        INSERT INTO pais
            (id, pais, entidad) VALUES(nuevoIdPais, 'Holanda', '');
        idPais4Grupo := nuevoIdPais;
        nuevoIdPais := nuevoIdPais + 1;
    END IF;
	
	SELECT COUNT(*) INTO totalPaises
		FROM grupopais 
		WHERE idgrupo=nuevoIdGrupo+5;
	IF totalPaises=0 THEN
        INSERT INTO grupopais
        (idgrupo, idpais)
        VALUES
        (nuevoIdGrupo+5, idPais1Grupo),
        (nuevoIdGrupo+5, idPais2Grupo),
        (nuevoIdGrupo+5, idPais3Grupo),
        (nuevoIdGrupo+5, idPais4Grupo);
    END IF;
    
END $$;

