/**********************************************************************************
*
*                                    EJERCICIO 1
*
***********************************************************************************
Realitzar les següents transaccions, compostes d'accions que es realitzaran de forma 
ordenada, sobre les taules dels esquemes propis de cada usuari:
************************************************************************************/

// TRANSACCIÓ 1.1
    /* 1)Inserir un departament nou en la taula departaments amb els valors:
    • Nombre: 50
    • Nom: HHRR
    • Localització: LOS ANGELES*/
    SET TRANSACTION READ WRITE NAME '1.1';
    INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES (50, 'HHRR', 'LOS ANGELES');
    
    /*2) Anul·lar la transacció*/
    ROLLBACK;
    
    /*3) Comprovar que les dades no han sigut inserits, ben tancant la sessió i 
    obrint una nova, o bé a través d'una sessió paral·lela només per a consultes.*/
    SELECT * FROM DEPT WHERE DEPTNO = 50;
    --NO APARECE

// TRANSACCIÓ 1.2
    /* 1)Inserir un departament nou en la taula departaments amb els valors:
    • Nombre: 50
    • Nom: HHRR
    • Localització: LOS ANGELES*/
    SET TRANSACTION READ WRITE NAME '1.2';
    INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES (50, 'HHRR', 'LOS ANGELES');
    
    /*2) Validar la transacció*/
    COMMIT;
    
    /*3) Comprovar que les dades no han sigut inserits, ben tancant la sessió i 
    obrint una nova, o bé a través d'una sessió paral·lela només per a consultes.*/
    SELECT * FROM DEPT WHERE DEPTNO = 50;
    --50 |	HHRR  |	LOS ANGELES
    
// TRANSACCIÓ 1.3
     /* 1)Inserir un empleat nou en la taula emprats amb els valors:
        • Nombre: 8001
        • Nom: JULIAN
        • Job: CONSULTANT*/
    SET TRANSACTION READ WRITE NAME '1.3';
    INSERT INTO EMP (EMPNO, ENAME, JOB) 
    VALUES (8001, 'JULIAN', 'CONSULTANT');
    
    /*2) Modificar el registre inserit, afegint els següents camps:
        • MGR: 7839
        • HIREDATE: 20/10/83
        • SAL: 3500
        • COMM: 0
        • DEPTNO: 50*/
    UPDATE EMP SET 
    MGR = 7839,
    HIREDATE = TO_DATE('20/10/83','DD/MM/YY'),
    SAL = 3500,
    COMM = 0,
    DEPTNO = 50
    WHERE EMPNO = 8001;

    /*3) Establir un punt de salvaguarda SP1*/
    SAVEPOINT SP1;
    
    /*4) Modificar el registre inserit, afegint els següents camps:
        • MGR: 7369
        • HIREDATE: 20/10/83
        • SAL: 3500
        • COMM: NULL
        • DEPTNO: 40*/
    UPDATE EMP SET 
    MGR = 7369,
    HIREDATE = TO_DATE('20/10/83','DD/MM/YY'),
    SAL = 3500,
    COMM = NULL,
    DEPTNO = 40
    WHERE EMPNO = 8001;
    
    /*5) Desfer la transacció fins al punt SP1*/
    ROLLBACK TO SP1;
    
    /*6) Comprovar les dades que hi ha en la taula.*/
    SELECT * FROM EMP;
     /*
    7369	SMITH	CLERK	    7902	--2/80	800		        20
    7499	ALLEN	SALESMAN	7698	--2/81	1600	300	    30
    7521	WARD	SALESMAN	7698	--2/81	1250	500	    30
    7566	JONES	MANAGER	    7839	--4/81	2975		    20
    7654	MARTIN	SALESMAN	7698	--9/81	1250	1400	30
    7698	BLAKE	MANAGER	    7839	--5/81	2850		    30
    7782	CLARK	MANAGER	    7839	--6/81	2450		    10
    7788	SCOTT	ANALYST	    7566	--4/87	3000		    20
    7839	KING	PRESIDENT		    --1/81	5000		    10
    7844	TURNER	SALESMAN	7698	--9/81	1500	0	    30
    7876	ADAMS	CLERK	    7788	--5/87	1100		    20
    7900	JAMES	CLERK	    7698	--2/81	950		30
    7902	FORD	ANALYST	    7566	--2/81	3000		    20
    7934	MILLER	CLERK	    7782	--1/82	1300		    10
--> 8001	JULIAN	CONSULTANT	7839	--0/83	3500	0	    50
    */
    
    /*7) Validar la transacció*/
    COMMIT;
    
