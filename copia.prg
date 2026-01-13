 
 
 TEXT TO lcstr2 TEXTMERGE NOSHOW PRETEXT 7
 	
	SELECT concat(SUBSTR(fecha,9,2),'/',SUBSTR(fecha,6,2),'/',SUBSTR(fecha,1,4)) as "FECHA DE ENTRADA", concat(encabezado.no_semana,'-',encabezado.no_orden) as 'numero de o/t',
	SUBSTR(tipo_reporte,3,10) as 'tipo de reporte', equipo, marca, modelo, serie, activo, servicios.descripcion "servicio que reporta", reportado as 'persona responsable', daño, SPACE(254) as daño_reportado, 
	datos_tec.evaluacion, datos_tec.trab_realizado, datos_tec.observacion, SPACE(250) as trabajo_realizado, encabezado.tecnico, 
	concat(SUBSTR(datos_tec.fecha_cierre,9,2),'/',SUBSTR(datos_tec.fecha_cierre,6,2),'/',SUBSTR(datos_tec.fecha_cierre,1,4)) as 'fecha de cierre', 
	SPACE(180) as p_instaladas,SPACE(5) as total_instalada, SPACE(180) as p_solicitadas, SPACE(5) as total_solicitada, 
	datos_tec.descarte as desca, SPACE(1) as 'descartes', SPACE(50) as observaciones, encabezado.año, encabezado.no_semana, encabezado.no_orden,
	reparado, no_funciona, instalado, reinstalacion, espera_pieza, mant_prev, espera_inf, comp_privada,	garantia, inspeccion, supervicion, traslado, retiro_equipo 
	FROM encabezado, datos_tec, servicios
	where encabezado.no_semana = datos_tec.no_semana 
	and encabezado.no_orden = datos_tec.no_orden
	and encabezado.año = datos_tec.año
	and MONTH(encabezado.fecha)='<<SUBSTR(thisform.combo_meses.Value,1,2)>>'
	and YEAR(encabezado.fecha) = '<<thisform.txt_año.value>>'
	and datos_tec.año = '<<thisform.txt_año.value>>'
	and encabezado.servicio = servicios.id
				
 ENDTEXT
 
 lnprepare = SQLPREPARE(lnhandle, lcstr2, 'c_ordenes')
lnexec = SQLEXEC(lnhandle)
 
 IF lnexec<1
    = AERROR(aerrorarray)
    FOR n = 2 TO 3
       MESSAGEBOX(aerrorarray(n))
    ENDFOR
 ENDIF
 
 SELECT * FROM c_ordenes INTO CURSOR c_ordenes READWRITE
 INDEX on año+no_semana+no_orden TAG llave 
 
 SELECT c_ordenes
 GO top
 DO WHILE NOT EOF()
 
 replace daño_reportado WITH daño
 replace trabajo_realizado WITH ALLTRIM(evaluacion)+' '+ALLTRIM(trab_realizado)+' '+ALLTRIM(observacion)

 IF desca = 1
 	replace descartes WITH 'X'
 ENDIF 	
 
 IF reparado = 1
 	obs1w = 'REPARADO'
 ENDIF 
 IF no_funciona = 1
 	obs2W = 'NO FUNCIONA'
 ENDIF 
 IF INSTALADO = 1
 	obs3w = 'INSTALADO'
 ENDIF 
 IF REINSTALACION = 1
 	obs4W = 'REINSTALACION'
 ENDIF 
 IF ESPERA_PIEZA = 1
 	obs5w = 'ESPERA DE PIEZA'
 ENDIF 
 IF MANT_PREV = 1
 	obs6W = 'MANTENIMIENTO PREVENTIVO'
 ENDIF 
 IF ESPERA_INF = 1
 	obs7w = 'ESPERA DE INFORMACION'
 ENDIF 
 IF COMP_PRIVADA = 1
 	obs8W = 'COMPAÑIA PRIVADA'
 ENDIF 
 *
 IF GARANTIA = 1
 	obs9w = 'GARANTIA'
 ENDIF 
 IF INSPECCION = 1
 	obs10W = 'INSPECCION'
 ENDIF 
 IF SUPERVICION = 1
 	obs11w = 'SUPERVICION'
 ENDIF 
 IF TRASLADO = 1
 	obs12W = 'TRASLADO'
 ENDIF 
 IF RETIRO_EQUIPO = 1
 	obs13w = 'ESPERA DE PIEZA'
 ENDIF
 
REPLACE OBSERVACIONES WITH ALLTRIM(OBS1W)+' '+ALLTRIM(OBS2W)+' '+ALLTRIM(OBS3W)+' '+ALLTRIM(OBS4W)+' '+ALLTRIM(OBS5W)+' '+ALLTRIM(OBS6W)+' '+ALLTRIM(OBS7W)+' '+ALLTRIM(OBS8W)+' '+ALLTRIM(OBS9W)+' '+ALLTRIM(OBS10W)+' '+ALLTRIM(OBS11W)+' '+ALLTRIM(OBS12W)+' '+ALLTRIM(OBS13W)
REPLACE OBSERVACIONES WITH ALLTRIM(OBSERVACIONES)

