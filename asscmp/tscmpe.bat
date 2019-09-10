asscmp -gloxff tasm tasm tscmpe
asxscn tasm.lst
asscmp -gloxff tlnk tlnk tscmpe
aslink -u tlnk
asxscn -i tlnk.rst
