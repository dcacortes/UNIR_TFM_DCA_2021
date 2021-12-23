PROCEDURE create_volados IS
    BEGIN
        DELETE FROM volados
        WHERE
            billete IN (
                SELECT DISTINCT
                    billete
                FROM
                    presivvar.presivvar_cupones_volados@dbdw_reader_bigdata
                WHERE
                    fecha_carga <= to_date(sysdate - 2)
                    AND fecha_carga > to_date(sysdate - 3)
            );

        INSERT INTO volados
            SELECT
                cia,
                billete,
                localizador,
                fecha_compra,
                id_billete,
                id_vuelo,
                id_venta_volados,
                transportista,
                vuelo,
                fecha_vuelo,
                importe,
                importe_pagado,
                tipo_tramo,
                clase,
                farebasis,
                tipo_pax,
                tipo_persona,
                transportado,
                guagua_barco,
                origen,
                destino,
                fecha_carga
            FROM
                (
                    SELECT
                        a.cia             AS cia,
                        a.billete         AS billete,
                        substr(transa.localizador, 0, 6) AS localizador,
                        transa.fecha      AS fecha_compra,
                        a.billete
                        || 'C'
                        || a.cupon
                        ||
                            CASE
                                WHEN presivvar.presivvar_adm_companias.cia_cod = '3B' THEN
                                    'CV'
                                ELSE
                                    presivvar.presivvar_adm_companias.cia_cod
                            END
                        || a.vuelo
                        || coalesce('D', '')
                        || coalesce(
                            CASE
                                WHEN length(to_char(EXTRACT(DAY FROM a.fecha_vuelo))) < 2 THEN
                                    coalesce('0', '')
                                    || coalesce(to_char(EXTRACT(DAY FROM a.fecha_vuelo)), '')
                                ELSE
                                    coalesce(to_char(EXTRACT(DAY FROM a.fecha_vuelo)), '')
                            END, '')
                        || coalesce('M', '')
                        || coalesce(
                            CASE
                                WHEN length(to_char(EXTRACT(MONTH FROM a.fecha_vuelo))) < 2 THEN
                                    coalesce('0', '')
                                    || coalesce(to_char(EXTRACT(MONTH FROM a.fecha_vuelo)), '')
                                ELSE
                                    coalesce(to_char(EXTRACT(MONTH FROM a.fecha_vuelo)), '')
                            END, '')
                        || coalesce('Y', '')
                        || coalesce(
                            CASE
                                WHEN length(to_char(EXTRACT(YEAR FROM a.fecha_vuelo))) < 2 THEN
                                    coalesce('0', '')
                                    || coalesce(to_char(EXTRACT(YEAR FROM a.fecha_vuelo)), '')
                                ELSE
                                    coalesce(to_char(EXTRACT(YEAR FROM a.fecha_vuelo)), '')
                            END, '')
                        || a.origen
                        || a.destino AS id_billete, -- se puede poner B (ventas) para saber el vuelo que compr�.

      /*
            CASE WHEN PRESIVVAR.PRESIVVAR_ADM_COMPANIAS.CIA_COD = '3B' THEN 'CV' ELSE PRESIVVAR.PRESIVVAR_ADM_COMPANIAS.CIA_COD END || A.VUELO || COALESCE('D','') || COALESCE(CASE WHEN LENGTH(TO_CHAR(EXTRACT(day FROM A.FECHA_VUELO))) < 2
                                     THEN COALESCE('0','') || COALESCE(TO_CHAR(EXTRACT(day FROM A.FECHA_VUELO)),'')
                                     ELSE COALESCE(TO_CHAR(EXTRACT(day FROM A.FECHA_VUELO)),'') END,'') ||
      COALESCE('M','') || COALESCE(CASE WHEN LENGTH(TO_CHAR(EXTRACT(month FROM A.FECHA_VUELO))) < 2
                                     THEN COALESCE('0','') || COALESCE(TO_CHAR(EXTRACT(month FROM A.FECHA_VUELO)),'')
                                     ELSE COALESCE(TO_CHAR(EXTRACT(month FROM A.FECHA_VUELO)),'') END,'') ||
      COALESCE('Y','') || COALESCE(CASE WHEN LENGTH(TO_CHAR(EXTRACT(year FROM A.FECHA_VUELO))) < 2
                                     THEN COALESCE('0','') || COALESCE(TO_CHAR(EXTRACT(year FROM A.FECHA_VUELO)),'')
                                     ELSE COALESCE(TO_CHAR(EXTRACT(year FROM A.FECHA_VUELO)),'') END,'')  || A.ORIGEN || A.DESTINO,

    */

-- Usando transportista en lugar de CIA
                        CASE
                                WHEN a.transportista = '3B' THEN
                                    'CV'
                                ELSE
                                    a.transportista
                            END
                        ||
                            CASE
                                WHEN a.destino != 'LIS' THEN
                                    CASE
                                        WHEN length(a.vuelo) > 4 THEN
                                            substr(a.vuelo, 2, 4)
                                        ELSE
                                            a.vuelo
                                    END
                                ELSE
                                    substr(
                                        CASE
                                            WHEN length(a.vuelo) < 5 THEN
                                                a.vuelo || '0'
                                            ELSE
                                                a.vuelo
                                        END, 1, 4)
                            END
                        || coalesce('D', '')
                        || coalesce(
                            CASE
                                WHEN length(to_char(EXTRACT(DAY FROM a.fecha_vuelo))) < 2 THEN
                                    coalesce('0', '')
                                    || coalesce(to_char(EXTRACT(DAY FROM a.fecha_vuelo)), '')
                                ELSE
                                    coalesce(to_char(EXTRACT(DAY FROM a.fecha_vuelo)), '')
                            END, '')
                        || coalesce('M', '')
                        || coalesce(
                            CASE
                                WHEN length(to_char(EXTRACT(MONTH FROM a.fecha_vuelo))) < 2 THEN
                                    coalesce('0', '')
                                    || coalesce(to_char(EXTRACT(MONTH FROM a.fecha_vuelo)), '')
                                ELSE
                                    coalesce(to_char(EXTRACT(MONTH FROM a.fecha_vuelo)), '')
                            END, '')
                        || coalesce('Y', '')
                        || coalesce(
                            CASE
                                WHEN length(to_char(EXTRACT(YEAR FROM a.fecha_vuelo))) < 2 THEN
                                    coalesce('0', '')
                                    || coalesce(to_char(EXTRACT(YEAR FROM a.fecha_vuelo)), '')
                                ELSE
                                    coalesce(to_char(EXTRACT(YEAR FROM a.fecha_vuelo)), '')
                            END, '')
                        || a.origen
                        || a.destino AS id_vuelo,


       /* CASE WHEN A.TRANSPORTISTA = '3B' THEN 'CV' ELSE A.TRANSPORTISTA END || CASE 
      WHEN B.DESTINO != 'LIS' THEN CASE WHEN LENGTH(B.VUELO) > 4 THEN SUBSTR(B.VUELO,2,4) ELSE B.VUELO END
      ELSE SUBSTR(
        CASE
          WHEN LENGTH(B.VUELO) < 5 THEN B.VUELO || '0'
          ELSE B.VUELO 
        END
      ,1,4) END || COALESCE('D','') || COALESCE(CASE WHEN LENGTH(TO_CHAR(EXTRACT(DAY FROM B.FECHA_VUELO))) < 2
                                     THEN COALESCE('0','') || COALESCE(TO_CHAR(EXTRACT(DAY FROM B.FECHA_VUELO)),'')
                                     ELSE COALESCE(TO_CHAR(EXTRACT(DAY FROM B.FECHA_VUELO)),'') END,'') ||
      COALESCE('M','') || COALESCE(CASE WHEN LENGTH(TO_CHAR(EXTRACT(MONTH FROM B.FECHA_VUELO))) < 2
                                     THEN COALESCE('0','') || COALESCE(TO_CHAR(EXTRACT(MONTH FROM B.FECHA_VUELO)),'')
                                     ELSE COALESCE(TO_CHAR(EXTRACT(MONTH FROM B.FECHA_VUELO)),'') END,'') ||
      COALESCE('Y','') || COALESCE(CASE WHEN LENGTH(TO_CHAR(EXTRACT(YEAR FROM B.FECHA_VUELO))) < 2
                                     THEN COALESCE('0','') || COALESCE(TO_CHAR(EXTRACT(YEAR FROM B.FECHA_VUELO)),'')
                                     ELSE COALESCE(TO_CHAR(EXTRACT(YEAR FROM B.FECHA_VUELO)),'') END,'')  || B.ORIGEN || B.DESTINO AS ID_VUELO_PROG,         
      */
                        a.billete
                        || 'C'
                        || a.cupon AS id_venta_volados,
                        a.transportista   AS transportista,
                        CASE
                            WHEN length(a.vuelo) < 4 THEN
                                '0' || a.vuelo
                            ELSE
                                a.vuelo
                        END AS vuelo,
      -- TO_CHAR(CAST(A.FECHA_VUELO AS DATE),'DD/MM/YYYY') AS FECHA_VUELO,     
                        a.fecha_vuelo     AS fecha_vuelo,
                        a.fecha_carga     AS fecha_carga,
                        a.importe         AS importe,
                        a.importe - a.subvencion AS importe_pagado, 
      -- to_char(cast(A.FECHA_VENTA as date),'DD/MM/YYYY'),     
                        a.tipo_tramo      AS tipo_tramo,
                        a.clase           AS clase,
                        a.farebasis       AS farebasis,
                        a.tipo_pax        AS tipo_pax,
                        CASE
                            WHEN ( a.tipo_doc IN (
                                'PAX',
                                'AER',
                                'FIM'
                            )
                                   AND ( a.cia != '474'
                                         OR a.numeracion_fim = '0' ) )
                                 AND a.tipo_pax IN (
                                'AD'
                            )
                                 AND ( a.importe > 0.00 ) THEN
                                'pax_adultos_pago'
                            WHEN ( a.tipo_doc IN (
                                'PAX',
                                'AER',
                                'FIM'
                            )
                                   AND ( a.cia != '474'
                                         OR a.numeracion_fim = '0' ) )
                                 AND a.tipo_pax IN (
                                'AD'
                            )
                                 AND ( a.importe <= 0.00 ) THEN
                                'pax_adultos_free'
                            WHEN ( a.tipo_doc IN (
                                'PAX',
                                'AER',
                                'FIM'
                            )
                                   AND ( a.cia != '474'
                                         OR a.numeracion_fim = '0' ) )
                                 AND a.tipo_pax = 'CH'
                                 AND ( a.importe > 0.00 ) THEN
                                'pax_child_pago'
                            WHEN ( a.tipo_doc IN (
                                'PAX',
                                'AER',
                                'FIM'
                            )
                                   AND ( a.cia != '474'
                                         OR a.numeracion_fim = '0' ) )
                                 AND a.tipo_pax = 'CH'
                                 AND ( a.importe <= 0.00 ) THEN
                                'pax_child_free'
                            WHEN ( a.tipo_doc IN (
                                'PAX',
                                'AER',
                                'FIM'
                            )
                                   AND ( a.cia != '474'
                                         OR a.numeracion_fim = '0' ) )
                                 AND a.tipo_pax = 'IN' THEN
                                'pax_infant'
                            WHEN a.tipo_doc IN (
                                'BLC',
                                'CHA'
                            ) THEN
                                'pax_charter'
                            WHEN a.tipo_doc = 'EXC' THEN
                                'exc_eq'
                            WHEN a.tipo_doc = 'MCO' THEN
                                'mco'
                            ELSE
                                'Desconocido'
                        END AS tipo_persona,
                        CASE
                            WHEN ( a.tipo_doc IN (
                                'PAX',
                                'AER',
                                'FIM'
                            )
                                   AND ( a.cia != '474'
                                         OR a.numeracion_fim = '0' ) )
                                 AND a.tipo_pax IN (
                                'AD'
                            )
                                 AND ( a.importe > 0.00 ) THEN
                                'TRANSPORTADO'
                            WHEN ( a.tipo_doc IN (
                                'PAX',
                                'AER',
                                'FIM'
                            )
                                   AND ( a.cia != '474'
                                         OR a.numeracion_fim = '0' ) )
                                 AND a.tipo_pax IN (
                                'AD'
                            )
                                 AND ( a.importe <= 0.00 ) THEN
                                'TRANSPORTADO'
                            WHEN ( a.tipo_doc IN (
                                'PAX',
                                'AER',
                                'FIM'
                            )
                                   AND ( a.cia != '474'
                                         OR a.numeracion_fim = '0' ) )
                                 AND a.tipo_pax = 'CH'
                                 AND ( a.importe > 0.00 ) THEN
                                'TRANSPORTADO'
                            WHEN ( a.tipo_doc IN (
                                'PAX',
                                'AER',
                                'FIM'
                            )
                                   AND ( a.cia != '474'
                                         OR a.numeracion_fim = '0' ) )
                                 AND a.tipo_pax = 'CH'
                                 AND ( a.importe <= 0.00 ) THEN
                                'TRANSPORTADO'
                            WHEN ( a.tipo_doc IN (
                                'PAX',
                                'AER',
                                'FIM'
                            )
                                   AND ( a.cia != '474'
                                         OR a.numeracion_fim = '0' ) )
                                 AND a.tipo_pax = 'IN' THEN
                                'NO TRANSPORTADO'
                            WHEN a.tipo_doc IN (
                                'BLC',
                                'CHA'
                            ) THEN
                                'TRANSPORTADO'
                            WHEN a.tipo_doc = 'EXC' THEN
                                'NO TRANSPORTADO'
                            WHEN a.tipo_doc = 'MCO' THEN
                                'NO TRANSPORTADO'
                            ELSE
                                'Desconocido'
                        END AS transportado,
                        CASE
                            WHEN a.origen = 'OZL'  THEN
                                'GUAGUA/BARCO'
                            WHEN a.destino = 'OZL' THEN
                                'GUAGUA/BARCO'
                            WHEN a.origen = 'GGA'  THEN
                                'GUAGUA/BARCO'
                            WHEN a.destino = 'GGA' THEN
                                'GUAGUA/BARCO'
                            ELSE
                                'VUELO'
                        END AS guagua_barco,
                        a.origen          AS origen,
                        a.destino         AS destino
                    FROM
                        presivvar.presivvar_cupones_volados@dbdw_reader_bigdata   a
                        LEFT JOIN presivvar.presivvar_adm_companias@dbdw_reader_bigdata ON presivvar.presivvar_adm_companias.cia =
                        a.cia
                        LEFT JOIN presivvar.presivvar_cupones_aracs@dbdw_reader_bigdata     b ON a.cia = b.cia
                                                                                             AND a.billete = b.billete
                                                                                             AND a.cupon = b.cupon
                                                                                             AND EXTRACT(YEAR FROM a.fecha_vuelo)
                                                                                             = EXTRACT(YEAR FROM b.fecha_vuelo)
                                                                                             AND b.tipo_transaccion = 'TKTT'
                        LEFT JOIN (
                            SELECT
                                cia,
                                tipo_transaccion,
                                billete,
                                ocupacion,
                                pnr AS localizador,
                                fecha
                            FROM
                                presivvar.presivvar_transacciones_aracs@dbdw_reader_bigdata
                        ) transa ON b.cia = transa.cia
                                    AND b.billete = transa.billete
                                    AND b.ocupacion = transa.ocupacion
                                    AND b.tipo_transaccion = transa.tipo_transaccion
                    WHERE
                        a.billete IN (
                            SELECT DISTINCT
                                billete
                            FROM
                                presivvar.presivvar_cupones_volados@dbdw_reader_bigdata
                            WHERE
                                fecha_carga <= to_date(sysdate - 2)
                                AND fecha_carga > to_date(sysdate - 3)
                        )
                        AND b.tipo_transaccion = 'TKTT'
--AND A.CIA = '474'
                );

        COMMIT;
    END create_volados;