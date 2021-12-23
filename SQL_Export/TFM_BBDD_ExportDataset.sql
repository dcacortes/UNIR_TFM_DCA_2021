SELECT
S.ID_VUELO,
S.ORIGEN_PROG ORIGEN,
S.DESTINO_PROG DESTINO,
(CASE 
  WHEN (MO.MERCADO IN ('Internacional','Africa','Cabo Verde') OR MD.MERCADO IN ('Internacional','Africa','Cabo Verde')) THEN 'Internacional'
  WHEN (MO.MERCADO IN ('Internacional EU','Portugal') OR MD.MERCADO IN ('Internacional EU','Portugal')) THEN 'Schengen'
  WHEN (MO.MERCADO IN ('Peninsula') OR MD.MERCADO IN ('Peninsula')) THEN 'Domestico'
  WHEN (MO.MERCADO IN ('Canarias') OR MD.MERCADO IN ('Canarias')) THEN 'Interinsular'
ELSE 'Desconocido' END) SEGMENTO,
S.CIA,
S.VUELO,
S.FLOTA_PROGRAMADA,
S.PROPIETARIO_VUELO,
S.FECHA_SALIDA_PROG,
TO_CHAR(S.FECHA_SALIDA_PROG,'YYYY') ANIO,
TO_CHAR(S.FECHA_SALIDA_PROG,'MM') MES,
TO_CHAR(S.FECHA_SALIDA_PROG,'DD') DIA,
TO_CHAR(S.FECHA_SALIDA_PROG,'D') DIA_SEMANA,
TO_CHAR(S.FECHA_SALIDA_PROG,'HH24:MI') HORA,
CASE WHEN DF.FECHA IS NULL THEN 0
ELSE 1 END FESTIVO,
S.MATRICULA_PROGRAMADA MATR, 
S.FRANJA_HORARIA,
S.OPERADOR_PROGRAMADO,
S.ASIENTOS_OFERTADOS OFERTA,
S.PASAJEROS_TRANSPORTADOS,
ROUND(S.OCUPACION,0) OCUPACION,
S.SECTOR,
S.CAPACIDAD_MAXIMA_PROG CMAX,
V.PAX_V,
VF.PAX_F,
VM.PAX_M,
COALESCE(V180.A180,0) A180,
COALESCE(V120.A120,0) A120,
COALESCE(V60.A60,0) A60,
COALESCE(V0.A0,0) A0

FROM BIGDATA.SIAIC S
-- Aeropuertos Mercado
LEFT JOIN BIGDATA.AEROPUERTO_MERCADO MO ON S.ORIGEN_PROG = MO.AEROPUERTO
LEFT JOIN BIGDATA.AEROPUERTO_MERCADO MD ON S.DESTINO_PROG = MD.AEROPUERTO
-- D�as Festivos
LEFT JOIN BIGDATA.DIAS_FESTIVOS DF ON 
  TO_CHAR(S.FECHA_SALIDA_PROG, 'DD/MM/YYYY') = TO_CHAR(DF.FECHA,'DD/MM/YYYY')
-- Pax Volados
LEFT JOIN
(SELECT ID_VUELO, COUNT(ID_BILLETE) PAX_V
  FROM BIGDATA.VOLADOS
  WHERE TRANSPORTADO = 'TRANSPORTADO'
  GROUP BY ID_VUELO) V ON S.ID_VUELO = V.ID_VUELO
-- Volados Fidelizados
LEFT JOIN
(SELECT ID_VUELO,COUNT(SICLI.DNI) PAX_F
  FROM BIGDATA.VOLADOS V2
  LEFT JOIN BIGDATA.DNI_BILLETE DNI ON V2.BILLETE = DNI.BILLETE
  LEFT JOIN 
  (SELECT DNI 
    FROM BIGDATA.SICLI 
    WHERE NIVEL_TARJETA IN ('Oro VIP','Plata','Verde','Oro')) SICLI
  ON DNI.DNI = SICLI.DNI 
  WHERE TRANSPORTADO = 'TRANSPORTADO'
  GROUP BY ID_VUELO) VF ON S.ID_VUELO = VF.ID_VUELO
