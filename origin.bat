::adb kill-server
@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul


:: 配置地址
set "router_gateway=192.168.31"
set "ipad_gateway=172.20.10"
set "softap_gateway=192.168.43"
set "port=5687"
set "interface=WLAN 2"

:: 初始化变量
set "gateway_ip="
set "laptop_ip="

:: 提取 gateway_ip 和 laptop_ip
for /f "tokens=1,2 delims=:" %%A in ('netsh interface ip show address "%interface%" ^| findstr /i "IP Address Default Gateway"') do (
    set "key=%%~A"
    set "value=%%~B"
    set "key=!key: =!"
    set "value=!value: =!"
    if /i "!key!"=="IPAddress" set "laptop_ip=!value!"
    if /i "!key!"=="DefaultGateway" set "gateway_ip=!value!"
)

:: 检查是否成功提取 IP 地址
if not defined gateway_ip (
    echo 错误: 无法提取 Default Gateway.
    goto :cleanup
)

if not defined laptop_ip (
    echo 错误: 无法提取 IP Address.
    goto :cleanup
)

:: 根据网关地址确定 tcp_ip
set "tcp_ip="
if /i "%gateway_ip%"=="%router_gateway%.1" (
    set "tcp_ip=%router_gateway%.88"
) else if /i "%gateway_ip%"=="%softap_gateway%.1" (
    set "tcp_ip=%softap_gateway%.1"
) else if /i "%gateway_ip%"=="%ipad_gateway%.1" (
    if /i "%laptop_ip%"=="%ipad_gateway%.2" (
        set "tcp_ip=%ipad_gateway%.3"
    ) else if /i "%laptop_ip%"=="%ipad_gateway%.3" (
        set "tcp_ip=%ipad_gateway%.2"
    )
) else (
    set "tcp_ip=%gateway_ip%"
)

:: 运行 cscript（如果 tcp_ip 已设置）
if defined tcp_ip (
    set "tcp_argu=%tcp_ip%:%port%"
    cscript //nologo origin.vbs
)

:: 输出信息
echo ------------------------
echo gateway_ip: %gateway_ip%
echo laptop_ip : %laptop_ip%
echo ------------------------
echo tcp_ip    : %tcp_ip%
echo max_size  : %max_size%
echo port      : %port%
echo tcp_argu  : %tcp_argu%
echo ------------------------

:: 等待5秒后退出
timeout /nobreak /t 5 >nul

:cleanup
endlocal
exit /b