#Requires AutoHotkey v2.0

;;; https://www.howtogeek.com/446418/how-to-use-caps-lock-as-a-modifier-key-on-windows/
; #NoEnv                      ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn                     ; Enable warnings to assist with detecting common errors.
#SingleInstance FORCE       ; Skip invocation dialog box and silently replace previously executing instance of this script.
; SendMode Input              ; Recommended for new scripts due to its superior speed and reliability.


; https://stackoverflow.com/questions/58062684/autohotkey-modifier-symbol-for-shift-does-not-work
NumpadDel::Send "{shift up},{shift down}"

; Alt + Esc or Alt + ` to switch input methods
!Esc::Send "{LWinDown}{Space down}{Space up}{LWinUp}"
!`::Send "{LWinDown}{Space down}{Space up}{LWinUp}"

; disable Ctrl + Win + n (which triggers windows narrator.)
^#n::Send ''

; Shift Numpad Plus shows an equal sign
+NumpadAdd::Send "="
+NumpadSub::Send "_"
+NumpadDiv::Send "("
+NumpadMult::Send ")"

; in Firefox, Ctrl + Shift + n opens up a incognito window, just like Chrome and Safari
if WinActive("ahk_class MozillaWindowClass") {
    ^+n::Send "{CtrlDown}{ShiftDown}p{ShiftUp}{CtrlUp}"
}
