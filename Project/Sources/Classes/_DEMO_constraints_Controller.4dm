property form : cs:C1710.formDelegate

Class constructor
	
	This:C1470.isSubform:=False:C215
	This:C1470.toBeInitialized:=False:C215
	
	// MARK:-Delegates 📦
	This:C1470.form:=cs:C1710.formDelegate.new(This:C1470)
	
	// Mark: Create and install a minimal menu bar
	cs:C1710.menuBar.new().defaultMinimalMenuBar().set()
	
	This:C1470.form.init()
	
	// MARK:-[Standard Suite]
	// === === === === === === === === === === === === === === === === === === === === ===
Function init()
	
	// Mark: Instantiate the widgets we want to manipulate.
	This:C1470.helloWorld:=This:C1470.form.static.new("helloWorld")
	This:C1470.helloWidth:=This:C1470.form.input.new("coord")
	
	This:C1470.bonjourLeMonde:=This:C1470.form.static.new("bonjourLeMonde")
	
	This:C1470.listbox:=This:C1470.form.listbox.new("List Box")
	This:C1470.header1:=This:C1470.form.static.new("label")
	This:C1470.header2:=This:C1470.form.static.new("label1")
	
	// Mark: Define the constraints
	// The vertical center line must always be centered
	This:C1470.form.constraints.add({\
		target: "middleLine"; \
		type: "horizontal-alignment"; \
		alignment: "center"\
		})
	
	// The left panel should always be 50% of the window width
	This:C1470.form.constraints.add({\
		target: "left"; \
		type: "right"; \
		value: 50\
		})
	
	// The right edge of the first hello world must be in the middle (50%),
	// & the width must be no less than 130px and no more than 520 px
	This:C1470.form.constraints.add({target: This:C1470.helloWorld; set: [\
		{type: "right"; value: 50}; \
		{type: "minimum-width"; value: 130}; \
		{type: "maximum-width"; value: 520}\
		]})
	
	// The width indicator must stay on right separated by 10px
	This:C1470.form.constraints.add({\
		target: This:C1470.helloWidth; \
		type: "margin"; \
		alignment: "left"; \
		margin: 10; \
		reference: This:C1470.helloWorld\
		})
	
	// Show red bullet if maximum width is reached
	This:C1470.form.constraints.add({formula: Formula:C1597(OBJECT SET VISIBLE:C603(*; "redBullet"; cs:C1710.coord.new("helloWorld").width=520))})
	
	// Associated comments ("Text5" & "Text7") are anchored to the left of the width indicator
	This:C1470.form.constraints.add({\
		target: "Text5,Text7"; \
		type: "anchor"; \
		alignment: "left"; \
		reference: This:C1470.helloWidth\
		})
	
	// This label must use the full width of the left panel, with a 20px margin to the left and right.
	This:C1470.form.constraints.add({\
		target: This:C1470.bonjourLeMonde; \
		type: "fit-width"; \
		reference: "left"; \
		margin: 20\
		})
	
	// The right edge of the lisbox must be in the middle (50%),
	// & the width must be no less than 130px and no more than 520 px
	This:C1470.form.constraints.add({target: This:C1470.listbox; set: [\
		{type: "right"; value: 50}; \
		{type: "minimum-width"; value: 150}; \
		{type: "maximum-width"; value: 520}\
		]})
	
	// The header of column 1 is anchored to the right of the column with a -10px offset
	This:C1470.form.constraints.add({\
		target: This:C1470.header1; \
		type: "anchor"; \
		alignment: "right"; \
		reference: This:C1470.listbox.getColumnName(1); \
		margin: 10\
		})
	
	// Associated comment is anchored to the right of the header label
	This:C1470.form.constraints.add({\
		target: "Text9"; \
		type: "anchor"; \
		alignment: "right"; \
		reference: This:C1470.header1\
		})
	
	// The header of column 2 is anchored to the left of the column with a +10px offset
	This:C1470.form.constraints.add({\
		target: This:C1470.header2; \
		type: "anchor"; \
		alignment: "left"; \
		reference: This:C1470.listbox.getColumnName(2); \
		margin: 10\
		})
	
	// Associated comment is anchored to the left of the header label
	This:C1470.form.constraints.add({\
		target: "Text10"; \
		type: "anchor"; \
		alignment: "left"; \
		reference: This:C1470.header2\
		})
	
	// The colored rectangle is centered on column 2
	This:C1470.form.constraints.add({\
		target: "rectangle"; \
		type: "horizontal-alignment"; \
		alignment: "center"; \
		reference: This:C1470.listbox.getColumnName(1)\
		})
	
	// Associated comment is anchored to the center of the rectangle
	This:C1470.form.constraints.add({\
		target: "Text8"; \
		type: "anchor"; \
		alignment: "center"; \
		reference: "rectangle"\
		})
	
	
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
	
	/// Mark: Set window title
	This:C1470.form.window.title:="Constraints"
	
	// These elements must be distributed according to their content
	// They should only be applied once (if the content is not modified),
	// which is why the "toDelete" property is set to True
	This:C1470.form.static.new("lang").bestSize()
	This:C1470.form.static.new("bonjour").bestSize()
	
	This:C1470.form.constraints.add({\
		target: "bonjour"; \
		type: "inline"; \
		reference: "lang"; \
		toDelete: True:C214\
		})
	
	This:C1470.form.constraints.add({\
		target: "monde"; \
		type: "inline"; \
		reference: "bonjour"; \
		toDelete: True:C214\
		})
	
	This:C1470.form.static.new("lang1").bestSize()
	This:C1470.form.static.new("bonjour1").bestSize()
	
	This:C1470.form.constraints.add({\
		target: "bonjour1"; \
		type: "inline"; \
		reference: "lang1"; \
		toDelete: True:C214\
		})
	
	This:C1470.form.constraints.add({\
		target: "monde1"; \
		type: "inline"; \
		reference: "bonjour1"; \
		toDelete: True:C214\
		})
	
	// Applying the constraints
	This:C1470.form.constraints.apply()
	
	// Rules marked as toDelete have been deleted
	
	