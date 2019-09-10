The directory '.\src' contains 10 dumby functions, func01 - func10.
Some of the functions reference other functions.

	func01 references func07
	func03 references func02
	func07 references func04
	func08 references func01
	func10 references func07

All of the functions are assembled using the
bldbin.bat file with the results stored in
the '.\bin' directory.

The library files lib_a.lib and lib_b.lib
located in the '.\bin' directory
are text files containing the [path]names of the
function object files in the libraries.

i.e. lib_a.lib:
	func01
	func02
	func03
	func04
	func05
 
and  lib_b.lib:
	func06
	func07
	func08
	func09
	func10

A test file - LibTest.asm is assembled and linked
by the LibTest.bat command file.  The linker command
file is LibTest.lnk.  The execution of the LibTest.bat
script causes the LibTest.asm file to be compiled and
then linked with the external library functions.

Note that the current version of the linker, 5.2 and older,
have a problem creating the the correct path/file names
for the external library functions.  This is resolved by
making sure that the library files have a .lib extension
and that the library object files specified in the library
files have an explicit .rel extension.

An updated lklibr.c file is included which corrects this
problem.  Recompile the linker with this file replacing
the old version.  The included ascheck.exe assembler was
compiled with the updated lklibr.c file.

The -k and -l options can have many valid specifications -
so experiment.

