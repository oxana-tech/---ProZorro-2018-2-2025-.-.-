   1. ЗАГРУЗКА CSV В DUCKDB
========================================================= */

CREATE OR REPLACE TABLE procurements_2018_all AS
SELECT *
FROM read_csv_auto('D:/.../procurements_2018_all.csv');

CREATE OR REPLACE TABLE procurements_2019_all AS
SELECT *
FROM read_csv_auto('D:/.../procurements_2019_all.csv');

CREATE OR REPLACE TABLE procurements_2020_all AS
SELECT *
FROM read_csv_auto('D:/.../procurements_2020_all.csv');

CREATE OR REPLACE TABLE procurements_all_2021 AS
SELECT *
FROM read_csv_auto('D:/.../procurements_all_2021.csv');

CREATE OR REPLACE TABLE procurements_all_2022 AS
SELECT *
FROM read_csv_auto('D:/.../procurements_all_2022.csv');

CREATE OR REPLACE TABLE procurements_all_2023 AS
SELECT *
FROM read_csv_auto('D:/.../procurements_all_2023.csv');

CREATE OR REPLACE TABLE procurements_all_2024 AS
SELECT *
FROM read_csv_auto('D:/.../procurements_all_2024.csv');

CREATE OR REPLACE TABLE procurements_1pivr2025 AS
SELECT *
FROM read_csv_auto('D:/.../procurements_1pivr2025.csv');
2. Объединение таблиц
/* =========================================================
   2. ОБЪЕДИНЕНИЕ ВСЕХ ТАБЛИЦ
========================================================= */

CREATE OR REPLACE TABLE union_all_procurements AS

SELECT
    *,
    NULL AS valueCurrency,
    NULL AS CPVCode,
    NULL AS CPVCodeName,
    NULL AS valueExpected,
    NULL AS procurementStatus,
    NULL AS contractStatus,
    NULL AS link
FROM procurements_2018_all

UNION ALL

SELECT
    *,
    NULL AS valueCurrency,
    NULL AS CPVCode,
    NULL AS CPVCodeName,
    NULL AS valueExpected,
    NULL AS procurementStatus,
    NULL AS contractStatus,
    NULL AS link
FROM procurements_2019_all

UNION ALL

SELECT
    *,
    NULL AS valueCurrency,
    NULL AS CPVCode,
    NULL AS CPVCodeName,
    NULL AS valueExpected,
    NULL AS procurementStatus,
    NULL AS contractStatus,
    NULL AS link
FROM procurements_2020_all

UNION ALL

SELECT
    *,
    NULL AS valueCurrency
FROM procurements_all_2021

UNION ALL

SELECT
    *,
    NULL AS valueCurrency
FROM procurements_all_2022

UNION ALL

SELECT
    *,
    NULL AS valueCurrency
FROM procurements_all_2023

UNION ALL

SELECT *
FROM procurements_all_2024

UNION ALL

SELECT *
FROM procurements_1pivr2025;
3. Очистка и приведение типов
/* =========================================================
   3. ОЧИСТКА ДАННЫХ
========================================================= */

UPDATE union_all_procurements
SET valueAmount = '0'
WHERE valueAmount IS NULL
   OR LOWER(TRIM(valueAmount)) = 'null';

UPDATE union_all_procurements
SET valueExpected = '0'
WHERE valueExpected IS NULL
   OR LOWER(TRIM(valueExpected)) = 'null';


ALTER TABLE union_all_procurements
ALTER COLUMN valueAmount
TYPE DECIMAL(18,2);

ALTER TABLE union_all_procurements
ALTER COLUMN valueExpected
TYPE DECIMAL(18,2);
4. Загрузка курса валют
/* =========================================================
   4. КУРСЫ ВАЛЮТ
========================================================= */

CREATE OR REPLACE TABLE exchange_rate AS
SELECT *
FROM read_xlsx(
'D:/.../EUR USD GBR курс гривні щодо іноземних валют.xlsx'
);
5. Финальное VIEW
/* =========================================================
   5. ФИНАЛЬНОЕ VIEW
========================================================= */

CREATE OR REPLACE VIEW v_union_all_ts_uah AS

