var $e : Object

$e:=FORM Event:C1606

HDI_LOAD_PAGE

If (FORM Event:C1606.objectName=Null:C1517)  // <== FORM METHOD
	
	// <NOTHING MORE TO DO>
	
Else   // <== WIDGETS METHOD
	
	If (Bool:C1537(Form:C1466.trace))\
		 & (String:C10($e.objectName)#"trace")
		
		Form:C1466.trace:=False:C215
		TRACE:C157
		
	End if 
	
	Case of 
			
			//______________________________________________________
		: (Form:C1466.clickMe.catch($e))
			
			// <THE WIDGET CALLBACK METHOD HAS BEEN EXECUTED DURING .catch()>
			
			// But we can change on the fly the code executed :-)
			Form:C1466.clickMe.setCallback(Formula:C1597(ALERT:C41("Hello World")))
			
			//______________________________________________________
		: (Form:C1466.alignRight.catch($e))
			
			ALERT:C41("You have clicked on "+$e.objectName)
			
			//______________________________________________________
		: (Split string:C1554("execute.reset.trace.next.previous"; ".").indexOf($e.objectName)#-1)
			
			// Ignore
			
			//______________________________________________________
		: (Form:C1466.close.catch($e; On Clicked:K2:4))
			
			// <THE WIDGET CALLBACK METHOD HAS BEEN EXECUTED DURING .catch()>
			
		: (Form:C1466.showHide1=Null:C1517)
			
			// Page 3 was never displayed
			
			//______________________________________________________
		: (Form:C1466.showHide1.catch())\
			 | (Form:C1466.showHide2.catch())
			
			var $group : cs:C1710.group
			$group:=Choose:C955($e.objectName="showHideGroup_1"; Form:C1466.group_1; Form:C1466.group_2)
			
			If ($group.members[0].isVisible())
				
				$group.hide()
				Form:C1466["showHide"+$group.index].setTitle("Show group "+$group.index)
				
			Else 
				
				$group.show()
				Form:C1466["showHide"+$group.index].setTitle("Hide group "+$group.index)
				Form:C1466["input"+$group.index].focus()
				
			End if 
			
			//________________________________________
	End case 
End if 