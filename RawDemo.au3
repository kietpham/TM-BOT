#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <WinHttp.au3>
#include <Constants.au3>

#Include <IE.au3>

$Form1 = GUICreate("Form1", 406, 316, 192, 124)
$btnLoadSite = GUICtrlCreateButton("Load Site", 32, 120, 75, 25)
$btnSetValue = GUICtrlCreateButton("Set Value", 128, 120, 75, 25)
$btnFind = GUICtrlCreateButton("Find", 224, 120, 75, 25)
GUISetState(@SW_SHOW)

Main()

Func main()
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
	  Case $GUI_EVENT_CLOSE
		 Exit

	  Case $btnLoadSite
;~ 			$myUrl = "https://www.google.com.vn"
;~ 			$myUrl = "http://www.ticketmaster.com/"
			$myUrl = "http://www.ticketmaster.com/2016-nfc-divisional-playoffs-dallas-cowboys-arlington-texas-01-15-2017/event/0C005181BEA9486F?artistid=805931&majorcatid=10004&minorcatid=8&bba=1#efeat4211"

			ConsoleWrite("Woking With IE"& @CRLF)

			Global $myIEObj = _IECreate($myUrl)
			_IELoadWait($myIEObj)
			WinSetState("[ACTIVE]", "", @SW_MAXIMIZE)

			Global $hIE
			While Not IsHWnd($hIE)
			   $hIE = HWnd($myIEObj.hWnd)
			   Sleep(10)
			WEnd
			ConsoleWrite(@CRLF & "tttttttttt " & $hIE & "ttttttt" & @CRLF)

		 case $btnSetValue
   			ConsoleWrite("C"& @CRLF)
			$oSb = _IEGetObjById($myIEObj, "dropdown_current_value_1")

			ConsoleWrite("BTN2 -------------   IE Focus"& @CRLF)
			WinActivate($hIE)
			WinWaitActive($hIE)
			sleep(2000)
			ConsoleWrite("BTN2 -------------   IE Click"& @CRLF)
			_IEAction($oSb,"Click")
			opt("Sendkeydelay",300)
			Send("{UP}")
;~ 			Send("{UP}")
			Send("{ENTER}")
			ConsoleWrite("BTN2 -------------   END "& @CRLF)

		 Case $btnFind
			$oSb = _IEGetObjById($myIEObj, "find_tickets_action")
;~ 			Local $sText = $oSb.InnerText
			_IEAction($oSb,"Click")

	EndSwitch
 WEnd
 EndFunc

Func SetData()
   ConsoleWrite ("eihnte"  & @CRLF)
   ConsoleWrite ("Temp Row 2 eihnte"  & @CRLF)
;~    GUICtrlSetData($Input1,"Tung")
EndFunc

;~ Open site by create winhttp object
Func OpenSite()

   $httpRequestObj = ObjCreate('winhttp.winhttprequest.5.1')
   $httpRequestObj.Open('POST','http://www.ticketmaster.com/')
   $httpRequestObj.Send()
   ConsoleWrite($httpRequestObj)
   ConsoleWrite($httpRequestObj.ResponseText)

EndFunc

Func OpenIE($url)

  $myIEObj = IECreate($url)

EndFunc

Func OpenAndWriteFile()

	$file = FileOpen("Received.html", 2) ; The value of 2 overwrites the file if it already exists
	FileWrite($file, $oReceived)
	FileClose($file)

 EndFunc

Func _WriteHtml($Data)
	 Local $hFOpen = FileOpen(@ScriptDir &"\hocautoit.html", 2+8+256)
	 FileWrite($hFOpen, $Data)
	 FileClose($hFOpen)
	 ShellExecute(@ScriptDir &"\hocautoit.html")
EndFunc

Func CloseIE()
   $Proc = "iexplore.exe"
   While ProcessExists($Proc)
      ProcessClose($Proc)
   Wend
EndFunc

Func SetIEActive()
   ConsoleWrite("Try to reopen IE"& @CRLF)
   WinActivate($hIE)
   ConsoleWrite("reOpen IE completed"& @CRLF)
EndFunc

Func GetExistWindow()
   $aWindows = WinList()
		 For $i=1 To $aWindows[0][0]

		  ; skip windows without a title
		  If $aWindows[$i][0] = '' Then ContinueLoop

		  ;use the HWND to get the state of the window
		  $iWndState =  WinGetState($aWindows[$i][1])

		  ; here you could filter out the windows you don't want to modify
		  ConsoleWrite($aWindows[$i][0] & ': ')
		  If BitAND($iWndState,1) = 1 Then ConsoleWrite(' exists')
		  If BitAND($iWndState,2) = 2 Then ConsoleWrite(' visible')
		  If BitAND($iWndState,4) = 4 Then ConsoleWrite(' enabled')
		  If BitAND($iWndState,8) = 8 Then ConsoleWrite(' active')
		  If BitAND($iWndState,16) = 16 Then ConsoleWrite(' minimised')
		  If BitAND($iWndState,32) = 32 Then ConsoleWrite(' maximised')
		  ConsoleWrite(@CRLF)
		 Next
EndFunc