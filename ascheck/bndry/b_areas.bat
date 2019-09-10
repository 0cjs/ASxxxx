ascheck -lagoxcff b_areas_1
ascheck -lagoxcff b_areas_2
ascheck -lagoxcff b_areas_3
aslink -xmuwi1 -b Area_1=0x0000 b_areas b_areas_1 b_areas_2 b_areas_3
asxscn -i b_areas_1.rst
asxscn -i b_areas_2.rst
asxscn -i b_areas_3.rst
