@echo off
setlocal enabledelayedexpansion

for /f "tokens=2" %%a in ('netsh interface ip show address ^| findstr "默认网关" ^| findstr /V "0.0.0.0"') do (
echo %%a
    set "hostip=%%a"
    if not "!hostip!"=="0.0.0.0" (
        goto :found
    )
)

:found
echo 找到的网关ip是: %hostip%
set homegateway=192.168.31.1
set homephoneip=192.168.31.88

if %hostip%==%homegateway% (
	set startip=!homephoneip!
	echo startip：!startip!
	adb connect %homephoneip%:5687
	adb -s %homephoneip%:5687 shell am broadcast -a "ftp_server"
	filezilla ftp://%homegateway%:2121
) else (
	set startip=!hostip!
	echo startip：!startip!
	adb connect %hostip%:5687
	adb -s %hostip%:5687 shell am broadcast -a "ftp_server"
	filezilla ftp://%hostip%:2121
)

endlocal
