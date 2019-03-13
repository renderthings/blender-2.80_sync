@ECHO OFF
SETLOCAL ENABLEEXTENSIONS	
	:: ENABLE THE ADDONS IN THE SAVED LIST
		IF EXIST "%_pathLib%\addons_list.csv" (
		CMD /C ""%_pathPrgm%\blender.exe" -b -P "%_pathLib%\enable_addons.py""
		EXIT /B
		) ELSE (
		EXIT /B
		)
		