@ECHO OFF
SETLOCAL ENABLEEXTENSIONS



::::::::::::::::::::::::: BEGIN GPL LICENSE BLOCK ::::::::::::::::::::::::::::
::																			::
::  This program is free software; you can redistribute it and/or			::
::  modify it under the terms of the GNU General Public License				::
::  as published by the Free Software Foundation; either version 2			::	
::  of the License, or (at your option) any later version.					::
::																			::
::  This program is distributed in the hope that it will be useful,			::
::  but WITHOUT ANY WARRANTY; without even the implied warranty of			::	
::  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the			::	
::  GNU General Public License for more details.							::
:: 																			::
::  You should have received a copy of the GNU General Public License		::
::  along with this program; if not, write to the Free Software Foundation, ::
::  Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.		::
::																			::
:::::::::::::::::::::::: END GPL LICENSE BLOCK :::::::::::::::::::::::::::::::



::::::::::::::::::::::::::::::: INFO :::::::::::::::::::::::::::::::::::::::::
		set _Name=blender-2.80_sync
		set _Purpose=Keep a blender 2.80 portable installation updated!
		set _Author=Ciro Vendrame 
		set _Version=1.0
		set _Revision=March 2019 - initial version		
		ECHO.
		ECHO  -------------- %_Name% -------------------
		ECHO.
		ECHO  Version  = %_Version% 
		ECHO  Revision = %_Revision% 
		ECHO.
		ECHO.-----------------------------------------------------
		ECHO.
				
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
	:: Set path to updater temp folder
		set _temp=%_pathUpdr%\temp
		REM echo updater temp folder path = %_temp%
	:: Set path to personal addons folder e.g. ..\program\2.80\scripts\addons_personal\addons
		set _pathAddonsPers=%_pathPrgm%\2.80\scripts\addons_personal\addons
		REM echo personal addons folder path = %_pathAddonsPers%
	:: Set the zip dropped onto this script as a variable to pass to the subroutines
		set _newBlender=%~dpn1.zip
	:: Set the unzip program 
		set _unzip=C:\Program Files\7-Zip\7z.exe & REM modify this line for the 7z.exe "portable" version

:::::::::::::::::::::::: PRELIMINARY OPERATION :::::::::::::::::::::::: 
	
	:: Check if already exists a temp folder and delete it
		IF EXIST "%_temp%" (
		rd /s /q "%_temp%"
		)
	
	:: Check if already exists a previous blender installation and
	:: call the associated subroutine	
		IF NOT EXIST "%_pathPrgm%\blender.exe" (
		GOTO install
		)

		IF EXIST "%_pathPrgm%\blender.exe" (
		GOTO update
		)		
		
	:install
	:: Ask if you want to install 
		ECHO Previous installation was NOT found
		ECHO Do you want to INSTALL blender 2.80 (portable) ?
		ECHO Press a key to continue or close the console to exit
		PAUSE >nul
		CALL :INSTALL_0
		
	:update
	:: Ask if you want to update
		ECHO Previous installation was FOUND
		ECHO Do you want to UPDATE blender 2.80?
		ECHO Press a key to continue or close the console to exit
		PAUSE >nul
		ECHO DELETE user preferences and startup file?		
		CHOICE /C YN /N /M "Press [Y] to delete or [N] to keep"
		IF %ERRORLEVEL% EQU 1 CALL :INSTALL_1-A		
		IF %ERRORLEVEL% EQU 2 CALL :INSTALL_1-B
	
::::::::::::::::::::::::: ERROR HANDLERS ::::::::::::::::::::::::::::::: 		
				
		:sub_error_check
		if %errorlevel% EQU 0 (
		Echo All done!
		ECHO.
		ECHO Press a key to exit
		PAUSE >nul	
		EXIT
		) ELSE (
		ECHO A subroutine error was found, look at the sub_log.txt
		ECHO Press a key to exit
		PAUSE >nul	
		EXIT 
		)
		
		:sub_error_R_check
		IF %ERRORLEVEL% LSS 8 (
		Echo All done!
		ECHO.
		ECHO Press a key to exit
		PAUSE >nul	
		EXIT
		) ELSE (
		ECHO A subroutine error was found, look at the sub_log.txt
		ECHO Press a key to exit
		PAUSE >nul	
		EXIT 
		)
						
		:error_handler
		IF %ERRORLEVEL% EQU 0 (
		ECHO No fatal errors
		EXIT /B
		) ELSE (
		ECHO Exit code =  %ERRORLEVEL%		
		ECHO Something failed
		ECHO Press a key to exit
		PAUSE >nul
		EXIT
		)	
		
		:error_R_handler
		IF %ERRORLEVEL% LSS 8 (
		ECHO No fatal errors 
		EXIT /B
		) ELSE (
		ECHO Exit code =  %ERRORLEVEL%		
		ECHO Something failed
		ECHO Press a key to exit
		PAUSE >nul	
		EXIT
		)
	
