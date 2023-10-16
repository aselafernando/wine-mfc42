#!/bin/bash

wget https://download.microsoft.com/download/vc60pro/Update/2/W9XNT4/EN-US/VC6RedistSetup_deu.exe &&
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
