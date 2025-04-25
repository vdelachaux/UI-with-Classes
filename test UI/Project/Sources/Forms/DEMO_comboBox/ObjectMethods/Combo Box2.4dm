var $e : Object:=Form:C1466.Cities.eventHandler()

If ([On Data Change:K2:15; On Clicked:K2:4].includes($e.code))
	
	// Enable Reset button if associated list was modified
	Form:C1466.resetCities.enable(Form:C1466.Cities.listModified())
	
End if 