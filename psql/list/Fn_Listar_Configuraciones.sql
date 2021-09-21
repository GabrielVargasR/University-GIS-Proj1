-- Procedimiento para listar todas las configuraciones disponibles para un drone
-- Recibe el id del drone como parámetro
CREATE OR REPLACE FUNCTION fn_listar_configuraciones(id_drone INTEGER)
RETURNS SETOF configuraciones AS $$ 
	BEGIN	
		RETURN QUERY 
		SELECT c.id, c.id, c.altitud, c.ancho_cobertura, c.velocidad_drone, c.volumen_descarga, c.baterias_x_ha
			FROM configuraciones c
			WHERE c.drone = id_drone;
	END; $$ LANGUAGE plpgsql;
	
select * from fn_listar_configuraciones(1)