rem  Zip File Created  with Info-Zip   Zip v2.31
rem  Zip File Verified with Info-Zip UnZip v5.52
rem
rem Remove Old Versions
rem
del asxs*.*
rem
rem  Zip The asxv5pxx Directory and Subdirectories
rem
cd ..\..\
asxv5pxx\zipper\zip.exe -r .\asxv5pxx\zipper\asxs5pxx.zip asxv5pxx\*.*
cd asxv5pxx\zipper
zip -T asxs5pxx.zip
rem
rem  Remove Zipped Files and the Zip/Unzip Utilities
rem
zip -d asxs5pxx.zip asxv5pxx\zipper\*.exe asxv5pxx\zipper\*.txt asxv5pxx\zipper\*.zip
zip -T asxs5pxx.zip
rem
rem  Remove Non-Distribution Directories
rem
zip -d asxs5pxx.zip asxv5pxx\asxdoc\asxrno\* asxv5pxx\asxhtmw\*
zip -d asxs5pxx.zip asxv5pxx\updater\* asxv5pxx\misc\*
rem
zip -d asxs5pxx.zip asxv5pxx\asxmak\cygwin\exe\*.exe
zip -d asxs5pxx.zip asxv5pxx\asxmak\djgpp\exe\*.exe
zip -d asxs5pxx.zip asxv5pxx\asxmak\linux\exe\as*
zip -d asxs5pxx.zip asxv5pxx\asxmak\linux\exe\s*
zip -d asxs5pxx.zip asxv5pxx\asxmak\turboc30\exe\*.EXE
zip -d asxs5pxx.zip asxv5pxx\asxmak\vc6\exe\*.exe
zip -d asxs5pxx.zip asxv5pxx\asxmak\vs05\exe\*.exe
zip -d asxs5pxx.zip asxv5pxx\asxmak\vs10\exe\*.exe
zip -d asxs5pxx.zip asxv5pxx\asxmak\vs13\exe\*.exe
zip -d asxs5pxx.zip asxv5pxx\asxmak\vs15\exe\*.exe
zip -d asxs5pxx.zip asxv5pxx\asxmak\watcom\exe\*.exe
zip -d asxs5pxx.zip asxv5pxx\asxmak\symantec\exe\*.EXE
zip -T asxs5pxx.zip
rem
rem  Remove Pad File
rem
zip -d asxs5pxx.zip asxv5pxx\asxv*.xml
zip -d asxv5pxx.zip asxv5pxx\asxdoc\asxv*.xml
zip -T asxs5pxx.zip
rem
rem  Copy Current readme.txt File To asxv5pxx.txt
rem  And Add To The Zip Archive
rem
copy ..\readme.txt asxs%1.txt
zip -g asxs5pxx.zip asxs%1.txt
zip -T asxs5pxx.zip
rem
rem  Change Name To Current Version
rem
ren asxs5pxx.zip asxs%1.zip
rem
rem  Final File Verification
rem
unzip -t asxs%1.zip

