
If (Bool:C1537(Form:C1466.trace))
	
	TRACE:C157
	
End if 

Form:C1466.clickMe.bestSize().enable().setHelpTip("Click here for more information about me")

Form:C1466.alignRight.bestSize(Align right:K42:4)
Form:C1466.login.bestSize().enable(Not:C34(Shift down:C543))
Form:C1466.close.bestSize(Align right:K42:4).enable()

var $o : Object
$o:=Form:C1466.blackRect.getCoordinates()
Form:C1466.blackRect.setCoordinates($o.left-10; $o.top-5; $o.right+10; $o.bottom+5)

Form:C1466.greenRect.resizeHorizontally(20)
Form:C1466.yellowRect.moveHorizontally(50)

Form:C1466.redRect.resizeVertically(10)
Form:C1466.blueRect.moveVertically(10)

Form:C1466.grapRect.moveHorizontally(100).resizeHorizontally(-141).resizeVertically(10)

Form:C1466.group1.distributeLeftToRight()
Form:C1466.group1.members[1].setTitle("Hello")

Form:C1466.bevel.setPicture("/Images/light_on.png")

Form:C1466.trace:=False:C215