property form : cs:C1710.formDelegate
property drag; reduce; zoom; close : cs:C1710.buttonDelegate
property isModal : Boolean
property options : Integer

Class constructor
	
	This:C1470.isSubform:=True:C214
	This:C1470.toBeInitialized:=False:C215
	
	// MARK:-Delegates 📦
	This:C1470.form:=cs:C1710.formDelegate.new(This:C1470)
	
	This:C1470.isModal:=This:C1470.form.window.type=Modal dialog:K27:2
	This:C1470.options:=0
	
	If (Is macOS:C1572)
		
		var $in; $out : Text
		LAUNCH EXTERNAL PROCESS:C811("defaults read NSGlobalDomain"; $in; $out)
		
		If (OK=1)
			
			ARRAY LONGINT:C221($pos; 0x0000)
			ARRAY LONGINT:C221($len; 0x0000)
			
			If (Match regex:C1019("(?mi-s)AppleActionOnDoubleClick\\s*=\\s*([^;]*);"; $out; 1; $pos; $len))
				
				This:C1470.AppleActionOnDoubleClick:=Substring:C12($out; $pos{1}; $len{1})
				
			End if 
		End if 
		
	Else 
		
		// TODO:Windows part ?
		
	End if 
	
	This:C1470.form.init()
	
	// MARK:-[Standard Suite]
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function init()
	
	This:C1470.drag:=This:C1470.form.button.new("dragWindow")
	
	If (Is macOS:C1572)
		
		This:C1470.reduce:=This:C1470.form.button.new("minusMac")
		This:C1470.zoom:=This:C1470.form.button.new("plusMac")
		This:C1470.close:=This:C1470.form.button.new("closeMac")
		
	Else 
		
		This:C1470.reduce:=This:C1470.form.button.new("minusWin")
		This:C1470.zoom:=This:C1470.form.button.new("plusWin")
		This:C1470.close:=This:C1470.form.button.new("closeWin")
		
	End if 
	
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
			: ($e.boundVariableChange)
				
				// ⚠️ The container must be of numeric type
				
				This:C1470.options:=OBJECT Get subform container value:C1785
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
		: (This:C1470.drag.catch($e))
			
			If ($e.doubleClick)
				
				Case of 
						
						//………………………………………………………………………………………………………………
					: (This:C1470.AppleActionOnDoubleClick=Null:C1517)\
						 || (This:C1470.AppleActionOnDoubleClick="none")
						
						// <NOTHING MORE TO DO>
						//………………………………………………………………………………………………………………
					: (This:C1470.AppleActionOnDoubleClick="Minimize")
						
						If (Not:C34(This:C1470.reduceDisabled))
							
							This:C1470.form.window.reduce()
							
						End if 
						
						//………………………………………………………………………………………………………………
					: (This:C1470.AppleActionOnDoubleClick="Maximize")
						
						This:C1470.miniaturiseOrNot()
						
						//………………………………………………………………………………………………………………
				End case 
				
			Else 
				
				This:C1470.form.window.drag()
				
			End if 
			
			//______________________________________________________
		: (This:C1470.close.catch($e))
			
			If (Not:C34(This:C1470.closeDisabled))
				
				CANCEL:C270
				
			End if 
			
			//______________________________________________________
		: (This:C1470.reduce.catch($e))
			
			If (Not:C34(This:C1470.reduceDisabled))
				
				This:C1470.form.window.reduce()
				
			End if 
			
			//______________________________________________________
		: (This:C1470.zoom.catch($e))
			
			This:C1470.miniaturiseOrNot()
			
			//______________________________________________________
		: (Is Windows:C1573)
			
			// The rollover animation is managed by the button icon, which has 4 states
			//______________________________________________________
		: ($e.mouseEnter)
			
			If (Not:C34(This:C1470.closeDisabled))
				
				This:C1470.close.setPicture("macOS/closeOver.png")
				
			End if 
			
			If (Not:C34(This:C1470.zoomDisabled))
				
				This:C1470.zoom.setPicture(Is window maximized:C1830(This:C1470.form.window.ref) ? "macOS/zoomRestoreOver.png" : "macOS/zoomEnlargeOver.png")
				
			End if 
			
			If (Not:C34(This:C1470.reduceDisabled))
				
				This:C1470.reduce.setPicture("macOS/minimizeOver.png")
				
			End if 
			
			//______________________________________________________
		: ($e.mouseLeave)
			
			If (Not:C34(This:C1470.closeDisabled))
				
				This:C1470.close.setPicture(This:C1470.documentModified ? "macOS/closeModified.png" : "macOS/close.png")
				
			End if 
			
			If (Not:C34(This:C1470.zoomDisabled))
				
				This:C1470.zoom.setPicture("macOS/zoom.png")
				
			End if 
			
			If (Not:C34(This:C1470.reduceDisabled))
				
				This:C1470.reduce.setPicture("macOS/minimize.png")
				
			End if 
			
			//______________________________________________________
	End case 
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function onLoad()
	
	This:C1470.form.refresh()
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function update()
	
	If (Is macOS:C1572)
		
		If (This:C1470.form.window.isFrontmost())
			
			If (This:C1470.closeDisabled)
				
				This:C1470.close.setPicture("macOS/disabled.png")
				
			Else 
				
				This:C1470.close.setPicture(This:C1470.documentModified ? "macOS/closeModified.png" : "macOS/close.png")
				
			End if 
			
			This:C1470.reduce.setPicture(This:C1470.reduceDisabled ? "macOS/disabled.png" : "macOS/minimize.png")
			
			This:C1470.zoom.setPicture(This:C1470.zoomDisabled ? "macOS/disabled.png" : "macOS/zoom.png")
			
		Else 
			
			If (This:C1470.closeDisabled)
				
				This:C1470.close.setPicture("macOS/disabled.png")
				
			Else 
				
				This:C1470.close.setPicture(This:C1470.documentModified ? "macOS/disabledModified.png" : "macOS/disabled.png")
				
			End if 
			
			This:C1470.zoom.setPicture("macOS/disabled.png")
			This:C1470.reduce.setPicture("macOS/disabled.png")
			
		End if 
		
	Else 
		
		If (This:C1470.form.window.isFrontmost())
			
			This:C1470.close.enable()
			This:C1470.reduce.enable(Not:C34(This:C1470.isModal))
			This:C1470.zoom.enable()
			
		Else 
			
			This:C1470.close.disable()
			This:C1470.reduce.disable()
			This:C1470.zoom.disable()
			
		End if 
	End if 
	
	This:C1470.form.callParent(On Load:K2:1)  // Resize
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get documentModified() : Boolean
	
	return This:C1470.options ?? 0
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get reduceDisabled() : Boolean
	
	return This:C1470.isModal | (This:C1470.options ?? 1)
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get zoomDisabled() : Boolean
	
	return This:C1470.options ?? 2
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get closeDisabled() : Boolean
	
	return This:C1470.options ?? 3
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function miniaturiseOrNot()
	
	If (This:C1470.zoomDisabled)
		
		return 
		
	End if 
	
	If (Is window maximized:C1830(This:C1470.form.window.ref))
		
		This:C1470.form.window.minimize()
		
		If (Is Windows:C1573)
			
			This:C1470.zoom.setPicture("Windows/maximize.png")
			
		End if 
		
	Else 
		
		This:C1470.form.window.maximize()
		
		If (Is Windows:C1573)
			
			This:C1470.zoom.setPicture("Windows/restore.png")
			
		End if 
	End if 
	
	This:C1470.form.callParent(On Load:K2:1)  // Resize