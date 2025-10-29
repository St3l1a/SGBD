--EJERCICIO 1
--1.
--@crear_tablas.sql;
--@datos2.sql;
--2.
CREATE INDEX IDX_SEXO
ON ACTORES (SEXO);

CREATE INDEX IDX_ANYO
ON PELICULAS (ANYO);

--3.
exec dbms_stats.gather_table_stats(ownname => 'GIISGBD101', tabname => 'ACTORES',cascade => TRUE, method_opt => 'FOR ALL COLUMNS SIZE 254',force => TRUE);

exec dbms_stats.gather_table_stats(ownname => 'GIISGBD101', tabname => 'ACTUACION',cascade => TRUE, method_opt => 'FOR ALL COLUMNS SIZE 254',force => TRUE);

exec dbms_stats.gather_table_stats(ownname => 'GIISGBD101', tabname => 'PELICULAS',cascade => TRUE, method_opt => 'FOR ALL COLUMNS SIZE 254',force => TRUE);

---4.a Taules: nom, nombre de files, nombre de blocs, longitud mitjana dels registres
SELECT table_name,
       num_rows,
       blocks,
       avg_space
FROM user_tab_statistics;
/*Resultado:
Table_name  Num_rows    Blocks  Avg_space
ACTORES     9146        244     0
PELICULAS   11182       370     0
ACTUACION   12500       244     0
*/

/*4.b Columnes: nom de taula i de columna, quantitat de valors diferents, valors mínim i 
màxim, nombre de nuls, longitud mitjana de la columna, histograma.*/
SELECT table_name,
        column_name,
        num_distinct,
        low_value,
        high_value,
        num_nulls,
        avg_col_len,
        histogram
FROM user_tab_col_statistics;
/*Resultado:
TABLE_NAME      COLUMN_NAME	    NUM_DISTINCT    LOW_VALUE	    HIGH_VALUE	    NUM_NULLS	AVG_LENGTH	HISTOGRAM
ACTORES	        SEXO	        1	            4D	            4D	            0	        2	        FREQUENCY
ACTORES	        NOM	            9146	        41616C746F2...  6C61205075...	0	        101     	HYBRID
ACTORES	        OID	            9146	        C3173202	    C33B3C35	    0	        5	        HYBRID
ACTUACION	    PAPEL	        6585	        3173742041...   C9766120202...  0	        101	        HYBRID
ACTUACION	    PELI	        11182	        C3173108	    C33B3B54	    0	        5	        HYBRID
ACTUACION	    ACTOR	        9146	        C3173202	    C33B3C35	    0	        5	        HYBRID
PELICULAS	    ANYO	        95	            80	            C21464	        0	        4	        FREQUENCY
PELICULAS	    TITULO	        11014	        243130303...    DA74656...      0	        201     	HYBRID
PELICULAS	    OID	            11182	        C3173108	    C33B3B54	    0	        5	        HYBRID
*/

/*4.c Índexs: nom, taula, profunditat, blocs en les fulles, quantitat de claus diferents, 
mitjana de blocs fulla per clau, mitjana de blocs de dades per clau, factor de 
clustering, nombre de registres
*/
SELECT index_name,
        table_name,
        blevel,
        leaf_blocks,
        distinct_keys,
        avg_leaf_blocks_per_key,
        avg_data_blocks_per_key,
        clustering_factor,
        num_rows
FROM user_ind_statistics;
/*Resultado:
INDEX_NAME     TABLE_NAME   BLEVEL  LEAF_BLOCKS     DISTINCT_KEYS   AVG_LEAF_BLOCKS_PER_KEY     AVG_DATA_BLOCKS_PER_KEY     CLUSTERING_FACTOR   NUM_ROWS
IDX_SEXO	    ACTORES	    1	    25	            1	            25	                        144	                        144	                9146
SYS_C00377216	ACTORES	    1	    18	            9146	        1	                        1	                        153	                9146
IDX_ANYO	    PELICULAS	1	    31	            95	            1	                        88	                        8430	            11182
SYS_C00377220	PELICULAS	1	    21	            11182	        1	                        1	                        370	                11182
SYS_C00377224	ACTUACION	1	    190	            12500	        1	                        1	                        219	                12500
*/

/*5.
Si, avg_space en las tablas sale como 0, low y high_value en las columnas salen como valores hexadecimales, los valores de la comuna sexo solo tiene 1 valor distinto
y hay índices muy dispersos (AVG_LEAF_BLOCKS_PER_KEY = 1) 
*/

--6.
DROP INDEX IDX_SEXO;
DROP INDEX IDX_ANYO;

exec dbms_stats.delete_table_stats(ownname => 'GIISGBD101', tabname => 'ACTORES');
exec dbms_stats.delete_table_stats(ownname => 'GIISGBD101', tabname => 'ACTUACION');
exec dbms_stats.delete_table_stats(ownname => 'GIISGBD101', tabname => 'PELICULAS');

