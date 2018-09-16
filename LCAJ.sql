-- PACKAGE BODY

create or replace PACKAGE BODY LCAJ AS  
  V_HONAP T_HONAP;
  V_MHO T_MHO;
  V_MHO_OUT T_MHO_OUT;
  V_TEAOR T_TEAOR;
  V_M0581 T_M0581;
  V_ENG_LIST T_ENG_LIST;
  V_ENG_MEGNEV T_ENG_MEGNEV;
  V_OSSZEG T_OSSZEG;
  V_HUN_LIST T_HUN_LIST;
  V_HUN_OSSZEG T_HUN_OSSZEG;
  V_out_table_01 T_out_table_01;
  V_out_table_02 T_out_table_02;
  V_out_table_03 T_out_table_03;
  V_out_table_04 T_out_table_04;
  V_LCAJ_INPUT_LTSZ T_LCAJ_INPUT_LTSZ;
  V_in_table_01 T_in_table_01;
  V_in_table_02 T_in_table_02;
  V_in_table_03 T_in_table_03;
  V_LCAJ_TABLES T_LCAJ_TABLES;
  V_LCAJ_TABLES_a T_LCAJ_TABLES_a;
  V_create_lcaj_01_LCAJ581 T_create_lcaj_01_LCAJ581;
  V_create_lcaj_01_LCAJ582 T_create_lcaj_01_LCAJ582;
  V_create_lcaj_01_kozf_n T_create_lcaj_01_kozf_n;

  v_out_lcaj_schema VARCHAR(10);
  
procedure ins_LCAJ_letszam(P_EVSZAM VARCHAR2) AS   

v_year VARCHAR2(5);
v_imp_lcaj_table VARCHAR2(50);
v_imp_lcaj_schema VARCHAR2(10);
procName VARCHAR2(30);
v_out_table VARCHAR2(30);
v_view_schema VARCHAR2(10);
v_out_lcaj_schema_fin VARCHAR2(10);
v NUMERIC;
BEGIN



procName := 'Create tables';
v_year := SUBSTR(''|| P_EVSZAM ||'', 3);
v_imp_lcaj_table := 'lcaj0_'|| v_year ||'0112_v05'; -- tábla megnevezése, ahonnan importálunk, évszámtól függ a neve
v_out_lcaj_schema := 'LC'; -- melyik sémába töltsük be az adatokat (WORK táblákat)
--v_out_lcaj_schema := 'PKD'; -- teszteléshez
v_out_lcaj_schema_fin := 'LC'|| v_year ||'_F'; -- melyik sémába töltsük be az adatokat (FINAL táblát)
--v_out_lcaj_schema_fin := 'PKD'; -- teszteléshez
--v_out_lcaj_schema_fin := 'LC';

-- séma megnevezése, ahonnan importálunk, évszámtól függ a neve, kikommentelni élesítés esetén
CASE 
WHEN ''|| P_EVSZAM ||'' = '2017' THEN v_imp_lcaj_schema := 'YB17';
ELSE v_imp_lcaj_schema := 'LC'|| v_year ||'_F'; 
END CASE; 

--v_imp_lcaj_schema := 'PKD'; -- teszteléshez
v_out_table := 'LCAJ5_180112_V05'; -- output tábla neve
v_view_schema := 'LC'; -- a séma neve, ahova a view-k kerüljenek
--v_view_schema := 'PKD'; -- teszteléshez


-- log
INSERT INTO logging_lcaj (created_on, info, proc_name, message, backtrace)
VALUES (TO_CHAR(CURRENT_TIMESTAMP, 'YYYY.MM.DD HH24:MI:SS.FF'), 'Info', ''|| procName ||'', 'STARTING', '');

-- log
INSERT INTO logging_lcaj (created_on, info, proc_name, message, backtrace)
VALUES (TO_CHAR(CURRENT_TIMESTAMP, 'YYYY.MM.DD HH24:MI:SS.FF'), 'Info', ''|| procName ||'', 'Imported table: '|| v_imp_lcaj_schema ||'.'|| v_imp_lcaj_table ||'', '');

-- log
INSERT INTO logging_lcaj (created_on, info, proc_name, message, backtrace)
VALUES (TO_CHAR(CURRENT_TIMESTAMP, 'YYYY.MM.DD HH24:MI:SS.FF'), 'Info', ''|| procName ||'', '', '');

EXECUTE IMMEDIATE'
CREATE TABLE W_LCAJ_01_letszam
(
LCAJ581 NUMBER(10,3),
MHO VARCHAR2(5),
LCAJ582 NUMBER(10,3),
LCAJ583 NUMBER(10,3),
teaor VARCHAR2(5),
MEGNEV VARCHAR2(500)
)
'
;


EXECUTE IMMEDIATE'
CREATE TABLE W_LCAJ_02_letszam
(
LCAJ581 NUMBER(10,3),
MHO VARCHAR2(5),
LCAJ582 NUMBER(10,3),
LCAJ583 NUMBER(10,3),
teaor VARCHAR2(5),
MEGNEV VARCHAR2(500)
)
'
;

EXECUTE IMMEDIATE'
CREATE TABLE W_LCAJ_03_letszam
(
LCAJ581 NUMBER(10,3),
MHO VARCHAR2(5),
LCAJ582 NUMBER(10,3),
LCAJ583 NUMBER(10,3),
teaor VARCHAR2(5),
MEGNEV VARCHAR2(500)
)
'
;

EXECUTE IMMEDIATE'
CREATE TABLE W_LCAJ_01_ora
(
LCAJ581 NUMBER(10,3),
MHO VARCHAR2(5),
LCAJ582 NUMBER(10,3),
LCAJ583 NUMBER(10,3),
teaor VARCHAR2(5),
MEGNEV VARCHAR2(500)
)
'
;

EXECUTE IMMEDIATE'
CREATE TABLE W_LCAJ_02_ora
(
LCAJ581 NUMBER(10,3),
MHO VARCHAR2(5),
LCAJ582 NUMBER(10,3),
LCAJ583 NUMBER(10,3),
teaor VARCHAR2(5),
MEGNEV VARCHAR2(500)
)
'
;

EXECUTE IMMEDIATE'
CREATE TABLE W_LCAJ_03_ora
(
LCAJ581 NUMBER(10,3),
MHO VARCHAR2(5),
LCAJ582 NUMBER(10,3),
LCAJ583 NUMBER(10,3),
teaor VARCHAR2(5),
MEGNEV VARCHAR2(500)
)
'
;

EXECUTE IMMEDIATE'
CREATE TABLE W_LCAJ_04_letszam_q1
(
TEV VARCHAR2(10),
MHO VARCHAR2(8),
teaor VARCHAR2(20),
MEGNEV VARCHAR2(500),
LCAJ581 NUMBER(10,3),
LCAJ582 NUMBER(10,3),
LCAJ583 NUMBER(10,3)
)
'
;

EXECUTE IMMEDIATE'
CREATE TABLE W_LCAJ_04_ora_q1
(
TEV VARCHAR2(10),
MHO VARCHAR2(8),
teaor VARCHAR2(20),
MEGNEV VARCHAR2(500),
LCAJ581 NUMBER(10,3),
LCAJ582 NUMBER(10,3),
LCAJ583 NUMBER(10,3)
)
'
;

EXECUTE IMMEDIATE'
CREATE TABLE W_LCAJ_04_letszam_q2
(
TEV VARCHAR2(10),
MHO VARCHAR2(8),
teaor VARCHAR2(20),
MEGNEV VARCHAR2(500),
LCAJ581 NUMBER(10,3),
LCAJ582 NUMBER(10,3),
LCAJ583 NUMBER(10,3)
)
'
;

EXECUTE IMMEDIATE'
CREATE TABLE W_LCAJ_04_ora_q2
(
TEV VARCHAR2(10),
MHO VARCHAR2(8),
teaor VARCHAR2(20),
MEGNEV VARCHAR2(500),
LCAJ581 NUMBER(10,3),
LCAJ582 NUMBER(10,3),
LCAJ583 NUMBER(10,3)
)
'
;

EXECUTE IMMEDIATE'
CREATE TABLE W_LCAJ_04_letszam_q3
(
TEV VARCHAR2(10),
MHO VARCHAR2(8),
teaor VARCHAR2(20),
MEGNEV VARCHAR2(500),
LCAJ581 NUMBER(10,3),
LCAJ582 NUMBER(10,3),
LCAJ583 NUMBER(10,3)
)
'
;

EXECUTE IMMEDIATE'
CREATE TABLE W_LCAJ_04_ora_q3
(
TEV VARCHAR2(10),
MHO VARCHAR2(8),
teaor VARCHAR2(20),
MEGNEV VARCHAR2(500),
LCAJ581 NUMBER(10,3),
LCAJ582 NUMBER(10,3),
LCAJ583 NUMBER(10,3)
)
'
;

EXECUTE IMMEDIATE'
CREATE TABLE W_LCAJ_04_letszam_q4
(
TEV VARCHAR2(10),
MHO VARCHAR2(8),
teaor VARCHAR2(20),
MEGNEV VARCHAR2(500),
LCAJ581 NUMBER(10,3),
LCAJ582 NUMBER(10,3),
LCAJ583 NUMBER(10,3)
)
'
;

