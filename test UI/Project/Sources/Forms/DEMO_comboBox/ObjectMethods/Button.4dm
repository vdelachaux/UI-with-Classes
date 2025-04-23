var $name:=Request:C163("New country name")

If (Length:C16($name)>0)
	
	var $combobox : cs:C1710.ui.comboBox:=Form:C1466.Countries
	$combobox.insert($name)
	
End if 