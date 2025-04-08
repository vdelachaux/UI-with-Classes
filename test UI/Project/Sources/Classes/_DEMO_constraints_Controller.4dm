property form : cs:C1710.ui.form
property helloWorld; bonjourLeMonde; header1; header2 : cs:C1710.ui.static
property helloWidth : cs:C1710.ui.input
property listbox : cs:C1710.ui.listbox

Class constructor
	
	// MARK:-Delegates 📦
	This:C1470.form:=cs:C1710.ui.form.new(This:C1470; Try(JSON Parse:C1218(File:C1566("/SOURCES/Forms/"+Current form name:C1298+"/form.4DForm").getText())))
	
	// Mark: Create and install a minimal menu bar
	cs:C1710.ui.menuBar.new().defaultMinimalMenuBar().set()
	
	This:C1470.form.init()
	
	// MARK:-[STANDARD SUITE]
	// === === === === === === === === === === === === === === === === === === === === ===
Function init()
	
	// Mark: Instantiate the widgets we want to manipulate.
	
	This:C1470.helloWorld:=This:C1470.form.Static("helloWorld")
	This:C1470.helloWidth:=This:C1470.form.Input("coord")
	
	This:C1470.bonjourLeMonde:=This:C1470.form.Static("bonjourLeMonde")
	
	This:C1470.listbox:=This:C1470.form.Listbox("List Box")
	This:C1470.header1:=This:C1470.form.Static("label")
	This:C1470.header2:=This:C1470.form.Static("label1")
	
	// Mark: Define the constraints
	
/*
💡 The constraint rules could also be loaded from a json file.
	
*/
	
/*
• The vertical centre line must always be centred inside the window.
	
*/
	This:C1470.form.constraints.new("middleLine").centerHorizontally.onViewport()
	
/*
• The left panel should always be 50% of the window width
	
*/
	This:C1470.form.constraints.new("left").tile(0.5)
	
/*
• The width of the "moveAndResize" text must always be 50% of the width of the window, 
  and must remain centered.
*/
	This:C1470.form.constraints.new("moveAndResize").tile(0.5).onViewport()
	This:C1470.form.constraints.new("moveAndResize").centerHorizontally.onViewport()
	
/*
• The right edge of the "Hello world" label must be in the middle (50%) of the window.
• However, the width must be no less than 130 px and no more than 520 px.
	
📌 As you can see, you can define a set of rules all at once by passing a collection.
	
*/
	This:C1470.form.constraints.new({target: This:C1470.helloWorld; set: [\
		{type: "right"; value: 50}; \
		{type: "minimum-width"; value: 145}; \
		{type: "maximum-width"; value: 520}\
		]})
	
/*
• The displayed label width value must remain to the right of the label, 
  separated by 10px.
	
📌 You can pass a widget object as the target or the reference
	
*/
	
	This:C1470.form.constraints.new(This:C1470.helloWidth).marginLeft(10).with(This:C1470.helloWorld)
	
/*
• Associated comments ("Text5" & "Text7") are anchored to the left of the width label
	
📌 Using a comma-delimited list of form object names allows you to define several targets at once.
	
*/
	
	This:C1470.form.constraints.new("Text5,Text7").anchorLeft().with(This:C1470.helloWidth)
	
/*
• If the maximum width is reached 
  - A check mark is displayed.
  - The label is displayed in red.
These constraints are applied using a formula
	
*/
	This:C1470.form.constraints.new({\
		formula: Formula:C1597(OBJECT SET VISIBLE:C603(*; "maxReached"; cs:C1710.ui.coordinates.new("helloWorld").width=520))\
		})
	
	This:C1470.form.constraints.new({\
		formula: Formula:C1597(OBJECT SET RGB COLORS:C628(*; "Text4"; (cs:C1710.ui.coordinates.new("helloWorld").width=520 ? "green" : "blue")))\
		})
	
/*
• If the minimum width is reached 
  - A prohibited symbol is displayed.
  - The label is displayed in red.
	
These constraints are applied using a formula
	
💡 Using a method or function allows you to do more than just a simple formula.
	
📌 Here, the formula uses the "formGetInstance" shared method,
   which returns the instance of the current form class, 
   so that the "minReached()" function can be called.
	
*/
	This:C1470.form.constraints.new({\
		formula: Formula:C1597(formGetInstance.minReached())\
		})
	
