var $e : Object:=Form:C1466.Fruits.eventHandler()

If ([On After Edit:K2:43; On Data Change:K2:15; On Clicked:K2:4].includes($e.code))
	
	// Enable Clear button if current value is not empty
	Form:C1466.clearFruits.enable(Length:C16(Form:C1466.Fruits.value)>0)
	
End if 