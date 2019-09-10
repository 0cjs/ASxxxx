rem  Zip File Created  with Info-Zip   Zip v2.31
rem  Zip File Verified with Info-Zip UnZip v5.52
rem
rem  Remove Old Version Files
rem
del asxv*.*
rem
rem  Zip The asxv5pxx Directory and Subdirectories
rem
cd ..\..\
asxv5pxx\zipper\zip.exe -r .\asxv5pxx\zipper\asxv5pxx.zip asxv5pxx\*.*
cd asxv5pxx\zipper
zip -T asxv5pxx.zip
rem
rem  Remove Zipped Files and the Zip/Unzip Utilities
rem
zip -d asxv5pxx.zip asxv5pxx\zipper\*.exe asxv5pxx\zipper\*.txt asxv5pxx\zipper\*.zip
zip -T asxv5pxx.zip
rem
rem  Remove Non-Distribution Directories
rem
zip -d asxv5pxx.zip asxv5pxx\asxdoc\asxrno\* asxv5pxx\asxhtmw\*
zip -d asxv5pxx.zip asxv5pxx\updater\* asxv5pxx\misc\*
rem
rem  Remove Pad File
rem
zip -d asxv5pxx.zip asxv5pxx\asxv*.xml
zip -d asxv5pxx.zip asxv5pxx\asxdoc\asxv*.xml
zip -T asxv5pxx.zip
rem
rem  Copy Current readme.txt File To asxv5pxx.txt
rem  And Add To The Zip Archive
rem
copy ..\readme.txt asxv%1.txt
zip -g asxv5pxx.zip asxv%1.txt
zip -T asxv5pxx.zip
rem
rem  Change Name To Current Version
rem
ren asxv5pxx.zip asxv%1.zip
rem
rem  Final File Verification
rem
unzip -t asxv%1.zip