EXECUTE IMMEDIATE'
CREATE TABLE W_LCAJ_04_ora_q4
(
TEV VARCHAR2(10),
MHO VARCHAR2(8),
teaor VARCHAR2(20),
MEGNEV VARCHAR2(500),
LCAJ581 NUMBER(10,3),
LCAJ582 NUMBER(10,3),
LCAJ583 NUMBER(10,3)
)
';


procName := 'Create table_01';

FOR a in 1..v_out_table_01.COUNT LOOP

-- log
INSERT INTO logging_lcaj (created_on, info, proc_name, message, backtrace)
VALUES (TO_CHAR(CURRENT_TIMESTAMP, 'YYYY.MM.DD HH24:MI:SS.FF'), 'Info', ''|| procName ||'', 'Create '|| v_out_table_01(a) ||'', '');


	FOR j IN 1..87 LOOP 
		
		-- 1. lépés: beimportáljuk a szükséges adatokat az alap táblából, első körben feltöltjük a TEAOR mezőket
		
		EXECUTE IMMEDIATE ' 
		INSERT INTO '|| v_out_lcaj_schema ||'.'|| v_out_table_01(a) ||'
			SELECT * FROM (
			SELECT 
			'''' AS LCAJ581, '''' AS MHO, '''' AS LCAJ582,  '''' AS LCAJ583, ''' || V_TEAOR(j) || ''' AS TEAOR, '''' AS MEGNEV
			FROM '|| v_imp_lcaj_schema ||'.'|| v_imp_lcaj_table ||'
			) WHERE LCAJ581 IS NOT NULL '
			;
		
		
		-- 2. lépés: az alap táblából a számokat átmásoljuk és átszámoljuk azokat
		
		FOR i IN 1..V_HONAP.COUNT LOOP      
			EXECUTE IMMEDIATE '          
			INSERT INTO '|| v_out_lcaj_schema ||'.'|| v_out_table_01(a) ||' 
				   SELECT * FROM (

			SELECT
			
			'|| v_create_lcaj_01_LCAJ581(a) ||' AS LCAJ581,
			''' ||V_MHO(i)|| ''' AS MHO,
			'|| v_create_lcaj_01_LCAJ582(a) ||' AS LCAJ582,
			'|| v_create_lcaj_01_kozf_n(a) ||' AS LCAJ583,
			''' || V_TEAOR(j) || ''' AS TEAOR, '''' AS MEGNEV
			FROM '|| v_imp_lcaj_schema ||'.'|| v_imp_lcaj_table ||'
			WHERE TEV = '''|| P_EVSZAM ||''' AND MHO IN ' || V_HONAP(i) ||' AND M0581 LIKE ' || V_M0581(j) || '
			) '
			;
		
		END LOOP;
	
			-- A MEGNEV mezőt feltöltjük a CA.CANA1 táblából
		
	
		EXECUTE IMMEDIATE ' 
		UPDATE  '|| v_out_lcaj_schema ||'.'|| v_out_table_01(a) ||'
		SET MEGNEV = (SELECT MEGNEV FROM CA.CANA1
		WHERE NKOD = ''0721'' AND NESORSZ = ''1'' AND NEKOD = ''' || V_TEAOR(j) || ''')
		WHERE TEAOR = ''' || V_TEAOR(j) || '''
		'			
		;
	
	END LOOP;
	
	
		-- 3. lépés: hozzáírjuk az adott negyedévet a MHO mezőbe

-- log
INSERT INTO logging_lcaj (created_on, info, proc_name, message, backtrace)
VALUES (TO_CHAR(CURRENT_TIMESTAMP, 'YYYY.MM.DD HH24:MI:SS.FF'), 'Info', ''|| procName ||'', 'Writing quarters', '');		
		
	FOR k IN 1..V_MHO.COUNT LOOP      
			EXECUTE IMMEDIATE '          
				INSERT INTO '|| v_out_lcaj_schema ||'.'|| v_out_table_01(a) ||' 
				SELECT * FROM (
				SELECT 
				SUM(LCAJ581),
				''' ||V_MHO(k)|| ''' AS MHO,
				SUM(LCAJ582),
				SUM (LCAJ583),
				''999'' as TEAOR,
				''Összesen'' as MEGNEV
				
				FROM '|| v_out_lcaj_schema ||'.'|| v_out_table_01(a) ||'
				WHERE MHO = ''' ||V_MHO(k)|| '''
				
				)
				'
			;
	END LOOP;
	
END LOOP;

-- SUM, első összegzés (angol verzió)

procName := 'Create table_02';

FOR a in 1..v_out_table_02.COUNT LOOP

-- log
INSERT INTO logging_lcaj (created_on, info, proc_name, message, backtrace)
VALUES (TO_CHAR(CURRENT_TIMESTAMP, 'YYYY.MM.DD HH24:MI:SS.FF'), 'Info', ''|| procName ||'', 'Create '|| v_out_table_02(a) ||'', '');	


		-- 4. lépés: létrehozzuk a második táblát, ami a SUM értékeket tartalmazza, első körben a negyedéveket írjuk be a MHO mezőbe

	FOR i IN 1..V_MHO.COUNT LOOP 
		EXECUTE IMMEDIATE '  
		INSERT INTO '|| v_out_lcaj_schema ||'.'|| v_out_table_02(a) ||'
		SELECT * FROM (
		SELECT 
		'''' AS LCAJ581, 
		'' ' ||V_MHO(i)|| ' '' AS MHO,
		'''' AS LCAJ582,  
		'''' AS LCAJ583, 
		'''' AS TEAOR, 
		'''' AS MEGNEV
		
		FROM '|| v_out_lcaj_schema ||'.'|| v_out_table_01(a) ||' )
		WHERE LCAJ581 IS NOT NULL '
		;

		-- 5. lépés: szummázunk, létrehozzuk az új TEAOR és szöveg mezőket és rekordokat
		
			FOR j IN 1..V_ENG_LIST.COUNT LOOP 
			EXECUTE IMMEDIATE '  
			INSERT INTO '|| v_out_lcaj_schema ||'.'|| v_out_table_02(a) ||'
				SELECT * FROM (
			
			SELECT 
			SUM(LCAJ581), 
			''' ||V_MHO(i)|| ''',
			SUM(LCAJ582),
			SUM(LCAJ583),
			''' || V_ENG_LIST(j) || ''',
			''' || V_ENG_MEGNEV(j) || '''
			
			FROM '|| v_out_lcaj_schema ||'.'|| v_out_table_01(a) ||' 
			WHERE MHO = ''' ||V_MHO(i)|| ''' AND TEAOR IN ' || V_OSSZEG(j) || '
			 )
			'
			;
			END LOOP;
			
	END LOOP;

END LOOP;		


-- SUM, második összegzés (magyar verzió)

procName := 'Create table_03';

FOR a in 1..v_out_table_03.COUNT LOOP

-- log
INSERT INTO logging_lcaj (created_on, info, proc_name, message, backtrace)
VALUES (TO_CHAR(CURRENT_TIMESTAMP, 'YYYY.MM.DD HH24:MI:SS.FF'), 'Info', ''|| procName ||'', 'Create '|| v_out_table_03(a) ||'', '');

		-- 6. lépés: létrehozzuk a harmadik táblát, ami a SUM értékeket tartalmazza, első körben a negyedéveket írjuk be a MHO mezőbe

	FOR i IN 1..V_MHO.COUNT LOOP 
		EXECUTE IMMEDIATE '  
		INSERT INTO '|| v_out_lcaj_schema ||'.'|| v_out_table_03(a) ||'
		SELECT * FROM (
		SELECT 
		'''' AS LCAJ581, 
		'' ' ||V_MHO(i)|| ' '' AS MHO,
		'''' AS LCAJ582,  
		'''' AS LCAJ583, 
		'''' AS TEAOR, 
		'''' AS MEGNEV
		
		FROM '|| v_out_lcaj_schema ||'.'|| v_out_table_01(a) ||'  )
		WHERE LCAJ581 IS NOT NULL '
		;

		
		-- 7. lépés: szummázunk, létrehozzuk az új TEAOR és szöveg mezőket és rekordokat
		
			FOR j IN 1..V_HUN_LIST.COUNT LOOP 
			EXECUTE IMMEDIATE '  
			INSERT INTO '|| v_out_lcaj_schema ||'.'|| v_out_table_03(a) ||'
				SELECT * FROM (
			
			SELECT 
			SUM(LCAJ581), 
			''' ||V_MHO(i)|| ''',
			SUM(LCAJ582),
			SUM(LCAJ583),
			''' || V_HUN_LIST(j) || ''',
			''''
			
			FROM '|| v_out_lcaj_schema ||'.'|| v_out_table_01(a) ||' 
			WHERE MHO = ''' ||V_MHO(i)|| ''' AND TEAOR IN ' || V_HUN_OSSZEG(j) || '
			 )
			'
			;
			
			
		-- hozzáírjuk a MEGNEV mezőt a CA.CANA1 táblából
	
			EXECUTE IMMEDIATE ' 
			UPDATE  '|| v_out_lcaj_schema ||'.'|| v_out_table_03(a) ||'
			SET MEGNEV = (SELECT MEGNEV FROM CA.CANA1
			WHERE NKOD = ''Y691'' AND NESORSZ = ''1'' AND NEKOD = ''' || V_HUN_LIST(j) || ''')
			WHERE TEAOR = ''' || V_HUN_LIST(j) || '''
			'			
			;
			
			EXECUTE IMMEDIATE ' 
			UPDATE  '|| v_out_lcaj_schema ||'.'|| v_out_table_03(a) ||'
			SET MEGNEV = ''Összesen''
			WHERE TEAOR = ''U_SUM''
			'			
			;
	
			
			
			END LOOP;
			
	END LOOP;

