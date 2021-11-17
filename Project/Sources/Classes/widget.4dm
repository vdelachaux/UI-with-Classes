Class extends formObject

//=== === === === === === === === === === === === === === === === === === ===
Class constructor($name : Text; $datasource)
	
	If (Count parameters:C259>=1)
		
		Super:C1705($name)
		
	Else 
		
		Super:C1705()
		
	End if 
	
	var $p : Pointer
	$p:=OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.name)
	This:C1470.assignable:=Not:C34(Is nil pointer:C315($p))
	
	If (This:C1470.assignable)
		
		This:C1470.pointer:=$p
		This:C1470.value:=$p->
		
	Else 
		
		If (Count parameters:C259>=2)
			
			This:C1470.setDatasource($datasource)
			
		End if 
	End if 
	
	This:C1470.action:=OBJECT Get action:C1457(*; This:C1470.name)
	
	//=== === === === === === === === === === === === === === === === === === ===
Function updatePointer()->$p : Pointer
	
	$p:=OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.name)
	
	If (Not:C34(Is nil pointer:C315($p)))
		
		This:C1470.pointer:=$p
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === ===
Function pointer()->$p : Pointer
	
	$p:=OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.name)
	
	//=== === === === === === === === === === === === === === === === === === ===
Function setDatasource($datasource)
	
	This:C1470.dataSource:=$datasource
	
	If (Value type:C1509($datasource)=Is object:K8:27)
		
		// Formula
		This:C1470.value:=This:C1470.dataSource.call()
		
	Else 
		
		This:C1470.value:=Formula from string:C1601($datasource).call()
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === ===
Function setFormat($format : Text)->$this : cs:C1710.widget
	
	OBJECT SET FORMAT:C236(*; This:C1470.name; $format)
	
	$this:=This:C1470
	
/*═════════════════════════════════════════════════
Attaches an image to the widget
	
   Possible values for proxy values are:
    • "#{folder/}picturename" or "file:{folder/}picturename" if the picture comes from a file stored in the Resources folder
    • variable name if the picture comes from a picture variable
    • number, preceded with a question mark (ex.: “?250”) if the picture comes from a picture library (OBSOLETE)
*/
Function setPicture($proxy : Text)->$this : cs:C1710.widget
	
	If (Count parameters:C259>=1)
		
		Case of 
				
				//______________________________________________________
			: (This:C1470.type=Object type 3D button:K79:17)\
				 | (This:C1470.type=Object type 3D checkbox:K79:27)\
				 | (This:C1470.type=Object type 3D radio button:K79:24)
				
				This:C1470.setFormat(";"+$proxy)
				
				//______________________________________________________
			: (This:C1470.type=Object type picture button:K79:20)\
				 | (This:C1470.type=Object type picture popup menu:K79:15)
				
				This:C1470.setFormat(";;"+$proxy)
				
				//______________________________________________________
			: (This:C1470.type=Object type listbox header:K79:9)\
				 | (This:C1470.type=Object type static picture:K79:3)
				
				This:C1470.setFormat($proxy)
				
				//______________________________________________________
			Else 
				
				// #ERROR
				
				//______________________________________________________
		End case 
		
	Else 
		
		// Remove picture
		
		Case of 
				
				//______________________________________________________
			: (This:C1470.type=Object type 3D button:K79:17)\
				 | (This:C1470.type=Object type 3D checkbox:K79:27)\
				 | (This:C1470.type=Object type 3D radio button:K79:24)
				
				This:C1470.setFormat(";\"\"")
				
				//______________________________________________________
			: (This:C1470.type=Object type picture button:K79:20)\
				 | (This:C1470.type=Object type picture popup menu:K79:15)
				
				This:C1470.setFormat(";;\"\"")
				
				//______________________________________________________
			: (This:C1470.type=Object type listbox header:K79:9)\
				 | (This:C1470.type=Object type static picture:K79:3)
				
				This:C1470.setFormat("")
				
				//______________________________________________________
			Else 
				
				// #ERROR
				
				//______________________________________________________
		End case 
	End if 
	
	$this:=This:C1470
	
/*══════════════════════════*/
Function getEnterable
	
	C_BOOLEAN:C305($0)
	
	$0:=OBJECT Get enterable:C1067(*; This:C1470.name)
	
