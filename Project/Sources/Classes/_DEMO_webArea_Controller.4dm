property form : cs:C1710.formDelegate
property area : cs:C1710.webAreaDelegate
property google; forum; bk; previous; next : cs:C1710.buttonDelegate
property url : cs:C1710.inputDelegate

Class constructor
	
	This:C1470.isSubform:=False:C215
	This:C1470.toBeInitialized:=False:C215
	
	// MARK:-Delegates 📦
	This:C1470.form:=cs:C1710.formDelegate.new(This:C1470)
	
	// MARK:-
	This:C1470.form.init()
	
	// MARK:-[Standard Suite]
	// === === === === === === === === === === === === === === === === === === === === ===
Function init()
	
/*
Instantiate the widgets we want to manipulate.
*/
	
	This:C1470.area:=This:C1470.form.webArea.new("Web Area")
	
	This:C1470.url:=This:C1470.form.input.new("url")
	
	This:C1470.google:=This:C1470.form.button.new("Button")
	This:C1470.forum:=This:C1470.form.button.new("Button1")
	This:C1470.bk:=This:C1470.form.button.new("Button2")
	This:C1470.previous:=This:C1470.form.button.new("Button3")
	This:C1470.next:=This:C1470.form.button.new("Button4")
	
	// Attach private data to the url buttons
	This:C1470.google.data:={url: "https://www.google.com/"}
	This:C1470.forum.data:={url: "https://discuss.4d.com/"}
	This:C1470.bk.data:={url: "https://kb.4d.com/"}
	
	// Define url button callbacks
	This:C1470.google.setCallback(Formula:C1597(formGetInstance.area.open(formGetInstance.google.data.url)))
	This:C1470.forum.setCallback(Formula:C1597(formGetInstance.area.open(formGetInstance.forum.data.url)))
	This:C1470.bk.setCallback(Formula:C1597(formGetInstance.area.open(formGetInstance.bk.data.url)))
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function handleEvents($e : cs:C1710.evt)
	
	$e:=$e || cs:C1710.evt.new()
	
	If ($e.form)  // <== FORM METHOD
		
		Case of 
				
				//==============================================
			: ($e.load)
				
				This:C1470.form.onLoad()
				
				//==============================================
			: ($e.timer)
				
				This:C1470.form.update()
				
				//==============================================
		End case 
		
	Else   // <== WIDGETS METHOD
		
		var $area : cs:C1710.webAreaDelegate
		$area:=This:C1470.area
		
		Case of 
				
				//==============================================
			: (This:C1470.google.catch($e))\
				 || (This:C1470.forum.catch($e))\
				 || (This:C1470.bk.catch($e))
				
				// Done by the associated callback
				
				//==============================================
			: (This:C1470.url.catch($e; [On Data Change:K2:15]))
				
				$area.open(This:C1470.url.value)
				
				//==============================================
			: ($area.catch($e))
				
				This:C1470.url.value:=$area.url
				
				//==============================================
			: (This:C1470.previous.catch($e))
				
				If ($e.click)
					
					$area.back()
					
				Else 
					
					$area.backMenu()
					
				End if 
				
				//==============================================
			: (This:C1470.next.catch($e))
				
				If ($e.click)
					
					$area.forward()
					
				Else 
					
					$area.forwardMenu()
					
				End if 
				
				//==============================================
		End case 
		
		This:C1470.form.refresh()
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function onLoad()
	
	// Create and install a minimal menu bar
	cs:C1710.menuBar.new().defaultMinimalMenuBar().set()
	
	// Set window title
	This:C1470.form.window.title:="Browser"
	
	cs:C1710.groupDelegate.new([\
		This:C1470.google; \
		This:C1470.forum; \
		This:C1470.bk; \
		This:C1470.previous; \
		This:C1470.next; \
		This:C1470.url]).distributeLeftToRight()
	
	This:C1470.area.open(This:C1470.google.data.url)
	
	This:C1470.update()
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function update()
	
	var $url : Text
	var $area : cs:C1710.webAreaDelegate
	
	$area:=This:C1470.area
	$url:=$area.url
	
	This:C1470.google.enable(Position:C15(This:C1470.google.data.url; $url)#1)
	This:C1470.forum.enable(Position:C15(This:C1470.forum.data.url; $url)#1)
	This:C1470.bk.enable(Position:C15(This:C1470.bk.data.url; $url)#1)
	
	This:C1470.previous.enable($area.canBackwards)
	This:C1470.next.enable($area.canForwards)
	