--Tools...

/*

Profiler | Perfmon | QueryStore | XEvents | 
Aktivit�tsmonitor | DB Optimierungsratgeber | DMVs | Datensammler

*/

--Tool 1: --QueryStore.. 

-- zeitlich eingrenzbares Auffinden von schlecht performenden TSQL
-- L/S/Memory/CPU/Dauer usw..
-- grafische Reports, aber auch per TSQL Abfragbar

-- Abfragen werden gespeichert mit Messdaten und Pl�nen
-- dauerhaft (auch Neustart) 
-- pro DB zu aktivieren (ab SQL 2022 automatisch)
--

--Tool2: Perfmon-- grafisch -> Spitzenlast finden

-- jede Instanz besitzt ihre eig Messwerte (SQL 2022 ca 1900)
-- select * from sys.dm_os_performance_counters
-- besser etwas zu viel als zu weniog aufzeichnen
-- braucht wenig Ressourcen
-- grafische Analyse.. sehr detailiert auf Sekunde genau oder auch einmal pro Woche
--> aber keine Aussage �ber Ursache im SQL Code (wer wann wo was..)

-- Tool3: Profiler

-- Aufzeichnung von SQL Statements (auch Prozeduren oder Deadlockgrafiken)
-- unbedingt Filtern
-- SP Statement Completed (ST Proc)
-- auf "anderen" HDD speicher
-- Beendigungszeit vrogeben. 
-- Vorsicht: zeichnet sehr umfangreich auf.. --> Performance
--> evtl sparsam umgehen (Filter setzen)


-- TIPP
-- Perfmon und Profiler lassen sich �bereinander legen
-- geht allerdings nur im Profiler, wenn eine Aufzeichnug geladen wurde
--> Datei: Leistungsdaten importieren



--Tools.. Datenbankoptimierungsassistent
--Finden einer geeigneten IX Strategie



--Einstellungen: 

--Indizes und Indizierte Sichten
--Partitionierung oder Columnstore w�hlen
--Keine pyhs. Entwurfsstrukturen beibehalten
--Erweiterte Optionen
--Zeitlich beschr�nkt--> unter erweiterten Optionen. 
--Max Speicher Wert �bernehmen und anklicken
--Wenn m�glich Online



---Tool Perfmon und Profiler

--Daten des Perfmon k�nne in Profiler geladen werden
--Aufzeichnung neu �ffnen
--Datei--> Import der Perfmon Daten

--die Aufzeichnung des Profiler kann auch f�r den Datenbankoptimierungsratgeber verwendet werden.-- IX finden und L�schen auf der Basis eines typischen Workload
--(oder �ber QueryStore)

--Profiler unbedingt gut filtern, sonst zeichnen wir jede Aktion jedes users auf (auch Klicks im SSMS)
--TSQL Start und Completet

--Stored Procedures
--SP:RPC Completet und SP:StmtCompletet
--Messdaten: Dauer / CPU / Lesen / Reads / Apllication / Login / Textdata / Host /Dauer
--Filter: Kann nur erstellt werden, wenn auch die Soalte zu sehen ist.. 
--	zB: Databasename like 'northwind' , Login='Dom�ne\User', CPU > 1000ms




-- DMVs Systemsichten --

-- in jeder DB enthalten
-- jeder Bericht und jedes Tool besorgt sich die Daten �ber DMVs

--Wichtige DMVs in DiagnosticVew von Glenn Berry

--ein paar Wichtige
select * from sys.dm_db_index_physical_stats
	(DB_ID(),OBJECT_ID('ku1'),NULL,NULL,'detailed')

--forward_record_count d�rften nicht vorkommen
--wir m�ssen die Tabelle physikalisch neu ablegen
--CL IX L�sung

--Datamanagementviews 
-- Fragen an die DB :			select * from sys.dm_db...
-- Fragen an SQL Instanz : 		select * from sys.dm_os...

--Frag den SQL Server wo es weh tut
select * from sys.dm_os_wait_stats 

---QUERY--> Worker (untersucht Ressource)---------> Ress Parat|--->CPU|
--------------------------------------------------------------------->gesamt Wartezeit
															  |------->Signalzeit


              SUSPENDED  LCK_M_S                      RUNNABLE    RUNNING

--falls die Signalzeit > 25% w�re, dann CPU Engpass
--dumm ist nur.. die Werte werden addiert seit dem Neustart
--dumm ist auch: kein zeitlicher verlauf
		--> regelm wegschreiben
		-15 Uhr SOS 134  15:10 138  15:20 324

-- Aktivit�tsmonitor - Liveprobleme ---
em
--                                  sys.dm_db_ Datenbank


-- Datensammler..
-- kann die Arbeit abnehmen, DMV Daten manuell zeitlich zu erfassen
-- cool.. grafische Auswertung die sehr detailiert ist
-- Vorsicht auf Performance: Evtl Erfassungsintervalle anpassen


-- XVents
--.. Aufzeichung wie Profiler
-- mit verschiedenen M�glichkeiten (histogramm, Ring_buffer)
-- lightweight.. aber Auswertung im Vergleich mit Perfmon: no


--Freeware -- Gratis     
Diagnostic View Glenn Berry  (wichtige Systemsichen.. aufgeschl�sselt)

First Responderkit Brent Ozar (Sp_blitz..--- Indizes etc)

sp_blitzindex

SQL Sentry Plan Explorer  (Pl�ne besser verstehen IX Histogram Deadlocks)



Idera: SQL Check (Aktive Prozesse beobchten -- Sperren nachvollziehen)
Vorsicht.. kostet
Log_Scout (Sammlen von Daten)
SQL Nexus (Analyse)
PAL Sammlen von DAten und Analyse mit Bewertung)

















