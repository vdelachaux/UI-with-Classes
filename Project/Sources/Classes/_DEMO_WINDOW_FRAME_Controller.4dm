property form : cs:C1710.formDelegate
property bar : cs:C1710.subformDelegate

Class constructor
	
	// MARK:-Delegates 📦
	This:C1470.form:=cs:C1710.formDelegate.new(This:C1470)
	
	This:C1470.form.init()
	
	// MARK:-[Standard Suite]
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function init()
	
	// MARK:-Title bar
	This:C1470.bar:=This:C1470.form.subform.new("bar")
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function handleEvents($e : cs:C1710.evt)
	
	$e:=$e || cs:C1710.evt.new()
	
	// MARK:Form Method
	If ($e.objectName=Null:C1517)
		
		Case of 
				
				//______________________________________________________
			: ($e.load)
				
				This:C1470.form.onLoad()
				
				//______________________________________________________
			: ($e.timer)
				
				This:C1470.form.update()
				
				//______________________________________________________
			: ($e.activate)
				
				This:C1470.bar.refresh()
				
				//______________________________________________________
			: ($e.deactivate)
				
				This:C1470.bar.refresh()
				
				//______________________________________________________
			: ($e.unload)
				
				//
				
				//______________________________________________________
		End case 
		
		return 
		
	End if 
	
	// MARK: Widget Methods
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function onLoad()
	
	// Resize the window frame widget
	This:C1470._barManager()
	
	This:C1470.form.refresh()
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function update()
	
	//
	
	// MARK:-Managers
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function _barManager($e : cs:C1710.evt)
	
	$e:=$e || cs:C1710.evt.new()
	
	This:C1470.bar.left:=0
	This:C1470.bar.width:=This:C1470.form.dimensions.width