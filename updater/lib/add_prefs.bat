@ECHO OFF
SETLOCAL ENABLEEXTENSIONS	
	:: SET THE BLENDER CUSTOM PREFERENCES ::
	:: This script will add the custom paths in the preferences.
		CMD /C ""%_pathPrgm%\blender.exe" -b -P "%_pathLib%\set_prefs.py""	
	