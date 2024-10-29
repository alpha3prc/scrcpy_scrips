strCommand = "cmd /c scrcpy -s 8ac6eeca -b 16M -Sw --no-audio --display-buffer=10 --audio-buffer=10 --video-codec=h265"

For Each Arg In WScript.Arguments
    strCommand = strCommand & " """ & replace(Arg, """", """""""""") & """"
Next

CreateObject("Wscript.Shell").Run strCommand, 0, false