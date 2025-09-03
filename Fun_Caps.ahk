#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



SetCapsLockState, AlwaysOff
CapsLock & k::up
CapsLock & j::down
CapsLock & h::left
CapsLock & l::right
CapsLock & q::#^left
CapsLock & e::#^right
CapsLock & a::#left
CapsLock & d::#right
CapsLock & s::#down
CapsLock & w::#up

RALT & i::up
RALT & k::down
RALT & j::left
RALT & l::right