END LOOP;		

-- OUTPUT tábla létrehozása

procName := 'Create table_04';


FOR a in 1..v_out_table_04.COUNT LOOP

-- log
INSERT INTO logging_lcaj (created_on, info, proc_name, message, backtrace)
VALUES (TO_CHAR(CURRENT_TIMESTAMP, 'YYYY.MM.DD HH24:MI:SS.FF'), 'Info', ''|| procName ||'', 'Create '|| v_out_table_04(a) ||'', '');
	
		-- beillesztjük az összes TEAOR rekordot
	
	FOR k IN 1..87 LOOP 
		EXECUTE IMMEDIATE '  
			INSERT INTO '|| v_out_lcaj_schema ||'.'|| v_out_table_04(a) ||'
			SELECT * FROM (
			SELECT DISTINCT '|| P_EVSZAM ||' AS TEV, MHO, TEAOR as teaor, MEGNEV, LCAJ581, LCAJ582, LCAJ583
			FROM '|| v_out_lcaj_schema ||'.'|| v_in_table_01(a) ||' 
			WHERE MHO = '|| V_MHO_OUT(a) ||' AND TEAOR = '|| V_TEAOR(k) ||'
			)
			'
			;
	END LOOP;
	
	
		-- összesen sort beillesztjük
	
	EXECUTE IMMEDIATE '  
			INSERT INTO '|| v_out_lcaj_schema ||'.'|| v_out_table_04(a) ||'
			SELECT * FROM (
			SELECT DISTINCT '|| P_EVSZAM ||' AS TEV, MHO, ''999'' as teaor, MEGNEV, LCAJ581, LCAJ582, LCAJ583
			FROM '|| v_out_lcaj_schema ||'.'|| v_in_table_01(a) ||' 
			WHERE MHO = '|| V_MHO_OUT(a) ||' AND TEAOR = ''999''
			)
			'
			;
			

		-- beillesztjük az összes angol SUM rekordot, a felhasználó által megadott negyedévre vonatkozóan
	
	FOR m IN 1..V_ENG_LIST.COUNT LOOP 
		EXECUTE IMMEDIATE '  
			INSERT INTO '|| v_out_lcaj_schema ||'.'|| v_out_table_04(a) ||'
			SELECT * FROM (
			SELECT DISTINCT '|| P_EVSZAM ||' AS TEV, MHO, TEAOR as teaor, MEGNEV, LCAJ581, LCAJ582, LCAJ583
			FROM '|| v_out_lcaj_schema ||'.'|| v_in_table_02(a) ||' 
			WHERE MHO = '''|| V_MHO_OUT(a) ||''' AND TEAOR = '''|| V_ENG_LIST(m) ||'''
			)
			'
			;
	END LOOP;	
	

	
	FOR o IN 1..V_HUN_LIST.COUNT LOOP 
		EXECUTE IMMEDIATE '  
			INSERT INTO '|| v_out_lcaj_schema ||'.'|| v_out_table_04(a) ||'
			SELECT * FROM (
			SELECT DISTINCT '|| P_EVSZAM ||' AS TEV, MHO, TEAOR as teaor, MEGNEV, LCAJ581, LCAJ582, LCAJ583
			FROM '|| v_out_lcaj_schema ||'.'|| v_in_table_03(a) ||' 
			WHERE MHO = '''|| V_MHO_OUT(a) ||''' AND TEAOR = '''|| V_HUN_LIST(o) ||'''
			)
			'
			;
	END LOOP;	
	
END LOOP;


		-- végtáblába összevonjuk a negyedéveket

procName := 'Create table_05';

-- log
INSERT INTO logging_lcaj (created_on, info, proc_name, message, backtrace)
VALUES (TO_CHAR(CURRENT_TIMESTAMP, 'YYYY.MM.DD HH24:MI:SS.FF'), 'Info', ''|| procName ||'', 'Create '|| v_out_table ||'', '');

	-- első negyedév beillesztése (létszám)
		
		EXECUTE IMMEDIATE '  
		INSERT INTO '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
		SELECT a.TEV, a.TEAOR, a.MEGNEV, ROUND(a.LCAJ581) AS LCAJ581_q1, ROUND(a.LCAJ582)  as LCAJ582_q1, ROUND(a.LCAJ583) AS LCAJ583_q1, '''' as LCAJ581_q2, '''' as LCAJ582_q2, '''' as LCAJ583_q2, '''' as LCAJ581_q3, '''' as LCAJ582_q3, '''' as LCAJ583_q3, '''' as LCAJ581_q4, '''' as LCAJ582_q4, '''' as LCAJ583_q4,
		'''' AS LCAJ584_q1, '''' as LCAJ585_q1, '''' AS LCAJ586_q1, '''' as LCAJ584_q2, '''' as LCAJ585_q2, '''' as LCAJ586_q2, '''' as LCAJ584_q3, '''' as LCAJ585_q3, '''' as LCAJ586_q3, '''' as LCAJ584_q4, '''' as LCAJ585_q4, '''' as LCAJ586_q4
		FROM '|| v_out_lcaj_schema ||'.'|| v_out_table_04(1) ||' a
		'
		;
	
		
	-- TEAOR sorok beillesztése (Q2-Q4: ltsz, Q1-Q4: óra)
	FOR b in 1..V_LCAJ_TABLES.COUNT LOOP
	
		FOR c in 1..V_TEAOR.COUNT LOOP
	
			EXECUTE IMMEDIATE '  
			UPDATE '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
			SET '|| V_LCAJ_TABLES(b) ||' = (SELECT ROUND('|| V_LCAJ_TABLES_a(b) ||')  FROM '|| V_LCAJ_INPUT_LTSZ(b) ||' WHERE TEAOR = '''|| V_TEAOR(c) ||''')  
			WHERE TEAOR = '''|| V_TEAOR(c) ||'''
			'
			;
	
		END LOOP;
	
	END LOOP;
	
	-- angol sorok beillesztése (Q2-Q4: ltsz, Q1-Q4: óra)
	
	FOR b in 1..V_LCAJ_TABLES.COUNT LOOP
	
		FOR c in 1..V_ENG_LIST.COUNT LOOP
	
			EXECUTE IMMEDIATE '  
			UPDATE '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
			SET '|| V_LCAJ_TABLES(b) ||' = (SELECT ROUND('|| V_LCAJ_TABLES_a(b) ||') FROM '|| V_LCAJ_INPUT_LTSZ(b) ||' WHERE TEAOR = '''|| V_ENG_LIST(c) ||''')  
			WHERE TEAOR = '''|| V_ENG_LIST(c) ||'''
			'
			;
	
		END LOOP;
	
	END LOOP;
	
	
	-- magyar SUM sorok beillesztése (Q2-Q4: ltsz, Q1-Q4: óra)
	
	FOR b in 1..V_LCAJ_TABLES.COUNT LOOP
	
		FOR c in 1..V_HUN_LIST.COUNT LOOP
	
			EXECUTE IMMEDIATE '  
			UPDATE '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
			SET '|| V_LCAJ_TABLES(b) ||' = (SELECT ROUND('|| V_LCAJ_TABLES_a(b) ||')  FROM '|| V_LCAJ_INPUT_LTSZ(b) ||' WHERE TEAOR = '''|| V_HUN_LIST(c) ||''')  
			WHERE TEAOR = '''|| V_HUN_LIST(c) ||'''
			'
			;
	
		END LOOP;
	
	END LOOP;

	 -- drop tables
 
 procName := 'Drop temp tables';
 
  -- log
INSERT INTO logging_lcaj (created_on, info, proc_name, message, backtrace)
VALUES (TO_CHAR(CURRENT_TIMESTAMP, 'YYYY.MM.DD HH24:MI:SS.FF'), 'Info', ''|| procName ||'', '', '');
 
DROP_TABLE(''|| v_out_lcaj_schema ||'.W_LCAJ_01_letszam');
DROP_TABLE(''|| v_out_lcaj_schema ||'.W_LCAJ_01_ora');
DROP_TABLE(''|| v_out_lcaj_schema ||'.W_LCAJ_02_letszam');
DROP_TABLE(''|| v_out_lcaj_schema ||'.W_LCAJ_02_ora');
DROP_TABLE(''|| v_out_lcaj_schema ||'.W_LCAJ_03_letszam');
DROP_TABLE(''|| v_out_lcaj_schema ||'.W_LCAJ_03_ora');
DROP_TABLE(''|| v_out_lcaj_schema ||'.W_LCAJ_04_letszam_q1');
DROP_TABLE(''|| v_out_lcaj_schema ||'.W_LCAJ_04_letszam_q2');
DROP_TABLE(''|| v_out_lcaj_schema ||'.W_LCAJ_04_letszam_q3');
DROP_TABLE(''|| v_out_lcaj_schema ||'.W_LCAJ_04_letszam_q4');
DROP_TABLE(''|| v_out_lcaj_schema ||'.W_LCAJ_04_ora_q1');
DROP_TABLE(''|| v_out_lcaj_schema ||'.W_LCAJ_04_ora_q2');
DROP_TABLE(''|| v_out_lcaj_schema ||'.W_LCAJ_04_ora_q3');
DROP_TABLE(''|| v_out_lcaj_schema ||'.W_LCAJ_04_ora_q4');
	

-- create view
procName := 'Create views';


-- log
INSERT INTO logging_lcaj (created_on, info, proc_name, message, backtrace)
VALUES (TO_CHAR(CURRENT_TIMESTAMP, 'YYYY.MM.DD HH24:MI:SS.FF'), 'Info', ''|| procName ||'', '', '');

EXECUTE IMMEDIATE '  
CREATE OR REPLACE VIEW '|| v_view_schema ||'.LCAJ_LETSZAM AS
SELECT DISTINCT ''01'' AS SORREND, TEV AS TEV, '''' AS TEAOR, ''Szervezet tevékenységében résztvevők létszáma (60 óra alatt foglalkoztatottak nélkül)'' AS MEGNEV, ''összes alkalmazott létszám (közfoglalkoztatottakkal)'' as LCAJ581q1, ''összes közfoglalkoztatott létszám'' as LCAJ582q1, ''összes létszám közfogl. nélküli alkalmazottakra'' as LCAJ583q1, ''összes alkalmazott létszám (közfoglalkoztatottakkal)'' as LCAJ581q2, ''összes közfoglalkoztatott létszám'' as LCAJ582q2, ''összes létszám közfogl. nélküli alkalmazottakra'' as LCAJ583q2, ''összes alkalmazott létszám (közfoglalkoztatottakkal)'' as LCAJ581q3, ''összes közfoglalkoztatott létszám'' as LCAJ582q3, ''összes létszám közfogl. nélküli alkalmazottakra'' as LCAJ583q3,
''összes alkalmazott létszám (közfoglalkoztatottakkal)'' as LCAJ581q4, ''összes közfoglalkoztatott létszám'' as LCAJ582q4, ''összes létszám közfogl. nélküli alkalmazottakra'' as LCAJ583q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'

