
*** actualiza partes solicitadas ***

	SELECT solicitadas
	GO top
	DO WHILE NOT EOF()

	IF solicitadas.ps_no = 0
		SKIP
		LOOP
	ENDIF
  	
  	TEXT TO lcStr2 NOSHOW  TEXTMERGE PRETEXT 7
	
	UPDATE datos_tec SET 
  	
  	ps_no1 				= '<<solicitadas.ps_no1>>',
	ps_cantidad1 		= '<<solicitadas.ps_cantidad1>>',
	ps_descripcion1 	= '<<solicitadas.ps_descripcion1>>',
	ps_partes1 			= '<<solicitadas.ps_no_partes1>>',
	ps_costo_uni1 		= '<<solicitadas.ps_costo_uni1>>',
	ps_costo_to1t 		= '<<solicitadas.ps_costo_tot1>>',
	ps_recibido1 		= '<<solicitadas.ps_recibido1>>', 
	ps_no2 				= '<<solicitadas.ps_no2>>',
	ps_cantidad2 		= '<<solicitadas.ps_cantidad2>>',
	ps_descripcion2 	= '<<solicitadas.ps_descripcion2>>',
	ps_partes2			= '<<solicitadas.ps_no_partes2>>',
	ps_costo_uni2 		= '<<solicitadas.ps_costo_uni2>>',
	ps_costo_tot2 		= '<<solicitadas.ps_costo_tot2>>',
	ps_recibido2 		= '<<solicitadas.ps_recibido2>>',
	ps_no3				= '<<solicitadas.ps_no3>>',
	ps_cantidad3 		= '<<solicitadas.ps_cantidad3>>',
	ps_descripcion3 	= '<<solicitadas.ps_descripcion3>>',
	ps_partes3 			= '<<solicitadas.ps_no_partes3>>',
	ps_costo_uni3 		= '<<solicitadas.ps_costo_uni3>>',
	ps_costo_tot3 		= '<<solicitadas.ps_costo_tot3>>',
	ps_recibido3 		= '<<solicitadas.ps_recibido3>>',
	ps_no4 				= '<<solicitadas.ps_no4>>',
	ps_cantidad4 		= '<<solicitadas.ps_cantidad4>>',
	ps_descripcion4 	= '<<solicitadas.ps_descripcion4>>',
	ps_partes4 			= '<<solicitadas.ps_no_partes4>>',
	ps_costo_uni4 		= '<<solicitadas.ps_costo_uni4>>',
	ps_costo_to4t 		= '<<solicitadas.ps_costo_tot4>>',
	ps_recibido4 		= '<<solicitadas.ps_recibido4>>'
	ps_no5				= '<<solicitadas.ps_no5>>',
	ps_cantidad5 		= '<<solicitadas.ps_cantidad5>>',
	ps_descripcion5 	= '<<solicitadas.ps_descripcion5>>',
	ps_partes5 			= '<<solicitadas.ps_no_partes5>>',
	ps_costo_uni5 		= '<<solicitadas.ps_costo_uni5>>',
	ps_costo_to5t 		= '<<solicitadas.ps_costo_tot5>>',
	ps_recibido5 		= '<<solicitadas.ps_recibido5>>')
	
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
	
	SELECT solicitadas
	SKIP
	LOOP 

	ENDDO 				