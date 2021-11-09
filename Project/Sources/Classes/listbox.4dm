Class extends scrollable

//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Class constructor($name : Text; $datasource)
	
	If (Count parameters:C259>=2)
		
		Super:C1705($name; $datasource)
		
	Else 
		
		Super:C1705($name)
		
	End if 
	
	ASSERT:C1129(This:C1470.type=Object type listbox:K79:8)
	
	This:C1470.isCollection:=Is nil pointer:C315(OBJECT Get data source:C1265(*; This:C1470.name))
	This:C1470.isArray:=Not:C34(This:C1470.isCollection)
	
	If (This:C1470.isCollection)
		
		This:C1470.item:=Null:C1517
		This:C1470.itemPosition:=0
		This:C1470.items:=Null:C1517
		
	End if 
	
	// Backup design properties
	This:C1470.saveProperties()
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
	// ⚠️ 
Function getCoordinates()->$coordinates : Object
	
	$coordinates:=Super:C1706.getCoordinates()
	
	This:C1470.getScrollPosition()
	This:C1470.getScrollbars()
	This:C1470.updateDefinition()
	This:C1470.updateCell()
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Select row(s)
Function select($row : Integer)->$this : cs:C1710.listbox
	
	If (Count parameters:C259=0)
		
		// Select all rows
		LISTBOX SELECT ROW:C912(*; This:C1470.name; 0; lk replace selection:K53:1)
		
	Else 
		
		// #TO_DO: use a collection for multiple selection
		LISTBOX SELECT ROW:C912(*; This:C1470.name; $row; lk replace selection:K53:1)
		
	End if 
	
	OBJECT SET SCROLL POSITION:C906(*; This:C1470.name; $row)
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Unselect row(s)
Function unselect($row : Integer)->$this : cs:C1710.listbox
	
	If (Count parameters:C259=0)
		
		// Unselect all rows
		LISTBOX SELECT ROW:C912(*; This:C1470.name; 0; lk remove from selection:K53:3)
		
	Else 
		
		// #TO_DO: use a collection for multiple selection
		LISTBOX SELECT ROW:C912(*; This:C1470.name; $row; lk remove from selection:K53:3)
		
	End if 
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Selects the given row if possible, else the most appropiate one
	// Useful to maintain a selection after a deletion