/***************************************--***************************************
*
*                                    EJE--IO 2
*
****************************************--***************************************
Generar un script de base de dades que r--tze la següent transacció executant 
aquestes tasques en l'ordre establit:

Identificar els problemes en les accions--ividuals i comentar els motius que les generen.
****************************************--****************************************/

// TRANSACCIÓ 2.1
    /* 1)Crear un departament nou (amb l--ades que es desitgen) amb codi 
        de departament 60*/
    SET TRANSACTION READ WRITE NAME '2.1--
    INSERT INTO DEPT (DEPTNO, DNAME, LOC--LUES (60, 'PRUEBA', 'VALENCIA');

    /*
    10	ACCOUNTING	NEW YORK
    20	RESEARCH	DALLAS
    30	SALES	CHICAGO
    40	OPERATIONS	BOSTON
    50	HHRR	LOS ANGELES
    60	PRUEBA	VALENCIA
    */

    /*2) Establir un punt de salvaguarda SP1*/
    SAVEPOINT SP1;

    /*3) Crear un empleat nou (amb les dades que es desitgen) amb codi d'empleat 9061 
        i assignat al departament 60*/
    INSERT INTO EMP (EMPNO, DEPTNO) VALUES (9061, 60);


    /*4)Crear un empleat nou (amb les dades que es desitgen) amb codi d'empleat 9062 
        i assignat al departament 60*/
    
    INSERT INTO EMP (EMPNO, DEPTNO) VALUES (9062, 60);

    /*5)Crear un departament nou (amb les dades que es desitgen) amb codi de 
        departament 70)*/
    INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES (70, 'PRUEBA2', 'VALENCIA2');

    /*6)Establir un punt de salvaguarda SP2*/
    SAVEPOINT SP2;

    /*7)Crear un empleat nou (amb les dades que es desitgen) amb codi d'empleat 9071 
        i assignat al departament 70*/
    INSERT INTO EMP (EMPNO, DEPTNO) VALUES (9071, 70);

    /*8)Crear un empleat nou (amb les dades que es desitgen) amb codi d'empleat 9071 
        i assignat al departament 70*/
    INSERT INTO EMP (EMPNO, DEPTNO) VALUES (9071, 70);

    /*
    Error que empieza en la línea: 7 del comando :
    INSERT INTO EMP (EMPNO, DEPTNO) VALUES (9071, 70)
    Informe de error -
    ORA-00001: restricción única (GIISGBD104.PK_EMP) violada
    */

    -- Vemos que da error porque se vuelve a crear el mismo empleado con la misma clave primaria.

    /*9)Tornar al punt de salvaguarda SP2*/
    ROLLBACK TO SP2;

    /*10)Crear un empleat nou (amb les dades que es desitgen) amb codi d'empleat 9071 
        i assignat al departament 70*/
    INSERT INTO EMP (EMPNO, DEPTNO) VALUES (9071, 70);

    /*11)Tornar al punt de salvaguarda SP1*/
    ROLLBACK TO SP1;

    /*12)Crear un empleat nou (amb les dades que es desitgen) amb codi d'empleat 9071 
        i assignat al departament 70*/
    INSERT INTO EMP (EMPNO, DEPTNO) VALUES (9071, 70);

    /*
    Error que empieza en la línea: 7 del comando :
    INSERT INTO EMP (EMPNO, DEPTNO) VALUES (9071, 70)
    Informe de error -
    ORA-02291: restricción de integridad (GIISGBD104.FK_DEPTNO) violada - 
    clave principal no encontrada
    */

    -- Cuando hacemos ROLLBACK A SP1 el departamento 60 aún no se había creado y por eso da error
    /*13)Validar la transacció*/
    COMMIT;


/**********************************************************************************
*
*                                    EJERCICIO 3
*
***********************************************************************************
Repetir les transaccions usant 2 tipus diferents d'aïllament per a la transacció B: 
READ COMMITED i SERIALIZABLE.

Localitzar les diferències de tots dos procediments i indicar el motiu pel qual succeeixen. Abans d'iniciar
la segona iteració, eliminar el departament 151 perquè no es produïsca un error d'inserció per duplicitat
de clau primària.

Localitzar les diferències de tots dos procediments i indicar el motiu pel qual succeeixen
************************************************************************************/

// TRANSACCIÓ 3.1 (Phantom reads)

-- COMMITTED - COMMITTED
    /*1A) Inici de transacció (establint el nivell d'aïllament sempre a READ COMMITTED)*/
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

    /*2B) Inici de transacció (establint el nivell d'aïllament corresponent per als casos 1 
        i 2)*/
                                                                SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

    /*3A Inserir un registre en la taula de departaments amb codi 151 i nom ADVERTISING*/
    INSERT INTO DEPT (DEPTNO, DNAME) VALUES (151, 'ADVERTISING');
    /*4B Contar el nombre de departaments*/
                                                                SELECT COUNT(*) FROM DEPT;
                                                                -- RESULTADO: 6
                                                                
   /*5A) Contar el nombre de departaments*/ 
    SELECT COUNT(*) FROM DEPT;
    -- RESULTADO: 7

   /*6A) Validar la transacció*/
    COMMIT;

   /*7B) Contar el nombre de departaments*/
                                                                SELECT COUNT(*) FROM DEPT;
                                                                -- RESULTADO: 7

   /*8B) Validar la transacció*/
                                                                COMMIT;
   
   /*9B) Contar el nombre de departaments*/
                                                                SELECT COUNT(*) FROM DEPT;
                                                                -- RESULTADO: 7

/*
CONCLUSIÓN COMMITTED-COMMITTED:
Hasta que la sesión A no se hace el commit, la sesión B no ve los cambios 
realizados de la sesión A
*/

-- COMMITTED - SERIALIZABLE
    /*1A) Inici de transacció (establint el nivell d'aïllament sempre a READ COMMITTED)*/
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

    /*2B) Inici de transacció (establint el nivell d'aïllament corresponent per als casos 1 
        i 2)*/
                                                                SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

    /*3A Inserir un registre en la taula de departaments amb codi 151 i nom ADVERTISING*/
    INSERT INTO DEPT (DEPTNO, DNAME) VALUES (151, 'ADVERTISING');
    /*4B Contar el nombre de departaments*/
                                                                SELECT COUNT(*) FROM DEPT;
                                                                -- RESULTADO: 6
                                                                
   /*5A) Contar el nombre de departaments*/ 
    SELECT COUNT(*) FROM DEPT;
    -- RESULTADO: 7

   /*6A) Validar la transacció*/
    COMMIT;

   /*7B) Contar el nombre de departaments*/
                                                                SELECT COUNT(*) FROM DEPT;
                                                                -- RESULTADO: 6

   /*8B) Validar la transacció*/
                                                                COMMIT;
   
   /*9B) Contar el nombre de departaments*/
                                                                SELECT COUNT(*) FROM DEPT;
                                                                -- RESULTADO: 7

/*
CONCLUSIÓN COMMITTED-SERIALIZABLE:
Cuando se hace con serializable se ignora los cambios de otras transacciones incluso cuando hacen
commit, por lo que en 7B se obtiene 6 y cuando termina la sesión B es cuando se ven los cambios 
realizados por otras transacciones.
*/



// TRANSACCIÓ 3.2 (Nonrepeatable reads) 
-- COMMITTED - COMMITTED
    /*1A) Inici de transacció (establint el nivell d'aïllament sempre a READ COMMITTED)*/
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    /*2B) Inici de transacció (establint el nivell d'aïllament corresponent per als 
        casos 1 i 2)*/
                                                            SET TRANSACTION ISOLATION LEVEL READ COMMITTED;   
    /*3B Seleccionar les dades del departament 151*/
                                                            SELECT * FROM DEPT WHERE DEPTNO = 151;
                                                            --151	ADVERTISING	 NULL
    /*4A Modificar el nom del departament 151*/
    UPDATE DEPT SET DNAME = 'EJERCICIO' WHERE DEPTNO = 151;

   /*5A) Validar la transacció*/ 
    COMMIT;

   /*6B) Seleccionar les dades del departament 151*/
                                                            SELECT * FROM DEPT WHERE DEPTNO = 151;
                                                                --151	EJERCICIO	NULL
   /*7B)Validar la transacció*/
                                                            COMMIT;
   /*8B) Seleccionar les dades del departament 151*/
                                                            SELECT * FROM DEPT WHERE DEPTNO = 151;
                                                            --151	EJERCICIO	NULL

-- COMMITTED - SERIALIZABLE 
    /*1A) Inici de transacció (establint el nivell d'aïllament sempre a READ COMMITTED)*/
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    /*2B) Inici de transacció (establint el nivell d'aïllament corresponent per als 
        casos 1 i 2)*/
                                                            SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    /*3B Seleccionar les dades del departament 151*/
                                                            SELECT * FROM DEPT WHERE DEPTNO = 151;
                                                            --151	EJERCICIO	NULL
    /*4A Modificar el nom del departament 151*/
    UPDATE DEPT SET DNAME = 'EJERCICIO2' WHERE DEPTNO = 151;

   /*5A) Validar la transacció*/ 
    COMMIT;

   /*6B) Seleccionar les dades del departament 151*/
                                                            SELECT * FROM DEPT WHERE DEPTNO = 151;
                                                                --151	EJERCICIO	NULL
   /*7B)Validar la transacció*/
                                                            COMMIT;
   /*8B) Seleccionar les dades del departament 151*/
                                                            SELECT * FROM DEPT WHERE DEPTNO = 151;
                                                            --151	EJERCICIO2	NULL

    /*
    CONCLUSIÓN COMMITTED-SERIALIZABLE:
    Cuando se hace con serializable se ignora los cambios de otras transacciones incluso cuando hacen
    commit, por lo que en 6B se obtiene se obtiene el valor sin cambiar EJERCICIO y cuando termina la sesión B 
    es cuando se ven los cambios realizados por otras transacciones.
    */

    /*
    DIFERENCIAS ENTRE COMMITTED-COMMITTED y COMMITTED-SERIALIZABLE 
    En READ COMMITTED, la sesión B ve siempre los últimos cambios confirmados, por eso en la línea 6B obtiene el valor modificado tras el COMMIT de la sesión A.
    En SERIALIZABLE, la sesión B ignora los cambios de otras transacciones incluso aunque hagan COMMIT.
    Por ello, en la línea 6B obtiene el valor sin modificar.
    Solo cuando finaliza la sesión B es cuando pasa a ver los cambios realizados por otras transacciones.
    */


/**********************************************************************************
*
*                                    EJERCICIO 4
*
***********************************************************************************
Per a la realització d'aquest exercici s'obriran 2 sessions simultànies sobre la base 
de dades. Des de cadascuna de les sessions es realitzaran les accions que s'esmenten, 
seguint l'ordre temporal establit i la sessió corresponent.

Avaluar l'èxit de l'operació, el moment en què es produeixen bloquejos i retards en 
les execucions d'accions particulars i el resultat de les transaccions per a cadascun 
dels casos.

************************************************************************************/

// CASO #4.1
    /*1A) Inici de transacció*/
    SET TRANSACTION READ WRITE NAME '4.1.A';
   
    /*2A) Inserir un registre en la taula de departaments amb codi 101 y nom PRIVACY*/
    INSERT INTO DEPT(DEPTNO,DNAME) VALUES (101,'PRIVACY'); 
    -- 101	PRIVACY   NULL

    /*3A) Fer un COMMIT*/
    COMMIT;
    --101	PRIVACY	    NULL                                --101	PRIVACY	    NULL

    /*4B) Inici de transacció*/
                                                            SET TRANSACTION READ WRITE NAME '4.1.B';

    /*5A) Actualitzar el nombre de departament 101 a 102*/
    UPDATE DEPT 
    SET DEPTNO = 102
    WHERE DEPTNO = 101;
    --102	PRIVACY	    NULL
    -- Bloqueo sobre la fila nueva 

    /*6B) Actualitzar el valor del nombre de departament 101 sumant-li 5*/
                                                            UPDATE DEPT
                                                            SET DEPTNO = DEPTNO + 5
                                                            WHERE DEPTNO = 101;
                                                            -- RESULTADO: Se queda esperando quedandose 
                                                            -- bloqueado por la sesión A porque no ha hecho commit

    /*8A) Validar la transacció*/
    COMMIT; 
    -- Ahora la sesión B ve que existe el DEPT 102 
    -- y se DESBLOQUEA la Sesión B

    /*7B) Actualitzar el valor del nombre de departament 102 sumant-li 5*/
                                                            UPDATE DEPT
                                                            SET DEPTNO = DEPTNO + 5
                                                            WHERE DEPTNO = 102;
                                                            -- 0 filas actualizadas porque la sesión B no ve el cambio de A 
                                                            -- porque no ha hecho commit y para ella (Sesión B) 
                                                            -- no existe el DEPT 102 todavía

    /*9B) Validar la transacció*/
                                                            COMMIT; 
                                                            --102	PRIVACY	    NULL

// CASO #4.2
    /*1A) Inici de transacció*/
    SET TRANSACTION READ WRITE NAME '4.2.A';

    /*2B) Inici de transacció*/
                                                            SET TRANSACTION READ WRITE NAME '4.2.B';
    
    /*3A) Seleccionar tots els departaments amb valor superior o igual a 100 amb 
        l'objectiu d'actualitzar algun dels seus camps (clàusula FOR UPDATE)*/
    SELECT * FROM DEPT
    WHERE DEPTNO >= 100
    FOR UPDATE;
    --102	PRIVACY	        NULL
    --151	EJERCICIO2	    NULL

    /*4B) Contar tots els departaments amb valor inferior a 100*/
                                                            SELECT COUNT(*) 
                                                            FROM DEPT
                                                            WHERE DEPTNO <= 100;
                                                            -- RESULTADO: 6

    /*5A) Restar 10 unitats als identificadors de departaments amb valor superior a 100 
        i contar els departaments amb valor inferior a 100.*/
    UPDATE DEPT
    SET DEPTNO = DEPTNO-10
    WHERE DEPTNO >= 100;
    -- 2 filas actualizadas
    --92	PRIVACY	        NULL
    --141	EJERCICIO2	    NULL

    /*6B) Contar tots els departaments amb valor inferior a 100*/
                                                            SELECT COUNT(*) 
                                                            FROM DEPT
                                                            WHERE DEPTNO <= 100;
                                                            -- RESULTADO: 6
                                                            -- Hasta que la sesión A no haga commit 
                                                            -- la sesión B no sabe que hay un dept <= 100 más
                                                            -- es decir, no sabe que ahora el dept con nombre PRIVACY 
                                                            -- es menor que 100.

    /*7A) Validar la transacció*/
    COMMIT;
    -- Ahora la sesión B puede ver 
    -- 92	PRIVACY	  NULL
    -- y si volvemos a hacer el paso 4B vemos
    -- que ahora hay como resultado 7

    /*8B) Validar la transacció*/
                                                            COMMIT;
                                                        

// CASO #4.3
    /*1A) Inici de transacció*/
    SET TRANSACTION READ WRITE NAME '4.3.A';

    /*2B) Inici de transacció*/
                                                            SET TRANSACTION READ WRITE NAME '4.3.B';

    /*3A) Crear un departament amb nombre 110*/
    INSERT INTO DEPT (DEPTNO, DNAME)VALUES (110, '3A');
    -- 110	3A	NULL

    /*4A) Realitzar un COMMIT*/
    COMMIT;
    -- Le aparece a la sesión B el dept 110

    /*5B) Crear un departament amb nombre 120*/
                                                            INSERT INTO DEPT (DEPTNO, DNAME)VALUES (120, '5B');
                                                            -- 120	5B	NULL
                                                            
    /*6B) Realitzar un COMMIT*/
                                                            COMMIT;
                                                            -- Le aparece a la sesión A el dept 120

    /*7A) Seleccionar el departament 110 amb l'objectiu d'actualitzar algun 
        dels seus camps (clàusula FOR UPDATE)*/
    SELECT * 
    FROM DEPT
    WHERE DEPTNO = 110
    FOR UPDATE;
    -- 110	3A	NULL
    -- La sesión A bloquea el 
    -- dept 110 para actualizar

    /*8B) Seleccionar el departament 120 amb l'objectiu d'actualitzar algun 
        dels seus camps (clàusula FOR UPDATE)*/
                                                            SELECT * 
                                                            FROM DEPT
                                                            WHERE DEPTNO = 120
                                                            FOR UPDATE;
                                                            -- 120	5B	NULL
                                                            -- La sesión B bloquea el 
                                                            -- dept 120 para actualizar

    /*9A) Canviar el nom del departament 110*/
    UPDATE DEPT
    SET DNAME = '9A'
    WHERE DEPTNO = 110;
    --110	9A	NULL
    --Permite cambiar el nombre porque
    --la misma sesión A tiene bloqueada el dept 110

    /*10B) Canviar el nom del departament 120*/
                                                            UPDATE DEPT
                                                            SET DNAME = '10B'
                                                            WHERE DEPTNO = 120;
                                                            -- 120	10B	 NULL
                                                            --Permite cambiar el nombre porque
                                                            --la misma sesión B tiene bloqueada el dept 120

    /*11A) Seleccionar el departament 120 amb l'objectiu d'actualitzar algun 
        dels seus camps (clàusula FOR UPDATE)*/
    SELECT * 
    FROM DEPT 
    WHERE DEPTNO = 120
    FOR UPDATE;
    -- Se queda esperando porque se bloquea
    -- ya que la sesión B tiene bloqueada el dept 120
    -- porque se está modificando.
    -- ORA-00060: detectado interbloqueo mientras se esperaba un recurso



    /*12B) Seleccionar el departament 110 amb l'objectiu d'actualitzar algun 
        dels seus camps (clàusula FOR UPDATE)*/
                                                            SELECT * 
                                                            FROM DEPT 
                                                            WHERE DEPTNO = 110
                                                            FOR UPDATE;
                                                            -- Se queda esperando porque se bloquea
                                                            -- ya que la sesión A tiene bloqueada el dept 110
                                                            -- porque se está modificando. Al bloquearse, Oracle cancela 
                                                            -- la operación de la sesión A.

    //VOLVEMOS A EJECUTAR LA OPERACIÓN DEL 11 A PORQUE ORACLE HA CANCELADO LA OPERACIÓN AL HABERSE BLOQUEADO LA SESIÓN B                                                    
     /*11A) Seleccionar el departament 120 amb l'objectiu d'actualitzar algun 
        dels seus camps (clàusula FOR UPDATE)*/
    SELECT * 
    FROM DEPT 
    WHERE DEPTNO = 120
    FOR UPDATE;
    -- Se queda esperando porque se bloquea
    -- ya que la sesión B tiene bloqueada el dept 120
    -- porque se está modificando.
    -- ORA-00060: detectado interbloqueo mientras se esperaba un recurso

    // VUELVE HA PASAR LO MISMO, LA SESIÓN A SE BLOQUEA Y ORACLE CANCELA LA OPERACIÓN DE LA SESIÓN b
    // POR LO QUE ES UN BUCLE INFINITO HASTA QUE ENCONTREMOS UNA SOLUCIÓN.

    /*1A) Inici de transacció*/
    SET TRANSACTION READ WRITE NAME '4.3.A';

    /*2B) Inici de transacció*/
                                                            SET TRANSACTION READ WRITE NAME '4.3.B';

    /*3A) Crear un departament amb nombre 110*/
    INSERT INTO DEPT (DEPTNO, DNAME)VALUES (110, '3A');
    -- 110	3A	NULL

    /*4A) Realitzar un COMMIT*/
    COMMIT;
    -- Le aparece a la sesión B el dept 110

    /*5B) Crear un departament amb nombre 120*/
                                                            INSERT INTO DEPT (DEPTNO, DNAME)VALUES (120, '5B');
                                                            -- 120	5B	NULL
                                                            
    /*6B) Realitzar un COMMIT*/
                                                            COMMIT;
                                                            -- Le aparece a la sesión A el dept 120

    /*7A) Seleccionar el departament 110 amb l'objectiu d'actualitzar algun 
        dels seus camps (clàusula FOR UPDATE)*/
    SELECT * 
    FROM DEPT
    WHERE DEPTNO = 110
    FOR UPDATE;
    -- 110	3A	NULL
    -- La sesión A bloquea el 
    -- dept 110 para actualizar

    /*8B) Seleccionar el departament 120 amb l'objectiu d'actualitzar algun 
        dels seus camps (clàusula FOR UPDATE)*/
                                                            SELECT * 
                                                            FROM DEPT
                                                            WHERE DEPTNO = 120
                                                            FOR UPDATE;
                                                            -- 120	5B	NULL
                                                            -- La sesión B bloquea el 
                                                            -- dept 120 para actualizar

    /*9A) Canviar el nom del departament 110*/
    UPDATE DEPT
    SET DNAME = '9A'
    WHERE DEPTNO = 110;
    --110	9A	NULL
    --Permite cambiar el nombre porque
    --la misma sesión A tiene bloqueada el dept 110

    /*10B) Canviar el nom del departament 120*/
                                                            UPDATE DEPT
                                                            SET DNAME = '10B'
                                                            WHERE DEPTNO = 120;
                                                            -- 120	10B	 NULL
                                                            --Permite cambiar el nombre porque
                                                            --la misma sesión B tiene bloqueada el dept 120

    /*11A) Seleccionar el departament 120 amb l'objectiu d'actualitzar algun 
        dels seus camps (clàusula FOR UPDATE)*/
    SELECT * 
    FROM DEPT 
    WHERE DEPTNO = 120
    FOR UPDATE;
    -- Se queda esperando porque se bloquea
    -- ya que la sesión B tiene bloqueada el dept 120
    -- porque se está modificando.
    -- ORA-00060: detectado interbloqueo mientras se esperaba un recurso

                                                            /*==> SOLUCIÓN: deshacer la sesión*/
                                                                ROLLBACK;
                                                                -- B libera el bloqueo de A


    //CONTINUAMOS CON LAS OPERACIONES DE LA SESIÓN A 
    /*13A) Canviar el nom del departament 120*/
    UPDATE DEPT
    SET DNAME = '13A'
    WHERE DEPTNO = 120;
    -- Se actualiza la fila
    -- 120	13A	NULL

    
     /*15A) Validar la transacció*/
    COMMIT;

    // AHORA VOLVEMOS HACER TODAS LAS OPERACIONES DE LA SESIÓN B DESDE EL COMMIT PORQUE HEMOS
    // HECHO UN ROLLBACK ANTERIORMENTE.

    /*8B) Seleccionar el departament 120 amb l'objectiu d'actualitzar algun 
        dels seus camps (clàusula FOR UPDATE)*/
                                                            SELECT * 
                                                            FROM DEPT
                                                            WHERE DEPTNO = 120
                                                            FOR UPDATE;
                                                            
                                                            -- La sesión B bloquea el 
                                                            -- dept 120	13A	NULL para actualizar

    /*10B) Canviar el nom del departament 120*/
                                                            UPDATE DEPT
                                                            SET DNAME = '10B'
                                                            WHERE DEPTNO = 120;
                                                            -- 120	10B	 NULL
                                                            --Permite cambiar el nombre porque
                                                            --la misma sesión B tiene bloqueada el dept 120

    /*12B) Seleccionar el departament 110 amb l'objectiu d'actualitzar algun 
        dels seus camps (clàusula FOR UPDATE)*/
                                                            SELECT * 
                                                            FROM DEPT 
                                                            WHERE DEPTNO = 110
                                                            FOR UPDATE;
                                                             -- La sesión B bloquea el 
                                                            -- dept 110	9A	NULL para actualizar

    /*14B) Canviar el nom del departament 110*/
                                                            UPDATE DEPT
                                                            SET DNAME = '14B'
                                                            WHERE DEPTNO = 110;
                                                            -- Se actualiza 
                                                            -- 110	14B	   NULL

   
    -- 

    /*16B) Validar la transacció*/
                                                            COMMIT;
                                                            -- Se confirma 
-- RESULTADO TABLA:
    // 110	14B	    NULL
    // 120	10B	    NULL

/**********************************************************************************
*
*                                    EJERCICIO 5
*
************************************************************************************/
// CASO #5.1
    SET TRANSACTION READ WRITE NAME '5.1';
    LOCK TABLE EMP IN SHARE MODE NOWAIT;
                                                            SELECT * FROM EMP;
                                                            --Funciona correctamente
                                                            INSERT INTO EMP (EMPNO, ENAME, JOB) VALUES (1, 'ALBERTO', 'CONSULTANT');
                                                            --Se queda cargando y no realiza la consulta hasta que la transición termina
                                                        
// CASO #5.2
    SET TRANSACTION READ WRITE NAME '5.2';
    LOCK TABLE EMP IN SHARE MODE NOWAIT;
                                                            SELECT * FROM EMP;
                                                            --Funciona correctamente
                                                            INSERT INTO EMP (EMPNO, ENAME, JOB) VALUES (1, 'ALBERTO', 'CONSULTANT');
                                                            --Se queda cargando y no realiza la consulta 
                                                        
// CASO #5.3
    SET TRANSACTION READ WRITE NAME '5.1';
    LOCK TABLE EMP IN SHARE MODE NOWAIT;
                                                            SELECT * FROM EMP;
                                                            --Funciona correctamente
                                                            SELECT * FROM EMP WHERE EMPNO = 1 FOR UPDATE;
                                                            --Se queda cargando y no realiza la consulta hasta que la transición termina
       
// CASO #5.4
SET TRANSACTION READ WRITE NAME '5.4.A';
                                                            SET TRANSACTION READ WRITE NAME '5.4.B';
LOCK TABLE EMP IN SHARE MODE NOWAIT;
                                                            LOCK TABLE EMP IN ROW SHARE MODE NOWAIT;
SELECT o.object_name, lo.locked_mode
FROM v$locked_object lo
JOIN all_objects o ON lo.object_id = o.object_id;
/*
OBJECT_NAME     LOCKED_MODE
--------------- -----------
EMP                       4
EMP                       2
*/
                                                            SELECT o.object_name, lo.locked_mode
                                                            FROM v$locked_object lo
                                                            JOIN all_objects o ON lo.object_id = o.object_id;
                                                            /*
                                                            OBJECT_NAME     LOCKED_MODE
                                                            --------------- -----------
                                                            EMP                       4
                                                            EMP                       2
                                                            */


/**********************************************************************************
*
*                                    EJERCICIO 6
*
************************************************************************************/

CREATE TABLE "EMPGRADE" (
"EMPNO" NUMBER(10,0), 
"GRADE" NUMBER
);
--Table "EMPGRADE" creado.

INSERT INTO EMPGRADE (EMPNO, GRADE)
SELECT 
    E.EMPNO,
    NVL(S.GRADE, 0) AS GRADE
FROM EMP E
LEFT JOIN SALGRADE S
    ON E.SAL BETWEEN S.LOSAL AND S.HISAL;
--17 filas insertadas.

COMMIT;
--Hacemos commit despues de insertar los datos en EMPGRADE para poder empezar la siguiente transacción sin problemas.

CREATE OR REPLACE PROCEDURE gestionar_nuevo_empleado AS
    -- Variables auxiliars
    v_sal_emp     EMP.SAL%TYPE;
    v_sal_jefe     EMP.SAL%TYPE;
    v_grade       EMPGRADE.GRADE%TYPE;
BEGIN
    ---------------------------------------------------------
    -- 1. Crear empleat 8010
    ---------------------------------------------------------
    INSERT INTO EMP (EMPNO, ENAME, JOB)
    VALUES (8010, 'CAGE', 'ASSISTANT');

    ---------------------------------------------------------
    -- 2. Actualitzar empleat 8010 amb les dades noves
    ---------------------------------------------------------
    UPDATE EMP
       SET MGR     = 8001,
           HIREDATE = TO_DATE('13/01/83','DD/MM/YY'),
           SAL     = 3800,
           COMM    = 100,
           DEPTNO  = 50
     WHERE EMPNO = 8010;

    ---------------------------------------------------------
    -- 3. Assignar el grau salarial 4 en EMPGRADE
    ---------------------------------------------------------
    INSERT INTO EMPGRADE (EMPNO, GRADE)
    VALUES (8010, 4);

    ---------------------------------------------------------
    -- 4. Comprovar condicions
    ---------------------------------------------------------

    -- Obtenir salari del empleat
    SELECT SAL INTO v_sal_emp
    FROM EMP
    WHERE EMPNO = 8010;

    -- Obtenir salari del cap
    SELECT SAL INTO v_sal_jefe
    FROM EMP
    WHERE EMPNO = 8001;

    -- Obtenir el grau assignat
    SELECT GRADE INTO v_grade
    FROM EMPGRADE
    WHERE EMPNO = 8010;

    ---------------------------------------------------------
    -- 5. Si no es compleix la condició #2 
    ---------------------------------------------------------
    IF v_sal_emp >= v_sal_jefe THEN
        -- Quitar empleado
        DELETE FROM EMP WHERE EMPNO = 8010;
        DELETE FROM EMPGRADE WHERE EMPNO = 8010;


        -- Tornar a crear i actualitzar l’empleat
        INSERT INTO EMP (EMPNO, ENAME, JOB)
        VALUES (8010, 'CAGE', 'ASSISTANT');

        UPDATE EMP
           SET MGR     = 8001,
               HIREDATE = TO_DATE('13/01/83','DD/MM/YY'),
               SAL     = v_sal_jefe - 800,        -- nou salari
               COMM    = 100,
               DEPTNO  = 50
         WHERE EMPNO = 8010;

        -- Tornar a assignar el grau 4
        INSERT INTO EMPGRADE (EMPNO, GRADE)
        VALUES (8010, 4);
    END IF;

    ---------------------------------------------------------
    -- 6. Si no es compleix la condició #1 (grau no concorda amb salari)
    ---------------------------------------------------------
    -- Suposem que el grau correcte és:
    --  GRADE 4 si SAL >= 3000
    --  GRADE 3 si SAL 2000–2999
    --  GRADE 2 si SAL 1000–1999
    --  GRADE 1 si SAL < 1000
    -- (Ajusta-ho si tens una taula de rangs)

        DECLARE
            v_grade_correcte NUMBER;
        BEGIN
            IF v_sal_emp BETWEEN 3001 AND 9999 THEN
                v_grade_correcte := 5;
                
            ELSIF v_sal_emp BETWEEN 2001 AND 3000 THEN
                v_grade_correcte := 4;
        
            ELSIF v_sal_emp BETWEEN 1401 AND 2000 THEN
                v_grade_correcte := 3;
        
            ELSIF v_sal_emp BETWEEN 1201 AND 1400 THEN
                v_grade_correcte := 2;
            ELSE
                v_grade_correcte := 1;
            END IF;
        
            IF v_grade_correcte != v_grade THEN
                -- Esborrem la inserció incorrecta
                DELETE FROM EMPGRADE WHERE EMPNO = 8010;
        
                -- Inserim el grau correcte
                INSERT INTO EMPGRADE (EMPNO, GRADE)
                VALUES (8010, v_grade_correcte);
            END IF;
        END;


    ---------------------------------------------------------
    -- 7. Validar transacció
    ---------------------------------------------------------
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END gestionar_nuevo_empleado;
/


                    