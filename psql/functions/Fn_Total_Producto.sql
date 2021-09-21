-- Función para calcular el total de producto por total (en litros)
-- Recibe como parámetros la cantidad del producto por hectárea y el área
CREATE OR REPLACE FUNCTION fn_total_producto (producto_hectarea DOUBLE PRECISION, area DOUBLE PRECISION)
RETURNS DOUBLE PRECISION AS $total_producto$
	BEGIN	
		RETURN producto_hectarea * area;
		
	END; $total_producto$ LANGUAGE plpgsql;