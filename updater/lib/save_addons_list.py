#---------------DEFINE PATHS VARIABLES--------------------

import sys
import os
import bpy
from bpy import context
import csv

# Note: when sys.argv[0] is passed trough blender command line
# it refers to blender.exe path e.g. ..\Blender_2.80sync\program\blender.exe
# print ('sys.argv[0] =', sys.argv[0])
# Set path to the main folder (the folder containing the program and updater folders)
pathMain = os.path.abspath(os.path.join(os.path.dirname(sys.argv[0]), '..'))
#print ('pathMain =', pathMain)
# Set path to program folder
pathPrgm = os.path.join(pathMain, "program")
#print ('pathPrgm =', pathPrgm)
# Set path to updater folder
pathUpdr = os.path.join(pathMain, "updater")
#print ('pathUpdr =', pathUpdr)
# Set path to lib folder
pathLib = os.path.join(pathUpdr, "lib")
#print ('pathLib =', pathLib)

# ---------------SAVE A LIST OF ENABLED ADDONS--------------------

bl_cwd = os.getcwd()
# print (bl_cwd)
addons_list = (bpy.context.preferences.addons.keys())
os.chdir(pathLib)
outputFile = open('addons_list.csv', 'w', newline='')
outputWriter = csv.writer(outputFile)
outputWriter.writerow(addons_list)
outputFile.close()
os.chdir(bl_cwd)
# _cwd = os.getcwd()
# print (_cwd) 
# use_quit_dialog(false)
# bpy.ops.wm.sysinfo()
bpy.ops.wm.quit_blender()

   
