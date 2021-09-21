-- Procedimiento para listar todos los drones disponibles en la base de datos
CREATE OR REPLACE FUNCTION fn_listar_drones()
RETURNS SETOF drones AS $$ 
	BEGIN	
		RETURN QUERY 
		SELECT d.id, d.marca, d.modelo, d.duracion_bateria, d.capacidad_tanque
			FROM drones d;	
	END; $$ LANGUAGE plpgsql;