-- Procedimiento para listar todos los productos disponibles con métrica en L/Ha
CREATE OR REPLACE FUNCTION fn_listar_productos()
RETURNS SETOF productos AS $$ 
	BEGIN	
		RETURN QUERY 
		SELECT p.id, p.tipo, p.ingrediente, p.cultivo, p.dosis_min, p.dosis_max, p.dosis_media, p.metrica
			FROM productos p
			WHERE p.metrica LIKE '%L/Ha%'
			ORDER BY p.ingrediente;
	END; $$ LANGUAGE plpgsql;