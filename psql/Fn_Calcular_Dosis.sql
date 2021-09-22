-- Función para realizar todos los cálculos de dosis
-- Recibe los id del drone, configuración y productos seleccionados, así como el tamaño del área indicada
DROP FUNCTION IF EXISTS fn_calcular_dosis;
CREATE OR REPLACE FUNCTION fn_calcular_dosis(id_drone INTEGER, id_config INTEGER, id_productos INTEGER [], area DOUBLE PRECISION)
RETURNS TABLE (
				descarga_ha DOUBLE PRECISION,
 				llenadas_ha DOUBLE PRECISION,
 				descarga_area DOUBLE PRECISION,
 				llenadas_area DOUBLE PRECISION,
   				prod_tanque DOUBLE PRECISION[],
 				agua_tanque DOUBLE PRECISION,
 				prod_ha DOUBLE PRECISION[],
 				agua_ha DOUBLE PRECISION,
  				prod_area DOUBLE PRECISION[],
 				agua_area DOUBLE PRECISION
				)
	AS $$
	DECLARE
		desc_ha DOUBLE PRECISION;
		desc_area DOUBLE PRECISION;
		tanque_ha DOUBLE PRECISION;
		prod_ha DOUBLE PRECISION[];
		agua_llenada DOUBLE PRECISION;
		ag_ha DOUBLE PRECISION;
		prod_llenada DOUBLE PRECISION[];
	BEGIN	
		desc_ha = fn_descarga_hectarea(id_config, id_drone);
 		desc_area = fn_descarga_area(desc_ha, area);
 		tanque_ha = fn_tanque_hectarea(desc_area, id_drone);
 		SELECT ARRAY_AGG(p.dosis_media) INTO prod_ha 
 			FROM productos p 
 			WHERE p.id IN 
 				(SELECT * FROM UNNEST(id_productos));
 		agua_llenada = fn_agua_tanque (id_drone, prod_ha);
 		ag_ha = fn_agua_hectarea(agua_llenada, tanque_ha);
    	SELECT ARRAY_AGG(fn_producto_tanque(dosis, tanque_ha))
			INTO prod_llenada
    		FROM UNNEST(prod_ha) WITH ORDINALITY AS a(dosis, n);

		RETURN QUERY
		SELECT 
			desc_ha, -- descarga por hectárea
 			tanque_ha, -- llenadas de tanque por hectárea
 			desc_area, -- descarga por área
 			fn_tanque_area(tanque_ha, area), -- llenadas por área
  	  		prod_llenada, -- cantidad productos por llenada de tanque
  			agua_llenada, -- cantidad de agua por llenada de tanque
 			prod_ha, -- cantidad de productos por hectárea
 			ag_ha, -- cantidad de agua por hectárea
   			(SELECT ARRAY_AGG(fn_total_producto(dosis, area)) FROM UNNEST(prod_ha) WITH ORDINALITY AS a(dosis, i)), -- cantidad de productos por área
  			fn_agua_total (ag_ha, area); -- cantidad de agua por área	
	END; $$ LANGUAGE plpgsql;
	
-- select * from fn_calcular_dosis(1,1,ARRAY[22,23], 10.0::DOUBLE PRECISION);