--7. Consultar de nou la informació estadística emmagatzemada
/*
    Observamos que ahora todos los valores salen como null
*/

-- 1.-Executar les consultes i anotar els registres recuperats i el temps d’execució. 
    SELECT *
    FROM PELICULAS
    WHERE ANYO > 1992;
    
SELECT plan_table_output
FROM 
    table(DBMS_XPLAN.DISPLAY('PLAN_TABLE',
    NULL,'TYPICAL'));

/*
2000 FILAS Y 00:00:00.060 
-------------------------------------------------------------------------------
| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |           |  2126 |   473K|   102   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| PELICULAS |  2126 |   473K|   102   (0)| 00:00:01 |
-------------------------------------------------------------------------------
Predicate Information (identified by operation id):
---------------------------------------------------
   1 - filter("ANYO">1992)
Note
-----
   - dynamic statistics used: dynamic sampling (level=2)
   - SQL plan baseline "SQL_PLAN_37ncmpadunta7d6672d41" used for this statement
*/

SELECT *
FROM PELICULAS P, ACTUACION ACT
WHERE P.OID = ACT.PELI
AND ANYO > 1992;

SELECT plan_table_output
FROM 
    table(DBMS_XPLAN.DISPLAY('PLAN_TABLE',
    NULL,'TYPICAL'));
    
/*
2294 FILAS RECUPERADAS Y 00:00:00.095 
---------------------------------------------------------------------------------------
| Id  | Operation             | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT      |               |  2771 |   963K|   170   (0)| 00:00:01 |
|*  1 |  HASH JOIN            |               |  2771 |   963K|   170   (0)| 00:00:01 |
|*  2 |   TABLE ACCESS FULL   | PELICULAS     |  2126 |   473K|   102   (0)| 00:00:01 |
|   3 |   INDEX FAST FULL SCAN| SYS_C00377276 | 14167 |  1770K|    68   (0)| 00:00:01 |
---------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - access("P"."OID"="ACT"."PELI")
   2 - filter("ANYO">1992)
 
Note
-----
   - dynamic statistics used: dynamic sampling (level=2)
   - SQL plan baseline "SQL_PLAN_5rbfp05f7uk3m7c4a039a" used for this statement
*/
SELECT P.*
FROM ACTORES A, ACTUACION X, PELICULAS P
WHERE A.NOM = 'Loy, Myrna'
AND A.OID = X.ACTOR
AND P.OID = X.PELI;

SELECT plan_table_output
FROM 
    table(DBMS_XPLAN.DISPLAY('PLAN_TABLE',
    NULL,'TYPICAL'));
    
/*
11 FILAS Y 00:00:00.031
----------------------------------------------------------------------------------------------
| Id  | Operation                    | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |               |     9 |  3321 |    80   (0)| 00:00:01 |
|   1 |  NESTED LOOPS                |               |     9 |  3321 |    80   (0)| 00:00:01 |
|   2 |   NESTED LOOPS               |               |     9 |  3321 |    80   (0)| 00:00:01 |
|   3 |    NESTED LOOPS              |               |     9 |  1269 |    71   (0)| 00:00:01 |
|*  4 |     TABLE ACCESS FULL        | ACTORES       |     3 |   345 |    68   (0)| 00:00:01 |
|*  5 |     INDEX RANGE SCAN         | SYS_C00377276 |     3 |    78 |     1   (0)| 00:00:01 |
|*  6 |    INDEX UNIQUE SCAN         | SYS_C00377272 |     1 |       |     0   (0)| 00:00:01 |
|   7 |   TABLE ACCESS BY INDEX ROWID| PELICULAS     |     1 |   228 |     1   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - filter("A"."NOM"='Loy, Myrna')
   5 - access("A"."OID"="X"."ACTOR")
   6 - access("P"."OID"="X"."PELI")
 
Note
-----
   - dynamic statistics used: dynamic sampling (level=2)
   - SQL plan baseline "SQL_PLAN_4z5x6suxn6hpc21f1959c" used for this statement
*/

/*2. Obtenir per a cadascuna d'elles el seu pla d'execució.
    a. Existeix alguna contradicció entre els plans d'execució i els continguts de les taules?*/

    --Si, la suma de los tiempos del plan de ejecución no coincide con los tiempos transcurridos

/*3. Investiga el significat del missatge “Note - dynamic sampling used for this statement”.
    El mensaje ese aparece cuando en Oracle se ejecuta una consulta y no dispone de estadísticas
    suficientes sobre las tablas implicadas.
*/

