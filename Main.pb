EnableExplicit

UsePNGImageDecoder()

Global Parameters.s

Procedure WinCallback(hWnd, uMsg, WParam, LParam)
	If uMsg = #WM_POWERBROADCAST And Wparam = #PBT_APMRESUMEAUTOMATIC
		RunProgram("PBO2 tuner.exe", Parameters, "", #PB_Program_Hide)
	EndIf
	ProcedureReturn #PB_ProcessPureBasicEvents 
EndProcedure 

Procedure Init()
	Protected Loop, Count, Program
	OpenWindow(0, 0, 0, 500, 400, "PBO2 Launcher", #PB_Window_Invisible)
	
	; Systray
	CatchImage(0, ?Icon)
	AddSysTrayIcon(0, WindowID(0), ImageID(0))
	SysTrayIconToolTip(0, "PBO2Wake")
	
	; Callback
	SetWindowCallback(@WinCallback(), 0)
	
	; Parameters
	Count = CountProgramParameters()
	If Count
		For Loop = 1 To Count
			Parameters + ProgramParameter() + " "
		Next
		Parameters = Trim(Parameters)
	Else
		MessageRequester("PBO2Wake", "Error : No parameter given.")
		End
	EndIf
	
	; Launch PBO2 Tuner for the first time
	RunProgram("PBO2 tuner.exe", Parameters, "", #PB_Program_Hide)
EndProcedure

Init()

Repeat 
	Select WaitWindowEvent() 
		Case #PB_Event_CloseWindow, #PB_Event_SysTray
			Break
	EndSelect 
ForEver

DataSection
	Icon:
	IncludeBinary "Icon.png"
EndDataSection 


; IDE Options = PureBasic 6.20 (Windows - x64)
; CursorPosition = 15
; Folding = -
; Optimizer
; EnableXP
; EnableAdmin
; DPIAware
; SharedUCRT
; Executable = ..\..\..\PBO2\PBO2Wake.exe
; CommandLine = -30 -30 -30 -30 -30 -30 -30 -30
; CurrentDirectory = ..\..\..\PBO2\Debug-cli\Debug\
; Compiler = PureBasic 6.20 - C Backend (Windows - x64)