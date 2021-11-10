Class extends widget

//═════════════════════════════════════════════════
Class constructor($name : Text; $datasource)
	
	If (Count parameters:C259>=2)
		
		Super:C1705($name; $datasource)
		
	Else 
		
		Super:C1705($name)
		
	End if 
	
/*═════════════════════════════════════════════════
Tryes to underline the first capital letter or,
if not found the first letter, corresponding to
the associated key shortcut
*/
Function highlightShortcut()->$this : cs:C1710.button
	
	var $key; $t : Text
	var $index; $lModifier : Integer
	
	$t:=This:C1470.title()
	
	OBJECT GET SHORTCUT:C1186(*; This:C1470.name; $key; $lModifier)
	
	If (Length:C16($key)>0)
		
		$index:=Position:C15(Uppercase:C13($key); $t; *)
		
		If ($index=0)
			
			$index:=Position:C15($key; $t)
			
		End if 
		
		If ($index>0)
			
			This:C1470.setTitle(Substring:C12($t; 1; $index)+Char:C90(0x0332)+Substring:C12($t; $index+1))
			
		End if 
		
	Else 
		
		// Remove if any
		$t:=Replace string:C233($t; Char:C90(0x0332); "")
		This:C1470.setTitle($t)
		
	End if 
	
	$this:=This:C1470
	
	//═════════════════════════════════════════════════
Function setLinkedPopupMenu()->$this : cs:C1710.button
	
	$this:=This:C1470._setPopupMenu("linked")
	
	//═════════════════════════════════════════════════
Function setSeparatePopupMenu()->$this : cs:C1710.button
	
	$this:=This:C1470._setPopupMenu("separate")
	
	//═════════════════════════════════════════════════
Function setNoPopupMenu()->$this : cs:C1710.button
	
	$this:=This:C1470._setPopupMenu("none")
	
/*═════════════════════════════════════════════════
Association of a pop-up menu with a 3D button
	
If no parameter, the pop menu is removed, if any,
else, possible values are:
	
• 0 or "none": No pop-up menu
• 1 or "linked": With linked pop-up menu
• 2 or "separate": With separate pop-up menu
*/
Function _setPopupMenu($value : Variant)->$this : cs:C1710.button
	
	If (This:C1470.type=Object type 3D button:K79:17)
		
		If (Count parameters:C259>=1)
			
			If (Value type:C1509($value)=Is text:K8:3)
				
				Case of 
						//______________________________________________________
					: ($value="none")
						
						This:C1470.setFormat(";;;;;;;;;;0")
						This:C1470.removeEvent(On Alternative Click:K2:36)
						
						//______________________________________________________
					: ($value="linked")
						
						This:C1470.setFormat(";;;;;;;;;;1")
						This:C1470.removeEvent(On Alternative Click:K2:36)
						
						//______________________________________________________
					: ($value="separate")
						
						This:C1470.setFormat(";;;;;;;;;;2")
						This:C1470.addEvent(On Alternative Click:K2:36)
						
						//______________________________________________________
					Else 
						
						// #ERROR
						
						//______________________________________________________
				End case 
				
			Else 
				
				This:C1470.setFormat(";;;;;;;;;;"+String:C10(Num:C11($value)))
				This:C1470[Choose:C955(Num:C11($value)=2; "addEvent"; "removeEvent")](On Alternative Click:K2:36)
				
			End if 
			
		Else 
			
			This:C1470.setFormat(";;;;;;;;;;0")
			This:C1470.removeEvent(On Alternative Click:K2:36)
			
		End if 
		
	Else 
		
		// #ERROR
		
	End if 
	
	$this:=This:C1470
	
	//═════════════════════════════════════════════════
	// Picture linked to a button
Function setPicture($proxy : Text)->$this : cs:C1710.button
	
	Case of 
			
			//______________________________________________________
		: (Count parameters:C259=0)
			
			// Remove picture
			Super:C1706.setFormat(";#")
			
			//______________________________________________________
		: (Position:C15("path:"; $proxy)=1)\
			 | (Position:C15("file:"; $proxy)=1)
			
			Super:C1706.setPicture($proxy)
			
			//______________________________________________________
		: (Position:C15("#"; $proxy)=1)  // Shortcut for Resources folder
			
			Super:C1706.setPicture("path:/RESOURCES/"+Replace string:C233($proxy; "#"; ""))
			
			//______________________________________________________
		: (Position:C15("/"; $proxy)=1)
			
			Super:C1706.setPicture("path:/RESOURCES"+$proxy)
			
			//Button;path:/RESOURCES/Images/light_on.png;;3;1;1;3;0;0;0;0;0;1
			//Button;path:/RESOURCES/RESOURCES/Images/light_on.png
			
			//______________________________________________________
		Else 
			
			Super:C1706.setPicture("path:/RESOURCES/"+$proxy)
			
			//______________________________________________________
	End case 
	
	$this:=This:C1470
	
	//═════════════════════════════════════════════════
	// Background picture linked to a button (Custom style)
Function setBackgroundPicture($proxy : Text)->$this : cs:C1710.button
	
	Case of 
			
			//______________________________________________________
		: (Count parameters:C259=0)
			
			// Remove background picture
			This:C1470.setFormat(";;#")
			
			//______________________________________________________
		: (Position:C15("path:"; $proxy)=1)\
			 | (Position:C15("file:"; $proxy)=1)
			
			This:C1470.setFormat(";;"+$proxy)
			
			//______________________________________________________
		: (Position:C15("#"; $proxy)=1)  // Shortcut for Resources folder
			
			This:C1470.setFormat(";;path:/RESOURCES/"+Replace string:C233($proxy; "#"; ""))
			
			//______________________________________________________
		: (Position:C15("/"; $proxy)=1)
			
			This:C1470.setFormat(";;path:/RESOURCES"+$proxy)
			
			//______________________________________________________
		Else 
			
			This:C1470.setFormat(";;path:/RESOURCES/"+$proxy)
			
			//______________________________________________________
	End case 
	
	$this:=This:C1470
	
	//═════════════════════════════════════════════════
	// Number of states present in picture used as icon for the 3D button, and which
	// will be used by 4D to represent the standard button states (from 0 to 4)
Function setNumStates($states : Integer)->$this : cs:C1710.button
	
	If (Count parameters:C259>=1)
		
		This:C1470.setFormat(";;;;;;;;;;;;"+String:C10($states))
		
	Else 
		
		// Default is 4
		This:C1470.setFormat(";;;;;;;;;;;;4")
		
	End if 
	
	$this:=This:C1470
	
/*═════════════════════════════════════════════════
A hack to force a button to be boolean type
	
⚠️ Obsolete in project mode because you can
choose the type for the checkboxes
Function asBoolean->$this : cs.button
	
If (This.type=Object type checkbox)
If (This.assignable)
	
EXECUTE FORMULA(":C305((:C1124(:K67:5;This.name))->)")
	
End if 
End if 
	
$this:=This
*/