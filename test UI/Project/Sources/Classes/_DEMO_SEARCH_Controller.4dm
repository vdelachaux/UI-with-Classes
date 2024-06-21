property form : cs:C1710.ui.form
property searchBox : cs:C1710.ui.subform
property list : cs:C1710.ui.listbox

Class constructor
	
	// MARK:Delegates 📦
	var $form : Object
	$form:=Try(JSON Parse:C1218(File:C1566("/SOURCES/Forms/"+Current form name:C1298+"/form.4DForm").getText()))
	This:C1470.form:=cs:C1710.ui.form.new(This:C1470; $form)
	
	This:C1470.form.init()
	
	// MARK:-[STANDARD SUITE]
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function init()
	
	This:C1470.searchBox:=This:C1470.form.subform.new("search")
	This:C1470.list:=This:C1470.form.listbox.new("list")
	
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
			: ($e.timer)
				
				This:C1470.form.update()
				
				//______________________________________________________
		End case 
		
		return 
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function onLoad()
	
	var $c : Collection
	$c:=[]
	$c.push({code: "558"; label: "Dolor sit amet consectetur adipisci[ng] velit"})
	$c.push({code: "5582"; label: "Ut enim ad minima veniam, quis nostrum[d] exercitationem ullam corporis suscipit laboriosam"})
	$c.push({code: "5253"; label: "Et harum quidem reru[d]um facilis est e[r]t expedita distinctio"})
	$c.push({code: "5254"; label: "At vero eos et accusamus et iusto odio dignissimos ducimus"})
	$c.push({code: "5558"; label: "Quis autem vel eum i[r]ure reprehenderit, qui in ea voluptate velit esse"})
	$c.push({code: "5564"; label: "Nam libero tempore, cum soluta nobis est eligendi optio"})
	$c.push({code: "556"; label: "Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium"})
	$c.push({code: "5568"; label: "Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit"})
	$c.push({code: "555"; label: "Quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo"})
	
	This:C1470.list.setSource($c)
	
/*
Some options allow you to adjust the search widget behaviour.
You can define :
  - The placeholder text (default: none)
  - The shortcut (and any associated modifier) to activate the search box (default: Ctrl/Cmd+F)
  - The helpTip displayed by the widget
  - The input type, which will define the correct input filter (default: text).
  - The instant mode, in which user keystrokes are sent to the host form as they are entered, or all at once when the widget loses focus (default: True = instant).
*/
	This:C1470.searchBox.data:={\
		placeholder: "5xx"; \
		shortcut: "f"; \
		modifier: Command key mask:K16:1; \
		helpTip: "Search by code "+(Is macOS:C1572 ? "⌘ F" : "Ctrl+F"); \
		type: Is integer:K8:5; \
		instant: True:C214\
		}
	
	// No focus at start
	This:C1470.form.focus()
	
	This:C1470.form.refresh()
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function update()
	
	// Update of the  list
	This:C1470.list.touch()
	
	// MARK:-[MANAGERS]
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function _searchManager($e : cs:C1710.ui.evt)
	
	$e:=$e || cs:C1710.ui.evt.new()
	
	Case of 
			
			//______________________________________________________
		: ($e.code=-1)  // Callback for search
			
			var $search : Text:=String:C10(This:C1470.searchBox.searchValue)
			
			If (Length:C16($search)>0)
				
				// Filter
				This:C1470.list.data:=This:C1470.list.source.query("code = :1"; $search+"@")
				
			Else 
				
				// Restore
				This:C1470.list.setData()
				
			End if 
			
			//______________________________________________________
	End case 