@echo off
%1 mshta vbscript:CreateObject("WScript.Shell").Run("%~s0 ::",0,FALSE)(window.close)&&exit
echo run autoadb to wait for mobile connect
autoadb scrcpy -s 8ac6eeca -b 16M -Sw --no-audio --no-mouse-hover --display-buffer=10 --audio-buffer=10 --video-codec=h265