-- Función para calcular el total de ague por tanque (en litros por tanque)
-- Recibe el id del drone y un arreglo con las dosis de los productos
CREATE OR REPLACE FUNCTION fn_agua_tanque (id_drone INT, dosis_productos DOUBLE PRECISION [])
RETURNS DOUBLE PRECISION AS $agua_tanque$
	DECLARE
		descarga_tanque DOUBLE PRECISION;
		total_dosis DOUBLE PRECISION;
	BEGIN
		SELECT d.capacidad_tanque into descarga_tanque
			FROM drones d 
			WHERE d.id = id_drone;
			
		SELECT SUM(nums) into total_dosis
			FROM UNNEST(dosis_productos)
			WITH ordinality a(nums, i);
			
		RETURN descarga_tanque - total_dosis;
		
	END; $agua_tanque$ LANGUAGE plpgsql;
	
-- select fn_agua_tanque(1, Array[1.0,2.0, 3.0]);