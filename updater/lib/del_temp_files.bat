@ECHO OFF
SETLOCAL ENABLEEXTENSIONS	
	:::: DELETE THE TEMP FOLDER ::::
		robocopy "%_pathLib%" "%_temp%" /PURGE /NOCOPY /NFL /NDL
		REM RD /s /q %_temp%
		
		