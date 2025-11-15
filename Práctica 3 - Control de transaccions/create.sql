--------------------------------------------------------
--  DDL for Table BONUS
--------------------------------------------------------

CREATE TABLE "BONUS" (
"ENAME" VARCHAR2(50 BYTE), 
"JOB" VARCHAR2(20 BYTE), 
"SAL" NUMBER, 
"COMM" NUMBER
);

--------------------------------------------------------
--  DDL for Table DEPT
--------------------------------------------------------

CREATE TABLE "DEPT" (
"DEPTNO" NUMBER(10,0), 
"DNAME" VARCHAR2(100 BYTE), 
"LOC" VARCHAR2(100 BYTE)
);

--------------------------------------------------------
--  DDL for Table EMP
--------------------------------------------------------

CREATE TABLE "EMP" (
"EMPNO" NUMBER(10,0), 
"ENAME" VARCHAR2(50 BYTE), 
"JOB" VARCHAR2(20 BYTE), 
"MGR" NUMBER(10,0), 
"HIREDATE" DATE, 
"SAL" NUMBER(7,2), 
"COMM" NUMBER(7,2), 
"DEPTNO" NUMBER(10,0)
);

--------------------------------------------------------
--  DDL for Table SALGRADE
--------------------------------------------------------

CREATE TABLE "SALGRADE" (
"GRADE" NUMBER, 
"LOSAL" NUMBER, 
"HISAL" NUMBER
);



--------------------------------------------------------
--  DML for inserting into BONUS
--------------------------------------------------------

--------------------------------------------------------
--  DML for inserting into DEPT
--------------------------------------------------------

Insert into DEPT (DEPTNO,DNAME,LOC) values ('10','ACCOUNTING','NEW YORK');
Insert into DEPT (DEPTNO,DNAME,LOC) values ('20','RESEARCH','DALLAS');
Insert into DEPT (DEPTNO,DNAME,LOC) values ('30','SALES','CHICAGO');
Insert into DEPT (DEPTNO,DNAME,LOC) values ('40','OPERATIONS','BOSTON');

--------------------------------------------------------
--  DML for inserting into EMP
--------------------------------------------------------

Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7369','SMITH','CLERK','7902',to_date('17/12/80','DD/MM/RR'),'800',null,'20');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7499','ALLEN','SALESMAN','7698',to_date('20/02/81','DD/MM/RR'),'1600','300','30');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7521','WARD','SALESMAN','7698',to_date('22/02/81','DD/MM/RR'),'1250','500','30');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7566','JONES','MANAGER','7839',to_date('02/04/81','DD/MM/RR'),'2975',null,'20');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7654','MARTIN','SALESMAN','7698',to_date('28/09/81','DD/MM/RR'),'1250','1400','30');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7698','BLAKE','MANAGER','7839',to_date('01/05/81','DD/MM/RR'),'2850',null,'30');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7782','CLARK','MANAGER','7839',to_date('09/06/81','DD/MM/RR'),'2450',null,'10');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7788','SCOTT','ANALYST','7566',to_date('19/04/87','DD/MM/RR'),'3000',null,'20');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7839','KING','PRESIDENT',null,to_date('17/11/81','DD/MM/RR'),'5000',null,'10');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7844','TURNER','SALESMAN','7698',to_date('08/09/81','DD/MM/RR'),'1500','0','30');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7876','ADAMS','CLERK','7788',to_date('23/05/87','DD/MM/RR'),'1100',null,'20');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7900','JAMES','CLERK','7698',to_date('03/12/81','DD/MM/RR'),'950',null,'30');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7902','FORD','ANALYST','7566',to_date('03/12/81','DD/MM/RR'),'3000',null,'20');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7934','MILLER','CLERK','7782',to_date('23/01/82','DD/MM/RR'),'1300',null,'10');

--------------------------------------------------------
--  DML for inserting into SALGRADE
--------------------------------------------------------

Insert into SALGRADE (GRADE,LOSAL,HISAL) values ('1','700','1200');
Insert into SALGRADE (GRADE,LOSAL,HISAL) values ('2','1201','1400');
Insert into SALGRADE (GRADE,LOSAL,HISAL) values ('3','1401','2000');
Insert into SALGRADE (GRADE,LOSAL,HISAL) values ('4','2001','3000');
Insert into SALGRADE (GRADE,LOSAL,HISAL) values ('5','3001','9999');

--------------------------------------------------------
--  DDL for Index PK_DEPT
--------------------------------------------------------

CREATE UNIQUE INDEX "PK_DEPT" ON "DEPT" ("DEPTNO");

--------------------------------------------------------
--  DDL for Index PK_EMP
--------------------------------------------------------

CREATE UNIQUE INDEX "PK_EMP" ON "EMP" ("EMPNO");

--------------------------------------------------------
--  Constraints for Table DEPT
--------------------------------------------------------

ALTER TABLE "DEPT" ADD CONSTRAINT "PK_DEPT" PRIMARY KEY ("DEPTNO");

--------------------------------------------------------
--  Constraints for Table EMP
--------------------------------------------------------

ALTER TABLE "EMP" ADD CONSTRAINT "PK_EMP" PRIMARY KEY ("EMPNO");


--------------------------------------------------------
--  Ref Constraints for Table EMP
--------------------------------------------------------

ALTER TABLE "EMP" ADD CONSTRAINT "FK_DEPTNO" FOREIGN KEY ("DEPTNO")
	REFERENCES "DEPT" ("DEPTNO") ENABLE;

