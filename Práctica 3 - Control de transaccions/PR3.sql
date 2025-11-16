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
    7369	SMITH	CLERK	    7902	17/12/80	800		        20
    7499	ALLEN	SALESMAN	7698	20/02/81	1600	300	    30
    7521	WARD	SALESMAN	7698	22/02/81	1250	500	    30
    7566	JONES	MANAGER	    7839	02/04/81	2975		    20
    7654	MARTIN	SALESMAN	7698	28/09/81	1250	1400	30
    7698	BLAKE	MANAGER	    7839	01/05/81	2850		    30
    7782	CLARK	MANAGER	    7839	09/06/81	2450		    10
    7788	SCOTT	ANALYST	    7566	19/04/87	3000		    20
    7839	KING	PRESIDENT		    17/11/81	5000		    10
    7844	TURNER	SALESMAN	7698	08/09/81	1500	0	    30
    7876	ADAMS	CLERK	    7788	23/05/87	1100		    20
    7900	JAMES	CLERK	    7698	03/12/81	950		30
    7902	FORD	ANALYST	    7566	03/12/81	3000		    20
    7934	MILLER	CLERK	    7782	23/01/82	1300		    10
--> 8001	JULIAN	CONSULTANT	7839	20/10/83	3500	0	    50
    */
    
    /*7) Validar la transacció*/
    COMMIT;
    
