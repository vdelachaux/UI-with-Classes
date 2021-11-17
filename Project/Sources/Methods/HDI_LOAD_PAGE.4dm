//%attributes = {"invisible":true}
var $page : Integer
var $o : Object
var $c : Collection

If (Form:C1466.pages=Null:C1517)  // First call
	
	Form:C1466.pages:=New collection:C1472.resize(5)  // 4 pages + page 0
	
End if 

$page:=FORM Get current page:C276

If (Form:C1466.pages[$page]=Null:C1517) | Shift down:C543  // The page was not previously displayed
	
	Form:C1466.pages[$page]:=True:C214
	
	Case of 
			
			//______________________________________________________
		: ($page=1)
			
			Form:C1466.alignRight:=cs:C1710.button.new("Button2")
			
			Form:C1466.login:=cs:C1710.button.new("Check Box")\
				.highlightShortcut()\
				.disable()
			
			Form:C1466.close:=cs:C1710.button.new("Check Box1")\
				.setShortcut("c"; Command key mask:K16:1).highlightShortcut()\
				.setCallback(Formula:C1597(BEEP:C151))
			
			Form:C1466.blackRect:=cs:C1710.formObject.new("Rectangle2")
			Form:C1466.greenRect:=cs:C1710.formObject.new("Rectangle4")
			Form:C1466.blueRect:=cs:C1710.formObject.new("Rectangle6")
			Form:C1466.redRect:=cs:C1710.formObject.new("Rectangle3")
			Form:C1466.yellowRect:=cs:C1710.formObject.new("Rectangle1")
			Form:C1466.grapRect:=cs:C1710.formObject.new("Rectangle5")
			
			$c:=New collection:C1472
			$c.push(cs:C1710.formObject.new("Text8").setTitle("CommonMenuFile"))  // Set title with a resname
			$c.push(cs:C1710.button.new("Button4").setTitle("Hello"))  // Set title with a string
			$c.push(cs:C1710.button.new("Button5").disable())
			Form:C1466.group1:=cs:C1710.group.new($c)
			
			Form:C1466.bevel:=cs:C1710.button.new("Button10")
			
			// If uncommented, must generate an assert
			// Form.Input:=cs.widget.new("objectThatDoesNotExist")
			
			$o:=cs:C1710.group.new("execute,reset").setFontStyle(Bold:K14:2).distributeLeftToRight()
			
			Form:C1466.clickMe:=cs:C1710.button.new("Button1")\
				.setShortcut("m"; Command key mask:K16:1)\
				.highlightShortcut()\
				.setHelpTip("Click on \"Execute\" to activate me")\
				.setCallback(Formula:C1597(ALERT:C41("You clicked on me\r\rNow try it again and see...")))\
				.disable()
			
			//=========================================
			// Keep coordinates for the reset button
			//=========================================
			Form:C1466.clickMe.origin:=Form:C1466.clickMe.coordinates
			Form:C1466.alignRight.origin:=Form:C1466.alignRight.coordinates
			Form:C1466.login.origin:=Form:C1466.login.coordinates
			Form:C1466.close.origin:=Form:C1466.close.coordinates
			Form:C1466.yellowRect.origin:=Form:C1466.yellowRect.coordinates
			Form:C1466.blackRect.origin:=Form:C1466.blackRect.coordinates
			Form:C1466.redRect.origin:=Form:C1466.redRect.coordinates
			Form:C1466.greenRect.origin:=Form:C1466.greenRect.coordinates
			Form:C1466.grapRect.origin:=Form:C1466.grapRect.coordinates
			Form:C1466.blueRect.origin:=Form:C1466.blueRect.coordinates
			
			For each ($o; Form:C1466.group1.members)
				
				$o.origin:=$o.coordinates
				
			End for each 
			
			//______________________________________________________
		: ($page=2)
			
			Form:C1466.input:="Hello world"
			
			//______________________________________________________
		: ($page=3)
			
			// Create a group 1
			Form:C1466.groupLeft:=cs:C1710.group.new()
			
			// Add the data I will need
			Form:C1466.groupLeft.ID:="Left"
			Form:C1466.groupLeft.index:="1"
			
			// Add widgets as members
			Form:C1466.box1:=cs:C1710.formObject.new("Group Box").addToGroup(Form:C1466.groupLeft)
			Form:C1466.label1:=cs:C1710.formObject.new("Text28").addToGroup(Form:C1466.groupLeft)
			Form:C1466.input1:=cs:C1710.input.new("Input4").addToGroup(Form:C1466.groupLeft)
			Form:C1466.checkbox1:=cs:C1710.button.new("Check Box2").addToGroup(Form:C1466.groupLeft)
			Form:C1466.button1:=cs:C1710.button.new("Button11").addToGroup(Form:C1466.groupLeft)
			
			// Create a group 2
			Form:C1466.groupRight:=cs:C1710.group.new()
			
			// Add the data I will need
			Form:C1466.groupRight.ID:="Right"
			Form:C1466.groupRight.index:="2"
			
			// Add widgets as members
			Form:C1466.box2:=cs:C1710.formObject.new("Group Box1").addToGroup(Form:C1466.groupRight)
			Form:C1466.label2:=cs:C1710.formObject.new("Text29").addToGroup(Form:C1466.groupRight)
			Form:C1466.input2:=cs:C1710.input.new("Input5").addToGroup(Form:C1466.groupRight)
			Form:C1466.checkbox2:=cs:C1710.button.new("Check Box3").addToGroup(Form:C1466.groupRight)
			Form:C1466.button2:=cs:C1710.button.new("Button12").addToGroup(Form:C1466.groupRight)
			
			// Create a super-group
			Form:C1466.super:=cs:C1710.group.new()
			Form:C1466.super.addMember(Form:C1466.groupLeft)
			Form:C1466.super.addMember(Form:C1466.groupRight)
			
			// Demo buttons
			Form:C1466.groupDemo:=cs:C1710.group.new()
			Form:C1466.showHideLeft:=cs:C1710.button.new("showHidegroup1").bestSize().addToGroup(Form:C1466.groupDemo)
			Form:C1466.showHideRight:=cs:C1710.button.new("showHidegroup2").bestSize().addToGroup(Form:C1466.groupDemo)
			Form:C1466.showHideSuper:=cs:C1710.button.new("showHidegroupSuper").bestSize().addToGroup(Form:C1466.groupDemo)
			Form:C1466.groupDemo.centerVertically()
			
			// Place the background of the buttons
			Form:C1466.groupDemoBackground:=cs:C1710.formObject.new("Rectangle9")\
				.setCoordinates(Form:C1466.groupDemo.enclosingRect(10))\
				
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
		Else 
			
			Form:C1466.pages[$page]:=Null:C1517
			
			//______________________________________________________
	End case 
	
Else   // ALREADY INITIALIZED
End if 