#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu May  6 13:41:36 2021

@author: qubit-starman
"""

regmapPath = "/home/qubit-starman/Documents/Si5338-RevB-Registers.h"
genFilePath = "/home/qubit-starman/Documents/regMapEx.vhd"

rF = open(regmapPath, "r")

print("Locating Start Point")

#locate 'Address,Data' line


 
    
textChunk = "0"
while textChunk != "{":
    textChunk =   rF.read(1)

AddressLine = []
    
AddressLine.append(textChunk)

#textChunk = rF.read(12)
line = rF.readline()
line = rF.readline()
line = rF.readline()
line = rF.readline()
line = rF.readline()
line = rF.readline()
line = rF.readline()
    
print(line)

'''   
AddressLine.append(textChunk)

AddressLine = ''.join(AddressLine)

print(AddressLine)
'''

address = []

regVal = []

regMask = []

chunks = []

running = 1
#while running == 1:
while True:
    chunks = []
    line = rF.readline()
    #print(line)
    if line == "//End of file\n":
        break
        
    c = 0
    textChunk = line[c]
    while textChunk != (","):
        if textChunk != "{":
            chunks.append(textChunk)
        
        c = c + 1
        #print(textChunk)
        textChunk = line[c]
    address.append(''.join(chunks))

    c = c + 1 
    textChunk = line[c]

    while textChunk != (","):
        if textChunk == "x":
            c = c + 1 #increment up
            regVal.append(line[c:c+2]) # append regval
            break
        else:
            c = c + 1
            textChunk = line[c]


    c = c + 1 
    textChunk = line[c]
    while textChunk != ("}"):
        if textChunk == "x":
            c = c + 1 #increment up
            regMask.append(line[c:c+2]) # append regval
            break
        else:
            c = c + 1
            textChunk = line[c]

        
    

print(address)
print(regVal)
print(regMask)

rF.close()
wF = open(genFilePath, "w")

wF.write("type i2c_bram is array (" + str(len(regVal) - 1) + " downto 0) of STD_LOGIC_VECTOR(7 downto 0); \r\n")
wF.write(("type i2c_addr is array (" + str(len(address) - 1) + " downto 0) of integer range 0 to " + address[len(address) - 1] + ");\n"))
wF.write("type i2c_mask is array (" + str(len(regMask) - 1) + " downto 0) of STD_LOGIC_VECTOR(7 downto 0); \r\n")
wF.write("CONSTANT si5338_init_data : i2c_bram := ( \n")

for i in range(len(regVal)):
    #wF.write
    wF.write('x"' + regVal[i] + '"')
    if(i != (len(regVal)-1)):
       wF.write(',')
    if (i+1) % 8 == 0:
        wF.write("\n")

wF.write(");\n\n")
   
wF.write("CONSTANT si5338_init_addr : i2c_addr := ( \n")

print(len(address))

for i in range(len(address)):
    #wF.write
    wF.write(address[i])
    if(i != (len(address)-1)):
       wF.write(',')
    if (i+1) % 8 == 0:
        wF.write("\n")

wF.write(");\n\n")

wF.write("CONSTANT si5338_init_regMask : i2c_mask := ( \n")

for i in range(len(regMask)):
    #wF.write
    wF.write( 'x"' + regMask[i] + '"')
    if(i != (len(regMask)-1)):
       wF.write(',')
    if (i+1) % 8 == 0:
        wF.write("\n")

wF.write(");")

    
    
wF.close()

    #break
#wF = open(genFileName, "w")