STORE ' ' TO  OBS1W, OBS2W, OBS3W, OBS4W, OBS5W, OBS6W, OBS7W, OBS8W, OBS9W, OBS10W, OBS11W, OBS12W, OBS13W  
 
 SKIP
 LOOP
 
 ENDDO
 
 *** piezas instaladas ***
 SELECT c_ordenes
 GO top
 DO WHILE NOT EOF()
 	añow = c_ordenes.año
 	semanaw = c_ordenes.no_semana
 	ordenw = c_ordenes.no_orden
 
	  TEXT TO lcstr2 TEXTMERGE NOSHOW PRETEXT 7
	  
	  SELECT * FROM p_instaladas WHERE año = '<<añow>>'
	  	  
	  ENDTEXT
	 lnprepare = SQLPREPARE(lnhandle, lcstr2, 'c_instaladas')
	 lnexec = SQLEXEC(lnhandle)
	 
	 IF lnexec<1
	    = AERROR(aerrorarray)
	    FOR n = 2 TO 3
	       MESSAGEBOX(aerrorarray(n))
	    ENDFOR
	 ENDIF 
	 
	 SELECT c_instaladas
	 GO top
	 DO while NOT EOF()
	 
	 IF año = añow AND no_semana = semanaw AND no_orden = ordenw
	 
	 	SELECT instaladas
	 	APPEND BLANK
	 	replace año WITH c_instaladas.año
	 	replace semana WITH c_instaladas.no_semana
	 	replace orden WITH c_instaladas.no_orden
	 	replace descripcion WITH c_instaladas.pi_descripcion
	 	replace cantidad WITH c_instaladas.pi_cantidad
	 	
	 	
	 ENDIF 	
	
	SELECT c_instaladas
	SKIP
	LOOP
	ENDDO
	 	
	 
	 *** Piezas solicitadas ***
	TEXT TO lcstr2 TEXTMERGE NOSHOW PRETEXT 7
	  
	  SELECT * FROM p_solicitadas WHERE año = '<<añow>>'
	  	  
	  ENDTEXT
	 lnprepare = SQLPREPARE(lnhandle, lcstr2, 'c_solicitadas')
	 lnexec = SQLEXEC(lnhandle)
	 
	 IF lnexec<1
	    = AERROR(aerrorarray)
	    FOR n = 2 TO 3
	       MESSAGEBOX(aerrorarray(n))
	    ENDFOR
	 ENDIF 
	 
	 SELECT c_solicitadas
	 GO top
	 DO while NOT EOF()
	 
	 IF año = añow AND no_semana = semanaw AND no_orden = ordenw
	 
	 	SELECT solicitadas
	 	APPEND BLANK
	 	replace año WITH c_solicitadas.año
	 	replace semana WITH c_solicitadas.no_semana
	 	replace orden WITH c_solicitadas.no_orden
	 	replace descripcion WITH c_solicitadas.ps_descripcion
	 	replace cantidad WITH c_solicitadas.ps_cantidad
	 	
	 ENDIF 	
	
	SELECT c_solicitadas
	SKIP
	LOOP
	ENDDO

 SELECT c_ordenes
 SKIP
 LOOP
 
 ENDDO 
 
 *** actualizar la tabla c_ordenes en piezas instaladas ***
 SELECT instaladas
 GO top
 DO WHILE NOT EOF()
 
 SELECT c_ordenes
 SET ORDER TO llave
 SEEK (instaladas.año+instaladas.semana+instaladas.orden)
 IF NOT EOF()
 	
 	replace total_instalada WITH STR(instaladas.cantidad,5)
 	
 	a1 = 1
 	IF c_ordenes.p_instaladas = ' '
 	
 		replace p_instaladas WITH instaladas.descripcion
 		
 	ELSE
 		 
		replace p_instaladas WITH ALLTRIM(SUBSTR(p_instaladas,1,60)+'+'+instaladas.descripcion)
		replace p_instaladas WITH ALLTRIM(p_instaladas)
		
	ENDIF 	
		 
ENDIF 
a1 = 0
SELECT instaladas
SKIP
LOOP

ENDDO 

*** actualizar la tabla c_ordenes en piezas SOLICITADAS ***
 SELECT solicitadas
 GO top
 DO WHILE NOT EOF()
 
 SELECT c_ordenes
 SET ORDER TO llave
 SEEK (solicitadas.año+solicitadas.semana+solicitadas.orden)
 IF NOT EOF()
 
 	replace total_solicitada WITH STR(solicitadas.cantidad,5)
 
 	a1 = 1
 	IF c_ordenes.p_solicitadas = ' '
 	
 		replace p_solicitadas WITH solicitadas.descripcion
 		
 	ELSE
 		 
		replace p_solicitadas WITH ALLTRIM(SUBSTR(p_solicitadas,1,60)+'+'+solicitadas.descripcion)
		replace p_solicitadas WITH ALLTRIM(p_solicitadas)
		
	ENDIF 	
		 
ENDIF 
a1 = 0
SELECT solicitadas
SKIP
LOOP

ENDDO 
 	
 
 thisform.combo_meses.Value = ' '
 thisform.txt_año.Value = ' '
 
 SELECT c_ordenes
 
 lcArchivo=LOWER(PUTFILE("Guardar Archivo:","c_ordenes.xls",".xls")) 
 
 COPY TO (lcArchivo) TYPE XL5

  
 
 
 