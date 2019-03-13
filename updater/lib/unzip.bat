@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
:::: EXTRACT THE NEW 2.80 BUILD TO A TEMP FOLDER ::::	
		REM ECHO %CD%
		"%_unzip%" x "%_newBlender%" -o"%_temp%"
		
	