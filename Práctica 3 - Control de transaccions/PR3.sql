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

    /*2A) Inserir un registre en la taula de departaments amb codi 101 y nom PRIVACY*/

    /*3A) Fer un COMMIT*/
    
    /*4B) Inici de transacció*/

    /*5A) Actualitzar el nombre de departament 101 a 102*/

    /*6B) Actualitzar el valor del nombre de departament 101 sumant-li 5*/

    /*7B) Actualitzar el valor del nombre de departament 102 sumant-li 5*/

    /*8A) Validar la transacció*/

    /*9B) Validar la transacció*/


// CASO #4.2
    /*1A) Inici de transacció*/

    /*2B) Inici de transacció*/

    /*3A) Seleccionar tots els departaments amb valor superior o igual a 100 amb 
        l'objectiu d'actualitzar algun dels seus camps (clàusula FOR UPDATE)*/
    
    /*4B) Contar tots els departaments amb valor inferior a 100*/

    /*5A) Restar 10 unitats als identificadors de departaments amb valor superior a 100 
        i contar els departaments amb valor inferior a 100.*/

    /*6B) Contar tots els departaments amb valor inferior a 100*/
    
    /*7A) Validar la transacció*/

    /*8B) Validar la transacció*/


// CASO #4.3
    /*1A) Inici de transacció*/

    /*2B) Inici de transacció*/

    /*3A) Crear un departament amb nombre 110*/
    
    /*4A) Realitzar un COMMIT*/

    /*5B) Crear un departament amb nombre120*/

    /*6B) Realitzar un COMMIT*/
    
    /*7A) Seleccionar el departament 110 amb l'objectiu d'actualitzar algun 
        dels seus camps (clàusula FORUPDATE)*/

    /*8B) Seleccionar el departament 120 amb l'objectiu d'actualitzar algun 
        dels seus camps (clàusula FOR UPDATE)*/

    /*9A) Canviar el nom del departament 110*/

    /*10B) Canviar el nom del departament 120*/

    /*11A) Seleccionar el departament 120 amb l'objectiu d'actualitzar algun 
        dels seus camps (clàusula FOR UPDATE)*/

    /*12B) Seleccionar el departament 110 amb l'objectiu d'actualitzar algun 
        dels seus camps (clàusula FOR UPDATE)*/
    
    /*13A) Canviar el nom del departament 120*/

    /*14B) Canviar el nom del departament 110*/

    /*15A) Validar la transacció*/

    /*16B) Validar la transacció*/