UNION 

SELECT DISTINCT ''02'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ581q1, '''' as LCAJ582q1, '''' as LCAJ583q1, 
'''' as LCAJ581q2, '''' as LCAJ582q2, '''' as LCAJ583q2,
'''' as LCAJ581q3, '''' as LCAJ582q3, '''' as LCAJ583q3,
'''' as LCAJ581q4, '''' as LCAJ582q4, '''' as LCAJ583q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
UNION

SELECT DISTINCT ''03'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ581q1, '''' as LCAJ582q1, '''' as LCAJ583q1, 
'''' as LCAJ581q2, '''' as LCAJ582q2, '''' as LCAJ583q2,
'''' as LCAJ581q3, '''' as LCAJ582q3, '''' as LCAJ583q3,
'''' as LCAJ581q4, '''' as LCAJ582q4, '''' as LCAJ583q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'

UNION

SELECT DISTINCT ''04'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ581q1, '''' as LCAJ582q1, '''' as LCAJ583q1, 
'''' as LCAJ581q2, '''' as LCAJ582q2, '''' as LCAJ583q2,
'''' as LCAJ581q3, '''' as LCAJ582q3, '''' as LCAJ583q3,
'''' as LCAJ581q4, '''' as LCAJ582q4, '''' as LCAJ583q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
 UNION
 
 SELECT DISTINCT ''05'' AS SORREND, TEV AS TEV, TEAOR AS TEAOR, MEGNEV AS MEGNEV, CAST(LCAJ581_q1 as VARCHAR2(50)) as LCAJ581q1, CAST(LCAJ582_q1 as VARCHAR2(50)) as LCAJ582q1, CAST(LCAJ583_q1 as VARCHAR2(50)) as LCAJ583q1, 
CAST(LCAJ581_q2 as VARCHAR2(50)) as LCAJ581q2, CAST(LCAJ582_q2 as VARCHAR2(50)) as LCAJ582q2, CAST(LCAJ583_q2 as VARCHAR2(50)) as LCAJ583q2,
CAST(LCAJ581_q3 as VARCHAR2(50)) as LCAJ581q3, CAST(LCAJ582_q3 as VARCHAR2(50)) as LCAJ582q3, CAST(LCAJ583_q3 as VARCHAR2(50)) as LCAJ583q3,
CAST(LCAJ581_q4 as VARCHAR2(50)) as LCAJ581q4, CAST(LCAJ582_q4 as VARCHAR2(50)) as LCAJ582q4, CAST(LCAJ583_q4 as VARCHAR2(50)) as LCAJ583q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 WHERE TEAOR > ''00'' AND TEAOR < ''9999''
 
UNION

SELECT DISTINCT ''06'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ581q1, '''' as LCAJ582q1, '''' as LCAJ583q1, 
'''' as LCAJ581q2, '''' as LCAJ582q2, '''' as LCAJ583q2,
'''' as LCAJ581q3, '''' as LCAJ582q3, '''' as LCAJ583q3,
'''' as LCAJ581q4, '''' as LCAJ582q4, '''' as LCAJ583q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
 UNION

SELECT DISTINCT ''07'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ581q1, '''' as LCAJ582q1, '''' as LCAJ583q1, 
'''' as LCAJ581q2, '''' as LCAJ582q2, '''' as LCAJ583q2,
'''' as LCAJ581q3, '''' as LCAJ582q3, '''' as LCAJ583q3,
'''' as LCAJ581q4, '''' as LCAJ582q4, '''' as LCAJ583q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
 UNION

SELECT DISTINCT ''08'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ581q1, '''' as LCAJ582q1, '''' as LCAJ583q1, 
'''' as LCAJ581q2, '''' as LCAJ582q2, '''' as LCAJ583q2,
'''' as LCAJ581q3, '''' as LCAJ582q3, '''' as LCAJ583q3,
'''' as LCAJ581q4, '''' as LCAJ582q4, '''' as LCAJ583q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
 UNION

SELECT DISTINCT ''09'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ581q1, '''' as LCAJ582q1, '''' as LCAJ583q1, 
'''' as LCAJ581q2, '''' as LCAJ582q2, '''' as LCAJ583q2,
'''' as LCAJ581q3, '''' as LCAJ582q3, '''' as LCAJ583q3,
'''' as LCAJ581q4, '''' as LCAJ582q4, '''' as LCAJ583q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
 UNION
 
 SELECT DISTINCT ''10'' AS SORREND, TEV AS TEV, TEAOR AS TEAOR, MEGNEV AS MEGNEV, CAST(LCAJ581_q1 as VARCHAR2(50)) as LCAJ581q1, CAST(LCAJ582_q1 as VARCHAR2(50)) as LCAJ582q1, CAST(LCAJ583_q1 as VARCHAR2(50)) as LCAJ583q1, 
CAST(LCAJ581_q2 as VARCHAR2(50)) as LCAJ581q2, CAST(LCAJ582_q2 as VARCHAR2(50)) as LCAJ582q2, CAST(LCAJ583_q2 as VARCHAR2(50)) as LCAJ583q2,
CAST(LCAJ581_q3 as VARCHAR2(50)) as LCAJ581q3, CAST(LCAJ582_q3 as VARCHAR2(50)) as LCAJ582q3, CAST(LCAJ583_q3 as VARCHAR2(50)) as LCAJ583q3,
CAST(LCAJ581_q4 as VARCHAR2(50)) as LCAJ581q4, CAST(LCAJ582_q4 as VARCHAR2(50)) as LCAJ582q4, CAST(LCAJ583_q4 as VARCHAR2(50)) as LCAJ583q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 WHERE TEAOR IN (''V'', ''VA'', ''VB_E'', ''VC'', ''VF'', ''VG_I'', ''VJ'', ''VK'', ''VL'', ''VM_N'', ''VO_Q'', ''VR_U'')
 
  UNION

SELECT DISTINCT ''11'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ581q1, '''' as LCAJ582q1, '''' as LCAJ583q1, 
'''' as LCAJ581q2, '''' as LCAJ582q2, '''' as LCAJ583q2,
'''' as LCAJ581q3, '''' as LCAJ582q3, '''' as LCAJ583q3,
'''' as LCAJ581q4, '''' as LCAJ582q4, '''' as LCAJ583q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
 UNION

