    PROCEDURE create_siaic IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table SIAIC';
        INSERT INTO siaic
            SELECT
                fecha_real,
                cd_vuelo,
                CASE
                    WHEN vuelo_futuro = 'VUELO FUTURO' THEN
                        id_vuelo_programado
                    WHEN vuelo_futuro = 'VUELO PASADO' THEN
                        id_vuelo_real
                END AS id_vuelo,
                id_vuelo_programado,
                id_vuelo_real,
                cia,
                vuelo,
                flota_programada,
                flota_real,
                propietario_vuelo,
                hora_salida_programada,
                hora_salida_real,
                retraso,
                tramo_programado,
                trayecto_programado,
                tramo_real,
                trayecto_real,
                sector_real,
                operador_informes,
                origen_programado,
                destino_programado,
                origen_real,
                destino_real,
                sector_programado,
                matricula_programada,
                matricula_real,
                franja_horaria,
                origen1_vuelo,
                estado_vuelo,
                retraso_salida,
                retraso_llegada,
                cia_programada,
                cia_real,
                transportista_keops,
                tiempo_vuelo,
                tiempo_bloque,
                asientos_ofertados,
                numero_adultos_pago,
                numero_adultos_free,
                numero_child_pago,
                numero_child_free,
                numero_infant,
                numero_charter,
                nu_exc_equipaje,
                nu_mco,
                nu_otros,
                ingresos_adultos_pago,
                ingresos_adultos_free,
                ingresos_child_pago,
                ingresos_child_free,
                ingresos_infant,
                ingresos_charter,
                ingresos_equipaje,
                ingresos_mco,
                ingresos_otros,
                ingresos_tasas_qv,
                ingresos_tasas_rs,
                kg_equipaje,
                kg_mercancia_pago,
                kg_mercancia_free,
                kg_correo,
                ingresos_nercancia_pago,
                ingresos_mercancia_free,
                ingresos_correo,
                pasajeros_transportados,
                ocupacion,
                vuelo_futuro,
                capacidad_maxima_prog,
                capacidad_maxima_real
            FROM
                (
                    SELECT
                        crea_prod.biai_factividad2.cd_fecha_real             AS fecha_real,
                        crea_prod.biai_factividad2.cd_vuelo_id               AS cd_vuelo,
                        coalesce(
                            CASE
                                WHEN length(coalesce(crea_prod.biai_factividad2.cd_vuelo, '')) < 4 THEN
                                    coalesce(crea_prod.biai_dcompania.cd_compania, '')
                                    || '0'
                                    || coalesce(crea_prod.biai_factividad2.cd_vuelo, '')
                                ELSE
                                    coalesce(crea_prod.biai_dcompania.cd_compania, '')
                                    || coalesce(crea_prod.biai_factividad2.cd_vuelo, '')
                            END, '')
                        || coalesce('D', '')
                        || coalesce(
                            CASE
                                WHEN length(to_char(EXTRACT(DAY FROM crea_prod.biai_factividad2.cd_hora_salida_prog))) < 2 THEN
                                    coalesce('0', '')
                                    || coalesce(to_char(EXTRACT(DAY FROM crea_prod.biai_factividad2.cd_hora_salida_prog)), '')
                                ELSE
                                    coalesce(to_char(EXTRACT(DAY FROM crea_prod.biai_factividad2.cd_hora_salida_prog)), '')
                            END, '')
                        || coalesce('M', '')
                        || coalesce(
                            CASE
                                WHEN length(to_char(EXTRACT(MONTH FROM crea_prod.biai_factividad2.cd_hora_salida_prog))) < 2 THEN
                                    coalesce('0', '')
                                    || coalesce(to_char(EXTRACT(MONTH FROM crea_prod.biai_factividad2.cd_hora_salida_prog)), '')
                                ELSE
                                    coalesce(to_char(EXTRACT(MONTH FROM crea_prod.biai_factividad2.cd_hora_salida_prog)), '')
                            END, '')
                        || coalesce('Y', '')
                        || coalesce(
                            CASE
                                WHEN length(to_char(EXTRACT(YEAR FROM crea_prod.biai_factividad2.cd_hora_salida_prog))) < 2 THEN
                                    coalesce('0', '')
                                    || coalesce(to_char(EXTRACT(YEAR FROM crea_prod.biai_factividad2.cd_hora_salida_prog)), '')
                                ELSE
                                    coalesce(to_char(EXTRACT(YEAR FROM crea_prod.biai_factividad2.cd_hora_salida_prog)), '')
                            END, '')
                        || crea_prod.biai_factividad2.cd_ae_de_prog
                        || crea_prod.biai_factividad2.cd_ae_at_prog AS id_vuelo_programado,
                        coalesce(
                            CASE
                                WHEN length(coalesce(crea_prod.biai_factividad2.cd_vuelo, '')) < 4 THEN
                                    coalesce(crea_prod.biai_dcompania.cd_compania, '')
                                    || '0'
                                    || coalesce(crea_prod.biai_factividad2.cd_vuelo, '')
                                ELSE
                                    coalesce(crea_prod.biai_dcompania.cd_compania, '')
                                    || coalesce(crea_prod.biai_factividad2.cd_vuelo, '')
                            END, '')
                        || coalesce('D', '')
                        || coalesce(
                            CASE
                                WHEN length(to_char(EXTRACT(DAY FROM crea_prod.biai_factividad2.cd_hora_salida_real))) < 2 THEN
                                    coalesce('0', '')
                                    || coalesce(to_char(EXTRACT(DAY FROM crea_prod.biai_factividad2.cd_hora_salida_real)), '')
                                ELSE
                                    coalesce(to_char(EXTRACT(DAY FROM crea_prod.biai_factividad2.cd_hora_salida_real)), '')
                            END, '')
                        || coalesce('M', '')
                        || coalesce(
                            CASE
                                WHEN length(to_char(EXTRACT(MONTH FROM crea_prod.biai_factividad2.cd_hora_salida_real))) < 2 THEN
                                    coalesce('0', '')
                                    || coalesce(to_char(EXTRACT(MONTH FROM crea_prod.biai_factividad2.cd_hora_salida_real)), '')
                                ELSE
                                    coalesce(to_char(EXTRACT(MONTH FROM crea_prod.biai_factividad2.cd_hora_salida_real)), '')
                            END, '')
                        || coalesce('Y', '')
                        || coalesce(
                            CASE
                                WHEN length(to_char(EXTRACT(YEAR FROM crea_prod.biai_factividad2.cd_hora_salida_real))) < 2 THEN
                                    coalesce('0', '')
                                    || coalesce(to_char(EXTRACT(YEAR FROM crea_prod.biai_factividad2.cd_hora_salida_real)), '')
                                ELSE
                                    coalesce(to_char(EXTRACT(YEAR FROM crea_prod.biai_factividad2.cd_hora_salida_real)), '')
                            END, '')
                        || crea_prod.biai_factividad2.cd_ae_de_real
                        || crea_prod.biai_factividad2.cd_ae_at_real AS id_vuelo_real,
                        crea_prod.biai_dcompania.cd_compania                 AS cia,
                        CASE
                            WHEN length(crea_prod.biai_factividad2.cd_vuelo) < 4 THEN
                                '0' || crea_prod.biai_factividad2.cd_vuelo
                            ELSE
                                crea_prod.biai_factividad2.cd_vuelo
                        END AS vuelo,
                        CASE
                            WHEN flota1.ds_desc_flota IS NULL THEN
                                'Desconocido'
                            ELSE
                                flota1.ds_desc_flota
                        END AS flota_programada,
                        CASE
                            WHEN flota2.ds_desc_flota IS NULL THEN
                                'Desconocido'
                            ELSE
                                flota2.ds_desc_flota
                        END AS flota_real,
                        CASE
                            WHEN crea_prod.biai_dpropietario_vuelo.ds_propietario_vuelo IS NULL THEN
                                'Desconocido'
                            ELSE
                                crea_prod.biai_dpropietario_vuelo.ds_propietario_vuelo
                        END AS propietario_vuelo,


    --to_char(cast(CREA_PROD.BIAI_FACTIVIDAD2.CD_HORA_SALIDA_PROG_LOC as date),'DD/MM/YYYY'),
                        crea_prod.biai_factividad2.cd_hora_salida_prog_loc   AS hora_salida_programada,
    --to_char(cast(CREA_PROD.BIAI_FACTIVIDAD2.CD_HORA_SALIDA_PROG_LOC as date),'hh24:mi:ss'),
    --to_char(cast(CREA_PROD.BIAI_FACTIVIDAD2.CD_HORA_SALIDA_REAL_LOC as date),'DD/MM/YYYY'),
                        crea_prod.biai_factividad2.cd_hora_salida_real_loc   AS hora_salida_real,
    --to_char(cast(CREA_PROD.BIAI_FACTIVIDAD2.CD_HORA_SALIDA_REAL_LOC as date),'hh24:mi:ss'),
                        CASE
      -- WHEN to_char(cast(CREA_PROD.BIAI_FACTIVIDAD2.CD_HORA_SALIDA_REAL_LOC as date),'hh24:mi:ss') IS NULL THEN 0
                            WHEN EXTRACT(DAY FROM(CAST(crea_prod.biai_factividad2.cd_hora_salida_real AS TIMESTAMP) - CAST(crea_prod
                            .biai_factividad2.cd_hora_salida_prog AS TIMESTAMP)) * 24 * 60) > 0 THEN
                                EXTRACT(DAY FROM(CAST(crea_prod.biai_factividad2.cd_hora_salida_real AS TIMESTAMP) - CAST(crea_prod
                                .biai_factividad2.cd_hora_salida_prog AS TIMESTAMP)) * 24 * 60)
                            WHEN EXTRACT(DAY FROM(CAST(crea_prod.biai_factividad2.cd_hora_salida_real AS TIMESTAMP) - CAST(crea_prod
                            .biai_factividad2.cd_hora_salida_prog AS TIMESTAMP)) * 24 * 60) <= 0 THEN
                                0
                        END AS retraso,
    
    -- to_char(cast(CREA_PROD.BIAI_FACTIVIDAD2.CD_HORA_ATERRIZAJE_REAL as date),'DD/MM/YYYY'),
    -- to_char(cast(CREA_PROD.BIAI_FACTIVIDAD2.CD_HORA_ATERRIZAJE_REAL as date),'hh24:mi:ss'),
    
    -- to_char(cast(CREA_PROD.BIAI_FACTIVIDAD2.CD_HORA_DESPEGUE_REAL as date),'DD/MM/YYYY'),
    -- to_char(cast(CREA_PROD.BIAI_FACTIVIDAD2.CD_HORA_DESPEGUE_REAL as date),'hh24:mi:ss'),
    
    -- to_char(cast(CREA_PROD.BIAI_FACTIVIDAD2.CD_HORA_LLEGADA_REAL as date),'DD/MM/YYYY'),
    -- to_char(cast(CREA_PROD.BIAI_FACTIVIDAD2.CD_HORA_LLEGADA_REAL as date),'hh24:mi:ss'),
    
    -- to_char(cast(CREA_PROD.BIAI_FACTIVIDAD2.CD_HORA_LLEGADA_PROG as date),'DD/MM/YYYY'),
    -- to_char(cast(CREA_PROD.BIAI_FACTIVIDAD2.CD_HORA_LLEGADA_PROG as date),'hh24:mi:ss'),
                        trayecto1.cd_tramo                                   AS tramo_programado,
                        trayecto1.ds_trayecto                                AS trayecto_programado,
                        trayecto2.cd_tramo                                   AS tramo_real,
                        trayecto2.ds_trayecto                                AS trayecto_real,
                        crea_prod.biai_vdsector_real.ds_sector_real          AS sector_real,
                        CASE
                            WHEN crea_prod.biai_dpropietario_vuelo.ds_propietario_vuelo = 'CANARYFLY'
                                 AND crea_prod.biai_vdsector_real.ds_sector_real = 'Canarias' THEN
                                'CNF'
                            WHEN crea_prod.biai_dpropietario_vuelo.ds_propietario_vuelo = 'CANARYFLY'
                                 AND ( crea_prod.biai_vdsector_real.ds_sector_real != 'Canarias'
                                       OR crea_prod.biai_vdsector_real.ds_sector_real IS NULL ) THEN
                                'IB'
                            WHEN crea_prod.biai_dcompania.cd_compania = 'NT' THEN
                                'NT'
                            WHEN crea_prod.biai_dcompania.cd_compania = 'CV' THEN
                                'BCV'
                            ELSE
                                'Desconocido'
                        END AS operador_informes,
                        crea_prod.biai_factividad2.cd_ae_de_prog             AS origen_programado,
                        crea_prod.biai_factividad2.cd_ae_at_prog             AS destino_programado,
                        crea_prod.biai_factividad2.cd_ae_de_real             AS origen_real,
                        crea_prod.biai_factividad2.cd_ae_at_real             AS destino_real,
                        CASE
                            WHEN crea_prod.biai_factividad2.cd_ae_de_prog IN (
                                'PMI',
                                'VGO',
                                'MAD',
                                'AGP',
                                'PNA',
                                'RMU',
                                'ZAZ'
                            )
                                 OR crea_prod.biai_factividad2.cd_ae_at_prog IN (
                                'PMI',
                                'VGO',
                                'MAD',
                                'AGP',
                                'PNA',
                                'RMU',
                                'ZAZ'
                            ) THEN
                                'Península y Baleares'
                            WHEN crea_prod.biai_factividad2.cd_ae_de_prog IN (
                                'LIS'
                            )
                                 OR crea_prod.biai_factividad2.cd_ae_at_prog IN (
                                'LIS'
                            ) THEN
                                'Lisboa'
                            WHEN crea_prod.biai_factividad2.cd_ae_de_prog IN (
                                'FNC',
                                'PXO',
                                'PDL'
                            )
                                 OR crea_prod.biai_factividad2.cd_ae_at_prog IN (
                                'FNC',
                                'PXO',
                                'PDL'
                            ) THEN
                                'Portugal - Islas'
                            WHEN crea_prod.biai_factividad2.cd_ae_de_prog IN (
                                'SID',
                                'BVC',
                                'RAI',
                                'SFL',
                                'VXE',
                                'MMO',
                                'SNE'
                            )
                                 OR crea_prod.biai_factividad2.cd_ae_at_prog IN (
                                'SID',
                                'BVC',
                                'RAI',
                                'SFL',
                                'VXE',
                                'MMO',
                                'SNE'
                            ) THEN
                                'Cabo Verde'
                            WHEN crea_prod.biai_factividad2.cd_ae_de_prog IN (
                                'AGA',
                                'BJL',
                                'CMN',
                                'RAK'
                            )
                                 OR crea_prod.biai_factividad2.cd_ae_at_prog IN (
                                'AGA',
                                'BJL',
                                'CMN',
                                'RAK'
                            ) THEN
                                'Marruecos'
                            WHEN crea_prod.biai_factividad2.cd_ae_de_prog IN (
                                'BOS',
                                'YYZ'
                            )
                                 OR crea_prod.biai_factividad2.cd_ae_at_prog IN (
                                'BOS',
                                'YYZ'
                            ) THEN
                                'América'
                            WHEN crea_prod.biai_factividad2.cd_ae_de_prog IN (
                                'DSS'
                            )
                                 OR crea_prod.biai_factividad2.cd_ae_at_prog IN (
                                'DSS'
                            ) THEN
                                'Dakar'
                            WHEN crea_prod.biai_factividad2.cd_ae_de_prog IN (
                                'NKC'
                            )
                                 OR crea_prod.biai_factividad2.cd_ae_at_prog IN (
                                'NKC'
                            ) THEN
                                'Mauritania'
                            WHEN crea_prod.biai_factividad2.cd_ae_de_prog IN (
                                'VIL',
                                'EUN'
                            )
                                 OR crea_prod.biai_factividad2.cd_ae_at_prog IN (
                                'VIL',
                                'EUN'
                            ) THEN
                                'Sáhara Occidental'
                            ELSE
                                'Canarias'
                        END AS sector_programado,
                        CASE
                            WHEN crea_prod.biai_factividad2.cd_matric_prog IS NULL THEN
                                'Desconocido'
                            ELSE
                                crea_prod.biai_factividad2.cd_matric_prog
                        END AS matricula_programada,
                        CASE
                            WHEN crea_prod.biai_factividad2.cd_matric_real IS NULL THEN
                                'Desconocido'
                            ELSE
                                crea_prod.biai_factividad2.cd_matric_real
                        END AS matricula_real,
                        crea_prod.biai_dfranja_horaria.ds_franja_horaria     AS franja_horaria,  
    -- CREA_PROD.BIAI_FACTIVIDAD2.CD_PRESUPUESTO,  
                        crea_prod.biai_dorigen_vuelo.ds_origen_vuelo         AS origen1_vuelo,
                        crea_prod.biai_destado_vuelo.ds_estado_vuelo         AS estado_vuelo,
                        CASE
                            WHEN crea_prod.biai_factividad2.cd_vlo_retr_sa = 0
                                 AND crea_prod.biai_factividad2.cd_hora_salida_real_loc IS NULL THEN
                                'Vuelo Futuro'
                            WHEN crea_prod.biai_factividad2.cd_vlo_retr_sa = 0 THEN
                                'RETRASO > 60 min'
                            WHEN crea_prod.biai_factividad2.cd_vlo_retr_sa = 1 THEN
                                'RETRASO 30 - 60 min'
                            WHEN crea_prod.biai_factividad2.cd_vlo_retr_sa = 2 THEN
                                'RETRASO 15 - 30 min'
                            WHEN crea_prod.biai_factividad2.cd_vlo_retr_sa = 3 THEN
                                'RETRASO 5 - 15 min'
                            WHEN crea_prod.biai_factividad2.cd_vlo_retr_sa = 4 THEN
                                'RETRASO 0 - 5 min'
                            WHEN crea_prod.biai_factividad2.cd_vlo_retr_sa = 9 THEN
                                'Desconocido'
                        END AS retraso_salida,
                        CASE
                            WHEN crea_prod.biai_factividad2.cd_vlo_retr_ll = 0
                                 AND crea_prod.biai_factividad2.cd_hora_llegada_real IS NULL THEN
                                'Vuelo Futuro'
                            WHEN crea_prod.biai_factividad2.cd_vlo_retr_ll = 0 THEN
                                'RETRASO > 60 min'
                            WHEN crea_prod.biai_factividad2.cd_vlo_retr_ll = 1 THEN
                                'RETRASO 30 - 60 min'
                            WHEN crea_prod.biai_factividad2.cd_vlo_retr_ll = 2 THEN
                                'RETRASO 15 - 30 min'
                            WHEN crea_prod.biai_factividad2.cd_vlo_retr_ll = 3 THEN
                                'RETRASO 5 - 15 min'
                            WHEN crea_prod.biai_factividad2.cd_vlo_retr_ll = 4 THEN
                                'RETRASO 0 - 5 min'
                            WHEN crea_prod.biai_factividad2.cd_vlo_retr_ll = 9 THEN
                                'Desconocido'
                        END AS retraso_llegada,
                        operador1.ds_compania                                AS cia_programada,
                        operador2.ds_compania                                AS cia_real,
                        CASE
                            WHEN operador3.ds_compania IS NULL THEN
                                'Desconocido'
                            ELSE
                                operador3.ds_compania
                        END AS transportista_keops,
                        crea_prod.biai_factividad2.nu_tmp_vuelo              AS tiempo_vuelo,
                        crea_prod.biai_factividad2.nu_tmp_bloque             AS tiempo_bloque,
                        crea_prod.biai_factividad2.nu_asien_ofer             AS asientos_ofertados,
                                              
    -- CREA_PROD.BIAI_FACTIVIDAD1.NU_AKO  
                        crea_prod.biai_factividad1.nu_pax_adultos_pago       AS numero_adultos_pago,
                        crea_prod.biai_factividad1.nu_pax_adultos_free       AS numero_adultos_free,
                        crea_prod.biai_factividad1.nu_pax_child_pago         AS numero_child_pago,
                        crea_prod.biai_factividad1.nu_pax_child_free         AS numero_child_free,
                        crea_prod.biai_factividad1.nu_pax_infant             AS numero_infant,
                        crea_prod.biai_factividad1.nu_pax_charter            AS numero_charter,
                        crea_prod.biai_factividad1.nu_exc_equipaje           AS nu_exc_equipaje,
                        crea_prod.biai_factividad1.nu_mco                    AS nu_mco,
                        crea_prod.biai_factividad1.nu_otros                  AS nu_otros,
                        crea_prod.biai_factividad1.nu_ing_pax_adultos_pago   AS ingresos_adultos_pago,
                        crea_prod.biai_factividad1.nu_ing_pax_adultos_free   AS ingresos_adultos_free,
                        crea_prod.biai_factividad1.nu_ing_pax_child_pago     AS ingresos_child_pago,
                        crea_prod.biai_factividad1.nu_ing_pax_child_free     AS ingresos_child_free,
                        crea_prod.biai_factividad1.nu_ing_pax_infant         AS ingresos_infant,
                        crea_prod.biai_factividad1.nu_ing_pax_charter        AS ingresos_charter,
                        crea_prod.biai_factividad1.nu_ing_exc_equipaje       AS ingresos_equipaje,
                        crea_prod.biai_factividad1.nu_ing_mco                AS ingresos_mco,
                        crea_prod.biai_factividad1.nu_ing_otros              AS ingresos_otros,
                        crea_prod.biai_factividad1.nu_ing_tasas_qv           AS ingresos_tasas_qv,
                        crea_prod.biai_factividad1.nu_ing_tasas_rs           AS ingresos_tasas_rs,
                        crea_prod.biai_factividad1.nu_kg_equipaje            AS kg_equipaje,
                        crea_prod.biai_factividad1.nu_kg_mercancia_pago      AS kg_mercancia_pago,
                        crea_prod.biai_factividad1.nu_kg_mercancia_free      AS kg_mercancia_free,
                        crea_prod.biai_factividad1.nu_kg_correo              AS kg_correo,
                        crea_prod.biai_factividad1.nu_ing_mercancia_pago     AS ingresos_nercancia_pago,
                        crea_prod.biai_factividad1.nu_ing_mercancia_free     AS ingresos_mercancia_free,
                        crea_prod.biai_factividad1.nu_ing_correo             AS ingresos_correo,
                        crea_prod.biai_factividad1.nu_pax_adultos_pago + crea_prod.biai_factividad1.nu_pax_adultos_free + crea_prod
                        .biai_factividad1.nu_pax_child_pago + crea_prod.biai_factividad1.nu_pax_child_free + crea_prod.biai_factividad1
                        .nu_pax_charter AS pasajeros_transportados,
                        CASE
                            WHEN crea_prod.biai_factividad2.nu_asien_ofer > 0 THEN
                                ( crea_prod.biai_factividad1.nu_pax_adultos_pago + crea_prod.biai_factividad1.nu_pax_adultos_free
                                + crea_prod.biai_factividad1.nu_pax_child_pago + crea_prod.biai_factividad1.nu_pax_child_free + crea_prod
                                .biai_factividad1.nu_pax_charter ) / crea_prod.biai_factividad2.nu_asien_ofer * 100
                            ELSE
                                0
                        END AS ocupacion,
                        CASE
                            WHEN crea_prod.biai_factividad2.cd_hora_salida_real IS NULL THEN
                                'VUELO FUTURO'
                            WHEN crea_prod.biai_factividad2.cd_hora_salida_real IS NOT NULL THEN
                                'VUELO PASADO'
                        END AS vuelo_futuro,
                        flota1.nu_asientos                                   capacidad_maxima_prog,
                        flota2.nu_asientos                                   capacidad_maxima_real
                    FROM
                        crea_prod.biai_factividad2@dbdw_reader_bigdata   left
                        JOIN crea_prod.biai_dcompania@dbdw_reader_bigdata ON crea_prod.biai_factividad2.cd_compa_id = crea_prod.biai_dcompania
                        .cd_compa_id
                        LEFT JOIN crea_prod.biai_dflota@dbdw_reader_bigdata        flota1 ON crea_prod.biai_factividad2.cd_flota_prog = flota1
                        .cd_flota
                        LEFT JOIN crea_prod.biai_dflota@dbdw_reader_bigdata        flota2 ON crea_prod.biai_factividad2.cd_flota_real = flota2
                        .cd_flota
                        LEFT JOIN crea_prod.biai_dpropietario_vuelo@dbdw_reader_bigdata ON flota2.cd_propietario = crea_prod.biai_dpropietario_vuelo
                        .cd_propietario_vuelo
                        LEFT JOIN crea_prod.biai_dtrayecto@dbdw_reader_bigdata     trayecto1 ON crea_prod.biai_factividad2.cd_trayecto_prog
                        = trayecto1.cd_trayecto
                        LEFT JOIN crea_prod.biai_dtrayecto@dbdw_reader_bigdata     trayecto2 ON crea_prod.biai_factividad2.cd_trayecto_real
                        = trayecto2.cd_trayecto
                        LEFT JOIN crea_prod.biai_destado_vuelo@dbdw_reader_bigdata ON crea_prod.biai_factividad2.cd_estado_vlo = crea_prod
                        .biai_destado_vuelo.cd_estado_vuelo
                        LEFT JOIN crea_prod.biai_dfranja_horaria@dbdw_reader_bigdata ON crea_prod.biai_factividad2.cd_franja_horaria
                        = crea_prod.biai_dfranja_horaria.cd_franja_horaria
                        LEFT JOIN crea_prod.biai_dorigen_vuelo@dbdw_reader_bigdata ON crea_prod.biai_factividad2.cd_origen_vlo = crea_prod
                        .biai_dorigen_vuelo.cd_origen_vuelo
                        LEFT JOIN crea_prod.biai_dcompania@dbdw_reader_bigdata     operador1 ON crea_prod.biai_factividad2.cd_cia_oper_prog
                        = operador1.cd_compa_id
                        LEFT JOIN crea_prod.biai_dcompania@dbdw_reader_bigdata     operador2 ON crea_prod.biai_factividad2.cd_cia_oper_real
                        = operador2.cd_compa_id
                        LEFT JOIN crea_prod.biai_dcompania@dbdw_reader_bigdata     operador3 ON crea_prod.biai_factividad2.cd_transportista_keops
                        = operador3.cd_compa_id
                        LEFT JOIN crea_prod.biai_factividad1@dbdw_reader_bigdata ON crea_prod.biai_factividad2.cd_vuelo_id = crea_prod
                        .biai_factividad1.cd_vuelo_id
  -- JOIN CREA_PROD.BIAI_DTRIPULANTE@DBDW_READER_BIGDATA ON CREA_PROD.BIAI_FACTIVIDAD2.CD_COMANDANTE = CREA_PROD.BIAI_DTRIPULANTE.CD_TRIPULANTE
                        LEFT JOIN crea_prod.biai_vdtrayecto_real@dbdw_reader_bigdata ON crea_prod.biai_factividad2.cd_trayecto_real
                        = crea_prod.biai_vdtrayecto_real.cd_trayecto_real
                        LEFT JOIN crea_prod.biai_vdsector_real@dbdw_reader_bigdata ON biai_vdtrayecto_real.cd_gsec_real = biai_vdsector_real
                        .cd_gran_sector_real
                                                                                      AND biai_vdtrayecto_real.cd_sec_real = biai_vdsector_real
                                                                                      .cd_sector_real
                    WHERE
                        crea_prod.biai_factividad2.cd_presupuesto = 'REAL'
                        AND crea_prod.biai_dcompania.cd_compania = 'NT'
                );

        COMMIT;
    END create_siaic;




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
                        || a.destino AS id_billete, -- se puede poner B (ventas) para saber el vuelo que compró.

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
    





















