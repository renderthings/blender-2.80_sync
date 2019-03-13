@ECHO OFF
SETLOCAL ENABLEEXTENSIONS	
	:: Check if already exist pycache folders in addons_personal folder 		
	:: and delete them all
		IF EXIST "%_pathAddonsPers%\__pycache__\*" (
		REM ECHO %CD%
		PUSHD "%_pathAddonsPers%"
		GOTO action
		) ELSE (
		ECHO No addons_personal pychache found
		EXIT /B
		)		
		:action
		FOR /D /r %%H in ("__pyca?he__") DO SET _cacheAddonsPers=%%H
		FOR /f "tokens=*" %%I in ('dir /b /s /a:d "__pycache__*"') DO RD /s /q "%%I"
		ECHO Addons_personal pychache deleted
		EXIT /B
		REM POPD
		
		
