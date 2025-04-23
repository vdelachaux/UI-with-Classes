var $e:=cs:C1710.ui.evt.new()
var $combobox : cs:C1710.ui.comboBox:=Form:C1466.Fruits

Case of 
		
		// ______________________________________________________
	: ($e.gettingFocus)\
		 && ($combobox.automaticExpand)
		
		$combobox.expand()
		
		// ______________________________________________________
	: ($e.afterEdit) | ($e.dataChange)
		
		SET TIMER:C645(-1)
		
		// ______________________________________________________
End case 