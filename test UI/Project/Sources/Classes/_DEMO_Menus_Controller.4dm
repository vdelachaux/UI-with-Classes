property form : cs:C1710.ui.form
property menuBar : cs:C1710.ui.menuBar
property fonts; families; windows; withFamilies; attachMenu : cs:C1710.ui.button
property choice; sample : cs:C1710.ui.input
property windowsMenuIndex : Integer:=3

Class constructor
	
	// MARK:Delegates 📦
	This:C1470.form:=cs:C1710.ui.form.new(This:C1470; Try(JSON Parse:C1218(File:C1566("/SOURCES/Forms/"+Current form name:C1298+"/form.4DForm").getText())))
	
	This:C1470.form.init()
	
	// MARK:-[STANDARD SUITE]
	// === === === === === === === === === === === === === === === === === === === === ===
Function init()
	
	// Mark:Menu bar
	
	// 1- Create the menu File
	
	// 📌 XLIFF resname are automatically resolved
	
	var $menuFile : cs:C1710.ui.menu
	$menuFile:=cs:C1710.ui.menu.new()\
		.append("close").shortcut("W").action(ak cancel:K76:36)\
		.line()\
		.append("MSC").shortcut("M"; Option key mask:K16:7).action(ak msc:K76:63)\
		.line()\
		.append("settings"; "settings").method(Formula:C1597(formMenuHandle).source)
	
/*
	
📌 The formMenuHandle shared method calls the _handleMenus() function of the current form class
	
*/
	
	// 2- Get a standard edit menu
	var $menuEdit : cs:C1710.ui.menu
	$menuEdit:=cs:C1710.ui.menu.new().edit()
	
	// 3 - With all the menus defined, we can now define and install the menu bar.
	
/*
	
📌 Note that a third empty menu "Windows" is added and will be filled in later.
	
📌 XLIFF resname are automatically resolved
	
*/
	
	This:C1470.menuBar:=cs:C1710.ui.menuBar.new([\
		":xliff:CommonMenuFile"; $menuFile; \
		":xliff:CommonMenuEdit"; $menuEdit; \
		"window"; cs:C1710.ui.menu.new()\
		]).set()
	
/*
	
📌 Note that by doing at this time or in the function onLoad(), the menu bar will be available
   even if you test the form execution by clicking on the "Execute form" button.
	
*/
	
/*
Instantiate the widgets we need to manipulate.
	
💡 Give them a name that makes your code readable independently of the name of the object in the form
	
*/
	
	// Mark: The choice is yours
	// This text zone will trigger the display of a contextual menu when it gets the focus.
	This:C1470.choice:=This:C1470.form.Input("Input1")
	This:C1470.choice.events:=[On Getting Focus:K2:7]
	
	// Mark: Fonts
	// This button will display a font menu.
	This:C1470.fonts:=This:C1470.form.Button("Button")
	
	// This text box will display an example of the selected font.
	This:C1470.sample:=This:C1470.form.Input("Input")
	
	// This check box allows you to choose whether or not fonts are grouped by family.
	This:C1470.withFamilies:=This:C1470.form.Button("Check Box")
	This:C1470.withFamilies.value:=False:C215  // Without faily by default
	
	// Mark: Windows
	// This button displays a menu of open windows.
	This:C1470.windows:=This:C1470.form.Button("Button1")
	
	// Mark: Add extra menu
	// This button is used to install/remove an "Extra" menu from the menu bar.
	This:C1470.attachMenu:=This:C1470.form.Button("Button2")
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function handleEvents($e : cs:C1710.ui.evt)
	
	$e:=$e || cs:C1710.ui.evt.new()
	
	If ($e.form)
		
		// Mark:FORM METHOD
		Case of 
				
				//==============================================
			: ($e.load)
				
				This:C1470.form.onLoad()
				
				//==============================================
			: ($e.activate)
				
				// Update the "Windows" menu
				This:C1470.menuBar.update(This:C1470.windowsMenuIndex; cs:C1710.ui.menu.new().windows())
				
				//==============================================
			: ($e.menuSelected)\
				 && ((Menu selected:C152\65536)=This:C1470.windowsMenuIndex)
				
				// The user has selected an item from the "Windows" menu: 
				// Bring the selected window to the foreground
				cs:C1710.ui.window.new(This:C1470.menuBar.getMenuItemParameter(Is longint:K8:6)).bringToFront()
				
				//==============================================
		End case 
		
		return 
		
	End if 
	
	// Mark:WIDGETS METHOD
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
		: (This:C1470.choice.catch($e))
			
			This:C1470._inputManager()
			
			//==============================================
	End case 
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function onLoad()
	
	/// Mark: Set window title
	This:C1470.form.window.title:="Les menus par le menu / Menus in detail"
	
	// Mark: Linking a menu to font and window buttons
	This:C1470.fonts.setLinkedPopupMenu()
	This:C1470.windows.setLinkedPopupMenu()
	
	// Mark: Distribute according to labels
	cs:C1710.ui.group.new([This:C1470.fonts; This:C1470.withFamilies]).distributeLeftToRight()
	This:C1470.windows.bestSize(Align center:K42:3)
	This:C1470.attachMenu.bestSize(Align center:K42:3)
	
	// Mark: Hide font sample
	This:C1470.sample.hide()
	
	// Mark: Remove any focus
	This:C1470.form.removeFocus()
	
	// MARK:-[MANAGERS]
	// === === === === === === === === === === === === === === === === === === === === ===