SELECT DISTINCT ''12'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ581q1, '''' as LCAJ582q1, '''' as LCAJ583q1, 
'''' as LCAJ581q2, '''' as LCAJ582q2, '''' as LCAJ583q2,
'''' as LCAJ581q3, '''' as LCAJ582q3, '''' as LCAJ583q3,
'''' as LCAJ581q4, '''' as LCAJ582q4, '''' as LCAJ583q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
 UNION
 
  SELECT DISTINCT ''13'' AS SORREND, TEV AS TEV, TEAOR AS TEAOR, MEGNEV AS MEGNEV, CAST(LCAJ581_q1 as VARCHAR2(50)) as LCAJ581q1, CAST(LCAJ582_q1 as VARCHAR2(50)) as LCAJ582q1, CAST(LCAJ583_q1 as VARCHAR2(50)) as LCAJ583q1, 
CAST(LCAJ581_q2 as VARCHAR2(50)) as LCAJ581q2, CAST(LCAJ582_q2 as VARCHAR2(50)) as LCAJ582q2, CAST(LCAJ583_q2 as VARCHAR2(50)) as LCAJ583q2,
CAST(LCAJ581_q3 as VARCHAR2(50)) as LCAJ581q3, CAST(LCAJ582_q3 as VARCHAR2(50)) as LCAJ582q3, CAST(LCAJ583_q3 as VARCHAR2(50)) as LCAJ583q3,
CAST(LCAJ581_q4 as VARCHAR2(50)) as LCAJ581q4, CAST(LCAJ582_q4 as VARCHAR2(50)) as LCAJ582q4, CAST(LCAJ583_q4 as VARCHAR2(50)) as LCAJ583q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 WHERE TEAOR IN (''A'', ''B'', ''C'', ''D'', ''E'', ''F'', ''G'', ''H'', ''I'', ''J'', ''K'', ''L'', ''M'', ''N'', ''O'', ''P'', ''Q='', ''R'', ''S'', ''T'', ''U'', ''U_SUM'')
 
 '
 ;
 


EXECUTE IMMEDIATE'
CREATE OR REPLACE VIEW '|| v_view_schema ||'.LCAJ_ORA AS
SELECT DISTINCT ''01'' AS SORREND, TEV AS TEV, '''' AS TEAOR, ''A szervezet tevékenységében résztvevők teljesített munkaórája a nemzetgazdaságban (60 óra alattiak nélkül) 1000 óra'' AS MEGNEV, ''összes ledolgozott óra alkalmazottakra (közfoglalkoztatottakkal)'' as LCAJ584q1, ''összes ledolgozott óra közfoglalkoztatottakra'' as LCAJ585q1, ''összes ledolgozott óra közfogl. nékül alkalmazottakra'' as LCAJ586q1,
''összes ledolgozott óra alkalmazottakra (közfoglalkoztatottakkal)'' as LCAJ584q2, ''összes ledolgozott óra közfoglalkoztatottakra'' as LCAJ585q2, ''összes ledolgozott óra közfogl. nékül alkalmazottakra'' as LCAJ586q2,
''összes ledolgozott óra alkalmazottakra (közfoglalkoztatottakkal)'' as LCAJ584q3, ''összes ledolgozott óra közfoglalkoztatottakra'' as LCAJ585q3, ''összes ledolgozott óra közfogl. nékül alkalmazottakra'' as LCAJ586q3,
''összes ledolgozott óra alkalmazottakra (közfoglalkoztatottakkal)'' as LCAJ584q4, ''összes ledolgozott óra közfoglalkoztatottakra'' as LCAJ585q4, ''összes ledolgozott óra közfogl. nékül alkalmazottakra'' as LCAJ586q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'

UNION 

SELECT DISTINCT ''02'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ584q1, '''' as LCAJ585q1, '''' as LCAJ586q1, 
'''' as LCAJ584q2, '''' as LCAJ585q2, '''' as LCAJ586q2,
'''' as LCAJ584q3, '''' as LCAJ585q3, '''' as LCAJ586q3,
'''' as LCAJ584q4, '''' as LCAJ585q4, '''' as LCAJ586q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
UNION

SELECT DISTINCT ''03'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ584q1, '''' as LCAJ585q1, '''' as LCAJ586q1, 
'''' as LCAJ584q2, '''' as LCAJ585q2, '''' as LCAJ586q2,
'''' as LCAJ584q3, '''' as LCAJ585q3, '''' as LCAJ586q3,
'''' as LCAJ584q4, '''' as LCAJ585q4, '''' as LCAJ586q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'

UNION

SELECT DISTINCT ''04'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ584q1, '''' as LCAJ585q1, '''' as LCAJ586q1, 
'''' as LCAJ584q2, '''' as LCAJ585q2, '''' as LCAJ586q2,
'''' as LCAJ584q3, '''' as LCAJ585q3, '''' as LCAJ586q3,
'''' as LCAJ584q4, '''' as LCAJ585q4, '''' as LCAJ586q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
 UNION
 
 SELECT DISTINCT ''05'' AS SORREND, TEV AS TEV, TEAOR AS TEAOR, MEGNEV AS MEGNEV, CAST(LCAJ584_q1 as VARCHAR2(50)) as LCAJ584q1, CAST(LCAJ585_q1 as VARCHAR2(50)) as LCAJ585q1, CAST(LCAJ586_q1 as VARCHAR2(50)) as LCAJ586q1, 
CAST(LCAJ584_q2 as VARCHAR2(50)) as LCAJ584q2, CAST(LCAJ585_q2 as VARCHAR2(50)) as LCAJ585q2, CAST(LCAJ586_q2 as VARCHAR2(50)) as LCAJ586q2,
CAST(LCAJ584_q3 as VARCHAR2(50)) as LCAJ584q3, CAST(LCAJ585_q3 as VARCHAR2(50)) as LCAJ585q3, CAST(LCAJ586_q3 as VARCHAR2(50)) as LCAJ586q3,
CAST(LCAJ584_q4 as VARCHAR2(50)) as LCAJ584q4, CAST(LCAJ585_q4 as VARCHAR2(50)) as LCAJ585q4, CAST(LCAJ586_q4 as VARCHAR2(50)) as LCAJ586q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 WHERE TEAOR > ''00'' AND TEAOR < ''9999''
 
UNION

SELECT DISTINCT ''06'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ584q1, '''' as LCAJ585q1, '''' as LCAJ586q1, 
'''' as LCAJ584q2, '''' as LCAJ585q2, '''' as LCAJ586q2,
'''' as LCAJ584q3, '''' as LCAJ585q3, '''' as LCAJ586q3,
'''' as LCAJ584q4, '''' as LCAJ585q4, '''' as LCAJ586q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
 UNION

SELECT DISTINCT ''07'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ584q1, '''' as LCAJ585q1, '''' as LCAJ586q1, 
'''' as LCAJ584q2, '''' as LCAJ585q2, '''' as LCAJ586q2,
'''' as LCAJ584q3, '''' as LCAJ585q3, '''' as LCAJ586q3,
'''' as LCAJ584q4, '''' as LCAJ585q4, '''' as LCAJ586q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
 UNION

SELECT DISTINCT ''08'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ584q1, '''' as LCAJ585q1, '''' as LCAJ586q1, 
'''' as LCAJ584q2, '''' as LCAJ585q2, '''' as LCAJ586q2,
'''' as LCAJ584q3, '''' as LCAJ585q3, '''' as LCAJ586q3,
'''' as LCAJ584q4, '''' as LCAJ585q4, '''' as LCAJ586q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
 UNION

SELECT DISTINCT ''09'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ584q1, '''' as LCAJ585q1, '''' as LCAJ586q1, 
'''' as LCAJ584q2, '''' as LCAJ585q2, '''' as LCAJ586q2,
'''' as LCAJ584q3, '''' as LCAJ585q3, '''' as LCAJ586q3,
'''' as LCAJ584q4, '''' as LCAJ585q4, '''' as LCAJ586q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
 UNION
 
 SELECT DISTINCT ''10'' AS SORREND, TEV AS TEV, TEAOR AS TEAOR, MEGNEV AS MEGNEV, CAST(LCAJ584_q1 as VARCHAR2(50)) as LCAJ584q1, CAST(LCAJ585_q1 as VARCHAR2(50)) as LCAJ585q1, CAST(LCAJ586_q1 as VARCHAR2(50)) as LCAJ586q1, 
CAST(LCAJ584_q2 as VARCHAR2(50)) as LCAJ584q2, CAST(LCAJ585_q2 as VARCHAR2(50)) as LCAJ585q2, CAST(LCAJ586_q2 as VARCHAR2(50)) as LCAJ586q2,
CAST(LCAJ584_q3 as VARCHAR2(50)) as LCAJ584q3, CAST(LCAJ585_q3 as VARCHAR2(50)) as LCAJ585q3, CAST(LCAJ586_q3 as VARCHAR2(50)) as LCAJ586q3,
CAST(LCAJ584_q4 as VARCHAR2(50)) as LCAJ584q4, CAST(LCAJ585_q4 as VARCHAR2(50)) as LCAJ585q4, CAST(LCAJ586_q4 as VARCHAR2(50)) as LCAJ586q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 WHERE TEAOR IN (''V'', ''VA'', ''VB_E'', ''VC'', ''VF'', ''VG_I'', ''VJ'', ''VK'', ''VL'', ''VM_N'', ''VO_Q'', ''VR_U'')
 
  UNION

SELECT DISTINCT ''11'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ584q1, '''' as LCAJ585q1, '''' as LCAJ586q1, 
'''' as LCAJ584q2, '''' as LCAJ585q2, '''' as LCAJ586q2,
'''' as LCAJ584q3, '''' as LCAJ585q3, '''' as LCAJ586q3,
'''' as LCAJ584q4, '''' as LCAJ585q4, '''' as LCAJ586q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
 UNION

SELECT DISTINCT ''12'' AS SORREND, TEV AS TEV, '''' AS TEAOR, '''' AS MEGNEV, '''' as LCAJ584q1, '''' as LCAJ585q1, '''' as LCAJ586q1, 
'''' as LCAJ584q2, '''' as LCAJ585q2, '''' as LCAJ586q2,
'''' as LCAJ584q3, '''' as LCAJ585q3, '''' as LCAJ586q3,
'''' as LCAJ584q4, '''' as LCAJ585q4, '''' as LCAJ586q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 
 UNION
 
  SELECT DISTINCT ''13'' AS SORREND, TEV AS TEV, TEAOR AS TEAOR, MEGNEV AS MEGNEV, CAST(LCAJ584_q1 as VARCHAR2(50)) as LCAJ584q1, CAST(LCAJ585_q1 as VARCHAR2(50)) as LCAJ585q1, CAST(LCAJ586_q1 as VARCHAR2(50)) as LCAJ586q1, 
