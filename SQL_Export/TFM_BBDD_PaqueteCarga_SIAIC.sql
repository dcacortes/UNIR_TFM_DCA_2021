PROCEDURE create_siaic IS BEGIN EXECUTE IMMEDIATE 'truncate table SIAIC';

INSERT INTO
    siaic
SELECT
    fecha_real,
    cd_vuelo,
    CASE
        WHEN vuelo_futuro = 'VUELO FUTURO' THEN id_vuelo_programado
        WHEN vuelo_futuro = 'VUELO PASADO' THEN id_vuelo_real
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
            crea_prod.biai_factividad2.cd_fecha_real AS fecha_real,
            crea_prod.biai_factividad2.cd_vuelo_id AS cd_vuelo,
            coalesce(
                CASE
                    WHEN length(
                        coalesce(crea_prod.biai_factividad2.cd_vuelo, '')
                    ) < 4 THEN coalesce(crea_prod.biai_dcompania.cd_compania, '') || '0' || coalesce(crea_prod.biai_factividad2.cd_vuelo, '')
                    ELSE coalesce(crea_prod.biai_dcompania.cd_compania, '') || coalesce(crea_prod.biai_factividad2.cd_vuelo, '')
                END,
                ''
            ) || coalesce('D', '') || coalesce(
                CASE
                    WHEN length(
                        to_char(
                            EXTRACT(
                                DAY
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_prog
                            )
                        )
                    ) < 2 THEN coalesce('0', '') || coalesce(
                        to_char(
                            EXTRACT(
                                DAY
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_prog
                            )
                        ),
                        ''
                    )
                    ELSE coalesce(
                        to_char(
                            EXTRACT(
                                DAY
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_prog
                            )
                        ),
                        ''
                    )
                END,
                ''
            ) || coalesce('M', '') || coalesce(
                CASE
                    WHEN length(
                        to_char(
                            EXTRACT(
                                MONTH
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_prog
                            )
                        )
                    ) < 2 THEN coalesce('0', '') || coalesce(
                        to_char(
                            EXTRACT(
                                MONTH
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_prog
                            )
                        ),
                        ''
                    )
                    ELSE coalesce(
                        to_char(
                            EXTRACT(
                                MONTH
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_prog
                            )
                        ),
                        ''
                    )
                END,
                ''
            ) || coalesce('Y', '') || coalesce(
                CASE
                    WHEN length(
                        to_char(
                            EXTRACT(
                                YEAR
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_prog
                            )
                        )
                    ) < 2 THEN coalesce('0', '') || coalesce(
                        to_char(
                            EXTRACT(
                                YEAR
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_prog
                            )
                        ),
                        ''
                    )
                    ELSE coalesce(
                        to_char(
                            EXTRACT(
                                YEAR
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_prog
                            )
                        ),
                        ''
                    )
                END,
                ''
            ) || crea_prod.biai_factividad2.cd_ae_de_prog || crea_prod.biai_factividad2.cd_ae_at_prog AS id_vuelo_programado,
            coalesce(
                CASE
                    WHEN length(
                        coalesce(crea_prod.biai_factividad2.cd_vuelo, '')
                    ) < 4 THEN coalesce(crea_prod.biai_dcompania.cd_compania, '') || '0' || coalesce(crea_prod.biai_factividad2.cd_vuelo, '')
                    ELSE coalesce(crea_prod.biai_dcompania.cd_compania, '') || coalesce(crea_prod.biai_factividad2.cd_vuelo, '')
                END,
                ''
            ) || coalesce('D', '') || coalesce(
                CASE
                    WHEN length(
                        to_char(
                            EXTRACT(
                                DAY
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_real
                            )
                        )
                    ) < 2 THEN coalesce('0', '') || coalesce(
                        to_char(
                            EXTRACT(
                                DAY
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_real
                            )
                        ),
                        ''
                    )
                    ELSE coalesce(
                        to_char(
                            EXTRACT(
                                DAY
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_real
                            )
                        ),
                        ''
                    )
                END,
                ''
            ) || coalesce('M', '') || coalesce(
                CASE
                    WHEN length(
                        to_char(
                            EXTRACT(
                                MONTH
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_real
                            )
                        )
                    ) < 2 THEN coalesce('0', '') || coalesce(
                        to_char(
                            EXTRACT(
                                MONTH
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_real
                            )
                        ),
                        ''
                    )
                    ELSE coalesce(
                        to_char(
                            EXTRACT(
                                MONTH
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_real
                            )
                        ),
                        ''
                    )
                END,
                ''
            ) || coalesce('Y', '') || coalesce(
                CASE
                    WHEN length(
                        to_char(
                            EXTRACT(
                                YEAR
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_real
                            )
                        )
                    ) < 2 THEN coalesce('0', '') || coalesce(
                        to_char(
                            EXTRACT(
                                YEAR
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_real
                            )
                        ),
                        ''
                    )
                    ELSE coalesce(
                        to_char(
                            EXTRACT(
                                YEAR
                                FROM
                                    crea_prod.biai_factividad2.cd_hora_salida_real
                            )
                        ),
                        ''
                    )
                END,
                ''
            ) || crea_prod.biai_factividad2.cd_ae_de_real || crea_prod.biai_factividad2.cd_ae_at_real AS id_vuelo_real,
            crea_prod.biai_dcompania.cd_compania AS cia,
            CASE
                WHEN length(crea_prod.biai_factividad2.cd_vuelo) < 4 THEN '0' || crea_prod.biai_factividad2.cd_vuelo
                ELSE crea_prod.biai_factividad2.cd_vuelo
            END AS vuelo,
            CASE
                WHEN flota1.ds_desc_flota IS NULL THEN 'Desconocido'
                ELSE flota1.ds_desc_flota
            END AS flota_programada,
            CASE
                WHEN flota2.ds_desc_flota IS NULL THEN 'Desconocido'
                ELSE flota2.ds_desc_flota
            END AS flota_real,
            CASE
                WHEN crea_prod.biai_dpropietario_vuelo.ds_propietario_vuelo IS NULL THEN 'Desconocido'
                ELSE crea_prod.biai_dpropietario_vuelo.ds_propietario_vuelo
            END AS propietario_vuelo,
            crea_prod.biai_factividad2.cd_hora_salida_prog_loc AS hora_salida_programada,
            crea_prod.biai_factividad2.cd_hora_salida_real_loc AS hora_salida_real,
            CASE
                WHEN EXTRACT(
                    DAY
                    FROM
(
                            CAST(
                                crea_prod.biai_factividad2.cd_hora_salida_real AS TIMESTAMP
                            ) - CAST(
                                crea_prod.biai_factividad2.cd_hora_salida_prog AS TIMESTAMP
                            )
                        ) * 24 * 60
                ) > 0 THEN EXTRACT(
                    DAY
                    FROM
(
                            CAST(
                                crea_prod.biai_factividad2.cd_hora_salida_real AS TIMESTAMP
                            ) - CAST(
                                crea_prod.biai_factividad2.cd_hora_salida_prog AS TIMESTAMP
                            )
                        ) * 24 * 60
                )
                WHEN EXTRACT(
                    DAY
                    FROM
(
                            CAST(
                                crea_prod.biai_factividad2.cd_hora_salida_real AS TIMESTAMP
                            ) - CAST(
                                crea_prod.biai_factividad2.cd_hora_salida_prog AS TIMESTAMP
                            )
                        ) * 24 * 60
                ) <= 0 THEN 0
            END AS retraso,
            trayecto1.cd_tramo AS tramo_programado,
            trayecto1.ds_trayecto AS trayecto_programado,
            trayecto2.cd_tramo AS tramo_real,
            trayecto2.ds_trayecto AS trayecto_real,
            crea_prod.biai_vdsector_real.ds_sector_real AS sector_real,
            CASE
                WHEN crea_prod.biai_dpropietario_vuelo.ds_propietario_vuelo = 'CANARYFLY'
                AND crea_prod.biai_vdsector_real.ds_sector_real = 'Canarias' THEN 'CNF'
                WHEN crea_prod.biai_dpropietario_vuelo.ds_propietario_vuelo = 'CANARYFLY'
                AND (
                    crea_prod.biai_vdsector_real.ds_sector_real != 'Canarias'
                    OR crea_prod.biai_vdsector_real.ds_sector_real IS NULL
                ) THEN 'IB'
                WHEN crea_prod.biai_dcompania.cd_compania = 'NT' THEN 'NT'
                WHEN crea_prod.biai_dcompania.cd_compania = 'CV' THEN 'BCV'
                ELSE 'Desconocido'
            END AS operador_informes,
            crea_prod.biai_factividad2.cd_ae_de_prog AS origen_programado,
            crea_prod.biai_factividad2.cd_ae_at_prog AS destino_programado,
            crea_prod.biai_factividad2.cd_ae_de_real AS origen_real,
            crea_prod.biai_factividad2.cd_ae_at_real AS destino_real,
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
                ) THEN 'Pen�nsula y Baleares'
                WHEN crea_prod.biai_factividad2.cd_ae_de_prog IN (
                    'LIS'
                )
                OR crea_prod.biai_factividad2.cd_ae_at_prog IN (
                    'LIS'
                ) THEN 'Lisboa'
                WHEN crea_prod.biai_factividad2.cd_ae_de_prog IN (
                    'FNC',
                    'PXO',
                    'PDL'
                )
                OR crea_prod.biai_factividad2.cd_ae_at_prog IN (
                    'FNC',
                    'PXO',
                    'PDL'
                ) THEN 'Portugal - Islas'
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
                ) THEN 'Cabo Verde'
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
                ) THEN 'Marruecos'
                WHEN crea_prod.biai_factividad2.cd_ae_de_prog IN (
                    'BOS',
                    'YYZ'
                )
                OR crea_prod.biai_factividad2.cd_ae_at_prog IN (
                    'BOS',
                    'YYZ'
                ) THEN 'Am�rica'
                WHEN crea_prod.biai_factividad2.cd_ae_de_prog IN (
                    'DSS'
                )
                OR crea_prod.biai_factividad2.cd_ae_at_prog IN (
                    'DSS'
                ) THEN 'Dakar'
                WHEN crea_prod.biai_factividad2.cd_ae_de_prog IN (
                    'NKC'
                )
                OR crea_prod.biai_factividad2.cd_ae_at_prog IN (
                    'NKC'
                ) THEN 'Mauritania'
                WHEN crea_prod.biai_factividad2.cd_ae_de_prog IN (
                    'VIL',
                    'EUN'
                )
                OR crea_prod.biai_factividad2.cd_ae_at_prog IN (
                    'VIL',
                    'EUN'
                ) THEN 'S�hara Occidental'
                ELSE 'Canarias'
            END AS sector_programado,
            CASE
                WHEN crea_prod.biai_factividad2.cd_matric_prog IS NULL THEN 'Desconocido'
                ELSE crea_prod.biai_factividad2.cd_matric_prog
            END AS matricula_programada,
            CASE
                WHEN crea_prod.biai_factividad2.cd_matric_real IS NULL THEN 'Desconocido'
                ELSE crea_prod.biai_factividad2.cd_matric_real
            END AS matricula_real,
            crea_prod.biai_dfranja_horaria.ds_franja_horaria AS franja_horaria,
            crea_prod.biai_dorigen_vuelo.ds_origen_vuelo AS origen1_vuelo,
            crea_prod.biai_destado_vuelo.ds_estado_vuelo AS estado_vuelo,
            CASE
                WHEN crea_prod.biai_factividad2.cd_vlo_retr_sa = 0
                AND crea_prod.biai_factividad2.cd_hora_salida_real_loc IS NULL THEN 'Vuelo Futuro'
                WHEN crea_prod.biai_factividad2.cd_vlo_retr_sa = 0 THEN 'RETRASO > 60 min'
                WHEN crea_prod.biai_factividad2.cd_vlo_retr_sa = 1 THEN 'RETRASO 30 - 60 min'
                WHEN crea_prod.biai_factividad2.cd_vlo_retr_sa = 2 THEN 'RETRASO 15 - 30 min'
                WHEN crea_prod.biai_factividad2.cd_vlo_retr_sa = 3 THEN 'RETRASO 5 - 15 min'
                WHEN crea_prod.biai_factividad2.cd_vlo_retr_sa = 4 THEN 'RETRASO 0 - 5 min'
                WHEN crea_prod.biai_factividad2.cd_vlo_retr_sa = 9 THEN 'Desconocido'
            END AS retraso_salida,
            CASE
                WHEN crea_prod.biai_factividad2.cd_vlo_retr_ll = 0
                AND crea_prod.biai_factividad2.cd_hora_llegada_real IS NULL THEN 'Vuelo Futuro'
                WHEN crea_prod.biai_factividad2.cd_vlo_retr_ll = 0 THEN 'RETRASO > 60 min'
                WHEN crea_prod.biai_factividad2.cd_vlo_retr_ll = 1 THEN 'RETRASO 30 - 60 min'
                WHEN crea_prod.biai_factividad2.cd_vlo_retr_ll = 2 THEN 'RETRASO 15 - 30 min'
                WHEN crea_prod.biai_factividad2.cd_vlo_retr_ll = 3 THEN 'RETRASO 5 - 15 min'
                WHEN crea_prod.biai_factividad2.cd_vlo_retr_ll = 4 THEN 'RETRASO 0 - 5 min'
                WHEN crea_prod.biai_factividad2.cd_vlo_retr_ll = 9 THEN 'Desconocido'
            END AS retraso_llegada,
            operador1.ds_compania AS cia_programada,
            operador2.ds_compania AS cia_real,
            CASE
                WHEN operador3.ds_compania IS NULL THEN 'Desconocido'
                ELSE operador3.ds_compania
            END AS transportista_keops,
            crea_prod.biai_factividad2.nu_tmp_vuelo AS tiempo_vuelo,
            crea_prod.biai_factividad2.nu_tmp_bloque AS tiempo_bloque,
            crea_prod.biai_factividad2.nu_asien_ofer AS asientos_ofertados,
            crea_prod.biai_factividad1.nu_pax_adultos_pago AS numero_adultos_pago,
            crea_prod.biai_factividad1.nu_pax_adultos_free AS numero_adultos_free,
            crea_prod.biai_factividad1.nu_pax_child_pago AS numero_child_pago,
            crea_prod.biai_factividad1.nu_pax_child_free AS numero_child_free,
            crea_prod.biai_factividad1.nu_pax_infant AS numero_infant,
            crea_prod.biai_factividad1.nu_pax_charter AS numero_charter,
            crea_prod.biai_factividad1.nu_exc_equipaje AS nu_exc_equipaje,
            crea_prod.biai_factividad1.nu_mco AS nu_mco,
            crea_prod.biai_factividad1.nu_otros AS nu_otros,
            crea_prod.biai_factividad1.nu_ing_pax_adultos_pago AS ingresos_adultos_pago,
            crea_prod.biai_factividad1.nu_ing_pax_adultos_free AS ingresos_adultos_free,
            crea_prod.biai_factividad1.nu_ing_pax_child_pago AS ingresos_child_pago,
            crea_prod.biai_factividad1.nu_ing_pax_child_free AS ingresos_child_free,
            crea_prod.biai_factividad1.nu_ing_pax_infant AS ingresos_infant,
            crea_prod.biai_factividad1.nu_ing_pax_charter AS ingresos_charter,
            crea_prod.biai_factividad1.nu_ing_exc_equipaje AS ingresos_equipaje,
            crea_prod.biai_factividad1.nu_ing_mco AS ingresos_mco,
            crea_prod.biai_factividad1.nu_ing_otros AS ingresos_otros,
            crea_prod.biai_factividad1.nu_ing_tasas_qv AS ingresos_tasas_qv,
            crea_prod.biai_factividad1.nu_ing_tasas_rs AS ingresos_tasas_rs,
            crea_prod.biai_factividad1.nu_kg_equipaje AS kg_equipaje,
            crea_prod.biai_factividad1.nu_kg_mercancia_pago AS kg_mercancia_pago,
            crea_prod.biai_factividad1.nu_kg_mercancia_free AS kg_mercancia_free,
            crea_prod.biai_factividad1.nu_kg_correo AS kg_correo,
            crea_prod.biai_factividad1.nu_ing_mercancia_pago AS ingresos_nercancia_pago,
            crea_prod.biai_factividad1.nu_ing_mercancia_free AS ingresos_mercancia_free,
            crea_prod.biai_factividad1.nu_ing_correo AS ingresos_correo,
            crea_prod.biai_factividad1.nu_pax_adultos_pago + crea_prod.biai_factividad1.nu_pax_adultos_free + crea_prod.biai_factividad1.nu_pax_child_pago + crea_prod.biai_factividad1.nu_pax_child_free + crea_prod.biai_factividad1.nu_pax_charter AS pasajeros_transportados,
            CASE
                WHEN crea_prod.biai_factividad2.nu_asien_ofer > 0 THEN (
                    crea_prod.biai_factividad1.nu_pax_adultos_pago + crea_prod.biai_factividad1.nu_pax_adultos_free + crea_prod.biai_factividad1.nu_pax_child_pago + crea_prod.biai_factividad1.nu_pax_child_free + crea_prod.biai_factividad1.nu_pax_charter
                ) / crea_prod.biai_factividad2.nu_asien_ofer * 100
                ELSE 0
            END AS ocupacion,
            CASE
                WHEN crea_prod.biai_factividad2.cd_hora_salida_real IS NULL THEN 'VUELO FUTURO'
                WHEN crea_prod.biai_factividad2.cd_hora_salida_real IS NOT NULL THEN 'VUELO PASADO'
            END AS vuelo_futuro,
            flota1.nu_asientos capacidad_maxima_prog,
            flota2.nu_asientos capacidad_maxima_real
        FROM
            crea_prod.biai_factividad2 @dbdw_reader_bigdata
            left JOIN crea_prod.biai_dcompania @dbdw_reader_bigdata ON crea_prod.biai_factividad2.cd_compa_id = crea_prod.biai_dcompania.cd_compa_id
            LEFT JOIN crea_prod.biai_dflota @dbdw_reader_bigdata flota1 ON crea_prod.biai_factividad2.cd_flota_prog = flota1.cd_flota
            LEFT JOIN crea_prod.biai_dflota @dbdw_reader_bigdata flota2 ON crea_prod.biai_factividad2.cd_flota_real = flota2.cd_flota
            LEFT JOIN crea_prod.biai_dpropietario_vuelo @dbdw_reader_bigdata ON flota2.cd_propietario = crea_prod.biai_dpropietario_vuelo.cd_propietario_vuelo
            LEFT JOIN crea_prod.biai_dtrayecto @dbdw_reader_bigdata trayecto1 ON crea_prod.biai_factividad2.cd_trayecto_prog = trayecto1.cd_trayecto
            LEFT JOIN crea_prod.biai_dtrayecto @dbdw_reader_bigdata trayecto2 ON crea_prod.biai_factividad2.cd_trayecto_real = trayecto2.cd_trayecto
            LEFT JOIN crea_prod.biai_destado_vuelo @dbdw_reader_bigdata ON crea_prod.biai_factividad2.cd_estado_vlo = crea_prod.biai_destado_vuelo.cd_estado_vuelo
            LEFT JOIN crea_prod.biai_dfranja_horaria @dbdw_reader_bigdata ON crea_prod.biai_factividad2.cd_franja_horaria = crea_prod.biai_dfranja_horaria.cd_franja_horaria
            LEFT JOIN crea_prod.biai_dorigen_vuelo @dbdw_reader_bigdata ON crea_prod.biai_factividad2.cd_origen_vlo = crea_prod.biai_dorigen_vuelo.cd_origen_vuelo
            LEFT JOIN crea_prod.biai_dcompania @dbdw_reader_bigdata operador1 ON crea_prod.biai_factividad2.cd_cia_oper_prog = operador1.cd_compa_id
            LEFT JOIN crea_prod.biai_dcompania @dbdw_reader_bigdata operador2 ON crea_prod.biai_factividad2.cd_cia_oper_real = operador2.cd_compa_id
            LEFT JOIN crea_prod.biai_dcompania @dbdw_reader_bigdata operador3 ON crea_prod.biai_factividad2.cd_transportista_keops = operador3.cd_compa_id
            LEFT JOIN crea_prod.biai_factividad1 @dbdw_reader_bigdata ON crea_prod.biai_factividad2.cd_vuelo_id = crea_prod.biai_factividad1.cd_vuelo_id
            LEFT JOIN crea_prod.biai_vdtrayecto_real @dbdw_reader_bigdata ON crea_prod.biai_factividad2.cd_trayecto_real = crea_prod.biai_vdtrayecto_real.cd_trayecto_real
            LEFT JOIN crea_prod.biai_vdsector_real @dbdw_reader_bigdata ON biai_vdtrayecto_real.cd_gsec_real = biai_vdsector_real.cd_gran_sector_real
            AND biai_vdtrayecto_real.cd_sec_real = biai_vdsector_real.cd_sector_real
        WHERE
            crea_prod.biai_factividad2.cd_presupuesto = 'REAL'
            AND crea_prod.biai_dcompania.cd_compania = 'NT'
    );

COMMIT;

END create_siaic;