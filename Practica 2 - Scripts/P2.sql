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