:::::::::::::::::::::::: INSTALL_0  :::::::::::::::::::::::: 
::::::::::::::::::(no previous blender installation)::::::::	
	
		:INSTALL_0		
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Extracting the new blender build
		CALL "%_pathLib%\unzip.bat" > "%_pathUpdr%\sub_log.txt" 
		CALL :error_handler
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Adding custom directories
		CALL "%_pathLib%\add_dirs.bat" >> "%_pathUpdr%\sub_log.txt"
		CALL :error_handler
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Copying (mirroring) new files
		CALL "%_pathLib%\robocopy1.bat" >> "%_pathUpdr%\sub_log.txt"
		CALL :error_R_handler
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Deleting temp files
		CALL "%_pathLib%\del_temp_files.bat" >> "%_pathUpdr%\sub_log.txt"
		CALL :error_R_handler 
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Setting preferences 
		CALL "%_pathLib%\set_prefs.bat" >> "%_pathUpdr%\sub_log.txt"
		CALL :error_handler 		
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		CALL :sub_error_check 
	
:::::::::::::::::::::::: INSTALL_1-A ::::::::::::::::::::::::::::::::::::::::::::::
::(previous blender installation was found + deleting userpref and startup file):::

		:INSTALL_1-A
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Saving the enabled addons list
		CALL "%_pathLib%\save_addons_list.bat" > "%_pathUpdr%\sub_log.txt" 
		CALL :error_handler 
		REM PAUSE
  		ECHO.			
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Deleting userpref.blender
		CALL "%_pathLib%\del_userpref.bat" >> "%_pathUpdr%\sub_log.txt" 
		CALL :error_handler
		REM PAUSE
  		ECHO.		
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Deleting startup.blender
		CALL "%_pathLib%\del_startup.bat" >> "%_pathUpdr%\sub_log.txt" 
		CALL :error_handler
		REM PAUSE
  		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Deleting addons_personal pychache
		CALL "%_pathLib%\del_pycache.bat" >> "%_pathUpdr%\sub_log.txt" 
		CALL :error_handler
		REM PAUSE
  		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Extracting the new blender build
		CALL "%_pathLib%\unzip.bat" >> "%_pathUpdr%\sub_log.txt" 
		CALL :error_handler
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Adding custom directories
		CALL "%_pathLib%\add_dirs.bat" >> "%_pathUpdr%\sub_log.txt"
		CALL :error_handler
		ECHO.		
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Copying (mirroring) new files excluding custom directories
		CALL "%_pathLib%\robocopy2.bat" >> "%_pathUpdr%\sub_log.txt"
		CALL :error_R_handler
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Deleting temp files
		CALL "%_pathLib%\del_temp_files.bat" >> "%_pathUpdr%\sub_log.txt"
		CALL :error_R_handler 
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Setting preferences
		CALL "%_pathLib%\set_prefs.bat" >> "%_pathUpdr%\sub_log.txt"
		CALL :error_handler 			
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Enabling addons
		CALL "%_pathLib%\enable_addons.bat" >> "%_pathUpdr%\sub_log.txt"
		CALL :error_handler 
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		CALL :sub_error_check 
	
:::::::::::::::::::::::: INSTALL_1-B ::::::::::::::::::::::::::::::::::::::::::::
::(previous blender installation was found + keeping userpref and startup file)::	
	 	
		:INSTALL_1-B
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Deleting addons_personal pychache
		CALL "%_pathLib%\del_pycache.bat" > "%_pathUpdr%\sub_log.txt" 
		CALL :error_handler
  		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Extracting the new blender build
		CALL "%_pathLib%\unzip.bat" >> "%_pathUpdr%\sub_log.txt" 
		CALL :error_handler
		ECHO. 
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Adding custom directories
		CALL "%_pathLib%\add_dirs.bat" >> "%_pathUpdr%\sub_log.txt"
		CALL :error_handler
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Copying (mirroring) new files
		CALL "%_pathLib%\robocopy2.bat" >> "%_pathUpdr%\sub_log.txt"
		CALL :error_R_handler
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Deleting temp files
		CALL "%_pathLib%\del_temp_files.bat" >> "%_pathUpdr%\sub_log.txt"
		CALL :error_R_handler 
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		ECHO Adding preferences settings
		CALL "%_pathLib%\add_prefs.bat" >> "%_pathUpdr%\sub_log.txt"
		CALL :error_handler 			
		ECHO.
		ECHO 	/////////////////////////////////////////////////////////
		ECHO.
		CALL :sub_error_check 
	
	
	