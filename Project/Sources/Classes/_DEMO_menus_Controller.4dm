property form : cs:C1710.formDelegate
property menuBar : cs:C1710.menuBar
property fonts; \
families; \
windows; \
withFamilies; \
attachMenu : cs:C1710.buttonDelegate
property input; \
sample : cs:C1710.inputDelegate

Class constructor
	
	This:C1470.isSubform:=False:C215
	This:C1470.toBeInitialized:=False:C215
	
	// MARK:-Delegates 📦
	This:C1470.form:=cs:C1710.formDelegate.new(This:C1470)
	
	This:C1470.form.init()
	
	// MARK:-[Standard Suite]
	// === === === === === === === === === === === === === === === === === === === === ===
Function init()
	
	// Create and install the menu bar
/*
	
📌 Note that by doing at this time, the menu bar will be available
   even if you test the form execution by clicking on the "Execute form" button.
	
*/
	
	// Create the menu File
	var $menuFile : cs:C1710.menu
	$menuFile:=cs:C1710.menu.new()\
		.append("Close").shortcut("W").action(ak cancel:K76:36)\
		.line()\
		.append("MSC").shortcut("M"; Option key mask:K16:7).action(ak msc:K76:63)\
		.line()\
		.append("Settings"; "settings").method(Formula:C1597(formMenuHandle).source)
	
	// Get a standard edit menu
	var $menuEdit : cs:C1710.menu
	$menuEdit:=cs:C1710.menu.new().edit()
	
/*
	
📌 Note that a third empty "Windows" is added and will be filled in later.
	
*/
	
	This:C1470.menuBar:=cs:C1710.menuBar.new([\
		":xliff:CommonMenuFile"; $menuFile; \
		":xliff:CommonMenuEdit"; $menuEdit; \
		"Windows"; cs:C1710.menu.new()\
		]).set()
	
	This:C1470.windowsMenuIndex:=3
	
	// Instantiate the widgets we want to manipulate.
	
	// Mark: The choice is yours
	This:C1470.input:=This:C1470.form.input.new("Input1")
	This:C1470.input.events:=On Getting Focus:K2:7
	
	// Mark: Fonts
	This:C1470.fonts:=This:C1470.form.button.new("Button")
	This:C1470.sample:=This:C1470.form.input.new("Input")
	This:C1470.withFamilies:=This:C1470.form.button.new("Check Box")
	This:C1470.withFamilies.value:=False:C215
	
	// Mark: Windows
	This:C1470.windows:=This:C1470.form.button.new("Button1")
	
	// Mark: Add extra menu
	This:C1470.attachMenu:=This:C1470.form.button.new("Button2")
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function handleEvents($e : cs:C1710.evt)
	
	$e:=$e || cs:C1710.evt.new()
	
	If ($e.form)
		
		// Mark: FORM METHOD
		
		Case of 
				
				//==============================================
			: ($e.load)
				
				This:C1470.form.onLoad()
				
				//==============================================
			: ($e.activate)
				
				// Update the "Windows" menu
				This:C1470.menuBar.update(This:C1470.windowsMenuIndex; cs:C1710.menu.new().windows())
				
				//==============================================
			: ($e.menuSelected)\
				 && ((Menu selected:C152\65536)=This:C1470.windowsMenuIndex)
				
				cs:C1710.windowDelegate.new(This:C1470.menuBar.getMenuItemParameter(Is longint:K8:6)).bringToFront()
				
				//==============================================
		End case 
		
	Else 
		
		// Mark: WIDGETS METHOD
		
		Case of 
				
				//==============================================
			: (This:C1470.fonts.catch($e))
				
				This:C1470._fontsManager()
				
				//==============================================
			: (This:C1470.windows.catch($e))
				
				This:C1470._windowsManager()
				
				//==============================================
			: (This:C1470.attachMenu.catch($e))
				
				This:C1470._extraManager()
				
				//==============================================
			: (This:C1470.input.catch($e))
				
				This:C1470._inputManager()
				
				//==============================================
		End case 
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function onLoad()
	
	/// Mark: Set window title
	This:C1470.form.window.title:="Menus"
	
	// Mark: Linking a menu to font and window buttons
	This:C1470.fonts.setLinkedPopupMenu()
	This:C1470.windows.setLinkedPopupMenu()
	
	// Mark: Distribute according to labels
	cs:C1710.groupDelegate.new(This:C1470.fonts; This:C1470.withFamilies).distributeLeftToRight()
	This:C1470.windows.alignCenter()
	
	// Mark: Hide font sample
	This:C1470.sample.hide()
	
	// Mark: Remove any focus
	This:C1470.form.removeFocus()
	
	// MARK:-
	// === === === === === === === === === === === === === === === === === === === === ===
