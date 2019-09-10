call ..\_path WATCOM
echo on

del *.rel
del *.lst
del *.rst
del *.map
del *.hlr
del *.sym

asz280 -lbcoxff -p tzx_CL asz_CL tz280x 
asxscn tzx_CL.lst

asz280 -lbcoxff -p tzx_CR asz_CR tz280x 
aslink -nf tzx_CR
asxscn tzx_CR.rst

asz280 -lbcoxff -p tzx_XL asz_XL tz280x 
asxscn tzx_XL.lst

asz280 -lbcoxff -p tzx_XR asz_XR tz280x 
aslink -nf tzx_XR
asxscn tzx_XR.rst

asz280 -lbcoxff -p tzx_EXL asz_EXL tz280x 
asxscn tzx_EXL.lst

asz280 -lbcoxff -p tzx_EXR asz_EXR tz280x 
aslink -nf tzx_EXR
asxscn tzx_EXR.rst

