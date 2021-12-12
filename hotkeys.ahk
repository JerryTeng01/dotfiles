#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

EnvGet, home, Homepath

; open Edge
#b::
Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge", , max
return

; open Edge incognito ;)
#n::
Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge" -inprivate, , max
return

; open Spotify
#s::
Run "%home%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Spotify", , max
return

; open Discord
#d::
Run "%home%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord", , max
return

; open VMware
#v::
Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\VMware\VMware Workstation Pro", , max
return