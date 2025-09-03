#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; Disable Caps Lock more robustly
SetCapsLockState, AlwaysOff
; Intercept the physical Caps Lock key press and do nothing
CapsLock::return

; Toggle Caps Lock with Alt+Shift+C (can be changed to your preference)
!+c::
    GetKeyState, CapsLockState, CapsLock, T
    if CapsLockState = D
        SetCapsLockState, AlwaysOff
    else              
        SetCapsLockState, On
    return

; --- SpaceFN Feature ---
; Hold Space for a layer of hotkeys, tap for a normal space.
Space::
    KeyWait, Space, T0.2  ; Wait for 200ms. Adjust T parameter for sensitivity.
    if ErrorLevel  ; This means Space was held down for longer than the timeout.
    {
        ; It's a hold, so it acts as a modifier. Do nothing here.
        return
    }
    else  ; This means Space was tapped (pressed  and released within the timeout).
    {
        Send {Space}
    }
return

; Prevent Space from triggering the Win key, which can happen with layered hotkeys.
Space & LWin::return
Space & RWin::return

; --- SpaceFN Layer Definition ---
; These hotkeys are active only when Space is held down.
#if GetKeyState("Space", "P")

; I,J,K,L as an arrow cluster
i::Up
k::Down
j::Left
l::Right

; Home and End
u::Home
o::End

; Page Down and Page Up
[::PgDn
]::PgUp

; Enter and Backspace
CapsLock::Enter
Tab::Backspace

; Number row as F1-F12
1::F1
2::F2
3::F3
4::F4
5::F5
6::F6
7::F7
8::F8
9::F9
0::F10
-::F11
=::F12

#if ; End of SpaceFN layer hotkeys

; Right Alt as arrow cluster (J, K, L, I)
RAlt & j::Send {Left}
RAlt & k::Send {Down}
RAlt & l::Send {Right}
RAlt & i::Send {Up}

; Arrow keys using CapsLock
CapsLock & k::up
CapsLock & j::down
CapsLock & h::left
CapsLock & l::right
CapsLock & Tab::Send {Delete} ; Tab as Delete while CapsLock is held

; Home & End using CapsLock + Ctrl + Alt combinations
;Todo:

!^h::Send {Home} ; Ctrl + Alt + K: Move cursor to beginning of line (Home)
!^k::Send ^{Home} ; Ctrl + Alt + J: Move cursor to beginning of document (Ctrl+Home)
!^l::Send {End} ; Ctrl + Alt + H: Move cursor to end of line (End)
!^j::Send ^{End} ; Ctrl + Alt + L: Move cursor to end of document (Ctrl+End)
!^+h::Send +{Home} ; Shift + Ctrl + Alt + H: select beginning of line (Shift+Home)
!^+k::Send ^+{Home} ; Shift + Ctrl + Alt + K: select beginning of document (Shift+Ctrl+Home)
!^+l::Send +{End} ; Shift + Ctrl + Alt + L: select end of line (Shift+End)
!^+j::Send ^+{End} ; Shift + Ctrl + Alt + J: select end of document (Shift+Ctrl+End)

;Switch Desktops
CapsLock & q::#^left
CapsLock & e::#^right

; Move Current Window
CapsLock & a::#left
CapsLock & d::#right
CapsLock & s::#down
CapsLock & w::WinMaximize, A  ; Maximize current window prevents moving window simple to top/top-left half

; Left-Hand Enter"
CapsLock & Space::Send {Enter}

; Ctrl + Q to close current window (Alt + F4)
^q::Send !{F4}

; F8 to play/pause media
F8::Send {Media_Play_Pause}

; Swap Backspace and \ key
*Backspace::Send {\}  ; Backspace types `\`
*\::Send {Backspace}      ; \ acts as Backspace

; Shift + Backspace types `|`
+Backspace::Send {|}

; Shift + \ sends Delete
+\::Send {Delete}

; hotkeys for word deletion
^\::Send ^{Backspace}  ; Ctrl + \ deletes word to left
^+\::Send ^{Delete}    ; Ctrl + Shift + \ deletes word to right

; hotkeys for line deletion
; Alt + \ deletes line to left of cursor
!\::
    Send {Shift Down}{Home}{Shift Up}  ; Select to start of line
    Send {Backspace}                    ; Delete selection
return

; Alt + Shift + \ deletes line to right of cursor
!+\::
    Send {Shift Down}{End}{Shift Up}    ; Select to end of line
    Send {Delete}                       ; Delete selection
return
