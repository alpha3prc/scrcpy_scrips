strCommand = "cmd /c scrcpy.exe --tcpip=192.168.43.1:5687  -m 1585 -Sb 12M  --max-fps=60 --always-on-top --no-mouse-hover --no-audio --video-codec=h264"

For Each Arg In WScript.Arguments
    strCommand = strCommand & " """ & replace(Arg, """", """""""""") & """"
Next

CreateObject("Wscript.Shell").Run strCommand, 0, false
