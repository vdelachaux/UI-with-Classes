property form : cs:C1710.ui.form
property isSubform:=True:C214

property backButton; cancel; ok : cs:C1710.ui.button

property TOP; BOTTOM : cs:C1710.ui.tabControl

Class constructor
	
	// MARK:-Delegates 📦
	This:C1470.form:=cs:C1710.ui.form.new(This:C1470; Try(JSON Parse:C1218(File:C1566("/SOURCES/Forms/"+Current form name:C1298+"/form.4DForm").getText())))
	
	This:C1470.form.init()
	
	// MARK:-[Standard Suite]
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function init()
	
	// MARK: Top tabs with an object
	This:C1470.TOP:=This:C1470.form.TabControl("tabControl1"; {\
		values: ["Page 1"; "Page 2"]; \
		index: 0})
	
	// MARK: Bottom tabs with a list
	var $list : Integer:=New list:C375
	APPEND TO LIST:C376($list; "Page 1"; 1)
	SET LIST ITEM PROPERTIES:C386($list; 0; True:C214; Plain:K14:1; "path:/RESOURCES/local.svg")
	APPEND TO LIST:C376($list; "Page 2"; 2)
	SET LIST ITEM PROPERTIES:C386($list; 0; True:C214; Plain:K14:1; "path:/RESOURCES/github.svg")
	
	This:C1470.BOTTOM:=This:C1470.form.TabControl("tabControl"; $list; 2)
	// Note that the tab control is initialized to display page 2 at startup.
	// ⚠️ This is a list of choices - Don't forget to call This.tabControl.clearList() to clear the memory.
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function handleEvents($e : cs:C1710.ui.evt)
	
	$e:=$e || cs:C1710.ui.evt.new()
	
	// MARK:Form Method
	If ($e.objectName=Null:C1517)  // <== FORM METHOD
		
		Case of 
				
				//______________________________________________________
			: ($e.pageChange)
				
				// Synchronize TOP with BOTTOM (for demo)
				This:C1470.BOTTOM.pageNumber:=This:C1470.form.page
				
				//______________________________________________________
			: ($e.unload)
				
				This:C1470.BOTTOM.clearList()  // ⚠️ Its a choiceList 
				
				//______________________________________________________
		End case 
		
		return 
		
	End if 
	
	// MARK: Widget Methods
	Case of 
			
			//==============================================
		: (This:C1470.BOTTOM.catch($e))
			
			This:C1470.BOTTOM.goToPage()
			
			//==============================================
	End case 