CAST(LCAJ584_q2 as VARCHAR2(50)) as LCAJ584q2, CAST(LCAJ585_q2 as VARCHAR2(50)) as LCAJ585q2, CAST(LCAJ586_q2 as VARCHAR2(50)) as LCAJ586q2,
CAST(LCAJ584_q3 as VARCHAR2(50)) as LCAJ584q3, CAST(LCAJ585_q3 as VARCHAR2(50)) as LCAJ585q3, CAST(LCAJ586_q3 as VARCHAR2(50)) as LCAJ586q3,
CAST(LCAJ584_q4 as VARCHAR2(50)) as LCAJ584q4, CAST(LCAJ585_q4 as VARCHAR2(50)) as LCAJ585q4, CAST(LCAJ586_q4 as VARCHAR2(50)) as LCAJ586q4
 FROM '|| v_out_lcaj_schema_fin ||'.'|| v_out_table ||'
 WHERE TEAOR IN (''A'', ''B'', ''C'', ''D'', ''E'', ''F'', ''G'', ''H'', ''I'', ''J'', ''K'', ''L'', ''M'', ''N'', ''O'', ''P'', ''Q='', ''R'', ''S'', ''T'', ''U'', ''U_SUM'')

 '
 ;

 
-- log
INSERT INTO logging_lcaj (created_on, info, proc_name, message, backtrace)
VALUES (TO_CHAR(CURRENT_TIMESTAMP, 'YYYY.MM.DD HH24:MI:SS.FF'), 'Info', ''|| procName ||'', 'END', '');

-- error case	
EXCEPTION WHEN OTHERS THEN
record_error_lcaj(procName);
RAISE;

END ins_LCAJ_letszam;

BEGIN

-- táblanevek
v_out_table_01(1):= 'W_LCAJ_01_letszam';
v_out_table_01(2):= 'W_LCAJ_01_ora';
v_out_table_02(1):= 'W_LCAJ_02_letszam';
v_out_table_02(2):= 'W_LCAJ_02_ora';
v_out_table_03(1):= 'W_LCAJ_03_letszam';
v_out_table_03(2):= 'W_LCAJ_03_ora';
v_out_table_04(1):= 'W_LCAJ_04_letszam_q1';
v_out_table_04(2):= 'W_LCAJ_04_ora_q1';
v_out_table_04(3):= 'W_LCAJ_04_letszam_q2';
v_out_table_04(4):= 'W_LCAJ_04_ora_q2';
v_out_table_04(5):= 'W_LCAJ_04_letszam_q3';
v_out_table_04(6):= 'W_LCAJ_04_ora_q3';
v_out_table_04(7):= 'W_LCAJ_04_letszam_q4';
v_out_table_04(8):= 'W_LCAJ_04_ora_q4';

v_in_table_01(1) := 'W_LCAJ_01_letszam';
v_in_table_01(2) := 'W_LCAJ_01_ora';
v_in_table_01(3) := 'W_LCAJ_01_letszam';
v_in_table_01(4) := 'W_LCAJ_01_ora';
v_in_table_01(5) := 'W_LCAJ_01_letszam';
v_in_table_01(6) := 'W_LCAJ_01_ora';
v_in_table_01(7) := 'W_LCAJ_01_letszam';
v_in_table_01(8) := 'W_LCAJ_01_ora';

v_in_table_02(1) := 'W_LCAJ_02_letszam';
v_in_table_02(2) := 'W_LCAJ_02_ora';
v_in_table_02(3) := 'W_LCAJ_02_letszam';
v_in_table_02(4) := 'W_LCAJ_02_ora';
v_in_table_02(5) := 'W_LCAJ_02_letszam';
v_in_table_02(6) := 'W_LCAJ_02_ora';
v_in_table_02(7) := 'W_LCAJ_02_letszam';
v_in_table_02(8) := 'W_LCAJ_02_ora';

v_in_table_03(1) := 'W_LCAJ_03_letszam';
v_in_table_03(2) := 'W_LCAJ_03_ora';
v_in_table_03(3) := 'W_LCAJ_03_letszam';
v_in_table_03(4) := 'W_LCAJ_03_ora';
v_in_table_03(5) := 'W_LCAJ_03_letszam';
v_in_table_03(6) := 'W_LCAJ_03_ora';
v_in_table_03(7) := 'W_LCAJ_03_letszam';
v_in_table_03(8) := 'W_LCAJ_03_ora';

V_LCAJ_TABLES(1) := 'LCAJ581_q2';
V_LCAJ_TABLES(2) := 'LCAJ581_q3';
V_LCAJ_TABLES(3) := 'LCAJ581_q4';
V_LCAJ_TABLES(4) := 'LCAJ582_q2';
V_LCAJ_TABLES(5) := 'LCAJ582_q3';
V_LCAJ_TABLES(6) := 'LCAJ582_q4';
V_LCAJ_TABLES(7) := 'LCAJ583_q2';
V_LCAJ_TABLES(8) := 'LCAJ583_q3';
V_LCAJ_TABLES(9) := 'LCAJ583_q4';
V_LCAJ_TABLES(10) := 'LCAJ584_q1';
V_LCAJ_TABLES(11) := 'LCAJ584_q2';
V_LCAJ_TABLES(12) := 'LCAJ584_q3';
V_LCAJ_TABLES(13) := 'LCAJ584_q4';
V_LCAJ_TABLES(14) := 'LCAJ585_q1';
V_LCAJ_TABLES(15) := 'LCAJ585_q2';
V_LCAJ_TABLES(16) := 'LCAJ585_q3';
V_LCAJ_TABLES(17) := 'LCAJ585_q4';
V_LCAJ_TABLES(18) := 'LCAJ586_q1';
V_LCAJ_TABLES(19) := 'LCAJ586_q2';
V_LCAJ_TABLES(20) := 'LCAJ586_q3';
V_LCAJ_TABLES(21) := 'LCAJ586_q4';

V_LCAJ_TABLES_a(1) := 'LCAJ581';
V_LCAJ_TABLES_a(2) := 'LCAJ581';
V_LCAJ_TABLES_a(3) := 'LCAJ581';
V_LCAJ_TABLES_a(4) := 'LCAJ582';
V_LCAJ_TABLES_a(5) := 'LCAJ582';
V_LCAJ_TABLES_a(6) := 'LCAJ582';
V_LCAJ_TABLES_a(7) := 'LCAJ583';
V_LCAJ_TABLES_a(8) := 'LCAJ583';
V_LCAJ_TABLES_a(9) := 'LCAJ583';
V_LCAJ_TABLES_a(10) := 'LCAJ581';
V_LCAJ_TABLES_a(11) := 'LCAJ581';
V_LCAJ_TABLES_a(12) := 'LCAJ581';
V_LCAJ_TABLES_a(13) := 'LCAJ581';
V_LCAJ_TABLES_a(14) := 'LCAJ582';
V_LCAJ_TABLES_a(15) := 'LCAJ582';
V_LCAJ_TABLES_a(16) := 'LCAJ582';
V_LCAJ_TABLES_a(17) := 'LCAJ582';
V_LCAJ_TABLES_a(18) := 'LCAJ583';
V_LCAJ_TABLES_a(19) := 'LCAJ583';
V_LCAJ_TABLES_a(20) := 'LCAJ583';
V_LCAJ_TABLES_a(21) := 'LCAJ583';

V_LCAJ_INPUT_LTSZ(1) := 'W_LCAJ_04_letszam_q2';
V_LCAJ_INPUT_LTSZ(2) := 'W_LCAJ_04_letszam_q3';
V_LCAJ_INPUT_LTSZ(3) := 'W_LCAJ_04_letszam_q4';
V_LCAJ_INPUT_LTSZ(4) := 'W_LCAJ_04_letszam_q2';
V_LCAJ_INPUT_LTSZ(5) := 'W_LCAJ_04_letszam_q3';
V_LCAJ_INPUT_LTSZ(6) := 'W_LCAJ_04_letszam_q4';
V_LCAJ_INPUT_LTSZ(7) := 'W_LCAJ_04_letszam_q2';
V_LCAJ_INPUT_LTSZ(8) := 'W_LCAJ_04_letszam_q3';
V_LCAJ_INPUT_LTSZ(9) := 'W_LCAJ_04_letszam_q4';
V_LCAJ_INPUT_LTSZ(10) := 'W_LCAJ_04_ora_q1';
V_LCAJ_INPUT_LTSZ(11) := 'W_LCAJ_04_ora_q2';
V_LCAJ_INPUT_LTSZ(12) := 'W_LCAJ_04_ora_q3';
V_LCAJ_INPUT_LTSZ(13) := 'W_LCAJ_04_ora_q4';
V_LCAJ_INPUT_LTSZ(14) := 'W_LCAJ_04_ora_q1';
V_LCAJ_INPUT_LTSZ(15) := 'W_LCAJ_04_ora_q2';
V_LCAJ_INPUT_LTSZ(16) := 'W_LCAJ_04_ora_q3';
V_LCAJ_INPUT_LTSZ(17) := 'W_LCAJ_04_ora_q4';
V_LCAJ_INPUT_LTSZ(18) := 'W_LCAJ_04_ora_q1';
V_LCAJ_INPUT_LTSZ(19) := 'W_LCAJ_04_ora_q2';
V_LCAJ_INPUT_LTSZ(20) := 'W_LCAJ_04_ora_q3';
V_LCAJ_INPUT_LTSZ(21) := 'W_LCAJ_04_ora_q4';


