# number of molecules
n = 500
# dimension (angstroms) of the box
BBx = 104.841
BBy = 102.718
BBz = 137.764
print ('Volume: {} Angstroms^3'.format(BBx*BBy*BBz))
# Avogadro number
NA = 6.023e23

# Molarity in mol/l
M = n/(BBx*BBy*BBz) * 1./NA * (1e27)

print('Molarity: {} mol/l'.format(M))