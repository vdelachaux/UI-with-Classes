C_OBJECT:C1216($o)

If (Bool:C1537(Form:C1466.trace))
	
	Form:C1466.trace:=False:C215
	TRACE:C157
	
End if 

Form:C1466.clickMe.setCoordinates(Form:C1466.clickMe.origin).disable()
Form:C1466.alignRight.setCoordinates(Form:C1466.alignRight.origin)
Form:C1466.login.setCoordinates(Form:C1466.login.origin)
Form:C1466.close.setCoordinates(Form:C1466.close.origin)

Form:C1466.yellowRect.setCoordinates(Form:C1466.yellowRect.origin)
Form:C1466.blackRect.setCoordinates(Form:C1466.blackRect.origin)
Form:C1466.redRect.setCoordinates(Form:C1466.redRect.origin)
Form:C1466.greenRect.setCoordinates(Form:C1466.greenRect.origin)
Form:C1466.grapRect.setCoordinates(Form:C1466.grapRect.origin)
Form:C1466.blueRect.setCoordinates(Form:C1466.blueRect.origin)

For each ($o; Form:C1466.group1.members)
	
	$o.setCoordinates($o.origin)
	
End for each 

Form:C1466.group1.members[1].setTitle("xxx")

Form:C1466.bevel.setPicture("")
