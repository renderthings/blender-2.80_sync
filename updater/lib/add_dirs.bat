@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
:::: ADD CUSTOM DIRECTORIES TO THE EXTRACTED BLENDER FOLDER TREE ::::
	:: Set current directory to temp folder
		CD /d "%_temp%" 	
	:: Set the source as a variable pointing to the folder inside the extracted folder
	:: e.g. ...\blender-2.80-xxxxxxxxxxxx-win64\blender-2.80.0-git.xxxxxxxxxxxx-windows64
		for /d %%G in (blender-2.80.*) do set "_source=%%G"
	:: Add custom directories
	MD "%_source%\2.80\autosave" "%_source%\2.80\cache" "%_source%\2.80\config" "%_source%\2.80\scripts\addons_personal\addons" "%_source%\2.80\temp"
 