/*══════════════════════════
.enterable()
.enterable(bool)
══════════════════════════*/
Function enterable
	
	C_BOOLEAN:C305($1)
	
	If (Count parameters:C259>=1)
		
		OBJECT SET ENTERABLE:C238(*; This:C1470.name; $1)
		
	Else 
		
		OBJECT SET ENTERABLE:C238(*; This:C1470.name; True:C214)
		
	End if 
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
/*══════════════════════════
.notEnterable() --> This
══════════════════════════*/
Function notEnterable
	
	OBJECT SET ENTERABLE:C238(*; This:C1470.name; False:C215)
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === ===
Function draggable($enabled : Boolean; $automatic : Boolean)->$this : cs:C1710.widget
	
	var $automaticDrag; $automaticDrop; $draggable; $droppable : Boolean
	
	OBJECT GET DRAG AND DROP OPTIONS:C1184(*; This:C1470.name; $draggable; $automaticDrag; $droppable; $automaticDrop)
	
	Case of 
			
			//______________________________________________________
		: (Count parameters:C259>=2)
			
			$draggable:=$enabled
			$automaticDrag:=$automatic
			
			//______________________________________________________
		: (Count parameters:C259>=1)
			
			$draggable:=$enabled
			$automaticDrag:=False:C215
			
			//______________________________________________________
		Else 
			
			$draggable:=True:C214
			$automaticDrag:=False:C215
			
			//______________________________________________________
	End case 
	
	OBJECT SET DRAG AND DROP OPTIONS:C1183(*; This:C1470.name; $draggable; $automaticDrag; $droppable; $automaticDrop)
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === ===
Function notDraggable()->$this : cs:C1710.widget
	
	var $automaticDrag; $automaticDrop; $draggable; $droppable : Boolean
	
	OBJECT GET DRAG AND DROP OPTIONS:C1184(*; This:C1470.name; $draggable; $automaticDrag; $droppable; $automaticDrop)
	OBJECT SET DRAG AND DROP OPTIONS:C1183(*; This:C1470.name; False:C215; False:C215; $droppable; $automaticDrop)
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === ===
Function droppable($enabled : Boolean; $automatic : Boolean)->$this : cs:C1710.widget
	
	var $automaticDrag; $automaticDrop; $draggable; $droppable : Boolean
	
	OBJECT GET DRAG AND DROP OPTIONS:C1184(*; This:C1470.name; $draggable; $automaticDrag; $droppable; $automaticDrop)
	
	Case of 
			
			//______________________________________________________
		: (Count parameters:C259>=2)
			
			$droppable:=$enabled
			$automaticDrop:=$automatic
			
			//______________________________________________________
		: (Count parameters:C259>=1)
			
			$droppable:=$enabled
			$automaticDrop:=False:C215
			
			//______________________________________________________
		Else 
			
			$droppable:=True:C214
			$automaticDrop:=False:C215
			
			//______________________________________________________
	End case 
	
	OBJECT SET DRAG AND DROP OPTIONS:C1183(*; This:C1470.name; $draggable; $automaticDrag; $droppable; $automaticDrop)
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === ===
Function notDroppable()->$this : cs:C1710.widget
	
	var $automaticDrag; $automaticDrop; $draggable; $droppable : Boolean
	
	OBJECT GET DRAG AND DROP OPTIONS:C1184(*; This:C1470.name; $draggable; $automaticDrag; $droppable; $automaticDrop)
	OBJECT SET DRAG AND DROP OPTIONS:C1183(*; This:C1470.name; $draggable; $automaticDrag; False:C215; False:C215)
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === ===
Function getValue()->$value
	
	$value:=OBJECT Get value:C1743(This:C1470.name)
	
	//=== === === === === === === === === === === === === === === === === === ===
