@ECHO OFF
SETLOCAL ENABLEEXTENSIONS	
	:: SET THE BLENDER CUSTOM PREFERENCES ::
	:: This script will run blender so you can choose your preferred settings in the quick setup window. Once terminated the quick setup, quit (!!!) blender, so to let the script continue and set automatically the custom paths in the preferences.
		CMD /C ""%_pathPrgm%\blender.exe" & "%_pathPrgm%\blender.exe" -b -P "%_pathLib%\set_prefs.py""	
	