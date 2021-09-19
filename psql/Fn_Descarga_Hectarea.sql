-- función para calcular la descarga (en litros) por hectarea
-- recibe como parámetros el id de la configuración y el id del drone
CREATE OR REPLACE FUNCTION fn_descarga_hectarea (id_config INT, id_drone INT)
RETURNS DOUBLE PRECISION AS $descarga_Ha$
	DECLARE
		vol DOUBLE PRECISION;
		bat DOUBLE PRECISION;
	BEGIN
		SELECT c.volumen_descarga INTO vol
			FROM configuraciones AS c WHERE c.id = id_config;
			
		SELECT d.duracion_bateria INTO bat
			FROM drones AS d WHERE d.id = id_drone;
			
		RETURN vol * bat;
	END; $descarga_Ha$ LANGUAGE plpgsql;