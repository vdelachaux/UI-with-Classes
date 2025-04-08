property form : cs:C1710.ui.form
property pwd : cs:C1710.ui.input
property ok; cancel; view : cs:C1710.ui.button
property bottomButtons : cs:C1710.ui.group

Class constructor
	
	// MARK:Delegates 📦
	This:C1470.form:=cs:C1710.ui.form.new(This:C1470; Try(JSON Parse:C1218(File:C1566("/SOURCES/Forms/"+Current form name:C1298+"/form.4DForm").getText())))
	
	This:C1470.form.init()
	
	// MARK:-[STANDARD SUITE]
	// === === === === === === === === === === === === === === === === === === === === ===
Function init()
	
/*
Instantiate the widgets we need to manipulate.
	
💡 Give them a name that makes your code readable independently of the name of the object in the form
	
*/
	
	// The text box for entering password
	This:C1470.pwd:=This:C1470.form.Input("Input")
	
	// The button to temporarily display the input
	This:C1470.view:=This:C1470.form.Button("view-password")
	
	// The bottom buttons are grouped together for correct positioning (see the onLoad function)
	This:C1470.bottomButtons:=This:C1470.form.Group()
	This:C1470.ok:=This:C1470.form.Button("Button").addToGroup(This:C1470.bottomButtons)
	This:C1470.cancel:=This:C1470.form.Button("Button1").addToGroup(This:C1470.bottomButtons)
	
	// 📌 Note: that the label is not instantiated, as we don't need to act on it.
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function handleEvents($e : cs:C1710.ui.evt)
	
	$e:=$e || cs:C1710.ui.evt.new()
	
	If ($e.form)
		
		// Mark:FORM METHOD
		Case of 
				
				//==============================================
			: ($e.load)
				
				// Preparing the form
				This:C1470.form.onLoad()
				
				//==============================================
		End case 
		
	Else 
		
		// Mark:WIDGETS METHOD
		Case of 
				
				//==============================================
			: (This:C1470.ok.catch($e; [On Clicked:K2:4]))
				
				// Make some validation then accept or not…
				If (This:C1470.verify())
					
					// All is OK, so we can validate
					ACCEPT:C269
					
				End if 
				
				//==============================================
			: (This:C1470.pwd.catch())
				
				// The OK button is only enabled if the password is not empty.
				This:C1470.ok.enable(This:C1470.pwd.isNotEmpty)
				
				//==============================================
			: (This:C1470.view.catch())
				
				This:C1470.pwd.asPassword:=Not:C34($e.mouseEnter)
				
				//==============================================
		End case 
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function onLoad()
	
	// Create and install a minimal menu bar, doing so here enables the menu bar 
	// to be displayed even if the dialog is run from development mode.
	cs:C1710.ui.menuBar.new().defaultMinimalMenuBar().set()
	
	// Set the window title
	// 💡 You can pass an XLIFF resname, it will be resolved
	This:C1470.form.window.title:="enterYourPassword"
	
	// Set the password textbox as password
	This:C1470.pwd.asPassword:=True:C214
	
	// Set the password textbox placeholder
	// 💡 You can pass an XLIFF resname, it will be resolved
	This:C1470.pwd.placeholder:="Try “1234” for fun"
	
	// Distribute bottom buttons according to their label
	This:C1470.bottomButtons.distributeRigthToLeft()
	
	If (Is Windows:C1573 || Shift down:C543)
		
		// Reverse the order of the bottom buttons
		This:C1470.bottomButtons.switch(True:C214)
		
	End if 
	
	// Define button tooltips
	// 📌 Note: The definition of tips automatically ensures that help tips are activated.
	This:C1470.cancel.helpTip:="Click here to abandon"
	
	// 💡 You can pass an XLIFF resname, it will be resolved
	This:C1470.ok.helpTip:="clickHereToValidateYourNewPassword"
	
	// Deactivating the validation button
	This:C1470.ok.disable()
	
	// MARK:-[IN-HOUSE]
	// === === === === === === === === === === === === === === === === === === === === ===
Function verify() : Boolean
	
	If (This:C1470.pwd.isEmpty || (This:C1470.pwd.value="1234"))
		
		This:C1470.form.window.vibrate()
		
		This:C1470.pwd.focus()
		This:C1470.pwd.highlight()
		
		return 
		
	End if 
	
	return True:C214