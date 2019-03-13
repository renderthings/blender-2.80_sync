@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
:::: COPY (mirroring) THE EXTRACTED FILES TO PROGRAM FOLDER ::::
	:: Set current directory to temp folder
		CD /d "%_temp%" 	
	:: Set the source as a variable pointing to the folder inside the extracted folder
	:: e.g. ...\blender-2.80-xxxxxxxxxxxx-win64\blender-2.80.0-git.xxxxxxxxxxxx-windows64
		for /d %%G in (blender-2.80.*) do set "_source=%%G"
	:: Set the destination
		set _dest=%_pathPrgm%
	:: Robocopy1: Mirror the directory tree of the _source to _dest adding a log file		
		REM :robocopy1
		ROBOCOPY "%_source%" "%_dest%" /MIR /NFL /NDL
		REM /LOG:"%_pathUpdr%\RoboLog.txt" /NFL /NDL	