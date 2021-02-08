#description     :This script generates all required files for each sample and run the CFD.
#author		 :Sumeet Lulekar, and Payam Ghassemi
#date            :Nov 02, 2019
#version         :2.0    
#==============================================================================

#### import the simple module from the paraview
from paraview.simple import *
#### disable automatic camera reset on 'Show'
paraview.simple._DisableFirstRenderCameraReset()

# create a new 'OpenFOAMReader'
a123foam = OpenFOAMReader(FileName='./123.foam')
a123foam.MeshRegions = ['internalMesh']
a123foam.CellArrays = ['U', 'k', 'nut', 'omega', 'p', 'vorticity', 'wallShearStress', 'yPlus']

# Properties modified on a123foam
a123foam.MeshRegions = ['internalMesh', 'topWall', 'bottomWall', 'inlet', 'outlet', 'sym', 'sideWall', 'motorBike']

# create a new 'Extract Block'
extractBlock1 = ExtractBlock(Input=a123foam)

print "Block extracted"

# Properties modified on extractBlock1
extractBlock1.BlockIndices = [9]

print "block extracted 1"

# create a new 'Calculator'
calculator1 = Calculator(Input=extractBlock1)
calculator1.Function = ''

# Properties modified on calculator1
calculator1.ResultArrayName = 'coord_1'
calculator1.Function = 'coords/0.127'

print "co-ordinates obtained"

# create a new 'Calculator'
calculator2 = Calculator(Input=calculator1)
calculator2.Function = ''

# Properties modified on calculator2
calculator2.ResultArrayName = 'Cp'
calculator2.Function = '(p-1.64)/(0.5*1.17*(40^2))'

print "Co-efficient of pressure obtained"

# create a new 'Slice'
slice1 = Slice(Input=calculator2)
slice1.SliceType = 'Plane'
slice1.SliceOffsetValues = [0.0]

# init the 'Plane' selected for 'SliceType'
slice1.SliceType.Origin = [0.008785825222730637, 2.1230429410934448e-05, 0.00024991855025291443]

# Properties modified on slice1.SliceType
slice1.SliceType.Origin = [0.0, 0.0, 0.0]
slice1.SliceType.Normal = [0.0, 0.0, 1.0]

# Properties modified on slice1.SliceType
slice1.SliceType.Origin = [0.0, 0.0, 0.0]
slice1.SliceType.Normal = [0.0, 0.0, 1.0]

print "Plane sliced"

# create a new 'Plot On Sorted Lines'
plotOnSortedLines1 = PlotOnSortedLines(Input=slice1)

print "Sorted lines obtained"

# export data
SaveData('./new_data.csv', proxy=slice1)

print "data Exported"



#### uncomment the following to render all views
# RenderAllViews()
# alternatively, if you want to write images, you can use SaveScreenshot(...).