WITH base AS (

    SELECT
        t.*,

        /* -----------------------------
           disposerName_unified
        ------------------------------ */

        CASE
            WHEN disposerName IS NULL THEN NULL

            ELSE UPPER(
                TRIM(
                    REGEXP_REPLACE(
                        REGEXP_REPLACE(
                            REGEXP_REPLACE(
                                REGEXP_REPLACE(
                                    REGEXP_REPLACE(

                                        CASE
                                            WHEN LEFT(TRIM(disposerName), 1) = '"'
                                             AND RIGHT(TRIM(disposerName), 1) = '"'
                                             AND LENGTH(TRIM(disposerName)) >= 2
                                            THEN SUBSTR(
                                                TRIM(disposerName),
                                                2,
                                                LENGTH(TRIM(disposerName)) - 2
                                            )
                                            ELSE TRIM(disposerName)
                                        END,

                                        '[«»“”„‟]',
                                        '"',
                                        'g'
                                    ),

                                    '\s+',
                                    ' ',
                                    'g'
                                ),

                                '\s*\.\s*',
                                '.',
                                'g'
                            ),

                            '"\s+|\s+"',
                            '"',
                            'g'
                        ),

                        '([А-ЯA-ZІЇЄҐ0-9])"([А-ЯA-ZІЇЄҐ0-9])',
                        '\1 "\2',
                        'g'
                    )
                )
            )
        END AS disposerName_unified,


        /* -----------------------------
           supplierName_unified
        ------------------------------ */

        CASE
            WHEN supplierName IS NULL THEN NULL

            ELSE UPPER(
                TRIM(
                    REGEXP_REPLACE(
                        REGEXP_REPLACE(
                            REGEXP_REPLACE(
                                REGEXP_REPLACE(
                                    REGEXP_REPLACE(

                                        CASE
                                            WHEN LEFT(TRIM(supplierName), 1) = '"'
                                             AND RIGHT(TRIM(supplierName), 1) = '"'
                                             AND LENGTH(TRIM(supplierName)) >= 2
                                            THEN SUBSTR(
                                                TRIM(supplierName),
                                                2,
                                                LENGTH(TRIM(supplierName)) - 2
                                            )
                                            ELSE TRIM(supplierName)
                                        END,

                                        '[«»“”„‟]',
                                        '"',
                                        'g'
                                    ),

                                    '\s+',
                                    ' ',
                                    'g'
                                ),

                                '\s*\.\s*',
                                '.',
                                'g'
                            ),

                            '"\s+|\s+"',
                            '"',
                            'g'
                        ),

                        '([А-ЯA-ZІЇЄҐ0-9])"([А-ЯA-ZІЇЄҐ0-9])',
                        '\1 "\2',
                        'g'
                    )
                )
            )
        END AS supplierName_unified

    FROM union_all_procurements AS t
)

SELECT
    base.*,

    /* -----------------------------
       valueAmount_UAH
    ------------------------------ */

    CASE
        WHEN base.valueCurrency IS NULL
            THEN base.valueAmount

        WHEN UPPER(TRIM(base.valueCurrency)) = 'UAH'
            THEN base.valueAmount

        WHEN UPPER(TRIM(base.valueCurrency))
             IN ('USD', 'EUR', 'GBP')

            THEN base.valueAmount
                 * CAST(r.Rate AS DECIMAL(18,6))

        ELSE NULL
    END AS valueAmount_UAH,


    /* -----------------------------
       valueExpected_UAH
    ------------------------------ */

    CASE
        WHEN base.valueCurrency IS NULL
            THEN base.valueExpected

        WHEN UPPER(TRIM(base.valueCurrency)) = 'UAH'
            THEN base.valueExpected

        WHEN UPPER(TRIM(base.valueCurrency))
             IN ('USD', 'EUR', 'GBP')

            THEN base.valueExpected
                 * CAST(r.Rate AS DECIMAL(18,6))

        ELSE NULL
    END AS valueExpected_UAH,


    /* -----------------------------
       currency after conversion
    ------------------------------ */

    CASE
        WHEN base.valueCurrency IS NULL THEN 'UAH'

        WHEN UPPER(TRIM(base.valueCurrency))
             IN ('UAH', 'USD', 'EUR', 'GBP')
        THEN 'UAH'

        ELSE NULL
    END AS valueCurrency_UAH,


    r.Rate           AS exchange_rate,
    r."Код літерний" AS exchange_currency,
    r."Дата"         AS exchange_date

FROM base

LEFT JOIN exchange_rate AS r
    ON CAST(base.dateSigned AS DATE)
       = CAST(r."Дата" AS DATE)

   AND UPPER(TRIM(base.valueCurrency))
       = UPPER(TRIM(r."Код літерний"));
       6. Проверки качества данных
/* =========================================================
   6. ПРОВЕРКИ
========================================================= */

-- Проверка количества строк

SELECT
    (SELECT COUNT(*) FROM union_all_procurements) AS rows_before,
    (SELECT COUNT(*) FROM v_union_all_ts_uah)     AS rows_after;


-- Проверка NULL

SELECT
    COUNT(*) AS total_rows,

    COUNT(*) FILTER (
        WHERE disposerName IS NULL
    ) AS disposerName_nulls,

    COUNT(*) FILTER (
        WHERE disposerName_unified IS NULL
    ) AS disposerName_unified_nulls,

    COUNT(*) FILTER (
        WHERE supplierName IS NULL
    ) AS supplierName_nulls,

    COUNT(*) FILTER (
        WHERE supplierName_unified IS NULL
    ) AS supplierName_unified_nulls

FROM v_union_all_ts_uah;


-- Проверка кавычек

SELECT

    COUNT(*) FILTER (
        WHERE MOD(
            LENGTH(disposerName_unified)
            - LENGTH(REPLACE(disposerName_unified, '"', '')),
            2
        ) = 1
    ) AS bad_disposer_quotes,

    COUNT(*) FILTER (
        WHERE MOD(
            LENGTH(supplierName_unified)
            - LENGTH(REPLACE(supplierName_unified, '"', '')),
            2
        ) = 1
    ) AS bad_supplier_quotes

FROM v_union_all_ts_uah;