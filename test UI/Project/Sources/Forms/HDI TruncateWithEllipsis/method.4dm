If (FORM Event:C1606.code=On Load:K2:1)
	
	Form:C1466.text:="Lorem ipsum dolor sit amet, consectetur adipiscing elit"
	Form:C1466.input:=cs:C1710.ui.input.new("Input").setValue(Form:C1466.text)
	Form:C1466.char:="…"
	
Else 
	
	SET TIMER:C645(0)
	
	Form:C1466.input.truncateWithEllipsis(Form:C1466.where; Form:C1466.text; Form:C1466.char)
	
End if 