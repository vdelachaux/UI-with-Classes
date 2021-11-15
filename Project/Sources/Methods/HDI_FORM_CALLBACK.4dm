//%attributes = {"invisible":true}
#DECLARE($message : Text)

var $o; $ui : Object

$ui:=Form:C1466.$

If (Bool:C1537($ui.trace))
	
	TRACE:C157
	
	$ui.trace:=False:C215
	
End if 

Case of 
		
		//______________________________________________________
	: ($message="execute")
		
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
	: ($message="reset")
		
		$ui.clickMe.setCoordinates($ui.clickMe.origin).disable()
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
			$ui.showHideSuper.setTitle("Show groups")
			$ui.showHide1.setTitle("Show group 1")
			$ui.showHide2.setTitle("Show group 2")
			
		Else 
			
			$ui.super.show()
			$ui.showHideSuper.setTitle("Hide groups")
			$ui.showHide1.setTitle("Hide group 1")
			$ui.showHide2.setTitle("Hide group 2")
			
		End if 
		
		//______________________________________________________
	: ($message="showHideGroup")
		
		$group:=$2
		
		If ($group.members[0].isVisible())
			
			$group.hide()
			$ui["showHide"+$group.index].setTitle("Show group "+$group.index)
			
		Else 
			
			$group.show()
			$ui["showHide"+$group.index].setTitle("Hide group "+$group.index)
			$ui["input"+$group.index].focus()
			
		End if 
		
		If ($ui.groupLeft.members[0].isVisible())\
			 | ($ui.groupRight.members[0].isVisible())
			
			$ui.showHideSuper.setTitle("Hide groups")
			
		Else 
			
			$ui.showHideSuper.setTitle("Show groups")
			
		End if 
		
		//______________________________________________________
	Else 
		
		// A "Case of" statement should never omit "Else"
		
		//______________________________________________________
End case 