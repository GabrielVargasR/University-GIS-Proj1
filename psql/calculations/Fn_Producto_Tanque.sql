-- Función para calcular el total de un producto por tanque (en litros por tanque)
-- Recibe la dosis del producto y el total de llenadas por hectárea como parámetros
CREATE OR REPLACE FUNCTION fn_producto_tanque (dosis DOUBLE PRECISION, llenadas_ha DOUBLE PRECISION)
RETURNS DOUBLE PRECISION AS $producto_tanque$
	BEGIN
		RETURN dosis / llenadas_ha;
	END; $producto_tanque$ LANGUAGE plpgsql;