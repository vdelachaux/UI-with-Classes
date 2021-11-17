//%attributes = {"invisible":true}
var $e; $ui : Object

If (Form:C1466.$=Null:C1517)
	
	// Instantiate the form class
	Form:C1466.$:=cs:C1710.HDI_FORM.new()
	
End if 

$e:=FORM Event:C1606
$ui:=Form:C1466.$

If ($e.objectName=Null:C1517)  // <== FORM METHOD
	
	Case of 
			
			//______________________________________________________
		: ($e.code=On Load:K2:1)
			
			// Set window title
			$ui.setTitle("DEMO with class form")
			
			//______________________________________________________
		: ($e.code=On Page Change:K2:54)
			
			$ui.loadPage()
			
			//______________________________________________________
	End case 
	
Else   // <== WIDGETS METHOD
	
	If (Bool:C1537(Form:C1466.trace))\
		 & (String:C10($e.objectName)#"trace")
		
		Form:C1466.trace:=False:C215
		TRACE:C157
		
	End if 
	
	Case of 
			
			//______________________________________________________
		: ($ui.clickMe.catch($e))
			
			// <THE WIDGET CALLBACK METHOD HAS BEEN EXECUTED DURING .catch()>
			
			// But we can change on the fly the code executed :-)
			$ui.clickMe.setCallback(Formula:C1597(ALERT:C41("Hello World")))
			
			//______________________________________________________
		: ($ui.alignRight.catch($e))
			
			ALERT:C41("You have clicked on "+$e.objectName)
			
			//______________________________________________________
		: ($ui.close.catch($e; On Clicked:K2:4))
			
			// <THE WIDGET CALLBACK METHOD HAS BEEN EXECUTED DURING .catch()>
			
			//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
		: ($ui.showHideLeft=Null:C1517)
			
			// PAGE 3 IS NOT INITIALIZED (never displayed)
			
			//______________________________________________________
		: ($ui.showHideSuper.catch())
			
			$ui.callMeBack("showHideSuper")
			
			//______________________________________________________
		: ($ui.showHideLeft.catch())\
			 | ($ui.showHideRight.catch())
			
			$ui.callMeBack("showHideGroup"; Choose:C955($e.objectName="showHideGroup1"; $ui.groupLeft; $ui.groupRight))
			
			//______________________________________________________
		Else 
			
			// A "Case of" statement should never omit "Else"
			
			//______________________________________________________
	End case 
End if 