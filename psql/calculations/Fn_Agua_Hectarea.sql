-- Función para calcular el total de agua por hectárea (en litros por hectárea)
-- Recibe como parámetros la cantidad de agua por tánque y número de llenadas de tanque por hectárea
CREATE OR REPLACE FUNCTION fn_agua_hectarea (agua_tanque DOUBLE PRECISION, tanque_hectarea DOUBLE PRECISION)
RETURNS DOUBLE PRECISION AS $agua_hectarea$
	BEGIN	
		RETURN agua_tanque * tanque_hectarea;
		
	END; $agua_hectarea$ LANGUAGE plpgsql;