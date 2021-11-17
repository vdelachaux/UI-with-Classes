var $e : Object

$e:=FORM Event:C1606

HDI_LOAD_PAGE

If ($e.objectName=Null:C1517)  // <== FORM METHOD
	
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
			
			//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
		: (Form:C1466.showHideLeft=Null:C1517)
			
			// PAGE 3 IS NOT INITIALIZED (never displayed)
			
			//______________________________________________________
		: (Form:C1466.showHideSuper.catch())
			
			If (Form:C1466.groupLeft.members[0].isVisible())\
				 | (Form:C1466.groupRight.members[0].isVisible())
				
				Form:C1466.super.hide()
				Form:C1466.showHideSuper.setTitle("Show all Groups")
				Form:C1466.showHideLeft.setTitle("Show Group Left")
				Form:C1466.showHideRight.setTitle("Show Group Right")
				
			Else 
				
				Form:C1466.super.show()
				Form:C1466.showHideSuper.setTitle("Hide all Groups")
				Form:C1466.showHideLeft.setTitle("Hide Group Left")
				Form:C1466.showHideRight.setTitle("Hide Group Right")
				
			End if 
			
			
			//______________________________________________________
		: (Form:C1466.showHideLeft.catch())\
			 | (Form:C1466.showHideRight.catch())
			
			var $group : cs:C1710.group
			$group:=Choose:C955($e.objectName="showHideGroup1"; Form:C1466.groupLeft; Form:C1466.groupRight)
			
			If ($group.members[0].isVisible())
				
				$group.hide()
				Form:C1466["showHide"+$group.ID].setTitle("Show Group "+$group.ID)
				
			Else 
				
				$group.show()
				Form:C1466["showHide"+$group.ID].setTitle("Hide Group "+$group.ID)
				Form:C1466["input"+$group.index].focus()
				
			End if 
			
			If (Form:C1466.groupLeft.members[0].isVisible())\
				 | (Form:C1466.groupRight.members[0].isVisible())
				
				Form:C1466.showHideSuper.setTitle("Hide all Groups")
				
			Else 
				
				Form:C1466.showHideSuper.setTitle("Show all Groups")
				
			End if 
			
			//______________________________________________________
	End case 
End if 