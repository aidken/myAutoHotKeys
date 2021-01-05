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
NumpadDel::Send , {shift up}{,}{shift down}

; ; do nothing upon alt + Esc
; !Esc::
; return

; Shift Numpad Plus shows an equal sign
+NumpadAdd::Send , =
+NumpadSub::Send , _
+NumpadDiv::Send , (
+NumpadMult::Send, )

;;; in Emacs and in Visual Studio Code, CapsLock is Ctrl
; https://mogya.com/2011/07/capslockctrl.html
#IfWinActive ahk_class Emacs ahk_exe emacs.exe
    Capslock::Ctrl
    sc03a::Ctrl
#IfWinActive

#IfWinActive ahk_class Chrome_WidgetWin_1 ahk_exe Code.exe
    Capslock::Ctrl
    sc03a::Ctrl
    Ctrl & g::Send , {esc}
#IfWinActive

#IfWinActive ahk_class keypirinha_wndcls_run
    ; active with KeyPirinha
    Ctrl & n::Send , {down}
    Ctrl & p::Send , {up}
    Ctrl & f::Send , {right}
    Ctrl & b::Send , {left}
    Ctrl & a::Send , {home}
    Ctrl & e::Send , {end}
    Ctrl & g::Send , {esc}
    Ctrl & d::Send , {delete}
#IfWinActive

;================================================================================================
;  CapsLock processing.  Must double tap CapsLock to toggle CapsLock mode on or off.
;================================================================================================
; Must double tap CapsLock to toggle CapsLock mode on or off.
CapsLock::
    KeyWait, CapsLock                                                   ; Wait forever until Capslock is released.
    KeyWait, CapsLock, D T0.01                                           ; ErrorLevel = 1 if CapsLock not down within 0.1 seconds.
        if ((ErrorLevel = 0) && (A_PriorKey = "CapsLock") )                 ; Is a double tap on CapsLock?
            {
                SetCapsLockState, % GetKeyState("CapsLock","T") ? "Off" : "On"  ; Toggle the state of CapsLock LED
            }
return

#If ( ! WinActive("ahk_exe emacs.exe") OR ! WinActive("ahk_exe Code.exe") )
    ;================================================================================================
    ; Hot keys with CapsLock modifier.  See https://autohotkey.com/docs/Hotkeys.htm#combo
    ;================================================================================================
    sc03a & f::Send , {right}
    sc03a & b::Send , {left}
    sc03a & n::Send , {down}
    sc03a & p::Send , {up}

    sc03a & a::Send , {home}
    sc03a & e::Send , {end}

    sc03a & d::Send , {delete}

    sc03a & g::Send , {esc}

    sc03a & space::Return

    sc03a & x::Send , ^x
    sc03a & c::Send , ^c
    sc03a & y::Send , ^v
    sc03a & v::Send , ^v
#If

; Alt + Esc or Alt + ` to switch input methods
!Esc::Send , {LWinDown}{Space down}{Space up}{LWinUp}
!`::Send , {LWinDown}{Space down}{Space up}{LWinUp}
!Sc29::Send , {LWinDown}{Space down}{Space up}{LWinUp}

; in Excel, Ctrl + j enters an equal sign
#if WinActive("ahk_class XLMAIN ahk_exe EXCEL.EXE")
    ^j::Send, =
    ^+c::Send , {F2}{CtrlDown}{ShiftDown}{Left}{ShiftUp}c{CtrlUp}{Esc}
#if

; in Firefox, Ctrl + Shift + n opens up a incognito window, just like Chrome and Safari
#if WinActive("ahk_class MozillaWindowClass")
    ^+n::Send , {CtrlDown}{ShiftDown}p{ShiftUp}{CtrlUp}

; in AnyConnect, access specific AP
#IfWinActive ahk_class #32770 ahk_exe vpnui.exe
    Ctrl & m::Send , {tab}{tab}{tab}trustedvpn-asiapac.mdlz.com{enter}

; ; ; https://stackoverflow.com/questions/64656235/hotkey-to-run-program-or-activate-toggle
; ^+o::
; ; IfWinExist, ahk_class rctrl_renwnd32 ahk_exe OUTLOOK.EXE
; IfWinExist, ahk_class rctrl_renwnd32 ; ahk_exe OUTLOOK.EXE
; {
;     WinActivate  ; Automatically uses the window found above.
;     ; WinMaximize  ; same
;     ; Send, Some text.{Enter}
;     return
; } else {
;     run C:\Program Files (x86)\Microsoft Office\root\Office16\OUTLOOK.EXE
;     ; run C:\Program Files (x86)\Microsoft Office\root\Office16\EXCEL.EXE
; }
; return
; ; November 8th 2020: I could not get this work as I expect. Regular key combo
; ; such as Win + 1 works just fine.
