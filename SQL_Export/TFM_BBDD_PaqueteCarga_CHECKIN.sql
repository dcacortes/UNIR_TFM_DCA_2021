PROCEDURE create_checkin IS
    BEGIN
        DELETE FROM checkin
        WHERE
            fecha_carga > sysdate - 1
            AND fecha_carga <= sysdate;

        INSERT INTO checkin
            SELECT 
        --DNI_FACTURACION,
        --UCI_FACTURACION,
        --DID_FACTURACION,
                billete_facturacion,
                billete_fake_checkin,
        --LINK_AMADEUS_SIVVAR,
                tipo_checkin_aceptado,
                boarded_checkin,
                canal_primer_checkin,
                estado_checkin,
                fecha_checkin,
                equipaje,
                peso_total,
                unidad,
                fecha_equipaje,
                fecha_vuelo,
                fecha_vuelo - fecha_checkin AS antelacion_checkin,
                CASE
                    WHEN facturacion.equipaje = 'SI'
                         AND facturacion.hora_ckin IS NOT NULL THEN
                        fecha_vuelo - fecha_equipaje
                    WHEN facturacion.equipaje = 'NO'
                         OR facturacion.hora_ckin IS NULL THEN
                        - 99
                END AS antelacion_equipaje,
                tarjeta_checkin,
                usa_tarjeta_checkin,
                fecha_carga,
                id_maleta,
                origen,
                destino
            FROM
                (
                    SELECT
                        CASE
                            WHEN substr(a.foid, 3) IS NULL THEN
                                'DESCONOCIDO'
                            WHEN substr(a.foid, 3) IS NOT NULL THEN
                                substr(a.foid, 3)
                        END AS dni_facturacion,
                        a.fecha_carga   AS fecha_carga,
                        a.uci           AS uci_facturacion,
                        a.did           AS did_facturacion,
                        a.billete       AS billete_facturacion,
                        b.fecha_vuelo,
                        a.origen        AS origen,
                        a.destino       AS destino,
                        a.billete
                        || 'C'
                        || a.cupon
                        || coalesce(
                            CASE
                                WHEN length(coalesce(
                                    CASE
                                        WHEN presivvar.presivvar_adm_companias.cia_cod = '3B' THEN
                                            'CV'
                                        ELSE
                                            presivvar.presivvar_adm_companias.cia_cod
                                    END, '')
                                            || coalesce(a.vuelo, '')) < 6 THEN
                                    coalesce(
                                        CASE
                                            WHEN presivvar.presivvar_adm_companias.cia_cod = '3B' THEN
                                                'CV'
                                            ELSE
                                                presivvar.presivvar_adm_companias.cia_cod
                                        END, '')
                                    || coalesce('0', '')
                                    || coalesce(a.vuelo, '')
                                ELSE
                                    coalesce(
                                        CASE
                                            WHEN presivvar.presivvar_adm_companias.cia_cod = '3B' THEN
                                                'CV'
                                            ELSE
                                                presivvar.presivvar_adm_companias.cia_cod
                                        END, '')
                                    || coalesce(a.vuelo, '')
                            END, '')
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
                        || a.destino AS billete_fake_checkin,
                        a.billete
                        || a.origen
                        || a.destino AS link_amadeus_sivvar,
                        CASE
                            WHEN tipo_aceptado = 'W'     THEN
                                'Desconocido'
                            WHEN tipo_aceptado = 'WEB'   THEN
                                'Desconocido'
                            WHEN tipo_aceptado = 'A'     THEN
                                'MOSTRADOR AEROPUERTO'
                            WHEN tipo_aceptado = 'AER'   THEN
                                'MOSTRADOR AEROPUERTO'
                            WHEN tipo_aceptado = 'M'     THEN
                                'CHECKIN MOVIL'
                            WHEN tipo_aceptado = 'MOVIL' THEN
                                'CHECKIN MOVIL'
                            WHEN tipo_aceptado = 'IATCI' THEN
                                'Desconocido'
                            WHEN tipo_aceptado IS NULL THEN
                                'Desconocido'
                        END AS tipo_checkin_aceptado,
                        a.estado        AS boarded_checkin,
                        CASE
                            WHEN equipaje.uci IS NULL THEN
                                'NO'
                            ELSE
                                'SI'
                        END AS equipaje,
                        peso_total,
                        unidad,
                        to_date(
                            CASE
                                WHEN hora_ckin IS NOT NULL THEN
                                    fecha_ckin
                                    || ' '
                                    || lpad(hora_ckin, 5, '0')
                                    || ':00'
                                WHEN hora_ckin IS NULL
                                     AND fecha_ckin IS NOT NULL THEN
                                    fecha_ckin
                                    || ' '
                                    || '00:00:00'
                                WHEN fecha_ckin IS NULL THEN
                                    '01/01/9999'
                                    || ' '
                                    || '00:00:00'
                            END, 'DD/MM/YYYY HH24:MI:SS') AS fecha_equipaje,
                        equipaje.hora_ckin,
                        ff              AS tarjeta_checkin,
                        CASE
                            WHEN ff IS NOT NULL
                                 AND cli_dni.cd_num_documento = cli_tar.cd_num_documento THEN
                                'Usa Tarjeta NT Propia'
                            WHEN ff IS NOT NULL
                                 AND cli_dni.cd_num_documento <> cli_tar.cd_num_documento THEN
                                'Usa Tarjeta NT Ajena'
                            WHEN ff IS NOT NULL
                                 AND substr(a.ff, 1, 2) = 'IB' THEN
                                'Usa Tarjeta IB'
                            WHEN ff IS NOT NULL
                                 AND substr(a.ff, 1, 2) = 'UX' THEN
                                'Usa Tarjeta UX'
                            WHEN ff IS NOT NULL
                                 AND substr(a.ff, 1, 2) NOT IN (
                                'NT',
                                'IB',
                                'UX'
                            ) THEN
                                'Usa Otra Tarjeta'
                            WHEN ff IS NOT NULL
                                 AND cli_tar.cd_tarjeta_fid IS NULL THEN
                                'Tarjeta no existe en SICLI'
                            WHEN ff IS NOT NULL
                                 AND a.foid IS NULL THEN
                                'No se puede comprobar (sin FOID)'
                            WHEN ff IS NOT NULL
                                 AND cli_dni.cd_num_documento IS NULL THEN
                                'No se puede comprobar (FOID incorrecto)'
                            WHEN ff IS NULL THEN
                                'No Usa Tarjeta'
                        END AS usa_tarjeta_checkin,
                        equipaje.ubi    AS id_maleta
                    FROM
                        int_amad.ccprrr@oraps03_reader_bigdata                  a
                        LEFT JOIN presivvar.presivvar_adm_companias@dbdw_reader_bigdata ON presivvar.presivvar_adm_companias.cia =
                        a.cia_billete
                        LEFT JOIN int_amad.bidbrr@oraps03_reader_bigdata                  equipaje ON
                            CASE
                                WHEN a.cia_billete = '474' THEN
                                    'NT'
                            END
                        = equipaje.carrier
                            AND a.uci = equipaje.uci
                            AND a.vuelo = equipaje.vuelo
                            AND a.origen = equipaje.origen
                            AND a.destino = equipaje.destino
                            AND a.fecha_vuelo = equipaje.fecha_vuelo
                        LEFT JOIN presivvar.presivvar_cupones_aracs@dbdw_reader_bigdata   b ON a.billete = b.billete
                                                                                             AND a.origen = b.origen
                                                                                             AND a.destino = b.destino
                                                                                             AND a.cupon = b.cupon
                        LEFT JOIN dwcli.dwcli_lclientes@dbdw_reader_bigdata               cli_dni ON
                            CASE
                                WHEN a.foid IS NULL THEN
                                    coalesce('ZZZZZZZZZ', '')
                                ELSE
                                    coalesce(substr(lpad(foid, 11, 'Z'), 3), '')
                            END
                        = cli_dni.cd_num_documento
                            AND cli_dni.cd_fecha_baja_fid = to_date('31/12/9999')
                        LEFT JOIN dwcli.dwcli_lclientes@dbdw_reader_bigdata               cli_tar ON
                            CASE
                                WHEN a.ff IS NULL THEN
                                    coalesce('ZZZZZZZZZ', '')
                                ELSE
                                    coalesce(substr(lpad(a.ff, 10, 'Z'), 3), '')
                            END
                        = cli_tar.cd_tarjeta_fid
                            AND cli_tar.cd_fecha_baja_fid = to_date('31/12/9999')
                    WHERE
                        a.fecha_carga > sysdate - 1
                        AND a.fecha_carga <= sysdate
                ) facturacion
                LEFT JOIN (
                    SELECT
                        tleft.did          AS did_historico,
                        CASE
                            WHEN tleft.canal_ckin = 'W'     THEN
                                'Desconocido'
                            WHEN tleft.canal_ckin = 'WEB'   THEN
                                'Desconocido'
                            WHEN tleft.canal_ckin = 'A'     THEN
                                'MOSTRADOR AEROPUERTO'
                            WHEN tleft.canal_ckin = 'AER'   THEN
                                'MOSTRADOR AEROPUERTO'
                            WHEN tleft.canal_ckin = 'M'     THEN
                                'CHECKIN MOVIL'
                            WHEN tleft.canal_ckin = 'MOVIL' THEN
                                'CHECKIN MOVIL'
                            WHEN tleft.canal_ckin = 'IATCI' THEN
                                'Desconocido'
                            WHEN tleft.canal_ckin IS NULL THEN
                                'Desconocido'
                        END AS canal_primer_checkin,

                -- TLEFT.CANAL_CKIN AS CANAL_PRIMER_CHECKIN, 
                        CASE
                            WHEN tleft.estado_ckin = 'ACCEPTED' THEN
                                'ACEPTADO'
                            WHEN tleft.estado_ckin IS NULL THEN
                                'NO ACEPTADO'
                        END AS estado_checkin,

                -- TLEFT.ESTADO_CKIN AS ESTADO_CHECKIN, 
                        tleft.fecha_ckin   AS fecha_checkin
                    FROM
                        (
                            SELECT
                                *
                            FROM
                                int_amad.ccprrr_hist@oraps03_reader_bigdata
                            WHERE
                                estado_ckin = 'ACCEPTED'
                        ) tleft
                        JOIN (
                            SELECT
                                did,
                                origen,
                                MIN(fecha_ckin) AS min_fecha
                            FROM
                                int_amad.ccprrr_hist@oraps03_reader_bigdata
                            GROUP BY
                                did,
                                origen
                        ) tright ON tleft.did = tright.did
                                    AND tleft.fecha_ckin = tright.min_fecha
                                    AND tleft.origen = tright.origen
                ) facturacion_hist ON facturacion.did_facturacion = facturacion_hist.did_historico;

        COMMIT;
    END create_checkin;