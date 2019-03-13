#---------------DEFINE PATHS VARIABLES--------------------

import sys, os

# Please note: when sys.argv[0] is passed trough blender command line
# it refers to blender.exe path e.g. ..\Blender_2.80sync\program\blender.exe
#print ('sys.argv[0] =', sys.argv[0])
# Set path to the main folder (the folder containing the program and updater folders)
pathMain = os.path.abspath(os.path.join(os.path.dirname(sys.argv[0]), '..'))
#print ('pathMain =', pathMain)
# Set path to program folder
pathPrgm = os.path.join(pathMain, "program")
#print ('pathPrgm =', pathPrgm)
# Set path to updater folder
pathUpdr = os.path.join(pathMain, "updater")
#print ('pathUpdr =', pathUpdr)

# ---------------DEFINE PREFERENCES SETTINGS--------------------

#import the Blender module
import bpy
from bpy import context
# Set blender temp folder path like: ..program\2.80\temp 
pathBlendTemp = os.path.abspath(os.path.join(pathPrgm, '2.80', 'temp'))
#print ('pathBlendTemp =', pathBlendTemp)
# Set blender addons_personal folder path like:..\program\2.80\scripts\addons_personal
pathAddonPers = os.path.abspath(os.path.join(pathPrgm, '2.80', 'scripts', 'addons_personal'))
#print ('pathAddonPers =', pathAddonPers)
#Insert pathBlendTemp and pathAddonPers in preferences settings
context.preferences.filepaths.temporary_directory = pathBlendTemp
context.preferences.filepaths.script_directory = pathAddonPers
bpy.ops.wm.save_userpref()
