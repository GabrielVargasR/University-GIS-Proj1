-- Función para calcular el total de llenadas de tanque por hectárea
-- Recibe la descarga por área total y el id del drone como parámetro
CREATE OR REPLACE FUNCTION fn_tanque_hectarea (descarga_total DOUBLE PRECISION, id_drone INT)
RETURNS DOUBLE PRECISION AS $llenadas_hectarea$
	DECLARE
		cap DOUBLE PRECISION;
	BEGIN
		SELECT d.capacidad_tanque into cap
			FROM drones d 
			WHERE d.id = id_drone;
			
		RETURN descarga_total / cap;
		
	END; $llenadas_hectarea$ LANGUAGE plpgsql;