Function setValue($value)->$this : cs:C1710.widget
	
	OBJECT SET VALUE:C1742(This:C1470.name; $value)
	This:C1470.value:=$value
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === ===
Function clear->$this : cs:C1710.widget
	
	var $type : Integer
	$type:=Value type:C1509(OBJECT Get value:C1743(This:C1470.name))
	
	Case of 
			
			//______________________________________________________
		: ($type=Is text:K8:3)
			
			OBJECT SET VALUE:C1742(This:C1470.name; "")
			
			//______________________________________________________
		: ($type=Is real:K8:4)\
			 | ($type=Is longint:K8:6)
			
			OBJECT SET VALUE:C1742(This:C1470.name; 0)
			
			//______________________________________________________
		: ($type=Is boolean:K8:9)
			
			OBJECT SET VALUE:C1742(This:C1470.name; False:C215)
			
			//______________________________________________________
		: ($type=Is date:K8:7)
			
			OBJECT SET VALUE:C1742(This:C1470.name; !00-00-00!)
			
			//______________________________________________________
		: ($type=Is time:K8:8)
			
			OBJECT SET VALUE:C1742(This:C1470.name; ?00:00:00?)
			
			//______________________________________________________
		: ($type=Is object:K8:27) | ($type=Is collection:K8:32)
			
			OBJECT SET VALUE:C1742(This:C1470.name; Null:C1517)
			
			//______________________________________________________
		: ($type=Is picture:K8:10)
			
			OBJECT SET VALUE:C1742(This:C1470.name; OBJECT Get value:C1743(This:C1470.name)*0)
			
			//______________________________________________________
		Else 
			
			OBJECT SET VALUE:C1742(This:C1470.name; Null:C1517)
			
			//______________________________________________________
	End case 
	
	$this:=This:C1470
	
	//=== === === === === === === === === === === === === === === === === === ===
