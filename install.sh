#!/bin/bash

if [ "${WINEPREFIX}" = "" ]; then
    WINEPREFIX=$HOME/.wine
fi

KARCH=$(uname -m)

if [ "$karch" = "x86_64" ] || [ "$karch" = "aarch64" ]; then
    SYS_PATH = ${WINEPREFIX}/drive_c/windows/syswow64
else
    SYS_PATH = ${WINEPREFIX}/drive_c/windows/system32
fi

if [ ! -f VC6RedistSetup_deu.exe ]; then
    curl -L -O https://download.microsoft.com/download/vc60pro/Update/2/W9XNT4/EN-US/VC6RedistSetup_deu.exe
fi

SHA=`sha256sum VC6RedistSetup_deu.exe | awk '{print $1}'`

if [ "$SHA" != "c2eb91d9c4448d50e46a32fecbcc3b418706d002beab9b5f4981de552098cee7" ]; then
    echo "Invalid SHA256: ${SHA}"
    exit
fi

cabextract VC6RedistSetup_deu.exe && cabextract vcredist.exe

cp *.dll ${SYS_PATH}
cp *.tlb ${SYS_PATH}
wine ./50comupd.exe /Q:A /R:N
wine ${SYS_PATH}/regsvr32.exe atl.dll
wine ${SYS_PATH}/regsvr32.exe comcat.dll
wine ${SYS_PATH}/regsvr32.exe mfc42.dll
wine ${SYS_PATH}/regsvr32.exe mfc42u.dll
wine ${SYS_PATH}/regsvr32.exe oleaut32.dll
wine ${SYS_PATH}/regsvr32.exe olepro32.dll
