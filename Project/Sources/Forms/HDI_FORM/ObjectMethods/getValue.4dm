var $ui : Object

$ui:=Form:C1466.$

If (Bool:C1537($ui.trace))
	
	$ui.trace:=False:C215
	TRACE:C157
	
End if 

Form:C1466.value.setValue(Form:C1466.testDatasource.getValue())
Form:C1466.value.focus()
