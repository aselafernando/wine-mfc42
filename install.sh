#!/bin/bash

if [ "${WINEPREFIX}" = "" ]; then
    WINEPREFIX=$HOME/.wine
fi

wget https://download.microsoft.com/download/vc60pro/Update/2/W9XNT4/EN-US/VC6RedistSetup_deu.exe
SHA=`sha256sum VC6RedistSetup_deu.exe | awk '{print $1}'`

if [ "$SHA" != "c2eb91d9c4448d50e46a32fecbcc3b418706d002beab9b5f4981de552098cee7" ]; then
    echo "Invalid SHA256: ${SHA}"
    exit
fi

cabextract VC6RedistSetup_deu.exe && cabextract vcredist.exe

cp *.dll ${WINEPREFIX}/drive_c/windows/system32/
cp *.tlb ${WINEPREFIX}/drive_c/windows/system32/
wine ./50comupd.exe /Q:A /R:N
wine regsvr32 atl.dll
wine regsvr32 comcat.dll
wine regsvr32 mfc42.dll
wine regsvr32 mfc42u.dll
wine regsvr32 oleaut32.dll
wine regsvr32 olepro32.dll
