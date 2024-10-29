strCommand = "cmd /c scrcpy.exe --tcpip=%tcp_argu%  -m 1000 -Swb 8M --max-fps=30 --window-width=700 --no-mouse-hover --no-audio --video-codec=h265"

For Each Arg In WScript.Arguments
    strCommand = strCommand & " """ & replace(Arg, """", """""""""") & """"
Next

CreateObject("Wscript.Shell").Run strCommand, 0, false
