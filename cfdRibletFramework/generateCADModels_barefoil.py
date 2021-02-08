# Generating CAD model of Riblets on NACA0012 airfoil
# Author: Sumeet Lulekar, Payam Ghassemi
# Date: Nov. 02, 2019
# a = Height of the Gaussian Ridge and the range of the gaussian distribution (-a,a).
# sig = Standard Deviation (sigma). This is hardcoded in the formula below.
# c = Span of the Airfoil from centre plane. i.e., half the spanwise distance
# d = Distance between two gaussian ridges measure from the centreline.
# Part5.STEP is used as a path for the gaussian curve extrusion, This CAD generation is only for NACA0012 airfoil
# NACA0012Coordinates.dat contains coordinates in mm, but salome treates them as dimensionless numbers and when 
#             saving into .stl, default is m. Hence, the model is scaled about origin.

import math
import SALOMEDS
import salome
salome.salome_init()
import GEOM
from salome.geom import geomBuilder
geompy = geomBuilder.New(salome.myStudy)
gg = salome.ImportComponentGUI("GEOM")

cur = []
ver = []

O = geompy.MakeVertex(0, 0, 0)
OX = geompy.MakeVectorDXDYDZ(1, 0, 0)
OY = geompy.MakeVectorDXDYDZ(0, 1, 0)
OZ = geompy.MakeVectorDXDYDZ(0, 0, 1)

f = open("inputVariables.dat")
n=0
for l in f:
    a, d, sig, aoa = [ float(v) for v in l.split() ]
    print a,d,sig,n
    pass

c = 63.5

lower_range = -3*sig
upper_range = 3*sig

f = open("naca0012Coordinates.dat")
n = 0
for l in f:
    x, y, z = [ float(v) for v in l.split() ]
    print x, y, z, n
    pt = geompy.MakeVertex(x, y, z)
    #geompy.addToStudy(pt, "Pt_%s"%(n))
    cur1 = (pt)
    cur.append(cur1)
    n += 1
    if (y>=0) and (x<125):
            pot = geompy.MakeVertex(x, y, z)
            #geompy.addToStudy(pot, "Pot_%s"%(n))
            ver1 = (pot)
            ver.append(ver1)
    pass

curve_1 = geompy.MakeInterpol(cur)
#geompy.addToStudy( curve_1, 'Curve_1')
Face_1 = geompy.MakeFaceWires([curve_1],1)
#geompy.addToStudy( Face_1, 'Face_1')
Extrusion_1 = geompy.MakePrismDXDYDZ2Ways(Face_1, 0, 0, c)
#geompy.addToStudy( Extrusion_1, 'Extrusion_1')

Gaussian = geompy.MakeCurveParametric("-%s*exp(-(t*t)/(%s*%s))"%(a,sig,sig), "0", "t", lower_range, upper_range, 25, GEOM.Bezier, True)
#geompy.addToStudy(Gaussian, 'Gaussian')
print "Created the curve!"

curve_2 = geompy.MakePolyline(ver)
#geompy.addToStudy( curve_2, 'Curve_2')

geomObj_1 = geompy.MakeCDG(Extrusion_1)
Centre_of_mass = geompy.MakeCDG(Extrusion_1)
#geompy.addToStudy(Centre_of_mass, 'Centre_of_mass')

Scale_1 = geompy.MakeScaleAlongAxes(curve_2, Centre_of_mass, 1.015, 1.05, 1)
#geompy.addToStudy(Scale_1, 'Scale_1')

Point_1 = geompy.MakeVertex(0.01,0,upper_range)
#geompy.addToStudy(Point_1,'Point_1')

Gaussian_vertex_3 = geompy.GetSubShape(Gaussian, [3])
Gaussian_vertex_2 = geompy.GetSubShape(Gaussian, [2])

Line_1 = geompy.MakeLineTwoPnt(Gaussian_vertex_3, Gaussian_vertex_2)
geompy.addToStudy(Line_1, 'Line_1')

Fuse_1 = geompy.MakeFuseList([Gaussian, Line_1],True, True)
#geompy.addToStudy(Fuse_1,'Fuse_1')

Fuse_1_vertex_4 = geompy.GetSubShape(Fuse_1, [4])
Translation_1 = geompy.MakeTranslationTwoPoints(Fuse_1,Fuse_1_vertex_4,Point_1)
#geompy.addToStudy(Translation_1,'Translation_1')


Face_2 = geompy.MakeFaceWires([Translation_1],1)
#geompy.addToStudy(Face_2,'Face_2')
print "Created wires!"
Part5 = geompy.ImportSTEP("Part5.STEP", True, True)
Part5_edge_2 = geompy.GetSubShape(Part5, [2])
Wire_1 = geompy.MakeWire([Part5_edge_2],1e-07)
Pipe_1 = geompy.MakePipe(Face_2, Wire_1)
geompy.addToStudy(Pipe_1, 'Pipe_1')

m = (c-a)/d
m = math.floor(m)
m = int(m)

Multi_Translation_1 = geompy.MakeMultiTranslation1D(Pipe_1, OZ, d, m)
Multi_Translation_2 = geompy.MakeMultiTranslation1D(Pipe_1, OZ, -d, (m+1))
geompy.addToStudy(Multi_Translation_1, 'Multi_Translation_1')
geompy.addToStudy(Multi_Translation_2, 'Multi_Translation_2')

Fuse_2 = geompy.MakeFuseList([Extrusion_1, Multi_Translation_1, Multi_Translation_2], False, True)
geompy.addToStudy(Fuse_2, 'Fuse_2')

COM = geompy.MakeCDG(Extrusion_1)
Translation_2 = geompy.MakeTranslationTwoPoints(Extrusion_1, COM, O)
geompy.addToStudy(Translation_1, 'Translation_1')

for n in range(0, 1, 4):
    Rotation_1 = geompy.MakeRotation(Translation_2, OZ, -n*math.pi/180.0)
    geompy.addToStudy(Rotation_1, 'Rotation_1')

print "Saving..."

baseCadModel = geompy.MakeScaleTransform(Extrusion_1, O, 0.001)
if aoa == -2:
    actualCadModel = geompy.MakeRotation(baseCadModel, OZ, 2*math.pi/180.0)
elif aoa == 0:
    actualCadModel = baseCadModel
elif aoa == 2:
    actualCadModel = geompy.MakeRotation(baseCadModel, OZ, -2*math.pi/180.0)
elif aoa == 4:
    actualCadModel = geompy.MakeRotation(baseCadModel, OZ, -4*math.pi/180.0)
elif aoa == 6:
    actualCadModel = geompy.MakeRotation(baseCadModel, OZ, -6*math.pi/180.0)
elif aoa == 8:
    actualCadModel = geompy.MakeRotation(baseCadModel, OZ, -8*math.pi/180.0)
else:
    raise NameError('Invalid value of Angle of Attack; you are only allowed to have a even value between [-2,8]')

geompy.ExportSTL(actualCadModel, "./actualCadModel.stl", True, 0.0004, True)

f = open('Aref.dat','w')
j = geompy.BasicProperties(baseCadModel, theTolerance=1.e-6)
print j[1]
f.write("Aref\t%5.8f;}" %(j[1]))
f.close()
