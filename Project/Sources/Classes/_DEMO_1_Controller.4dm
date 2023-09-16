property form : cs:C1710.formDelegate
property pwd : cs:C1710.inputDelegate
property ok; cancel : cs:C1710.buttonDelegate
property buttons : cs:C1710.groupDelegate

Class constructor
	
	This:C1470.isSubform:=False:C215
	This:C1470.toBeInitialized:=False:C215
	
	// MARK:-Delegates 📦
	This:C1470.form:=cs:C1710.formDelegate.new(This:C1470)
	
	This:C1470.form.init()
	
	// MARK:-[Standard Suite]
	// === === === === === === === === === === === === === === === === === === === === ===
Function init()
	
/*
Instantiate the widgets we want to manipulate.
• Note that the label is not instantiated, as we don't need to act on it.
*/
	
	This:C1470.pwd:=This:C1470.form.input.new("Input")
	
	// Bottom buttons
	This:C1470.ok:=This:C1470.form.button.new("Button")
	This:C1470.cancel:=This:C1470.form.button.new("Button1")
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function handleEvents($e : cs:C1710.evt)
	
	$e:=$e || cs:C1710.evt.new()
	
	If ($e.form)  // <== FORM METHOD
		
		Case of 
				
				//==============================================
			: ($e.load)
				
				This:C1470.form.onLoad()
				
				//==============================================
		End case 
		
	Else   // <== WIDGETS METHOD
		
		Case of 
				
				//==============================================
			: (This:C1470.ok.catch($e; [On Clicked:K2:4]))
				
				// Make some validation then accept or not…
				If (This:C1470.pwd.isEmpty || (This:C1470.pwd.value="1234"))
					
					ALERT:C41("Invalid pasword!")
					This:C1470.pwd.focus()
					return 
					
				End if 
				
				// All is OK, so we can validate
				ACCEPT:C269
				
				//==============================================
			: (This:C1470.pwd.catch())
				
				This:C1470.ok.enable(This:C1470.pwd.isNotEmpty)
				
				//==============================================
		End case 
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function onLoad()
	
	// Create and install a minimal menu bar
	cs:C1710.menuBar.new().defaultMinimalMenuBar().set()
	
	// Set window title
	This:C1470.form.window.title:="Passkey"
	
	// Set the textbox as password & set a placeholder  for it
	This:C1470.pwd.setPlaceholder("Please enter your password...")
	This:C1470.pwd.asPassword:=True:C214
	
	// Distribute bottom buttons according to their label
	This:C1470.form.group.new(This:C1470.ok; This:C1470.cancel).distributeRigthToLeft()
	This:C1470.ok.helpTip:="Click here to validate your password"
	This:C1470.cancel.helpTip:="Click here to abandon"
	
	This:C1470.ok.disable()