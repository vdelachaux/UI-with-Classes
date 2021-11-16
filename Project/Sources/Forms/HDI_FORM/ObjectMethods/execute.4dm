
var $ui : Object

$ui:=Form:C1466.$

If (Bool:C1537($ui.trace))
	
	$ui.trace:=False:C215
	TRACE:C157
	
End if 

If (False:C215)
	
	// Direct execution
	$ui.doExecute()
	
Else 
	
	// Use CALL FORM
	$ui.callMeBack("doExecute")
	
End if 