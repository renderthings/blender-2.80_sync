@ECHO OFF
SETLOCAL ENABLEEXTENSIONS	
	:: Save the enabled addon list
		CMD /C ""%_pathPrgm%\blender.exe" -b -P "%_pathLib%\save_addons_list.py""