Function touch()->$this : cs:C1710.widget
	
	var $value
	$value:=OBJECT Get value:C1743(This:C1470.name)
	
	If (Value type:C1509($value)#Is undefined:K8:13)
		
		OBJECT SET VALUE:C1742(This:C1470.name; $value)
		
	End if 
	
	$this:=This:C1470
	
/*══════════════════════════
.on(e;callback) -> bool
══════════════════════════*/
Function on
	
	C_BOOLEAN:C305($0)
	C_VARIANT:C1683($1)
	C_OBJECT:C1216($2)
	
	If (Asserted:C1132(This:C1470.type#-1; "Does not apply to a group"))
		
		If (Count parameters:C259=0)
			
			$0:=(This:C1470.name=FORM Event:C1606.objectName)
			
		Else 
			
			If (Value type:C1509($1)=Is object:K8:27)
				
				If (Count parameters:C259>=2)
					
					$0:=(This:C1470.name=String:C10($1.objectName))\
						 & ($1.code=$2)
					
				Else 
					
					$0:=(This:C1470.name=String:C10($1.objectName))
					
				End if 
			Else 
				
				$0:=(This:C1470.name=String:C10($1))
				
			End if 
		End if 
		
		If ($0)
			
			$2.call()
			
		End if 
	End if 
	
/*══════════════════════════
.catch(e) -> bool
══════════════════════════*/
Function catch
	
	C_BOOLEAN:C305($0)
	C_VARIANT:C1683($1)
	C_VARIANT:C1683($2)
	
	If (Asserted:C1132(This:C1470.type#-1; "Does not apply to a group"))
		
		If (Count parameters:C259=0)
			
			$0:=(This:C1470.name=FORM Event:C1606.objectName)
			
		Else 
			
			If (Value type:C1509($1)=Is object:K8:27)
				
				If (Count parameters:C259>=2)
					
					If ((This:C1470.name=String:C10($1.objectName)))
						
						If (Value type:C1509($2)=Is collection:K8:32)
							
							$0:=($2.indexOf($1.code)#-1)
							
						Else 
							
							$0:=($1.code=Num:C11($2))
							
						End if 
					End if 
					
				Else 
					
					$0:=(This:C1470.name=String:C10($1.objectName))
					
				End if 
			Else 
				
				$0:=(This:C1470.name=String:C10($1))
				
			End if 
		End if 
	End if 
	
	If ($0)
		
		If (This:C1470.callback#Null:C1517)
			
			This:C1470.callback.call()
			
		End if 
	End if 
	
/*══════════════════════════
.setCallback(formula) -> This
.setCallback(text) -> This
══════════════════════════*/
Function setCallback($formula)->$this : cs:C1710.widget
	
	If (Value type:C1509($formula)=Is object:K8:27)
		
		This:C1470.callback:=$formula
		
	Else 
		
		This:C1470.callback:=Formula from string:C1601(String:C10($formula))
		
	End if 
	
	$this:=This:C1470
	
/*══════════════════════════
.execute()
══════════════════════════*/
Function execute
	
	If (Asserted:C1132(This:C1470.callback#Null:C1517; "No callback method define"))
		
		This:C1470.callback.call()
		
	End if 
	
/*══════════════════════════
.getHelpTip() -> text
══════════════════════════*/
Function getHelpTip
	
	C_TEXT:C284($0)
	
	$0:=OBJECT Get help tip:C1182(*; This:C1470.name)
	
/*══════════════════════════
.setHelpTip(text| resname) -> This
══════════════════════════*/
Function setHelpTip($helpTip : Text)->$this : cs:C1710.widget
	var $t : Text
	
	If (Count parameters:C259>=1)
		
		$t:=$helpTip
		
		If (Length:C16($helpTip)>0)\
			 & (Length:C16($helpTip)<=255)
			
			//%W-533.1
			If ($helpTip[[1]]#Char:C90(1))
				
				$t:=Get localized string:C991($helpTip)
				$t:=Choose:C955(Length:C16($t)>0; $t; $helpTip)  // Revert if no localization
				
			End if 
			//%W+533.1
			
		End if 
	End if 
	
	OBJECT SET HELP TIP:C1181(*; This:C1470.name; $t)
	
	$this:=This:C1470
	
/*══════════════════════════
.getShortcut() -> object
  {"key";text;"modifier";int)
══════════════════════════*/
Function getShortcut
	
	C_OBJECT:C1216($0)
	C_TEXT:C284($t)
	C_LONGINT:C283($l)
	
	OBJECT GET SHORTCUT:C1186(*; This:C1470.name; $t; $l)
	
	$0:=New object:C1471(\
		"key"; $t; \
		"modifier"; $l)
	
/*══════════════════════════
.setShortcut(text{;int} ) -> This
══════════════════════════*/
Function setShortcut($key : Text; $modifier : Integer)->$this : cs:C1710.widget
	
	If (Count parameters:C259>=2)
		
		OBJECT SET SHORTCUT:C1185(*; This:C1470.name; $key; $modifier)
		
	Else 
		
		OBJECT SET SHORTCUT:C1185(*; This:C1470.name; $key)
		
	End if 
	
	$this:=This:C1470
	
/*══════════════════════════
.focus() -> This
══════════════════════════*/
Function focus
	
	GOTO OBJECT:C206(*; This:C1470.name)
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
/*════════════════════════════════════════════════════
.addEvent(collection | longint))-> This
*/
Function addEvent($event)->$this : cs:C1710.widget
	
	ARRAY LONGINT:C221($eventArray; 0x0000)
	
	Case of 
			//______________________________________________________
		: (Value type:C1509($event)=Is collection:K8:32)
			
			COLLECTION TO ARRAY:C1562($event; $eventArray)
			OBJECT SET EVENTS:C1239(*; This:C1470.name; $eventArray; Enable events others unchanged:K42:38)
			
			//______________________________________________________
		: (Value type:C1509($event)=Is object:K8:27)
			
			//#TO_DO
			
			//______________________________________________________
		Else 
			
			APPEND TO ARRAY:C911($eventArray; Num:C11($event))
			OBJECT SET EVENTS:C1239(*; This:C1470.name; $eventArray; Enable events others unchanged:K42:38)
			
			//______________________________________________________
	End case 
	
	$this:=This:C1470
	
/*════════════════════════════════════════════════════
.removeEvent(collection | longint) -> This
*/
Function removeEvent($event)->$this : cs:C1710.widget
	
	ARRAY LONGINT:C221($eventArray; 0x0000)
	
	Case of 
			//______________________________________________________
		: (Value type:C1509($event)=Is collection:K8:32)
			
			COLLECTION TO ARRAY:C1562($event; $eventArray)
			OBJECT SET EVENTS:C1239(*; This:C1470.name; $eventArray; Disable events others unchanged:K42:39)
			
			//______________________________________________________
		: (Value type:C1509($event)=Is object:K8:27)
			
			//#TO_DO
			
			//______________________________________________________
		Else 
			
			APPEND TO ARRAY:C911($eventArray; Num:C11($event))
			OBJECT SET EVENTS:C1239(*; This:C1470.name; $eventArray; Disable events others unchanged:K42:39)
			
			//______________________________________________________
	End case 
	
	$this:=This:C1470