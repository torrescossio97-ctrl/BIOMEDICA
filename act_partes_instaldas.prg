
*** Actualizar la tabla de partes instaladas ***

	SELECT instaladas
	GO top
	DO WHILE NOT EOF()

	IF instaladas.pi_no = 0
		SKIP
		LOOP
	ENDIF

    	
  	TEXT TO lcStr2 NOSHOW  TEXTMERGE PRETEXT 7
	
	UPDATE datos_tec SET 
  	
  	pi_no1 				= '<<instaladas.pi_no1>>',
	pi_cantidad1 		= '<<instaladas.pi_cantidad1>>',
	pi_descripcion1 	= '<<instaladas.pi_descripcion1>>',
	pi_partes1 			= '<<instaladas.pi_no_partes1>>',
	pi_costo_uni1 		= '<<instaladas.pi_costo_uni1>>',
	pi_costo_to1t 		= '<<instaladas.pi_costo_tot1>>',
	pi_recibido1 		= '<<instaladas.pi_recibido1>>', 
	pi_no2 				= '<<instaladas.pi_no2>>',
	pi_cantidad2 		= '<<instaladas.pi_cantidad2>>',
	pi_descripcion2 	= '<<instaladas.pi_descripcion2>>',
	pi_partes2			= '<<instaladas.pi_no_partes2>>',
	pi_costo_uni2 		= '<<instaladas.pi_costo_uni2>>',
	pi_costo_tot2 		= '<<instaladas.pi_costo_tot2>>',
	pi_recibido2 		= '<<instaladas.pi_recibido2>>',
	pi_no3				= '<<instaladas.pi_no3>>',
	pi_cantidad3 		= '<<instaladas.pi_cantidad3>>',
	pi_descripcion3 	= '<<instaladas.pi_descripcion3>>',
	pi_partes3 			= '<<instaladas.pi_no_partes3>>',
	pi_costo_uni3 		= '<<instaladas.pi_costo_uni3>>',
	pi_costo_tot3 		= '<<instaladas.pi_costo_tot3>>',
	pi_recibido3 		= '<<instaladas.pi_recibido3>>',
	pi_no4 				= '<<instaladas.pi_no4>>',
	pi_cantidad4 		= '<<instaladas.pi_cantidad4>>',
	pi_descripcion4 	= '<<instaladas.pi_descripcion4>>',
	pi_partes4 			= '<<instaladas.pi_no_partes4>>',
	pi_costo_uni4 		= '<<instaladas.pi_costo_uni4>>',
	pi_costo_to4t 		= '<<instaladas.pi_costo_tot4>>',
	pi_recibido4 		= '<<instaladas.pi_recibido4>>'
	pi_no5				= '<<instaladas.pi_no5>>',
	pi_cantidad5 		= '<<instaladas.pi_cantidad5>>',
	pi_descripcion5 	= '<<instaladas.pi_descripcion5>>',
	pi_partes5 			= '<<instaladas.pi_no_partes5>>',
	pi_costo_uni5 		= '<<instaladas.pi_costo_uni5>>',
	pi_costo_to5t 		= '<<instaladas.pi_costo_tot5>>',
	pi_recibido5 		= '<<instaladas.pi_recibido5>>')
	
	WHERE año = '<<añow>>' and no_semana = '<<no_semanaw>>' and no_orden = '<<no_ordenw>>'
							
	ENDTEXT 
	
	lnPrepare=SQLPREPARE(lnHandle,lcStr2)
	lnExec=SQLEXEC(lnHandle) 
	IF lnexec<1
		MESSAGEBOX('ok2')
     = AERROR(aerrorarray)
     FOR n = 1 TO 7
        MESSAGEBOX(aerrorarray(n))
     ENDFOR
  	ENDIF	
	
	SELECT instaladas
	SKIP
	LOOP 

	ENDDO 				
