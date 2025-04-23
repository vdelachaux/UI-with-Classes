var $e:=cs:C1710.ui.evt.new()
var $combobox : cs:C1710.ui.comboBox:=Form:C1466.Cities

Case of 
		
		// ______________________________________________________
	: ($e.gettingFocus)\
		 && ($combobox.automaticExpand)
		
		$combobox.expand()
		
		// ______________________________________________________
	: ($e.dataChange)
		
		$combobox.insert()
		
		SET TIMER:C645(-1)
		
		// ______________________________________________________
End case 