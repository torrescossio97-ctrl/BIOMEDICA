

update control_servicio inner join cierre_orden set
	control_servicio.reporte_emp 		= cierre_orden.reporte_emp,
  control_servicio.fecha_ini 	 	= cierre_orden.fecha_ini,
  control_servicio.fecha_ter 	 	 = cierre_orden.fecha_ter,
  control_servicio.trabajo_rea 	  = cierre_orden.trabajo_rea,
  control_servicio.observaciones  = cierre_orden.observaciones,
  control_servicio.desc_pieza   	= cierre_orden.desc_pieza,
  control_servicio.codigo_empresa = cierre_orden.codigo_empresa,
  control_servicio.fecha_ini 		 	= cierre_orden.fecha_ini,
  control_servicio.operacional    = cierre_orden.operacional,
  control_servicio.par_oper       = cierre_orden.par_oper,
  control_servicio.fue_serv       = cierre_orden.fue_serv,
  control_servicio.esp_inf        = cierre_orden.esp_inf,
  control_servicio.espera_pieza   = cierre_orden.espera_pieza,
  control_servicio.cotizar        = cierre_orden.cotizar,
  control_servicio.a_pedir        = cierre_orden.a_pedir,
  control_servicio.pieza_col      = cierre_orden.pieza_col,
	control_servicio.estado1       = cierre_orden.estado1,
	control_servicio.act = '*'
	
where control_servicio.reporte = cierre_orden.orden