Function doSafeSelect($row : Integer)->$this : cs:C1710.listbox
	
	var $rowNumber : Integer
	
	$rowNumber:=This:C1470.rowsNumber()
	
	Case of 
			
			//______________________________
		: ($row<=$rowNumber)
			
			$this:=This:C1470.select($row)
			
			//______________________________
		: ($rowNumber>0)
			
			$this:=This:C1470.select($rowNumber)
			
			//______________________________
			
		Else 
			
			$this:=This:C1470.unselect()
			
			//______________________________
	End case 
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function selectAll()->$this : cs:C1710.listbox
	
	$this:=This:C1470.select()
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Returns a row coordinates
Function getRowCoordinates($row : Integer)->$coordinates : Object
	
	var $l; $bottom; $left; $right; $top; $width : Integer
	var $horizontal; $vertical : Boolean
	
	This:C1470.getCoordinates()
	
	LISTBOX GET CELL COORDINATES:C1330(*; This:C1470.name; 1; $row; $left; $top; $l; $l)
	LISTBOX GET CELL COORDINATES:C1330(*; This:C1470.name; This:C1470.columnsNumber(); $row; $l; $l; $right; $bottom)
	
	// Adjust according to the visible part
	$left:=Choose:C955($left<This:C1470.coordinates.left; This:C1470.coordinates.left; $left)
	$top:=Choose:C955($top<This:C1470.coordinates.top; This:C1470.coordinates.top; $top)
	
	OBJECT GET SCROLLBAR:C1076(*; This:C1470.name; $horizontal; $vertical)
	
	If ($vertical)
		
		$width:=LISTBOX Get property:C917(*; This:C1470.name; lk ver scrollbar width:K53:9)
		$right:=Choose:C955($right>(This:C1470.coordinates.right-$width); This:C1470.coordinates.right-$width; $right)
		
	Else 
		
		$right:=Choose:C955($right>This:C1470.coordinates.right; This:C1470.coordinates.right; $right)
		
	End if 
	
	$bottom:=Choose:C955($bottom>This:C1470.coordinates.bottom; This:C1470.coordinates.bottom; $bottom)
	
	$coordinates:=New object:C1471(\
		"left"; $left; \
		"top"; $top; \
		"right"; $right; \
		"bottom"; $bottom)
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Gives the number of selected rows
Function selectedNumber()->$count : Integer
	
	$count:=Count in array:C907((This:C1470.pointer())->; True:C214)
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Gives the number of columns
Function columnsNumber()->$count : Integer
	
	$count:=LISTBOX Get number of columns:C831(*; This:C1470.name)
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Gives the number of rows
Function rowsNumber()->$count : Integer
	
	$count:=LISTBOX Get number of rows:C915(*; This:C1470.name)
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Reveal the row
Function reveal($row : Integer)->$this : cs:C1710.listbox
	
	LISTBOX SELECT ROW:C912(*; This:C1470.name; $row; lk replace selection:K53:1)
	OBJECT SET SCROLL POSITION:C906(*; This:C1470.name; $row)
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Update the listbox columns/rows definition
Function updateDefinition()->$this : cs:C1710.listbox
	
	var $i : Integer
	
	ARRAY BOOLEAN:C223($isVisible; 0x0000)
	ARRAY POINTER:C280($columnsPtr; 0x0000)
	ARRAY POINTER:C280($footersPtr; 0x0000)
	ARRAY POINTER:C280($headersPtr; 0x0000)
	ARRAY POINTER:C280($stylesPtr; 0x0000)
	ARRAY TEXT:C222($columns; 0x0000)
	ARRAY TEXT:C222($footers; 0x0000)
	ARRAY TEXT:C222($headers; 0x0000)
	
	LISTBOX GET ARRAYS:C832(*; This:C1470.name; \
		$columns; $headers; \
		$columnsPtr; $headersPtr; \
		$isVisible; \
		$stylesPtr; \
		$footers; $footersPtr)
	
	This:C1470.definition:=New collection:C1472
	
	ARRAY TO COLLECTION:C1563(This:C1470.definition; \
		$columns; "name"; \
		$headers; "header"; \
		$footers; "footer")
	
	This:C1470.columns:=New object:C1471
	
	For ($i; 1; Size of array:C274($columns); 1)
		
		This:C1470.columns[$columns{$i}]:=New object:C1471(\
			"number"; $i; \
			"visible"; $isVisible{$i}; \
			"height"; LISTBOX Get row height:C1408(*; This:C1470.name; $i); \
			"wordwrap"; LISTBOX Get property:C917(*; $columns{$i}; lk allow wordwrap:K53:39); \
			"autoRowHeight"; LISTBOX Get property:C917(*; $columns{$i}; lk auto row height:K53:72); \
			"maxWidth"; LISTBOX Get property:C917(*; $columns{$i}; lk column max width:K53:51); \
			"minWidth"; LISTBOX Get property:C917(*; $columns{$i}; lk column min width:K53:50); \
			"resizable"; LISTBOX Get property:C917(*; $columns{$i}; lk column resizable:K53:40); \
			"displayType"; LISTBOX Get property:C917(*; $columns{$i}; lk display type:K53:46); \
			"fontColorExpression"; LISTBOX Get property:C917(*; $columns{$i}; lk font color expression:K53:48); \
			"fontStyleExpression"; LISTBOX Get property:C917(*; $columns{$i}; lk font style expression:K53:49); \
			"multiStyle"; LISTBOX Get property:C917(*; $columns{$i}; lk multi style:K53:71); \
			"truncate"; LISTBOX Get property:C917(*; $columns{$i}; lk truncate:K53:37); \
			"pointer"; $columnsPtr{$i})
		
	End for 
	
	This:C1470.getScrollbars()
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Update the current cell indexes and coordinates
Function updateCell()->$this : cs:C1710.listbox
	
	This:C1470.cellPosition()
	This:C1470.cellCoordinates()
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Current cell indexes {column,row}
Function cellPosition($event : Object)->$position : Object
	
	var $_; $column; $row; $x; $y : Integer
	var $e; $event : Object
	
	If (Count parameters:C259>=1)
		
		// Event is provided
		$e:=$event
		
	Else 
		
		$e:=FORM Event:C1606
		
	End if 
	
	If ($e.code=On Clicked:K2:4)\
		 | ($e.code=On Double Clicked:K2:5)
		
		LISTBOX GET CELL POSITION:C971(*; This:C1470.name; $column; $row)
		
	Else 
		
		GET MOUSE:C468($x; $y; $_)
		LISTBOX GET CELL POSITION:C971(*; This:C1470.name; $x; $y; $column; $row)
		
	End if 
	
	$position:=New object:C1471(\
		"column"; $column; \
		"row"; $row)
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function cellCoordinates($column : Integer; $row : Integer)->$coordinates : Object
	
	var $bottom; $left; $right; $top : Integer
	var $columnƒ; $rowƒ : Integer
	var $e : Object
	
	If (Count parameters:C259=0)
		
		$e:=FORM Event:C1606
		
		If ($e.column#Null:C1517)
			
			$columnƒ:=$e.column
			$rowƒ:=$e.row
			
		Else 
			
			// A "If" statement should never omit "Else"
			
		End if 
		
	Else 
		
		$columnƒ:=$column
		$rowƒ:=$row
		
	End if 
	
	LISTBOX GET CELL COORDINATES:C1330(*; This:C1470.name; $columnƒ; $rowƒ; $left; $top; $right; $bottom)
	
	If (This:C1470.cellBox=Null:C1517)
		
		This:C1470.cellBox:=New object:C1471(\
			"left"; $left; \
			"top"; $top; \
			"right"; $right; \
			"bottom"; $bottom)
		
	Else 
		
		This:C1470.cellBox.left:=$left
		This:C1470.cellBox.top:=$top
		This:C1470.cellBox.right:=$right
		This:C1470.cellBox.bottom:=$bottom
		
	End if 
	
	$coordinates:=This:C1470.cellBox
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Displays a cs.menu at the bottom left of the current cell
Function popup($menu : cs:C1710.menu; $default : Text)->$choice : cs:C1710.menu
	
	var $bottom; $left : Integer
	var $coordinates : Object
	
	$coordinates:=This:C1470.cellCoordinates()
	
	$left:=$coordinates.left
	$bottom:=$coordinates.bottom
	
	CONVERT COORDINATES:C1365($left; $bottom; XY Current form:K27:5; XY Current window:K27:6)
	
	If (Count parameters:C259=1)
		
		$menu.popup(""; $left; $bottom)
		
	Else 
		
		$menu.popup($default; $left; $bottom)
		
	End if 
	
	$choice:=$menu
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function showColumn($column; $visible : Boolean)
	
	var $name : Text
	var $show : Boolean
	var $o : Object
	
	$show:=True:C214
	
	If (Count parameters:C259>=2)
		
		$show:=$visible
		
	End if 
	
	This:C1470.updateDefinition()
	
	If (Value type:C1509($column)=Is real:K8:4) | (Value type:C1509($column)=Is longint:K8:6)
		
		If (Asserted:C1132($column<=This:C1470.definition.length; "Index out of range"))
			
			$name:=This:C1470.definition[$column].name
			
		End if 
		
	Else 
		
		$o:=This:C1470.definition.query("name = "; String:C10($column)).pop()
		
		If (Asserted:C1132($o#Null:C1517; "Unknown column name"))
			
			$name:=$o.name
			
		End if 
	End if 
	
	OBJECT SET VISIBLE:C603(*; $name; $show)
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function hideColumn($column)
	
	This:C1470.showColumn($column; False:C215)
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function clear()->$this : cs:C1710.listbox
	
	var $o : Object
	
	This:C1470.updateDefinition()
	
	For each ($o; This:C1470.definition)
		
		CLEAR VARIABLE:C89(OBJECT Get pointer:C1124(Object named:K67:5; $o.name)->)
		
	End for each 
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function deleteRow($row : Integer)->$this : cs:C1710.listbox
	
	
	If (Count parameters:C259=0)
		
		// Delete all rowsLISTBOX DELETE ROWS(*; This.name; 1; This.rowsNumber())
		LISTBOX SELECT ROW:C912(*; This:C1470.name; 0; lk remove from selection:K53:3)
		
	Else 
		
		// #TO_DO: use a collection for multiple delrtion
		LISTBOX DELETE ROWS:C914(*; This:C1470.name; $row; 1)
		
	End if 
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Returns all properties of the column or listbox
Function getProperties($column : Text)->$properties : Object
	
	var $target : Text
	
	If (Count parameters:C259>=1)
		
		$target:=$column
		
	Else 
		
		$target:=This:C1470.name
		
	End if 
	
	$properties:=New object:C1471(\
		"allowWordwrap"; LISTBOX Get property:C917(*; $target; lk allow wordwrap:K53:39); \
		"autoRowHeight"; LISTBOX Get property:C917(*; $target; lk auto row height:K53:72); \
		"backgroundColorExpression"; LISTBOX Get property:C917(*; $target; lk background color expression:K53:47); \
		"columnMinWidth"; LISTBOX Get property:C917(*; $target; lk column min width:K53:50); \
		"columnResizable"; LISTBOX Get property:C917(*; $target; lk column resizable:K53:40); \
		"detailFormName"; LISTBOX Get property:C917(*; $target; lk detail form name:K53:44); \
		"displayFooter"; LISTBOX Get property:C917(*; $target; lk display footer:K53:20); \
		"displayHeader"; LISTBOX Get property:C917(*; $target; lk display header:K53:4); \
		"displayType"; LISTBOX Get property:C917(*; $target; lk display type:K53:46); \
		"doubleClickOnRow"; LISTBOX Get property:C917(*; $target; lk double click on row:K53:43); \
		"extraRows"; LISTBOX Get property:C917(*; $target; lk extra rows:K53:38); \
		"fontColorExpression"; LISTBOX Get property:C917(*; $target; lk font color expression:K53:48); \
		"fontStyleExpression"; LISTBOX Get property:C917(*; $target; lk font style expression:K53:49); \
		"hideSelectionHighlight"; LISTBOX Get property:C917(*; $target; lk hide selection highlight:K53:41); \
		"highlightSet"; LISTBOX Get property:C917(*; $target; lk highlight set:K53:66); \
		"horScrollbarHeight"; LISTBOX Get property:C917(*; $target; lk hor scrollbar height:K53:7); \
		"multiStyle"; LISTBOX Get property:C917(*; $target; lk multi style:K53:71); \
		"namedSelection"; LISTBOX Get property:C917(*; $target; lk named selection:K53:67); \
		"resizingMode"; LISTBOX Get property:C917(*; $target; lk resizing mode:K53:36); \
		"rowHeightUnit"; LISTBOX Get property:C917(*; $target; lk row height unit:K53:42); \
		"selectionMode"; LISTBOX Get property:C917(*; $target; lk selection mode:K53:35); \
		"singleClickEdit"; LISTBOX Get property:C917(*; $target; lk single click edit:K53:70); \
		"sortable"; LISTBOX Get property:C917(*; $target; lk sortable:K53:45); \
		"truncate"; LISTBOX Get property:C917(*; $target; lk truncate:K53:37); \
		"verScrollbarWidth"; LISTBOX Get property:C917(*; $target; lk ver scrollbar width:K53:9)\
		)
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function getProperty($property : Integer; $column : Text)->$value : Variant
	
	If (Count parameters:C259=0)
		
		$value:=LISTBOX Get property:C917(*; This:C1470.name; $property)
		
	Else 
		
		$value:=LISTBOX Get property:C917(*; $column; $property)
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function highlight($enabled : Boolean)->$this : cs:C1710.listbox
	
	var $highlight : Boolean
	
	If (Count parameters:C259>=1)
		
		$highlight:=$enabled
		
	End if 
	
	This:C1470.setProperty(lk hide selection highlight:K53:41; Choose:C955($highlight; lk yes:K53:69; lk no:K53:68))
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function noHighlight()->$this : cs:C1710.listbox
	
	$this:=This:C1470.highlight(False:C215)
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function movableLines($enabled : Boolean)->$this : cs:C1710.listbox
	
	var $movable : Boolean
	$movable:=True:C214
	
	If (Count parameters:C259>=1)
		
		$movable:=$enabled
		
	End if 
	
	This:C1470.setProperty(lk movable rows:K53:76; Choose:C955($movable; lk yes:K53:69; lk no:K53:68))
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function nonMovableLines()->$this : cs:C1710.listbox
	
	$this:=This:C1470.movableLines(False:C215)
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function selectable($enabled : Boolean)->$this : cs:C1710.listbox
	
	var $selectable : Boolean
	$selectable:=True:C214
	
	If (Count parameters:C259>=1)
		
		$selectable:=$enabled
		
	End if 
	
	If ($selectable)
		
		// Restore design mode definition
		This:C1470.setProperty(lk selection mode:K53:35; This:C1470.properties.selectionMode)
		
	Else 
		
		This:C1470.setProperty(lk selection mode:K53:35; lk none:K53:57)
		
	End if 
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function notSelectable()->$this : cs:C1710.listbox
	
	$this:=This:C1470.selectable(False:C215)
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function singleSelectable()->$this : cs:C1710.listbox
	
	$this:=This:C1470.setProperty(lk selection mode:K53:35; lk single:K53:58)
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function multipleSelectable()->$this : cs:C1710.listbox
	
	$this:=This:C1470.setProperty(lk selection mode:K53:35; lk multiple:K53:59)
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function sortable($enabled : Boolean)->$this : cs:C1710.listbox
	
	var $sortable : Boolean
	$sortable:=True:C214
	
	If (Count parameters:C259>=1)
		
		$sortable:=$enabled
		
	End if 
	
	This:C1470.setProperty(lk movable rows:K53:76; Choose:C955($sortable; lk yes:K53:69; lk no:K53:68))
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function notSortable()->$this : cs:C1710.listbox
	
	$this:=This:C1470.sortable(False:C215)
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setProperty($property : Integer; $value)->$this : cs:C1710.listbox
	
	LISTBOX SET PROPERTY:C1440(*; This:C1470.name; $property; $value)
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setRowsHeight($height : Integer; $unit : Integer)->$this : cs:C1710.listbox
	
	If (Count parameters:C259>=2)
		
		LISTBOX SET ROWS HEIGHT:C835(*; This:C1470.name; $height; $unit)
		
	Else 
		
		LISTBOX SET ROWS HEIGHT:C835(*; This:C1470.name; $height)
		
	End if 
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function restoreProperties()->$this : cs:C1710.listbox
	
	This:C1470.setProperty(lk allow wordwrap:K53:39; This:C1470.properties.allowWordwrap)
	This:C1470.setProperty(lk auto row height:K53:72; This:C1470.properties.autoRowHeight)
	This:C1470.setProperty(lk background color expression:K53:47; This:C1470.properties.backgroundColorExpression)
	This:C1470.setProperty(lk double click on row:K53:43; This:C1470.properties.doubleClickOnRow)
	This:C1470.setProperty(lk extra rows:K53:38; This:C1470.properties.extraRows)
	This:C1470.setProperty(lk font color expression:K53:48; This:C1470.properties.fontColorExpression)
	This:C1470.setProperty(lk font style expression:K53:49; This:C1470.properties.fontStyleExpression)
	This:C1470.setProperty(lk hide selection highlight:K53:41; This:C1470.properties.hideSelectionHighlight)
	This:C1470.setProperty(lk highlight set:K53:66; This:C1470.properties.highlightSet)
	This:C1470.setProperty(lk hor scrollbar height:K53:7; This:C1470.properties.horScrollbarHeight)
	This:C1470.setProperty(lk meta expression:K53:75; This:C1470.properties.metaExpression)
	This:C1470.setProperty(lk movable rows:K53:76; This:C1470.properties.movableRows)
	This:C1470.setProperty(lk named selection:K53:67; This:C1470.properties.namedSelection)
	This:C1470.setProperty(lk resizing mode:K53:36; This:C1470.properties.resizingMode)
	
	This:C1470.setProperty(lk display footer:K53:20; This:C1470.properties.displayFooter)
	LISTBOX SET FOOTERS HEIGHT:C1145(*; This:C1470.name; This:C1470.properties.footerHeight; This:C1470.properties.footerHeightUnit)
	This:C1470.setProperty(lk display header:K53:4; This:C1470.properties.displayHeader)
	LISTBOX SET HEADERS HEIGHT:C1143(*; This:C1470.name; This:C1470.properties.headerHeight; This:C1470.properties.headerHeightUnit)
	
	This:C1470.setRowsHeight(This:C1470.properties.rowHeight; This:C1470.properties.rowHeightUnit)
	This:C1470.setProperty(lk row height unit:K53:42; This:C1470.properties.rowHeightUnit)
	This:C1470.setProperty(lk row max height:K53:74; This:C1470.properties.rowMaxHeight)
	This:C1470.setProperty(lk row min height:K53:73; This:C1470.properties.rowMinHeight)
	
	This:C1470.setProperty(lk selection mode:K53:35; This:C1470.properties.selectionMode)
	This:C1470.setProperty(lk single click edit:K53:70; This:C1470.properties.singleClickEdit)
	This:C1470.setProperty(lk sortable:K53:45; This:C1470.properties.sortable)
	This:C1470.setProperty(lk truncate:K53:37; This:C1470.properties.truncate)
	This:C1470.setProperty(lk ver scrollbar width:K53:9; This:C1470.properties.verScrollbarWidth)
	
	This:C1470.setScrollbars(This:C1470.properties.horScrollbar; This:C1470.properties.verScrollbar)
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
Function saveProperties()
	
	var $unit : Integer
	
	This:C1470.properties:=New object:C1471
	
	This:C1470.properties.selectionMode:=LISTBOX Get property:C917(*; This:C1470.name; lk selection mode:K53:35)
	This:C1470.properties.singleClickEdit:=LISTBOX Get property:C917(*; This:C1470.name; lk single click edit:K53:70)
	This:C1470.properties.sortable:=LISTBOX Get property:C917(*; This:C1470.name; lk sortable:K53:45)
	This:C1470.properties.truncate:=LISTBOX Get property:C917(*; This:C1470.name; lk truncate:K53:37)
	This:C1470.properties.allowWordwrap:=LISTBOX Get property:C917(*; This:C1470.name; lk allow wordwrap:K53:39)
	This:C1470.properties.doubleClickOnRow:=LISTBOX Get property:C917(*; This:C1470.name; lk double click on row:K53:43)
	This:C1470.properties.extraRows:=LISTBOX Get property:C917(*; This:C1470.name; lk extra rows:K53:38)
	This:C1470.properties.hideSelectionHighlight:=LISTBOX Get property:C917(*; This:C1470.name; lk hide selection highlight:K53:41)
	This:C1470.properties.movableRows:=LISTBOX Get property:C917(*; This:C1470.name; lk movable rows:K53:76)
	This:C1470.properties.resizingMode:=LISTBOX Get property:C917(*; This:C1470.name; lk resizing mode:K53:36)
	
	This:C1470.properties.displayFooter:=LISTBOX Get property:C917(*; This:C1470.name; lk display footer:K53:20)
	This:C1470.properties.footerHeight:=LISTBOX Get footers height:C1146(*; This:C1470.name; $unit)
	This:C1470.properties.footerHeightUnit:=$unit
	This:C1470.properties.displayHeader:=LISTBOX Get property:C917(*; This:C1470.name; lk display header:K53:4)
	This:C1470.properties.headerHeight:=LISTBOX Get headers height:C1144(*; This:C1470.name; $unit)
	This:C1470.properties.headerHeightUnit:=$unit
	
	This:C1470.properties.rowHeight:=LISTBOX Get rows height:C836(*; This:C1470.name; lk pixels:K53:22)
	This:C1470.properties.autoRowHeight:=LISTBOX Get property:C917(*; This:C1470.name; lk auto row height:K53:72)
	This:C1470.properties.rowHeightUnit:=LISTBOX Get property:C917(*; This:C1470.name; lk row height unit:K53:42)
	This:C1470.properties.rowMaxHeight:=LISTBOX Get property:C917(*; This:C1470.name; lk row max height:K53:74)
	This:C1470.properties.rowMinHeight:=LISTBOX Get property:C917(*; This:C1470.name; lk row min height:K53:73)
	
	This:C1470.properties.highlightSet:=LISTBOX Get property:C917(*; This:C1470.name; lk highlight set:K53:66)
	This:C1470.properties.metaExpression:=LISTBOX Get property:C917(*; This:C1470.name; lk meta expression:K53:75)
	This:C1470.properties.namedSelection:=LISTBOX Get property:C917(*; This:C1470.name; lk named selection:K53:67)
	This:C1470.properties.backgroundColorExpression:=LISTBOX Get property:C917(*; This:C1470.name; lk background color expression:K53:47)
	This:C1470.properties.fontColorExpression:=LISTBOX Get property:C917(*; This:C1470.name; lk font color expression:K53:48)
	This:C1470.properties.fontStyleExpression:=LISTBOX Get property:C917(*; This:C1470.name; lk font style expression:K53:49)
	
	var $horizontal; $vertical : Integer
	OBJECT GET SCROLLBAR:C1076(*; This:C1470.name; $horizontal; $vertical)
	This:C1470.properties.horScrollbar:=$horizontal
	This:C1470.properties.verScrollbar:=$vertical
	This:C1470.properties.horScrollbarHeight:=LISTBOX Get property:C917(*; This:C1470.name; lk hor scrollbar height:K53:7)
	This:C1470.properties.verScrollbarWidth:=LISTBOX Get property:C917(*; This:C1470.name; lk ver scrollbar width:K53:9)
	
	//=== === === === === === === === === === === === === === === === === === === === === === === === === ===
	// ⚠️ ONLY WORKS WITH ARRAY TYPE LIST BOXES
Function setRowFontStyle($row : Integer; $tyle : Integer)
	
	If (Asserted:C1132(This:C1470.isArray; "setRowFontStyle() only works with array type list boxes!"))
		
		If (Count parameters:C259>=2)
			
			LISTBOX SET ROW FONT STYLE:C1268(*; This:C1470.name; $row; $tyle)
			
		Else 
			
			// Default is plain
			LISTBOX SET ROW FONT STYLE:C1268(*; This:C1470.name; $row; Plain:K14:1)
			
		End if 
	End if 
	