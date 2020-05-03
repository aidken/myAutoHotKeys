; https://stackoverflow.com/questions/58062684/autohotkey-modifier-symbol-for-shift-does-not-work
NumpadDel::
Send , {shift up}{,}{shift down}
return

; do nothing upon alt + Esc
!Esc::
return

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


; https://mogya.com/2011/07/capslockctrl.html
Capslock::Ctrl
sc03a::Ctrl
