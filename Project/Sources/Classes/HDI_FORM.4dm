Class extends form

// === === === === === === === === === === === === === === 
Class constructor
	
	Super:C1705("HDI_FORM_CALLBACK")
	
	This:C1470.pages:=New collection:C1472.resize(5)  // 4 pages + page 0
	
	This:C1470.init()
	
	
	//=========================================
	// Keep coordinates for the reset button
	//=========================================
	This:C1470.backup()
	
	// === === === === === === === === === === === === === === 
Function init()
	
	If (This:C1470.toBeInitialized)
		
		This:C1470.toBeInitialized:=False:C215
		
		This:C1470.loadPage()
		
	End if 
	
	// === === === === === === === === === === === === === === 
Function loadPage()
	
	var $page : Integer
	var $o : Object
	var $c : Collection
	
	$page:=This:C1470.page()
	
	Case of 
			
			//______________________________________________________
		: (This:C1470.pages[$page]#Null:C1517)
			
			// <NOTHING MORE TO DO>
			
			//______________________________________________________
		: ($page=1)
			
			This:C1470.alignRight:=This:C1470.button("Button2")
			
			This:C1470.login:=This:C1470.button("Check Box")\
				.highlightShortcut()\
				.disable()
			
			This:C1470.close:=This:C1470.button("Check Box1")\
				.setShortcut("c"; Command key mask:K16:1)\
				.highlightShortcut()\
				.setCallback(Formula:C1597(BEEP:C151))
			
			This:C1470.blackRect:=This:C1470.formObject("Rectangle2")
			This:C1470.greenRect:=This:C1470.formObject("Rectangle4")
			This:C1470.blueRect:=This:C1470.formObject("Rectangle6")
			This:C1470.redRect:=This:C1470.formObject("Rectangle3")
			This:C1470.yellowRect:=This:C1470.formObject("Rectangle1")
			This:C1470.grapRect:=This:C1470.formObject("Rectangle5")
			
			// Define a group with a collection of widgets
			$c:=New collection:C1472
			$c.push(This:C1470.formObject("Text8").setTitle("CommonMenuFile"))  // Set title with a resname
			$c.push(This:C1470.button("Button4").setTitle("Hello"))  // Set title with a string
			$c.push(This:C1470.button("Button5").disable())
			This:C1470.group("group1"; $c)
			
			This:C1470.bevel:=This:C1470.button("Button10").setPicture("")
			
/*
   If the next line is uncommented, it must generate an assert
   because the object does not exist.
Form.Input:=this.widget("objectThatDoesNotExist")
*/
			
			This:C1470.clickMe:=This:C1470.button("Button1")\
				.setShortcut("m"; Command key mask:K16:1)\
				.highlightShortcut()\
				.setHelpTip("Click on \"Execute\" to activate me")\
				.setCallback(Formula:C1597(ALERT:C41("You clicked on me\r\rTry again to see...")))\
				.disable()
			
			// Demo buttons
			$o:=cs:C1710.group.new("reset,execute").setFontStyle(Bold:K14:2).distributeRigthToLeft()
			
			//______________________________________________________
		: ($page=2)
			
			Form:C1466.input:="Hello world"
			
			// Align labels and checkbox on best size
			cs:C1710.group.new("Text17,fontStyles,Text30").distributeLeftToRight()
			
			//______________________________________________________
		: ($page=3)
			
			// Create a groupLeft
			This:C1470.group("groupLeft")
			
			// Add the data I will need
			This:C1470.groupLeft.index:="1"
			
			// Add widgets as members
			This:C1470.box1:=This:C1470.formObject("Group Box").addToGroup(This:C1470.groupLeft)
			This:C1470.label1:=This:C1470.formObject("Text28").addToGroup(This:C1470.groupLeft)
			This:C1470.input1:=This:C1470.input("Input4").addToGroup(This:C1470.groupLeft)
			This:C1470.checkbox1:=This:C1470.button("Check Box2").addToGroup(This:C1470.groupLeft)
			This:C1470.button1:=This:C1470.button("Button11").addToGroup(This:C1470.groupLeft)
			
			// Create a groupRight
			This:C1470.group("groupRight")
			
			// Add the data I will need
			This:C1470.groupRight.index:="2"
			
			// Add widgets as members
			This:C1470.box2:=This:C1470.formObject("Group Box1").addToGroup(This:C1470.groupRight)
			This:C1470.label2:=This:C1470.formObject("Text29").addToGroup(This:C1470.groupRight)
			This:C1470.input2:=This:C1470.input("Input5").addToGroup(This:C1470.groupRight)
			This:C1470.checkbox2:=This:C1470.button("Check Box3").addToGroup(This:C1470.groupRight)
			This:C1470.button2:=This:C1470.button("Button12").addToGroup(This:C1470.groupRight)
			
			// Create a super-group
			This:C1470.group("super")
			This:C1470.super.addMember(This:C1470.groupLeft)
			This:C1470.super.addMember(This:C1470.groupRight)
			
			// Demo buttons
			This:C1470.groupDemo:=This:C1470.group("groupDemo")
			This:C1470.showHide1:=This:C1470.button("showHidegroup1").bestSize().addToGroup(This:C1470.groupDemo)
			This:C1470.showHide2:=This:C1470.button("showHidegroup2").bestSize().addToGroup(This:C1470.groupDemo)
			This:C1470.showHideSuper:=This:C1470.button("showHidegroupSuper").bestSize().addToGroup(This:C1470.groupDemo)
			This:C1470.groupDemo.centerVertically()
			
			This:C1470.buttonBack:=This:C1470.formObject("Rectangle9")\
				.setCoordinates(This:C1470.groupDemo.enclosingRect())\
				.moveAndResizeHorizontally(-10; 10)\
				.moveAndResizeVertically(-10; 10)
			
			//______________________________________________________
		: ($page=4)
			
			Form:C1466.nonAssignable:="Hello"
			Form:C1466.testDatasource:=cs:C1710.input.new("Input"; Formula:C1597(Form:C1466.nonAssignable))
			Form:C1466.value:=cs:C1710.input.new("Input1")
			Form:C1466.getValue:=cs:C1710.button.new("Button3").disable()
			
			Form:C1466.testPicture:=cs:C1710.picture.new("picture"; Formula:C1597(Form:C1466.picture))
			Form:C1466.testPicture.read(File:C1566("/RESOURCES/images/4d.png")).thumbnail(100)\
				.superImposition(File:C1566("/RESOURCES/images/light_on.png"); 5; 5)
			
			//______________________________________________________
	End case 
	
	This:C1470.pages[$page]:=True:C214
	
	// === === === === === === === === === === === === === === 
Function backup()
	
	var $o : Object
	
	This:C1470.clickMe.origin:=This:C1470.clickMe.coordinates
	This:C1470.alignRight.origin:=This:C1470.alignRight.coordinates
	This:C1470.login.origin:=This:C1470.login.coordinates
	This:C1470.close.origin:=This:C1470.close.coordinates
	This:C1470.yellowRect.origin:=This:C1470.yellowRect.coordinates
	This:C1470.blackRect.origin:=This:C1470.blackRect.coordinates
	This:C1470.redRect.origin:=This:C1470.redRect.coordinates
	This:C1470.greenRect.origin:=This:C1470.greenRect.coordinates
	This:C1470.grapRect.origin:=This:C1470.grapRect.coordinates
	This:C1470.blueRect.origin:=This:C1470.blueRect.coordinates
	
	For each ($o; This:C1470.group1.members)
		
		$o.origin:=$o.coordinates
		
	End for each 
	
	// === === === === === === === === === === === === === === 
Function doExecute()
	
	If (Bool:C1537(This:C1470.trace))
		
		TRACE:C157
		
	End if 
	
	This:C1470.clickMe.bestSize().enable().setHelpTip("Click here for more information about me")
	
	This:C1470.alignRight.bestSize(Align right:K42:4)
	This:C1470.login.bestSize().enable(Not:C34(Shift down:C543))
	This:C1470.close.bestSize(Align right:K42:4).enable()
	
	var $o : Object
	$o:=This:C1470.blackRect.getCoordinates()
	This:C1470.blackRect.setCoordinates($o.left-10; $o.top-5; $o.right+10; $o.bottom+5)
	
	This:C1470.greenRect.resizeHorizontally(20)
	This:C1470.yellowRect.moveHorizontally(50)
	
	This:C1470.redRect.resizeVertically(10)
	This:C1470.blueRect.moveVertically(10)
	
	This:C1470.grapRect.moveHorizontally(100).resizeHorizontally(-141).resizeVertically(10)
	
	This:C1470.group1.distributeLeftToRight()
	This:C1470.group1.members[1].setTitle("Hello")
	
	This:C1470.bevel.setPicture("/Images/light_on.png")
	
	This:C1470.trace:=False:C215
	
	// === === === === === === === === === === === === === === 
Function doRestore()
	
	var $o : Object
	
	If (Bool:C1537(This:C1470.trace))
		
		This:C1470.trace:=False:C215
		TRACE:C157
		
	End if 
	
	This:C1470.clickMe.setCoordinates(This:C1470.clickMe.origin).disable()
	This:C1470.alignRight.setCoordinates(This:C1470.alignRight.origin)
	This:C1470.login.setCoordinates(This:C1470.login.origin)
	This:C1470.close.setCoordinates(This:C1470.close.origin)
	
	This:C1470.yellowRect.setCoordinates(This:C1470.yellowRect.origin)
	This:C1470.blackRect.setCoordinates(This:C1470.blackRect.origin)
	This:C1470.redRect.setCoordinates(This:C1470.redRect.origin)
	This:C1470.greenRect.setCoordinates(This:C1470.greenRect.origin)
	This:C1470.grapRect.setCoordinates(This:C1470.grapRect.origin)
	This:C1470.blueRect.setCoordinates(This:C1470.blueRect.origin)
	
	For each ($o; This:C1470.group1.members)
		
		$o.setCoordinates($o.origin)
		
	End for each 
	
	This:C1470.group1.members[1].setTitle("xxx")
	
	This:C1470.bevel.setPicture("")
	