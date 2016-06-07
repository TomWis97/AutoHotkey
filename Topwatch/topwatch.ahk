Gui +ToolWindow +AlwaysOnTop
Gui, Margin, 10, 10
Gui, Font, S50, Courier New
Gui, Add, Text, vTime, x:xx:xx.x
Gui, Show, W380 H100 NoActivate, Topwatch
Sleep 200
status = 0

Loop {
  ; Statuses:
  ; Status 0: Time is 0:0:0.0. Waiting for start.
  ; Status 1: Time is running.
  ; Status 2: Time is stopped.
  GuiControl,,Time,0:00:00.0
  while (status == 0) {
    sleep, 100
  }
  startTicks = %A_TickCount%
  while (status == 1) {
    sleep 100
    currentTicks := A_TickCount - startTicks
    ;msgbox, currentTicks = %currentTicks%
    timeText := TicksToTime(currentTicks)
    GuiControl,, Time, %timeText%
  }
  while (status == 2) {
    sleep, 100
  }
}
Return

F9::
  if (status == 0) {
    status = 1
  }
  else if (status == 1) {
    status = 2
  }
  else if (status == 2) {
    status = 0
  }
  ;msgbox, status now %status%
  Return

ticksToTime(ticks){
  hours := ticks // 3600000
  ticks := ticks - (hours * 3600000)
  minutes := ticks // 60000
  ticks := ticks - (minutes * 60000)
  seconds := ticks // 1000
  ticks := ticks - (seconds * 1000)
  milliseconds := ticks
  minutesp := padNum(minutes)
  secondsp := padNum(seconds)
  millisecondsp := round(milliseconds / 100)

  formatted = %hours%:%minutesp%:%secondsp%.%millisecondsp%
  Return formatted
}

padNum(num)
{
  padded := (StrLen(num)=1 ? "0" : "") num
  Return padded
}
