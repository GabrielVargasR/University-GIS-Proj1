-- Función para calcular el total de llenadas del tanque para el área total
-- Recibe el total de llenadas del tanque por hectárea y el área total como parámetros
CREATE OR REPLACE FUNCTION fn_tanque_area (tanque_ha DOUBLE PRECISION, area DOUBLE PRECISION)
RETURNS DOUBLE PRECISION AS $llenadas_total$
	BEGIN	
		RETURN tanque_ha * area;
	END; $llenadas_total$ LANGUAGE plpgsql;