-- 4. Crear estadístiques per a tots els objectes
    exec dbms_stats.gather_table_stats(ownname=>'GIISGBD104',tabname=>'ACTORES', cascade=>true,force=>true);
    --Procedimiento PL/SQL terminado correctamente.  Transcurrido: 00:00:00.268
    exec dbms_stats.gather_table_stats(ownname=>'GIISGBD104',tabname=>'ACTUACION', cascade=>true,force=>true);
    --Procedimiento PL/SQL terminado correctamente. Transcurrido: 00:00:00.253
    exec dbms_stats.gather_table_stats(ownname=>'GIISGBD104',tabname=>'PELICULAS', cascade=>true,force=>true);
    --Procedimiento PL/SQL terminado correctamente. Transcurrido: 00:00:00.111
    
-- 5. Tornar a obtenir el pla d'execució de cada consulta i comparar-los amb els anteriors. 
--1
EXPLAIN PLAN FOR
SELECT *
FROM PELICULAS
WHERE ANYO > 1992;

SELECT plan_table_output
FROM 
    table(DBMS_XPLAN.DISPLAY('PLAN_TABLE',
    NULL,'TYPICAL'));
    
/*
Plan hash value: 2378278331
 
-------------------------------------------------------------------------------
| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |           |  1999 |   409K|   102   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| PELICULAS |  1999 |   409K|   102   (0)| 00:00:01 |
-------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("ANYO">1992)
 
Note
-----
   - SQL plan baseline "SQL_PLAN_37ncmpadunta7d6672d41" used for this statement

Consulta 1: Hay menos filas 1999 antes habia 2232. Bytes es menor 409K antes 473.
El coste es el mismo. No aparece el mensaje anterior - dynamic sampling used for this statement
*/

EXPLAIN PLAN FOR
SELECT *
FROM PELICULAS P, ACTUACION ACT
WHERE P.OID = ACT.PELI
AND ANYO > 1992;

SELECT plan_table_output
FROM 
    table(DBMS_XPLAN.DISPLAY('PLAN_TABLE',
    NULL,'TYPICAL'));
    
/*
Plan hash value: 3982339754
 
---------------------------------------------------------------------------------------
| Id  | Operation             | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT      |               |  2235 |   700K|   155   (0)| 00:00:01 |
|*  1 |  HASH JOIN            |               |  2235 |   700K|   155   (0)| 00:00:01 |
|*  2 |   TABLE ACCESS FULL   | PELICULAS     |  1999 |   409K|   102   (0)| 00:00:01 |
|   3 |   INDEX FAST FULL SCAN| SYS_C00377276 | 12500 |  1354K|    53   (0)| 00:00:01 |
---------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - access("P"."OID"="ACT"."PELI")
   2 - filter("ANYO">1992)
 
Note
-----
   - SQL plan baseline "SQL_PLAN_5rbfp05f7uk3m7c4a039a" used for this statement
Consulta 2: Hay menos filas 2235 antes habia 2771. Bytes es menor 409K antes 473.
El coste disminuye de 170 a 155.
*/

EXPLAIN PLAN FOR
SELECT P.*
FROM ACTORES A, ACTUACION X, PELICULAS P
WHERE A.NOM = 'Loy, Myrna'
AND A.OID = X.ACTOR
AND P.OID = X.PELI;

SELECT plan_table_output
FROM 
    table(DBMS_XPLAN.DISPLAY('PLAN_TABLE',
    NULL,'TYPICAL'));
    
/*
Plan hash value: 3447177501
 
----------------------------------------------------------------------------------------------
| Id  | Operation                    | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |               |     1 |   326 |    70   (0)| 00:00:01 |
|   1 |  NESTED LOOPS                |               |     1 |   326 |    70   (0)| 00:00:01 |
|   2 |   NESTED LOOPS               |               |     1 |   326 |    70   (0)| 00:00:01 |
|   3 |    NESTED LOOPS              |               |     1 |   116 |    69   (0)| 00:00:01 |
|*  4 |     TABLE ACCESS FULL        | ACTORES       |     1 |   106 |    68   (0)| 00:00:01 |
|*  5 |     INDEX RANGE SCAN         | SYS_C00377276 |     1 |    10 |     1   (0)| 00:00:01 |
|*  6 |    INDEX UNIQUE SCAN         | SYS_C00377272 |     1 |       |     0   (0)| 00:00:01 |
|   7 |   TABLE ACCESS BY INDEX ROWID| PELICULAS     |     1 |   210 |     1   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - filter("A"."NOM"='Loy, Myrna')
   5 - access("A"."OID"="X"."ACTOR")
   6 - access("P"."OID"="X"."PELI")
 
Note
-----
   - SQL plan baseline "SQL_PLAN_4z5x6suxn6hpc21f1959c" used for this statement

CONSULTA 3: Las filas disminuyen de 9 a 1 y el coste disminuye de 80 a 70 
*/