-- Presentados en Mostrador
LEFT JOIN
(SELECT ID_VUELO, COUNT(V.ID_BILLETE) PAX_M
  FROM BIGDATA.VOLADOS V
  INNER JOIN
  (SELECT DISTINCT ID_BILLETE FROM BIGDATA.CHECKIN_MOSTRADOR_ACEPTADOS) X
  ON V.ID_BILLETE = X.ID_BILLETE
  WHERE TRANSPORTADO = 'TRANSPORTADO'
  GROUP BY ID_VUELO) VM ON S.ID_VUELO = VM.ID_VUELO
-- PAX >= 120
LEFT JOIN
(SELECT ID_VUELO, COUNT(V.ID_BILLETE) A180
  FROM BIGDATA.VOLADOS V
  INNER JOIN
  (SELECT DISTINCT ID_BILLETE 
     FROM BIGDATA.CHECKIN_MOSTRADOR_ACEPTADOS
   WHERE (((ANTELACION_CHECKIN>0) AND (ANTELACION_EQUIPAJE<0) AND ((ANTELACION_CHECKIN*24*60) >= 180)) OR 
        ((ANTELACION_EQUIPAJE>0) AND ((ANTELACION_EQUIPAJE*24*60) >= 180)))) X
  ON V.ID_BILLETE = X.ID_BILLETE
  WHERE TRANSPORTADO = 'TRANSPORTADO'
  GROUP BY ID_VUELO) V180 ON S.ID_VUELO = V180.ID_VUELO
-- 180 > PAX >= 120
LEFT JOIN
(SELECT ID_VUELO, COUNT(V.ID_BILLETE) A120
  FROM BIGDATA.VOLADOS V
  INNER JOIN
  (SELECT DISTINCT ID_BILLETE 
   FROM BIGDATA.CHECKIN_MOSTRADOR_ACEPTADOS
   WHERE (((ANTELACION_CHECKIN>0) AND (ANTELACION_EQUIPAJE<0) AND ((ANTELACION_CHECKIN*24*60) BETWEEN 120 AND 180)) OR 
        ((ANTELACION_EQUIPAJE>0) AND ((ANTELACION_EQUIPAJE*24*60) BETWEEN 120 AND 180)))) X
  ON V.ID_BILLETE = X.ID_BILLETE
  WHERE TRANSPORTADO = 'TRANSPORTADO'
  GROUP BY ID_VUELO) V120 ON S.ID_VUELO = V120.ID_VUELO
-- 120 > PAX >= 60
LEFT JOIN
(SELECT ID_VUELO, COUNT(V.ID_BILLETE) A60
  FROM BIGDATA.VOLADOS V
  INNER JOIN
  (SELECT DISTINCT ID_BILLETE 
   FROM BIGDATA.CHECKIN_MOSTRADOR_ACEPTADOS
   WHERE (((ANTELACION_CHECKIN>0) AND (ANTELACION_EQUIPAJE<0) AND ((ANTELACION_CHECKIN*24*60) BETWEEN 60 AND 120)) OR 
        ((ANTELACION_EQUIPAJE>0) AND ((ANTELACION_EQUIPAJE*24*60) BETWEEN 60 AND 120)))) X
  ON V.ID_BILLETE = X.ID_BILLETE
  WHERE TRANSPORTADO = 'TRANSPORTADO'
  GROUP BY ID_VUELO) V60 ON S.ID_VUELO = V60.ID_VUELO
-- 60 > PAX >= 0
LEFT JOIN
(SELECT ID_VUELO, COUNT(V.ID_BILLETE) A0
  FROM BIGDATA.VOLADOS V
  INNER JOIN
  (SELECT DISTINCT ID_BILLETE 
   FROM BIGDATA.CHECKIN_MOSTRADOR_ACEPTADOS
   WHERE (((ANTELACION_CHECKIN>0) AND (ANTELACION_EQUIPAJE<0) AND ((ANTELACION_CHECKIN*24*60) < 60)) OR 
        ((ANTELACION_EQUIPAJE>0) AND ((ANTELACION_EQUIPAJE*24*60) < 60)))) X
  ON V.ID_BILLETE = X.ID_BILLETE
  WHERE TRANSPORTADO = 'TRANSPORTADO'
  GROUP BY ID_VUELO) V0 ON S.ID_VUELO = V0.ID_VUELO

-- ---------------------------------------------  
WHERE S.FECHA_SALIDA_PROG BETWEEN TO_DATE('01/01/2019') AND TO_DATE('01/08/2021')
;

