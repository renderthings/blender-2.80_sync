 @ECHO OFF
SETLOCAL ENABLEEXTENSIONS	

:::::::::::::::::::::::: SET VARIABLES :::::::::::::::::::::::::::::::::::::::
	:: Set path to the main folder (the folder containing the updater and p folders)
	:: e.g. D:\..\2.80 sync; please note that %~dp0 means the batch script path, e.g. D:\..\updater\
		CD /d "%~dp0" 
		pushd ..
		FOR /F "delims=" %%G IN ('echo %cd%') DO set _pathMain=%%G
		popd
		REM echo %_pathMain%
	:: Set path to program folder
		set _pathPrgm=%_pathMain%\program
		REM echo program folder path = %_pathPrgm%
	:: Set path to updater folder
		set _pathUpdr=%_pathMain%\updater
		REM echo updater folder path = %_pathUpdr%
	:: Set path to lib folder
		set _pathLib=%_pathUpdr%\lib
		REM echo lib folder path = %_pathLib%		
	:: SET THE BLENDER CUSTOM PREFERENCES ::
	:: This script will add the custom paths in the preferences.
		CMD /C ""%_pathPrgm%\blender.exe" -b -P "%_pathLib%\set_prefs.py"" 
		CMD /C  ""%_pathPrgm%\blender.exe"
	