Function _fontsManager()
	
	var $menu : cs:C1710.menu
	
	// Display a contextual font menu
	$menu:=cs:C1710.menu.new().fonts(This:C1470.withFamilies.value).popup()
	
	If ($menu.selected)
		
		This:C1470.sample.value:=$menu.choice
		This:C1470.sample.font:=$menu.choice
		This:C1470.sample.bestSize(Align center:K42:3).show()
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function _windowsManager()
	
	var $menu : cs:C1710.menu
	
	// Display the window menu
	$menu:=cs:C1710.menu.new().windows().popup()
	
	If ($menu.selected)
		
		cs:C1710.windowDelegate.new(Num:C11($menu.choice)).bringToFront()
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function _extraManager()
	
	var $menu : cs:C1710.menu
	
	If (This:C1470.menuBar.itemCount()=3)
		
		// Mark: Add
		var $menuHandle : Text
		$menuHandle:=Formula:C1597(formMenuHandle).source
		
		$menu:=cs:C1710.menu.new()\
			.append("Line 1"; "Line 1").method($menuHandle)\
			.append("Line 2"; "Line 2").method($menuHandle)\
			.append("Language…"; cs:C1710.menu.new()\
			.append("English"; "en").setData("en"; "Hello world").method($menuHandle)\
			.append("Français"; "fr").setData("fr"; "Bonjour le monde").method($menuHandle)\
			.append("日本語"; "jp").setData("jp"; "ハロー・ワールド").method($menuHandle))
		
		This:C1470.menuBar.append("Extra"; $menu)
		This:C1470.attachMenu.title:="Remove \"Extra\" menu from the menu bar"
		
	Else 
		
		// Mark: Remove
		This:C1470.menuBar.delete(This:C1470.menuBar.itemCount())
		This:C1470.attachMenu.title:="Add \"Extra\" menu to the menu bar"
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function _inputManager()
	
	var $menu : cs:C1710.menu
	
	$menu:=cs:C1710.menu.new()\
		.append("Line 1"; "Line 1")\
		.append("Line 2"; "Line 2")\
		.append("Language…"; cs:C1710.menu.new()\
		.append("English"; "en").setData("en"; "Hello world")\
		.append("Français"; "fr").setData("fr"; "Bonjour le monde")\
		.append("日本語"; "jp").setData("jp"; "ハロー・ワールド"))\
		.popup(This:C1470.input)
	
	If ($menu.selected)
		
		This:C1470.input.value:=$menu.getData($menu.choice) || $menu.choice
		
	End if 
	
	This:C1470.form.focusNext()
	
	// MARK:-
	// === === === === === === === === === === === === === === === === === === === === ===
Function handleMenus($what : Text)
	
	$what:=$what || Get selected menu item parameter:C1005
	
	Case of 
			
			//______________________________________________________
		: ($what="settings")
			
			OPEN SETTINGS WINDOW:C903("/Database/General"; False:C215; Structure settings:K5:26)
			
			//______________________________________________________
		: ($what="hello")
			
			ALERT:C41("Hello world")
			
			//______________________________________________________
		: ($what="en")\
			 | ($what="fr")\
			 | ($what="jp")
			
			This:C1470.input.value:=This:C1470.menuBar.getData($what)
			
			//______________________________________________________
		Else 
			
			ALERT:C41("Unmanaged menu item: \""+$what+"\"…\r\rWe are going tout doux ;-)")
			
			//______________________________________________________
	End case 