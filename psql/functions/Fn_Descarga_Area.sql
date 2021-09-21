-- Función para calcular el total de descargas para el área
-- Recibe la descarga por hectárea y el área total como parámetros
CREATE OR REPLACE FUNCTION fn_descarga_area (descarga_ha DOUBLE PRECISION, area DOUBLE PRECISION)
RETURNS DOUBLE PRECISION AS $descarga_total$
	BEGIN	
		RETURN descarga_ha * area;
	END; $descarga_total$ LANGUAGE plpgsql;