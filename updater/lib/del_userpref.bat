@ECHO OFF
SETLOCAL ENABLEEXTENSIONS	
	:: Check if already exists a user preferences file and ask to keep/delete it
		REM :del_userpref
		IF EXIST "%_pathPrgm%\2.80\config\userpref.blend" (
		Del /Q "%_pathPrgm%\2.80\config\userpref.blend"
		ECHO Previouse userpref.blend deleted
		EXIT /B		
		) ELSE (
		ECHO No previous userpref.blend found
		EXIT /B)		