# -*- coding: utf-8 -*-
"""
Created on Wed Nov  9 18:07:35 2016

@author: eia14agr
"""
#Variables:
Velocity = 8.0
Mach = (Velocity/343.0)
#Reynolds = 187500
Reynolds = 100000
#Cl = 0.3101
Cl = 1.090
MaxCam = 7
MinCam = 7
MaxThk = 4
MinThk = 4


#init
import subprocess as sp
xfoil = sp.Popen(['xfoil.exe'], stdin=sp.PIPE, stdout=sp.PIPE, stderr=None)
k = True
for i in range (MinThk , MaxThk + 1):
    for j in range (MinCam , MaxCam + 1):
        xfoil.stdin.write(bytes(('naca'+str(j)+'4'+str(i).zfill(2)+'\n'),'utf8'))
        xfoil.stdin.write(bytes('ppar\n','utf8'))
        xfoil.stdin.write(bytes('n 160\n','utf8'))
        xfoil.stdin.write(bytes('\n','utf8'))
        xfoil.stdin.write(bytes('\n','utf8'))
        xfoil.stdin.write(bytes('oper\n','utf8'))
        if k == True:
            xfoil.stdin.write(bytes('visc\n','utf8'))
            xfoil.stdin.write(bytes((str(Reynolds)+'\n'),'utf8'))
            xfoil.stdin.write(bytes(('mach '+str(Mach)+'\n'),'utf8'))
            xfoil.stdin.write(bytes('iter 100\n','utf8'))
            k = False
        a = 0
        xfoil.stdin.write(bytes('pacc\n','utf8'))
        xfoil.stdin.write(bytes(('naca'+str(j)+'4'+str(i).zfill(2)+'polarl.txt\n'),'utf8'))
        xfoil.stdin.write(bytes('\n','utf8'))
        for a in range (200,600):
            xfoil.stdin.write(bytes(('alfa'+ str((a/40))+'\n'),'utf8'))
            #xfoil.stdin.write(bytes(('alfa '+ str(-a/4)+'\n'),'utf8'))
        xfoil.stdin.write(bytes('pacc\n','utf8'))
        xfoil.stdin.write(bytes('pdel 1\n','utf8'))
        xfoil.stdin.write(bytes('\n','utf8'))

print(xfoil.communicate()[0])