-- szükséges számolások
-- összesen
v_create_lcaj_01_LCAJ581(1):= '(SUM(LCAJ105 - LCAJ098) / 3 )';
v_create_lcaj_01_LCAJ581(2):= '(SUM(LCAJ075 + LCAJ086 + LCAJ106) / 1000 )';

-- közfoglalkoztatottak
v_create_lcaj_01_LCAJ582(1):= '(SUM(LCAJ131 + LCAJ135 + LCAJ152 + LCAJ156) / 3 )';
v_create_lcaj_01_LCAJ582(2):= '(SUM(LCAJ160) / 1000 )';

-- közfoglalkoztatottak nélkül
v_create_lcaj_01_kozf_n(1):= '((SUM(LCAJ105 - LCAJ098) / 3) - (SUM(LCAJ131 + LCAJ135 + LCAJ152 + LCAJ156) / 3 ))';
v_create_lcaj_01_kozf_n(2):= '((SUM(LCAJ075 + LCAJ086 + LCAJ106) / 1000 ) - (SUM(LCAJ160) / 1000 ))';
			
-- negyedév hónapjai
V_HONAP(1):= '(''01'', ''02'', ''03'')';
V_HONAP(2):= '(''04'', ''05'', ''06'')';
V_HONAP(3):= '(''07'', ''08'', ''09'')';
V_HONAP(4):= '(''10'', ''11'', ''12'')';

-- negyedévek
V_MHO(1):= '03';
V_MHO(2):= '06';
V_MHO(3):= '09';
V_MHO(4):= '12';

-- negyedévek outputra
V_MHO_OUT(1):= '03';
V_MHO_OUT(2):= '03';
V_MHO_OUT(3):= '06';
V_MHO_OUT(4):= '06';
V_MHO_OUT(5):= '09';
V_MHO_OUT(6):= '09';
V_MHO_OUT(7):= '12';
V_MHO_OUT(8):= '12';

-- TEAOR kódok
V_TEAOR(1):= '01';
V_TEAOR(2):= '02';
V_TEAOR(3):= '03';
V_TEAOR(4):= '05';
V_TEAOR(5):= '06';
V_TEAOR(6):= '07';
V_TEAOR(7):= '08';
V_TEAOR(8):= '09';
V_TEAOR(9):= '10';
V_TEAOR(10):= '11';
V_TEAOR(11):= '12';
V_TEAOR(12):= '13';
V_TEAOR(13):= '14';
V_TEAOR(14):= '15';
V_TEAOR(15):= '16';
V_TEAOR(16):= '17';
V_TEAOR(17):= '18';
V_TEAOR(18):= '19';
V_TEAOR(19):= '20';
V_TEAOR(20):= '21';
V_TEAOR(21):= '22';
V_TEAOR(22):= '23';
V_TEAOR(23):= '24';
V_TEAOR(24):= '25';
V_TEAOR(25):= '26';
V_TEAOR(26):= '27';
V_TEAOR(27):= '28';
V_TEAOR(28):= '29';
V_TEAOR(29):= '30';
V_TEAOR(30):= '31';
V_TEAOR(31):= '32';
V_TEAOR(32):= '33';
V_TEAOR(33):= '35';
V_TEAOR(34):= '36';
V_TEAOR(35):= '37';
V_TEAOR(36):= '38';
V_TEAOR(37):= '39';
V_TEAOR(38):= '41';
V_TEAOR(39):= '42';
V_TEAOR(40):= '43';
V_TEAOR(41):= '45';
V_TEAOR(42):= '46';
V_TEAOR(43):= '47';
V_TEAOR(44):= '49';
V_TEAOR(45):= '50';
V_TEAOR(46):= '51';
V_TEAOR(47):= '52';
V_TEAOR(48):= '53';
V_TEAOR(49):= '55';
V_TEAOR(50):= '56';
V_TEAOR(51):= '58';
V_TEAOR(52):= '59';
V_TEAOR(53):= '60';
V_TEAOR(54):= '61';
V_TEAOR(55):= '62';
V_TEAOR(56):= '63';
V_TEAOR(57):= '64';
V_TEAOR(58):= '65';
V_TEAOR(59):= '66';
V_TEAOR(60):= '68';
V_TEAOR(61):= '69';
V_TEAOR(62):= '70';
V_TEAOR(63):= '71';
V_TEAOR(64):= '72';
V_TEAOR(65):= '73';
V_TEAOR(66):= '74';
V_TEAOR(67):= '75';
V_TEAOR(68):= '77';
V_TEAOR(69):= '78';
V_TEAOR(70):= '79';
V_TEAOR(71):= '80';
V_TEAOR(72):= '81';
V_TEAOR(73):= '82';
V_TEAOR(74):= '84';
V_TEAOR(75):= '85';
V_TEAOR(76):= '86';
V_TEAOR(77):= '87';
V_TEAOR(78):= '88';
V_TEAOR(79):= '90';
V_TEAOR(80):= '91';
V_TEAOR(81):= '92';
V_TEAOR(82):= '93';
V_TEAOR(83):= '94';
V_TEAOR(84):= '95';
V_TEAOR(85):= '96';
V_TEAOR(86):= '97';
V_TEAOR(87):= '99';
V_TEAOR(88):= '999';


-- TEAOR kódok, amiket beolvasunk
V_M0581(1):= '(''01%'')';
V_M0581(2):= '(''02%'')';
V_M0581(3):= '(''03%'')';
V_M0581(4):= '(''05%'')';
V_M0581(5):= '(''06%'')';
V_M0581(6):= '(''07%'')';
V_M0581(7):= '(''08%'')';
V_M0581(8):= '(''09%'')';
V_M0581(9):= '(''10%'')';
V_M0581(10):= '(''11%'')';
V_M0581(11):= '(''12%'')';
V_M0581(12):= '(''13%'')';
V_M0581(13):= '(''14%'')';
V_M0581(14):= '(''15%'')';
V_M0581(15):= '(''16%'')';
V_M0581(16):= '(''17%'')';
V_M0581(17):= '(''18%'')';
V_M0581(18):= '(''19%'')';
V_M0581(19):= '(''20%'')';
V_M0581(20):= '(''21%'')';
V_M0581(21):= '(''22%'')';
V_M0581(22):= '(''23%'')';
V_M0581(23):= '(''24%'')';
V_M0581(24):= '(''25%'')';
V_M0581(25):= '(''26%'')';
V_M0581(26):= '(''27%'')';
V_M0581(27):= '(''28%'')';
V_M0581(28):= '(''29%'')';
V_M0581(29):= '(''30%'')';
V_M0581(30):= '(''31%'')';
V_M0581(31):= '(''32%'')';
V_M0581(32):= '(''33%'')';
V_M0581(33):= '(''35%'')';
V_M0581(34):= '(''36%'')';
V_M0581(35):= '(''37%'')';
V_M0581(36):= '(''38%'')';
V_M0581(37):= '(''39%'')';
V_M0581(38):= '(''41%'')';
V_M0581(39):= '(''42%'')';
V_M0581(40):= '(''43%'')';
V_M0581(41):= '(''45%'')';
V_M0581(42):= '(''46%'')';
V_M0581(43):= '(''47%'')';
V_M0581(44):= '(''49%'')';
V_M0581(45):= '(''50%'')';
V_M0581(46):= '(''51%'')';
V_M0581(47):= '(''52%'')';
V_M0581(48):= '(''53%'')';
V_M0581(49):= '(''55%'')';
V_M0581(50):= '(''56%'')';
V_M0581(51):= '(''58%'')';
V_M0581(52):= '(''59%'')';
V_M0581(53):= '(''60%'')';
V_M0581(54):= '(''61%'')';
V_M0581(55):= '(''62%'')';
V_M0581(56):= '(''63%'')';
V_M0581(57):= '(''64%'')';
V_M0581(58):= '(''65%'')';
V_M0581(59):= '(''66%'')';
V_M0581(60):= '(''68%'')';
V_M0581(61):= '(''69%'')';
V_M0581(62):= '(''70%'')';
V_M0581(63):= '(''71%'')';
V_M0581(64):= '(''72%'')';
V_M0581(65):= '(''73%'')';
V_M0581(66):= '(''74%'')';
V_M0581(67):= '(''75%'')';
V_M0581(68):= '(''77%'')';
V_M0581(69):= '(''78%'')';
V_M0581(70):= '(''79%'')';
V_M0581(71):= '(''80%'')';
V_M0581(72):= '(''81%'')';
V_M0581(73):= '(''82%'')';
V_M0581(74):= '(''84%'')';
V_M0581(75):= '(''85%'')';
V_M0581(76):= '(''86%'')';
V_M0581(77):= '(''87%'')';
V_M0581(78):= '(''88%'')';
V_M0581(79):= '(''90%'')';
V_M0581(80):= '(''91%'')';
V_M0581(81):= '(''92%'')';
V_M0581(82):= '(''93%'')';
V_M0581(83):= '(''94%'')';
V_M0581(84):= '(''95%'')';
V_M0581(85):= '(''96%'')';
V_M0581(86):= '(''97%'')';
V_M0581(87):= '(''99%'')';
V_M0581(88):= '(''999%'')';


