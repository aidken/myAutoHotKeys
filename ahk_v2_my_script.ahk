#Requires AutoHotkey v2.0

;;; https://www.howtogeek.com/446418/how-to-use-caps-lock-as-a-modifier-key-on-windows/
; #NoEnv                      ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn                     ; Enable warnings to assist with detecting common errors.
#SingleInstance FORCE       ; Skip invocation dialog box and silently replace previously executing instance of this script.
; SendMode Input              ; Recommended for new scripts due to its superior speed and reliability.


; Ctrl + Shift + Alt + d prints current time and date
; in the format of "18:25:08 Saturday, January 13, 2024"
^+!d::InsertDateTime()
InsertDateTime(*){
    Send FormatTime(A_Now, "HH:mm:ss dddd, MMMM d, yyyy")
}
; Shift + Alt + d prints current date
; in the format of "Saturday, January 13, 2024"
+!d::InsertDate()
InsertDate(*){
    Send FormatTime(A_Now, "dddd, MMMM d, yyyy")
}


; https://stackoverflow.com/questions/58062684/autohotkey-modifier-symbol-for-shift-does-not-work
NumpadDel::Send "{shift up},{shift down}"

; Alt + Esc or Alt + ` to switch input methods
!Esc::Send "{LWinDown}{Space down}{Space up}{LWinUp}"
!`::Send "{LWinDown}{Space down}{Space up}{LWinUp}"
!Sc29::Send "{LWinDown}{Space down}{Space up}{LWinUp}"

; disable Ctrl + Win + n (which triggers windows narrator.)
^#n::Send ''

; disable Win + p (display/projector option)
#p::Send ''

; Shift Numpad Plus shows an equal sign
+NumpadAdd::Send "="
+NumpadSub::Send "_"
+NumpadDiv::Send "("
+NumpadMult::Send ")"

; in Firefox, Ctrl + Shift + n opens up a incognito window, just like Chrome and Safari
if WinActive("ahk_class MozillaWindowClass") {
    ^+n::Send "{CtrlDown}{ShiftDown}p{ShiftUp}{CtrlUp}"
}

; ; Array object
; ; https://www.autohotkey.com/docs/v2/lib/Array.htm
; Days := [31, 30, 29, 28]
; Months := [12, 11, 10]
; Years := [2026, 2025, 2024]

; TargetDate := A_Now  ; A_Now is a built-in var that contains current date and time
Counter := 0
SearchUntil := 15

; function
; https://www.autohotkey.com/docs/v2/Functions.htm
OpenFile(FilePath, FileBody, TargetDate, FileExtension, SearchUntil){

    Counter := 0

    while 1 {
        ; FormatTime
        ; https://www.autohotkey.com/docs/v2/lib/FormatTime.htm
        ; MsgBox FormatTime(Day, "yyyy-MM-dd"), , "ok"

        ; string concatenation
        ; https://www.autohotkey.com/docs/v2/Variables.htm#concat
        ; return FileBody . FormatTime(Date, "_yyyy-MM-dd") . FileExtension
        MsgBox FilePath . FileBody . FormatTime(TargetDate, "yyyy-MM-dd") . FileExtension
        ; MsgBox FileName("inventory", TargetDate, ".xlsx")

        ; DateAdd
        ; https://www.autohotkey.com/docs/v2/lib/DateAdd.htm
        ; actually you can add also hours, minutes, seconds, not only days.
        ; interesting this function name is Not TimeAdd
        TargetDate := DateAdd(TargetDate, -1, "days")

        ; ++ is post-increment operator
        ; https://www.autohotkey.com/docs/v2/Variables.htm#operators
        Counter++

        ; if flow control
        ; https://www.autohotkey.com/docs/v2/lib/If.htm
        if Counter = SearchUntil {
            break
        }
    }

}

OpenFileInventory(*){
    OpenFile "./", "inventory_", A_Now, ".xlsx", SearchUntil
}

OpenFileOverview(*){
    OpenFile "./", "overview_", A_Now, ".xlsx", SearchUntil
}

StartAppXyzzy(*) {
	Run "C:\Program Files (x86)\xyzzy\xyzzycli.exe"
    HideGui()
}

StartAppEmacs(*) {
	Run "C:\Program Files\emacs\bin\runemacs.exe"
    HideGui()
}



; gui example
; https://www.autohotkey.com/docs/v2/lib/Gui.htm#Examples
MyGui := Gui()
MyGui.Title := "Open..."
; MyGui.Add("Text", , "Open file...")
MyGui.Add("Button", "default xm", "Open inventory").OnEvent("Click", OpenFileInventory)  ; xm puts it at the bottom left corner.
MyGui.Add("Button", , "Open overview").OnEvent("Click", OpenFileOverview)
MyGui.Add("Button", , "Xyzzy").OnEvent("Click", StartAppXyzzy)
MyGui.Add("Button", , "Emacs").OnEvent("Click", StartAppEmacs)
MyGui.Add("Button", , "Close").OnEvent("Click", HideGui)

; Ctrl + Shift + Alt + f shows MyGui panel.
^+!f::MyGui.Show

HideGui(*){
    MyGui.hide
}

; enter today's date
JapaneseWeekDay(WeekDayNumber) {
    if WeekDayNumber < 1 or WeekDayNumber > 7 {
        throw ValueError(WeekDayNumber . " should be between 1 and 7.")
    }
    else {
        Switch WeekDayNumber {
            Case 1: return '日'
            Case 2: return '月'
            Case 3: return '火'
            Case 4: return '水'
            Case 5: return '木'
            Case 6: return '金'
            Case 7: return '土'
        }
    }
}
Hotstring "::etoday", FormatTime(, "LongDate")
Hotstring "::jtoday", FormatTime(, "yyyy年M月d日(" . JapaneseWeekDay(FormatTime(, "WDay")) . ")")
