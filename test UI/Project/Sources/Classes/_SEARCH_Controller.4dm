property form : cs:C1710.ui.form

property ring; glass : cs:C1710.ui.static
property box : cs:C1710.ui.input
property button; close : cs:C1710.ui.button

Class constructor
	
	This:C1470.isSubform:=True:C214
	This:C1470.toBeInitialized:=False:C215
	
	// MARK:-Delegates 📦
	var $form : Object
	$form:=Try(JSON Parse:C1218(File:C1566("/SOURCES/Forms/"+Current form name:C1298+"/form.4DForm").getText()))
	This:C1470.form:=cs:C1710.ui.form.new(This:C1470; $form)
	
	This:C1470.form.init()
	
	// MARK:-[STANDARD SUITE]
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function init()
	
	This:C1470.expanded:=False:C215
	
	This:C1470.ring:=This:C1470.form.static.new("ring")
	This:C1470.glass:=This:C1470.form.static.new("glass")
	This:C1470.box:=This:C1470.form.input.new("box")
	This:C1470.button:=This:C1470.form.button.new("button")
	This:C1470.close:=This:C1470.form.button.new("close")
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function handleEvents($e : cs:C1710.ui.evt)
	
	$e:=$e || cs:C1710.ui.evt.new()
	
	// MARK:Form Method
	If ($e.objectName=Null:C1517)
		
		Case of 
				
				//______________________________________________________
			: ($e.load)
				
				This:C1470.form.onLoad()
				
				//______________________________________________________
			: ($e.unload)
				
				This:C1470._boxManager($e)
				
				//______________________________________________________
			: ($e.boundVariableChange)
				
				If (Length:C16(Form:C1466.value)>0)
					
					This:C1470.close.show()
					This:C1470.expand()
					
				Else 
					
					This:C1470.close.hide()
					This:C1470.collapse()
					
				End if 
				
				This:C1470.form.update()
				
				//______________________________________________________
			: ($e.timer)
				
				This:C1470.form.update()
				
				//______________________________________________________
		End case 
		
		return 
		
	End if 
	
	// MARK: Widget Methods
	Case of 
			
			//______________________________________________________
		: (This:C1470.button.catch($e))\
			 || ($e.activate)  // The widget get the focus
			
			This:C1470.box.focus()
			
			//______________________________________________________
		: (This:C1470.box.catch($e))
			
			This:C1470._boxManager($e)
			
			//______________________________________________________
		: (This:C1470.close.catch($e))
			
			This:C1470.box.clear()
			This:C1470.box.focus()
			This:C1470.close.hide()
			
			This:C1470.callHost("")
			
			//______________________________________________________
	End case 
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function onLoad()
	
	This:C1470.form.refresh()
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function update()
	
	This:C1470.options:=This:C1470.form.container ? This:C1470.form.container.data : Null:C1517
	This:C1470.options:=This:C1470.options || Form:C1466.options
	
	If (This:C1470.options=Null:C1517)\
		 || (OB Is empty:C1297(This:C1470.options))
		
		// Default behaviours
		This:C1470.box.setFilter(Is text:K8:3)
		This:C1470.box.setHelpTip(Is macOS:C1572 ? "⌘ F" : "Ctrl+F")
		This:C1470.button.setShortcut("f"; Command key mask:K16:1)
		This:C1470.instant:=True:C214
		
		return 
		
	End if 
	
	This:C1470.box.setFilter(This:C1470.options.type#Null:C1517 ? This:C1470.options.type : Is text:K8:3)
	
	If (This:C1470.options.helpTip#Null:C1517)
		
		This:C1470.box.setHelpTip(String:C10(This:C1470.options.helpTip))
		
	Else 
		
		This:C1470.box.setHelpTip(Is macOS:C1572 ? "⌘ F" : "Ctrl+F")
		
	End if 
	
	If (This:C1470.options.shortcut#Null:C1517)
		
		This:C1470.button.setShortcut(String:C10(This:C1470.options.shortcut); Num:C11(This:C1470.options.modifier))
		
	Else 
		
		This:C1470.button.setShortcut("f"; Command key mask:K16:1)
		
	End if 
	
	This:C1470.instant:=This:C1470.options.instant#Null:C1517 ? This:C1470.options.instant : True:C214
	
	// MARK:-[MANAGERS]
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function _boxManager($e : cs:C1710.ui.evt)
	
	$e:=$e || cs:C1710.ui.evt.new()
	
	Case of 
			
			//______________________________________________________
		: ($e.gettingFocus)
			
			This:C1470.ring.setColors(Highlight menu background color:K23:7)
			This:C1470.expand()
			
			//______________________________________________________
		: ($e.losingFocus)
			
			If (Not:C34(This:C1470.instant))
				
				// Transfer the text to the host form
				This:C1470.callHost()
				
			End if 
			
			If (Length:C16(Get edited text:C655)=0)
				
				This:C1470.collapse()
				
			End if 
			
			This:C1470.ring.foregroundColor:=This:C1470.form.darkScheme ? "grey" : "silver"
			
			//______________________________________________________
		: ($e.afterEdit)\
			 && (This:C1470.instant)
			
			// Instant transfer of text to the host form
			This:C1470.callHost()
			
			//______________________________________________________
	End case 
	
	This:C1470.close.show(Length:C16(Get edited text:C655)>0)
	
	// MARK:-[IN-HOUSE]
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function callHost($value)
	
	$value:=Value type:C1509($value)=Is text:K8:3 ? $value : Get edited text:C655
	
	If (This:C1470.form.container=Null:C1517)
		
		OBJECT SET SUBFORM CONTAINER VALUE:C1784({searchValue: $value})
		
	Else 
		
		This:C1470.form.container.searchValue:=$value
		
	End if 
	
	This:C1470.form.callParent(-1)
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function expand()
	
	If (Not:C34(This:C1470.expanded))
		
		var $ring : cs:C1710.ui.coord
		$ring:=This:C1470.ring.coordinates
		
		var $glass : cs:C1710.ui.coord
		$glass:=cs:C1710.ui.coord.new(This:C1470.glass)
		
		This:C1470.glass.setCoordinates(\
			$ring.left+3; \
			$ring.top+3; \
			$ring.left+3+$glass.width; \
			$ring.top+3+$glass.height)
		
		This:C1470.box.setCoordinates($ring.left+3+17; \
			$ring.top+2; \
			$ring.right-3; \
			$ring.bottom-2)
		
		This:C1470.box.placeholder:=String:C10(This:C1470.options.placeholder)
		This:C1470.expanded:=True:C214
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function collapse()
	
	This:C1470.glass.restorePosition()
	This:C1470.box.restorePosition()
	This:C1470.box.placeholder:=""
	
	This:C1470.expanded:=False:C215