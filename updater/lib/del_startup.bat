@ECHO OFF
SETLOCAL ENABLEEXTENSIONS	
	:: Check if already exists a startup file and ask to keep/delete it
		REM :del_startup
		IF EXIST "%_pathPrgm%\2.80\config\startup.blend" (
		Del /Q "%_pathPrgm%\2.80\config\startup.blend"
		ECHO Previous startup.blend deleted
		EXIT /B
		) ELSE (
		ECHO No previous startup.blend found
		EXIT /B
		)