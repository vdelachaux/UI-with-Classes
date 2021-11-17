//%attributes = {"invisible":true}
#DECLARE($message : Text; $param : Object)

var $o; $ui : Object

$ui:=Form:C1466.$

If (Bool:C1537($ui.trace))
	
	TRACE:C157
	
	$ui.trace:=False:C215
	
End if 

Case of 
		
		//______________________________________________________
	: ($message="doExecute")
		
		$ui.clickMe.bestSize().enable().setHelpTip("Click here for more information about me")
		
		$ui.alignRight.bestSize(Align right:K42:4)
		$ui.login.bestSize().enable(Not:C34(Shift down:C543))
		$ui.close.bestSize(Align right:K42:4).enable()
		
		$o:=$ui.blackRect.getCoordinates()
		$ui.blackRect.setCoordinates($o.left-10; $o.top-5; $o.right+10; $o.bottom+5)
		
		$ui.greenRect.resizeHorizontally(20)
		$ui.yellowRect.moveHorizontally(50)
		
		$ui.redRect.resizeVertically(10)
		$ui.blueRect.moveVertically(10)
		
		$ui.grapRect.moveHorizontally(100).resizeHorizontally(-141).resizeVertically(10)
		
		$ui.group1.distributeLeftToRight()
		$ui.group1.members[1].setTitle("Hello")
		
		$ui.bevel.setPicture("/Images/light_on.png")
		
		$ui.trace:=False:C215
		
		//______________________________________________________
	: ($message="doRestore")
		
		$ui.clickMe.setCoordinates($ui.clickMe.origin).setCallback(Formula:C1597(ALERT:C41("You clicked on me\r\rTry again to see..."))).disable()
		$ui.alignRight.setCoordinates($ui.alignRight.origin)
		$ui.login.setCoordinates($ui.login.origin)
		$ui.close.setCoordinates($ui.close.origin)
		
		$ui.yellowRect.setCoordinates($ui.yellowRect.origin)
		$ui.blackRect.setCoordinates($ui.blackRect.origin)
		$ui.redRect.setCoordinates($ui.redRect.origin)
		$ui.greenRect.setCoordinates($ui.greenRect.origin)
		$ui.grapRect.setCoordinates($ui.grapRect.origin)
		$ui.blueRect.setCoordinates($ui.blueRect.origin)
		
		For each ($o; $ui.group1.members)
			
			$o.setCoordinates($o.origin)
			
		End for each 
		
		$ui.group1.members[1].setTitle("xxx")
		
		$ui.bevel.setPicture("")
		
		//______________________________________________________
	: ($message="showHideSuper")
		
		If ($ui.groupLeft.members[0].isVisible())\
			 | ($ui.groupRight.members[0].isVisible())
			
			$ui.super.hide()
			$ui.removeFocus()
			$ui.showHideSuper.setTitle("Show all Groups")
			$ui.showHideLeft.setTitle("Show Group Left")
			$ui.showHideRight.setTitle("Show Group Right")
			
		Else 
			
			$ui.super.show()
			$ui.showHideSuper.setTitle("Hide all Groups")
			$ui.showHideLeft.setTitle("Hide Group Left")
			$ui.showHideRight.setTitle("Hide Group Right")
			
		End if 
		
		//______________________________________________________
	: ($message="showHideGroup")
		
		$group:=$param
		
		If ($group.members[0].isVisible())
			
			$group.hide()
			$ui["showHide"+$group.ID].setTitle("Show Group "+$group.ID)
			
		Else 
			
			$group.show()
			$ui["showHide"+$group.ID].setTitle("Hide Group "+$group.ID)
			$ui["input"+$group.index].focus()
			
		End if 
		
		If ($ui.groupLeft.members[0].isVisible())\
			 | ($ui.groupRight.members[0].isVisible())
			
			$ui.showHideSuper.setTitle("Hide all Groups")
			
		Else 
			
			$ui.showHideSuper.setTitle("Show all Groups")
			
		End if 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+$message+"\"")
		
		//______________________________________________________
End case 