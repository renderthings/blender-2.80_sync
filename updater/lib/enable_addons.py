#---------------DEFINE PATHS VARIABLES--------------------

import sys, os

# Note: when sys.argv[0] is passed trough blender command line
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
# Set path to lib folder
pathLib = os.path.join(pathUpdr, "lib")
#print ('pathLib =', pathLib)

# ---------------ENABLE THE ADDONS IN THE LIST--------------------
import bpy
import csv

bl_cwd = os.getcwd()
#print (bl_cwd)
os.chdir(pathLib)
with open('addons_list.csv', newline='') as csvfile:
    csvreader = list(csv.reader(csvfile, delimiter=','))   
    for i in (csvreader[0]):
        bpy.ops.wm.addon_enable(module=i) #disable #enable
bpy.ops.wm.save_userpref()