/*
• The "Bonjour le monde" label must use the full width of the left panel, 
  with a 20px margin to the left and right.
	
*/
	This:C1470.form.constraints.new(This:C1470.bonjourLeMonde).fitWidth(20).with("left")
	
/*
• The right edge of the lisbox must be in the middle (50%), 
  & the width must be no less than 130px and no more than 520 px
	
*/
	This:C1470.form.constraints.new({target: This:C1470.listbox; set: [\
		{type: "right"; value: 50}; \
		{type: "minimum-width"; value: 150}; \
		{type: "maximum-width"; value: 520}\
		]})
	
/*
• The header of column 1 is anchored to the right of the column with a -10px offset
• The columns/headers separator move as the listbox columns
• Associated comment is anchored to the right of the header label
	
*/
	This:C1470.form.constraints.new(This:C1470.header1).anchorRight(10).with(This:C1470.listbox.getColumnName(1))
	This:C1470.form.constraints.new("headerSeparator").anchoredOnTheRight.of(This:C1470.listbox.getColumnName(1))
	This:C1470.form.constraints.new("Text9").anchoredOnTheRight.of(This:C1470.header1)
	
/*
• The header of column 2 is anchored to the left of the column with a +10px offset
• Associated comment is anchored to the left of the header label
	
*/
	This:C1470.form.constraints.new(This:C1470.header2).anchorLeft(10).with(This:C1470.listbox.getColumnName(2))
	This:C1470.form.constraints.new("Text10").anchoredOnTheLeft.of(This:C1470.header2)
	
/*
• The colored rectangle is centered on column 1
• Associated comment is anchored to the center of the rectangle
	
*/
	This:C1470.form.constraints.new("rectangle").centerHorizontally.on(This:C1470.listbox.getColumnName(1))
	This:C1470.form.constraints.new("Text8").anchoredInTheCenter.of("rectangle")
	
/*
• The input box and associated comment must remain centred in the dialog box.
	
📌 The "input.label" is automatically attached to the input box.
	
*/
	This:C1470.form.constraints.new("input,Text11").centerHorizontally.onViewport()
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function handleEvents($e : cs:C1710.ui.evt)
	
	$e:=$e || cs:C1710.ui.evt.new()
	
	If ($e.form)
		
		// Mark: FORM METHOD
		
		Case of 
				
				//==============================================
			: ($e.load)
				
				This:C1470.form.onLoad()
				
				//==============================================
			: ($e.resize)
				
				// Applying the constraints
				This:C1470.form.constraints.apply()
				
				//==============================================
		End case 
		
	Else 
		
		// Mark: WIDGETS METHOD
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function onLoad()
	
	This:C1470.form.window.title:="title_3"
	
/*
• These elements must be distributed according to their content
• They should only be applied once (if the content is not modified),
	
📌 Which is why we use the "oneShot" constructor. 
   Rules will be deleted after the call to apply()
	
*/
	This:C1470.form.Static("lang").bestSize()
	This:C1470.form.Static("bonjour").bestSize()
	
	This:C1470.form.constraints.oneShot("bonjour").inline.with("lang")
	This:C1470.form.constraints.oneShot("monde").inline.with("bonjour")
	
	This:C1470.form.Static("lang1").bestSize()
	This:C1470.form.Static("bonjour1").bestSize()
	
	This:C1470.form.constraints.oneShot("bonjour1").inline.with("lang1")
	This:C1470.form.constraints.oneShot("monde1").inline.with("bonjour1")
	
	// Applying the constraints
	This:C1470.form.constraints.apply()
	
	// MARK:-[IN-HOUSE]
	// === === === === === === === === === === === === === === === === === === === === ===
Function minReached()
	
	var $coord : cs:C1710.ui.coordinates
	$coord:=cs:C1710.ui.coordinates.new("helloWorld")
	
	OBJECT SET VISIBLE:C603(*; "minReached"; $coord.width=145)
	OBJECT SET RGB COLORS:C628(*; "Text3"; ($coord.width=145 ? "red" : "blue"))