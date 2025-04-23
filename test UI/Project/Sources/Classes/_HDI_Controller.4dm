property form : cs:C1710.ui.form
property windowFrame : cs:C1710.ui.subform
property title : cs:C1710.ui.static
property titleBackground; desc; tip : cs:C1710.ui.static
property titleButtons; detail : cs:C1710.ui.group
property editForm; editClass; run : cs:C1710.ui.button
property sidebar : cs:C1710.ui.listbox

property demos:=[]
property controllers:=[]

Class constructor
	
	// MARK:Delegates 📦
	This:C1470.form:=cs:C1710.ui.form.new(This:C1470; Try(JSON Parse:C1218(File:C1566("/SOURCES/Forms/"+Current form name:C1298+"/form.4DForm").getText())))
	
	This:C1470.form.init()
	
	// MARK:-[STANDARD SUITE]
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function init()
	
	// Mark:Title bar
	This:C1470.windowFrame:=This:C1470.form.Subform("windowFrame")
	
	This:C1470.title:=This:C1470.form.Static("windowTitle")
	This:C1470.titleBackground:=This:C1470.form.Static("titleBackground")
	
	// Edit buttons
	This:C1470.titleButtons:=This:C1470.form.Group()
	This:C1470.editForm:=This:C1470.form.Button("form").addToGroup(This:C1470.titleButtons)
	This:C1470.editClass:=This:C1470.form.Button("class").addToGroup(This:C1470.titleButtons)
	
	// Mark:Sidebar
	This:C1470.demos.push({\
		name: Localized string:C991("title_1"); \
		form: "DEMO_1"; \
		comments: Localized string:C991("desc_1")})
	
	This:C1470.demos.push({\
		name: Localized string:C991("title_2"); \
		form: "DEMO_Menus"; \
		comments: Localized string:C991("desc_2")})
	
	This:C1470.demos.push({\
		name: Localized string:C991("title_3"); \
		form: "DEMO_constraints"; \
		comments: Localized string:C991("desc_3")})
	
	This:C1470.demos.push({\
		name: "CSS"; \
		form: "HDI CSS"; \
		comments: Localized string:C991("desc_4")})
	
	This:C1470.demos.push({\
		name: Localized string:C991("title_5"); \
		form: "DEMO_SEARCH"; \
		comments: Localized string:C991("desc_5")})
	
	This:C1470.demos.push({\
		name: Localized string:C991("title_6"); \
		form: "DEMO_TAB_CONTROL"; \
		comments: Localized string:C991("desc_6")})
	
	This:C1470.demos.push({\
		name: Localized string:C991("title_7"); \
		form: "DEMO_Dropdown"; \
		comments: Localized string:C991("desc_7")})
	
	This:C1470.sidebar:=This:C1470.form.Listbox("sidebar")
	
	// Mark:Detail panel
	This:C1470.detail:=This:C1470.form.Group()
	This:C1470.desc:=This:C1470.form.Static("desc").addToGroup(This:C1470.detail)
	This:C1470.run:=This:C1470.form.Button("run").addToGroup(This:C1470.detail)
	
	This:C1470.tip:=This:C1470.form.Static("tip")
	
	// Mark:-[Constraints]
	// -> The editing buttons must remain centred on the detail panel.
	This:C1470.form.constraints.new(This:C1470.titleButtons).centerHorizontally.with("common_background")
	
	// -> The "run" button must be anchored in the center of the panel.
	This:C1470.form.constraints.add("run").anchoredInTheCenter.of("common_background")
	
	// Mark: Controlers
	ARRAY TEXT:C222($classes; 0x0000)
	METHOD GET PATHS:C1163(Path class:K72:19; $classes)
	ARRAY TO COLLECTION:C1563(This:C1470.controllers; $classes)
	
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
			: ($e.resize)
				
				This:C1470.form.constraints.apply()
				
				//______________________________________________________
			: ($e.timer)
				
				This:C1470.form.update()
				
				//______________________________________________________
			: ($e.deactivate)
				
				This:C1470.windowFrame.refresh()
				
				//______________________________________________________
			: ($e.activate)
				
				This:C1470.windowFrame.refresh()
				
				//______________________________________________________
		End case 
		
		return 
		
	End if 
	
	// MARK: Widget Methods
	Case of 
			
			//______________________________________________________
		: (This:C1470.sidebar.catch($e))
			
			This:C1470._sidebarManager($e)
			
			//______________________________________________________
		: (This:C1470.run.catch($e))
			
			var $p : Integer
			
			// By default, the method name is the same as the form name
			If (This:C1470.demoSelected.method=Null:C1517)
				
				$p:=New process:C317(Formula:C1597(_DEMO).source; 0; This:C1470.demoSelected.form; This:C1470.demoSelected)
				
			Else 
				
				$p:=New process:C317(This:C1470.demoSelected.method; 0; This:C1470.demoSelected.method)
				
			End if 
			
			//______________________________________________________
		: (This:C1470.editForm.catch($e))
			
			FORM EDIT:C1749(String:C10(This:C1470.demoSelected.form))
			
			//______________________________________________________
		: (This:C1470.editClass.catch($e))
			
			METHOD OPEN PATH:C1213("[class]/_"+This:C1470.demoSelected.form+"_Controller")
			
			//______________________________________________________
	End case 
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function onLoad()
	
	// Create and install a minimal menu bar
	cs:C1710.ui.menuBar.new().defaultMinimalMenuBar().set()
	
	// Force resize the window frame widget
	This:C1470._windowFrameManager()
	
	// Adapt the width of the title to its content
	This:C1470.title.bestSize()
	
	If (Is Windows:C1573)
		
		// Position the window title 16px from the window icon or the Back button.
		// If there is no icon or Back button, place the window title 16 px from the far left border.
		
		This:C1470.title.moveHorizontally(-(This:C1470.title.left-16))
		
	End if 
	
	// Resize and position buttons to match the translation
	This:C1470.titleButtons.distributeLeftToRight()
	This:C1470.run.bestSize()
	
	// Applying constraints
	This:C1470.form.constraints.apply()
	
	// Firstly, the editing buttons are disabled and the detail panel is hidden.
	This:C1470.titleButtons.disable()
	This:C1470.detail.hide()
	
	This:C1470.sidebar.setScrollbars(0; 2)
	This:C1470.sidebar.setSource(This:C1470.demos)
	
	This:C1470.form.refresh()
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function update()
	
	// Force the redarw of the demo list
	This:C1470.sidebar.touch()
	
	// MARK:-[MANAGERS]
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function _sidebarManager($e : cs:C1710.ui.evt)
	
	$e:=$e || cs:C1710.ui.evt.new()
	
	var $o : Object:=This:C1470.demoSelected
	
	//populate
	This:C1470.desc.title:=$o.comments
	
	// Depending on the selection :
	// 1 - show/hide detail & enable/disable editing buttons
	This:C1470.detail.show($o#Null:C1517)
	This:C1470.titleButtons.enable($o#Null:C1517)
	
	If ($o#Null:C1517)
		
		// Make sure that the controller class exists to activate the "class" button
		This:C1470.editClass.enable(This:C1470.controllers.includes("[class]/_"+$o.form+"_Controller"))
		
		// Place the run button
		This:C1470.run.moveVertically(This:C1470.desc.coordinates.top+This:C1470.desc.getBestHeight()+100-This:C1470.run.coordinates.top)
		
	End if 
	
	// 2 - show/hide the tip message
	This:C1470.tip.show($o=Null:C1517)
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function _windowFrameManager()
	
	// The title bar fills the entire width of the window
	This:C1470.windowFrame.left:=0
	This:C1470.windowFrame.width:=This:C1470.form.dimensions.width
	
	// MARK:-[IN-HOUSE]
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get demoSelected() : Object
	
	return This:C1470.sidebar.item
	