Function _fontsManager()
	
/*
The fonts() function in the menu class returns a menu of installed fonts
grouped by family if the parameter passed is True.
	
The popup() function display the contextual menu
*/
	var $menu : cs:C1710.ui.menu
	$menu:=cs:C1710.ui.menu.new().fonts(This:C1470.withFamilies.value).popup()
	
	If ($menu.selected)
		
		// Display the item selected in the example
		This:C1470.sample.value:=$menu.choice
		
		// Set the text box font to the selected font
		This:C1470.sample.font:=$menu.choice
		
		// Adapt width & height
		This:C1470.sample.bestSize(Align center:K42:3).show()
		This:C1470.sample.height:=This:C1470.sample.getBestHeight()
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function _windowsManager()
	
/*
The windows() function in the menu class returns a menu of windows open in 4D
	
The popup() function display the contextual menu
*/
	
	var $menu : cs:C1710.ui.menu
	$menu:=cs:C1710.ui.menu.new().windows().popup()
	
	If ($menu.selected)
		
		// Bring the selected window to the foreground
		cs:C1710.ui.window.new(Num:C11($menu.choice)).bringToFront()
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function _extraManager()
	
	var $menu : cs:C1710.ui.menu
	
	If (This:C1470.menuBar.itemCount()=3)
		
		// Mark: Add the Extra menu
		
/*
		
📌 $menuHandle will call the _handleMenus() function of this class
		
*/
		var $menuHandle : Text
		$menuHandle:=Formula:C1597(formMenuHandle).source
		
/*
		
Create a menu with 2 lines and a "Language" submenu
		
📌 Sub-menu items are associated with data, 
   in this case a character string that will be used if the item is selected.
   See _handleMenus() below
		
		
*/
		$menu:=cs:C1710.ui.menu.new()\
			.append("Line 1"; "Line 1").method($menuHandle).icon("#green.png")\
			.append("Line 2"; "Line 2").method($menuHandle).icon("#red.png")\
			.append("language"; cs:C1710.ui.menu.new()\
			.append("english"; "en").setData("en"; "Hello world").method($menuHandle)\
			.append("french"; "fr").setData("fr"; "Bonjour le monde").method($menuHandle)\
			.append("日本語"; "jp").setData("jp"; "ハロー・ワールド").method($menuHandle))
		
		// Append the menu to the menu bar
		This:C1470.menuBar.append("Extra"; $menu)
		
		// Update the button title
		// 📌 XLIFF resname are automatically resolved
		This:C1470.attachMenu.title:="removeExtraMenuFromTheMenuBar"
		
	Else 
		
		// Mark: Remove the Extra menu
		This:C1470.menuBar.delete(This:C1470.menuBar.itemCount())
		
		// Update the button title
		// 📌 XLIFF resname are automatically resolved
		This:C1470.attachMenu.title:="addExtraMenuToTheMenuBar"
		
	End if 
	
	// Adapt button size to the label
	This:C1470.attachMenu.bestSize(Align center:K42:3)
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function _inputManager()
	
/*
	
Create a menu with 2 lines and a "Language" submenu
	
📌 Sub-menu items are associated with data, 
   in this case a character string that will be used if the item is selected.
	
*/
	var $menu : cs:C1710.ui.menu
	$menu:=cs:C1710.ui.menu.new()\
		.append("Line 1"; "Line 1").icon("#green.png")\
		.append("Line 2"; "Line 2").icon("#red.png")\
		.append("Language…"; cs:C1710.ui.menu.new()\
		.append("English"; "en").setData("en"; "Hello world")\
		.append("Français"; "fr").setData("fr"; "Bonjour le monde")\
		.append("日本語"; "jp").setData("jp"; "ハロー・ワールド"))\
		.popup(This:C1470.choice)
	
	If ($menu.selected)
		
/*
Display the character string saved as data associated with the selected menu item
		
OR
		
the parameter of the selected menu item if no data is associated.
*/
		This:C1470.choice.value:=$menu.getData($menu.choice) || $menu.choice
		
	End if 
	
	If (Is Windows:C1573)
		
		This:C1470.form.focusNext()
		
	Else 
		
		// Only one focusable widget
		This:C1470.form.removeFocus()
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function _handleMenus($what : Text)
	
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
			
			// Display the character string saved as data associated with the selected item
			This:C1470.choice.value:=This:C1470.menuBar.getData($what)
			
			//______________________________________________________
		Else 
			
			ALERT:C41("Unmanaged menu item: \""+$what+"\"…\r\rWe are going tout doux ;-)")
			
			//______________________________________________________
	End case 