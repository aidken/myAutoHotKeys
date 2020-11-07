; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one .ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.

; #z::Run www.autohotkey.com

; ^!n::
; IfWinExist Untitled - Notepad
;	WinActivate
; else
;	Run Notepad
; return


; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.


;;; https://www.howtogeek.com/446418/how-to-use-caps-lock-as-a-modifier-key-on-windows/
#NoEnv                      ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn                     ; Enable warnings to assist with detecting common errors.
#SingleInstance FORCE       ; Skip invocation dialog box and silently replace previously executing instance of this script.
SendMode Input              ; Recommended for new scripts due to its superior speed and reliability.




; https://stackoverflow.com/questions/58062684/autohotkey-modifier-symbol-for-shift-does-not-work
NumpadDel::
Send , {shift up}{,}{shift down}
return

; ; do nothing upon alt + Esc
; !Esc::
; return

; Shift Numpad Plus shows an equal sign
+NumpadAdd::
Send , =
return

+NumpadSub::
Send , _
return

+NumpadDiv::
Send , (
return

+NumpadMult::
Send, )
return

; ; https://mogya.com/2011/07/capslockctrl.html
; Capslock::Ctrl
; sc03a::Ctrl

;================================================================================================
;  CapsLock processing.  Must double tap CapsLock to toggle CapsLock mode on or off.
;================================================================================================
; Must double tap CapsLock to toggle CapsLock mode on or off.
CapsLock::
    KeyWait, CapsLock                                                   ; Wait forever until Capslock is released.
    KeyWait, CapsLock, D T0.1                                           ; ErrorLevel = 1 if CapsLock not down within 0.1 seconds.
    if ((ErrorLevel = 0) && (A_PriorKey = "CapsLock") )                 ; Is a double tap on CapsLock?
        {
            SetCapsLockState, % GetKeyState("CapsLock","T") ? "Off" : "Off"  ; Toggle the state of CapsLock LED
        }
return

;================================================================================================
; Hot keys with CapsLock modifier.  See https://autohotkey.com/docs/Hotkeys.htm#combo
;================================================================================================
CapsLock & f::
    Send , {right}
Return

CapsLock & b::
    Send , {left}
Return

CapsLock & n::
    Send , {down}
Return

CapsLock & p::
    Send , {up}
Return

CapsLock & a::
    Send , {home}
Return

CapsLock & e::
    Send , {end}
Return

CapsLock & d::
    Send , {delete}
Return

CapsLock & g::
    Send , {esc}
Return

CapsLock & space::
Return

CapsLock & x::
    Send , ^x
Return

CapsLock & c::
    Send , ^c
Return

CapsLock & y::
    Send , ^v
Return

CapsLock & v::
    Send , ^v
Return

!Esc::
    Send , {LWinDown}{Space down}{Space up}{LWinUp}
Return

!`::
    Send , {LWinDown}{Space down}{Space up}{LWinUp}
Return

!Sc29::
    Send , {LWinDown}{Space down}{Space up}{LWinUp}
Return
