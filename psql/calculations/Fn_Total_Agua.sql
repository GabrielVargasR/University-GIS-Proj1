-- Función para calcular el total de agua (en litros)
-- Recibe como parámetros la cantidad de agua por tánque y número de llenadas de tanque por hectárea
CREATE OR REPLACE FUNCTION fn_agua_total (agua_hectarea DOUBLE PRECISION, area DOUBLE PRECISION)
RETURNS DOUBLE PRECISION AS $agua_total$
	BEGIN	
		RETURN agua_hectarea * area;
	END; $agua_total$ LANGUAGE plpgsql;