-- sum részhez

-- angol TEAOR
V_ENG_LIST(1):= 'V';
V_ENG_LIST(2):= 'VA';
V_ENG_LIST(3):= 'VB_E';
V_ENG_LIST(4):= 'VC';
V_ENG_LIST(5):= 'VF';
V_ENG_LIST(6):= 'VG_I';
V_ENG_LIST(7):= 'VJ';
V_ENG_LIST(8):= 'VK';
V_ENG_LIST(9):= 'VL';
V_ENG_LIST(10):= 'VM_N';
V_ENG_LIST(11):= 'VO_Q';
V_ENG_LIST(12):= 'VR_U';

-- angol TEAOR szövegek
V_ENG_MEGNEV(1):= 'Összesen';
V_ENG_MEGNEV(2):= 'Agriculture, forestry and fishing';
V_ENG_MEGNEV(3):= 'Industry including energy';
V_ENG_MEGNEV(4):= 'of which: Manufacturing';
V_ENG_MEGNEV(5):= 'Construction';
V_ENG_MEGNEV(6):= 'Wholesale and retail trade';
V_ENG_MEGNEV(7):= 'Information and communication';
V_ENG_MEGNEV(8):= 'Financial and insurance activities';
V_ENG_MEGNEV(9):= 'Real estate activities';
V_ENG_MEGNEV(10):= 'Professional, scientific and technical activities, administrative and support service activities';
V_ENG_MEGNEV(11):= 'Public administration and defence, compulsory social security; education, human health and social work activities';
V_ENG_MEGNEV(12):= 'Arts, entertainment, repair of household goods and other services';


-- angol SUM számoláshoz szükséges TEAOR kódok
V_OSSZEG(1):= '(''01'', ''02'', ''03'', ''05'', ''06'', ''07'', ''08'', ''09'', ''10'', ''11'', ''12'', ''13'', ''14'', ''15'', ''16'', ''17'', ''18'', ''19'', ''20'', ''21'', ''22'', ''23'', ''24'', ''25'', ''26'', ''27'', ''28'', ''29'', ''30'', ''31'', ''32'', ''33'', ''35'', ''36'', ''37'', ''38'', ''39'', ''41'', ''42'', ''43'', ''45'', ''46'', ''47'', ''49'', ''50'', ''51'', ''52'', ''53'', ''55'', ''56'', ''58'', ''59'', ''60'', ''61'', ''62'', ''63'', ''64'', ''65'', ''66'', ''68'', ''69'', ''70'', ''71'', ''72'', ''73'', ''74'', ''75'', ''77'', ''78'', ''79'', ''80'', ''81'', ''82'', ''84'', ''85'', ''86'', ''87'', ''88'', ''90'', ''91'', ''92'', ''93'', ''94'', ''95'', ''96'', ''97'', ''99'')';
V_OSSZEG(2):= '(''01'', ''02'', ''03'')';
V_OSSZEG(3):= '(''05'', ''06'', ''07'', ''08'', ''09'', ''10'', ''11'', ''12'', ''13'', ''14'', ''15'', ''16'', ''17'', ''18'', ''19'', ''20'', ''21'', ''22'', ''23'', ''24'', ''25'', ''26'', ''27'', ''28'', ''29'', ''30'', ''31'', ''32'', ''33'', ''35'', ''36'', ''37'', ''38'', ''39'')';
V_OSSZEG(4):=  '(''10'', ''11'', ''12'', ''13'', ''14'', ''15'', ''16'', ''17'', ''18'', ''19'', ''20'', ''21'', ''22'', ''23'', ''24'', ''25'', ''26'', ''27'', ''28'', ''29'', ''30'', ''31'', ''32'', ''33'')';
V_OSSZEG(5):=  '(''41'', ''42'', ''43'')';
V_OSSZEG(6):=  '(''45'', ''46'', ''47'', ''49'', ''50'', ''51'', ''52'', ''53'', ''55'', ''56'')';
V_OSSZEG(7):=  '(''58'', ''59'', ''60'', ''61'', ''62'', ''63'')';
V_OSSZEG(8):=  '(''64'', ''65'', ''66'')';
V_OSSZEG(9):=  '(''68'')';
V_OSSZEG(10):= '(''69'', ''70'', ''71'', ''72'', ''73'', ''74'', ''75'', ''77'', ''78'', ''79'', ''80'', ''81'', ''82'')';
V_OSSZEG(11):= '(''84'', ''85'', ''86'', ''87'', ''88'')';
V_OSSZEG(12):= '(''90'', ''91'', ''92'', ''93'', ''94'', ''95'', ''96'', ''97'', ''99'')';


-- magyar SUM TEAOR kódok
V_HUN_LIST(1):= 'A';
V_HUN_LIST(2):= 'B';
V_HUN_LIST(3):= 'C';
V_HUN_LIST(4):= 'D';
V_HUN_LIST(5):= 'E';
V_HUN_LIST(6):= 'F';
V_HUN_LIST(7):= 'G';
V_HUN_LIST(8):= 'H';
V_HUN_LIST(9):= 'I';
V_HUN_LIST(10):= 'J';
V_HUN_LIST(11):= 'K';
V_HUN_LIST(12):= 'L';
V_HUN_LIST(13):= 'M';
V_HUN_LIST(14):= 'N';
V_HUN_LIST(15):= 'O';
V_HUN_LIST(16):= 'P';
V_HUN_LIST(17):= 'Q=';
V_HUN_LIST(18):= 'R';
V_HUN_LIST(19):= 'S';
V_HUN_LIST(20):= 'T';
V_HUN_LIST(21):= 'U';
V_HUN_LIST(22):= 'U_SUM';


-- magyar SUM számoláshoz szükséges TEAOR kódok
V_HUN_OSSZEG(1):= '(''01'', ''02'', ''03'')';
V_HUN_OSSZEG(2):= '(''05'', ''06'', ''07'', ''08'', ''09'')';
V_HUN_OSSZEG(3):= '(''10'', ''11'', ''12'', ''13'', ''14'', ''15'', ''16'', ''17'', ''18'', ''19'', ''20'', ''21'', ''22'', ''23'', ''24'', ''25'', ''26'', ''27'', ''28'', ''29'', ''30'', ''31'', ''32'', ''33'')';
V_HUN_OSSZEG(4):= '(''35'')';
V_HUN_OSSZEG(5):= '(''36'', ''37'', ''38'', ''39'')';
V_HUN_OSSZEG(6):= '(''41'', ''42'', ''43'')';
V_HUN_OSSZEG(7):= '(''45'', ''46'', ''47'')';
V_HUN_OSSZEG(8):= '(''49'', ''50'', ''51'', ''52'', ''53'')';
V_HUN_OSSZEG(9):= '(''55'', ''56'')';
V_HUN_OSSZEG(10):= '(''58'', ''59'', ''60'', ''61'', ''62'', ''63'')';
V_HUN_OSSZEG(11):= '(''64'', ''65'', ''66'')';
V_HUN_OSSZEG(12):= '(''68'')';
V_HUN_OSSZEG(13):= '(''69'', ''70'', ''71'', ''72'', ''73'', ''74'', ''75'')';
V_HUN_OSSZEG(14):= '(''77'', ''78'', ''79'', ''80'', ''81'', ''82'')';
V_HUN_OSSZEG(15):= '(''84'')';
V_HUN_OSSZEG(16):= '(''85'')';
V_HUN_OSSZEG(17):= '(''86'', ''87'', ''88'')';
V_HUN_OSSZEG(18):= '(''90'', ''91'', ''92'', ''93'')';
V_HUN_OSSZEG(19):= '(''94'', ''95'', ''96'')';
V_HUN_OSSZEG(20):= '(''97'')';
V_HUN_OSSZEG(21):= '(''99'')';
V_HUN_OSSZEG(22):= '(''01'', ''02'', ''03'', ''05'', ''06'', ''07'', ''08'', ''09'', ''10'', ''11'', ''12'', ''13'', ''14'', ''15'', ''16'', ''17'', ''18'', ''19'', ''20'', ''21'', ''22'', ''23'', ''24'', ''25'', ''26'', ''27'', ''28'', ''29'', ''30'', ''31'', ''32'', ''33'', ''35'', ''36'', ''37'', ''38'', ''39'', ''41'', ''42'', ''43'', ''45'', ''46'', ''47'', ''49'', ''50'', ''51'', ''52'', ''53'', ''55'', ''56'', ''58'', ''59'', ''60'', ''61'', ''62'', ''63'', ''64'', ''65'', ''66'', ''68'', ''69'', ''70'', ''71'', ''72'', ''73'', ''74'', ''75'', ''77'', ''78'', ''79'', ''80'', ''81'', ''82'', ''84'', ''85'', ''86'', ''87'', ''88'', ''90'', ''91'', ''92'', ''93'', ''94'', ''95'', ''96'', ''97'', ''99'')';


END LCAJ;


-- futtatáshoz script:
/*
begin
LCAJ.ins_LCAJ_letszam('2017');
end;*/