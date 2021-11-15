/*————————————————————————————————————————————————————————————————————————————————
A group is a collection of static or active objects

You can define it by passing N objects as parameters
--> cs.group.new(object1, object2, …, objectN)

or a collection of objects (could be a group)
--> cs.group.new(object collection)    

or a comma separated list of object names
--> cs.group.new("name1,name2,…,nameN")
in this case, all named objects are initialized with widget class

——————————————————————————*/
Class constructor($members : Variant)
	
	C_OBJECT:C1216(${2})
	
	C_LONGINT:C283($i)
	C_TEXT:C284($t)
	
	Case of 
			
			//___________________________
		: (Count parameters:C259=0)
			
			This:C1470.members:=New collection:C1472
			
			//___________________________
		: (Value type:C1509($members)=Is collection:K8:32)
			
			This:C1470.members:=$members
			
			//___________________________
		: (Value type:C1509($members)=Is object:K8:27)  // 1 to N objects (could be groups)
			
			This:C1470.members:=New collection:C1472
			
			For ($i; 1; Count parameters:C259; 1)
				
				This:C1470.addMember(${$i})
				
			End for 
			
			//___________________________
		: (Value type:C1509($members)=Is text:K8:3)  // Comma separated list of object names
			
			This:C1470.members:=New collection:C1472
			
			This:C1470.addMember($members)
			
			//___________________________
		Else 
			
			This:C1470.members:=New collection:C1472
			
			//___________________________
	End case 
	
	//=== === === === === === === === === === === === === === === === === === === === ===
Function addMember($member)->$this : cs:C1710.group
	
	var $t : Text
	
	Case of 
			
			//___________________________
		: (Value type:C1509($member)=Is collection:K8:32)
			
			This:C1470.members:=This:C1470.members.combine($member)
			
			//___________________________
		: (Value type:C1509($member)=Is object:K8:27)
			
			If (OB Instance of:C1731($member; cs:C1710.group))
				
				This:C1470.members:=This:C1470.members.combine($member.members)
				
			Else 
				
				This:C1470.members.push($member)
				
			End if 
			
			//___________________________
		: (Value type:C1509($member)=Is text:K8:3)  // Comma separated list of object names
			
			For each ($t; Split string:C1554($member; ","))
				
				This:C1470.members.push(cs:C1710.widget.new($t))  // Widget by default
				
			End for each 
			
			//___________________________
		Else 
			
			ASSERT:C1129(False:C215; "Bad parameter type")
			
			//___________________________
	End case 
	
	$this:=This:C1470
	
/*════════════════════════════════════════════
Returns True if the passed object or object name is part of the group
	
.belongsTo(obj) --> bool
	
or
	
.belongsTo("name") --> bool
	
══════════════════════════*/
Function belongsTo($formObject : Variant)->$yes : Boolean
	
	Case of 
			
			//______________________________________________________
		: (Value type:C1509($formObject)=Is object:K8:27)
			
			$yes:=(This:C1470.members.indexOf($formObject)#-1)
			
			//______________________________________________________
		: (Value type:C1509($formObject)=Is text:K8:3)
			
			$yes:=(This:C1470.members.query("name=:1"; $formObject).pop()#Null:C1517)
			
			//______________________________________________________
		Else 
			
			ASSERT:C1129(False:C215; "Unmanaged parameter type")
			
			//______________________________________________________
	End case 
	
	//════════════════════════════════════════════
	// Returns the coordinates of the rectangle enclosing the group.
Function enclosingRect()->$coordinates : Object
	
	var $left; $top; $right; $bottom : Integer
	var $o : Object
	
	For each ($o; This:C1470.members)
		
		OBJECT GET COORDINATES:C663(*; $o.name; $left; $top; $right; $bottom)
		
		If ($coordinates=Null:C1517)
			
			$coordinates:=New object:C1471(\
				"left"; $left; \
				"top"; $top; \
				"right"; $right; \
				"bottom"; $bottom)
			
		Else 
			
			$coordinates.left:=Choose:C955($left<$coordinates.left; $left; $coordinates.left)
			$coordinates.top:=Choose:C955($top<$coordinates.top; $top; $coordinates.top)
			$coordinates.right:=Choose:C955($right>$coordinates.right; $right; $coordinates.right)
			$coordinates.bottom:=Choose:C955($bottom>$coordinates.bottom; $bottom; $coordinates.bottom)
			
		End if 
	End for each 
	
	//════════════════════════════════════════════
Function moveVertically($offset : Integer)
	
	var $o : Object
	
	For each ($o; This:C1470.members)
		
		$o.moveVertically($offset)
		
	End for each 
	
	//════════════════════════════════════════════
Function moveHorizontally($offset : Integer)
	
	var $o : Object
	
	For each ($o; This:C1470.members)
		
		$o.moveHorizontally($offset)
		
	End for each 
	
/*════════════════════════════════════════════
Performs a horizontal distribution, from left to right,
of the elements according to their best size
	
.distributeLeftToRight({obj})
	
The optional object type parameter allow to specify:
- The starting point x in pixels in the form (start)
- The spacing in pixels to respect between the elements (spacing)
- The minimum width to respect in pixels (minWidth)
- The maximum width to respect in pixels (maxWidth)
	
══════════════════════════*/
Function distributeLeftToRight($params : Object)->$this : cs:C1710.group
	
	var $e; $o : Object
	var $key : Text
	
	$e:=New object:C1471(\
		"start"; 0; \
		"spacing"; 0; \
		"minWidth"; 0; \
		"maxWidth"; 0; \
		"alignment"; Align left:K42:2)
	
	If (Count parameters:C259>=1)
		
		For each ($key; $params)
			
			If ($params[$key]#Null:C1517)
				
				$e[$key]:=$params[$key]
				
			End if 
		End for each 
	End if 
	
	For each ($o; This:C1470.members)
		
		$o.bestSize($e)
		
		If ($e.start#0)
			
			$o.moveHorizontally($e.start-$o.coordinates.left)
			
		End if 
		
		// Calculate the cumulative shift
		If ($e.spacing=0)
			
			Case of 
					
					//_______________________________
				: ($o.type=Object type push button:K79:16)
					
					$e.start:=$o.coordinates.right+Choose:C955(Is macOS:C1572; 20; 20)
					
					//_______________________________
				Else 
					
					$e.start:=$o.coordinates.right
					
					//_______________________________
			End case 
			
		Else 
			
			$e.start:=$o.coordinates.right+$e.spacing
			
		End if 
	End for each 
	
	$this:=This:C1470
	
/*════════════════════════════════════════════
Performs a horizontal distribution, from right to left,
of the elements according to their best size
	
.distributeRigthToLeft({obj})
	
The optional object type parameter allow to specify:
- The starting point x in pixels in the form (start)
- The spacing in pixels to respect between the elements (spacing)
- The minimum width to respect in pixels (minWidth)
- The maximum width to respect in pixels (maxWidth)
	
══════════════════════════*/
Function distributeRigthToLeft($params : Object)->$this : cs:C1710.group
	
	var $e; $o : Object
	var $key : Text
	
	$e:=New object:C1471(\
		"start"; 0; \
		"spacing"; 0; \
		"minWidth"; 0; \
		"maxWidth"; 0; \
		"alignment"; Align right:K42:4)
	
	If (Count parameters:C259>=1)
		
		For each ($key; $params)
			
			If ($params[$key]#Null:C1517)
				
				$e[$key]:=$params[$key]
				
			End if 
		End for each 
	End if 
	
	For each ($o; This:C1470.members)
		
		$o.bestSize($e)
		
		If ($e.start#0)
			
			$o.moveHorizontally($e.start-$o.coordinates.right)
			
		End if 
		
		// Calculate the cumulative shift
		If ($e.spacing=0)
			
			Case of 
					
					//_______________________________
				: ($o.type=Object type push button:K79:16)
					
					$e.start:=$o.coordinates.left-Choose:C955(Is macOS:C1572; 20; 20)
					
					//_______________________________
				Else 
					
					$e.start:=$o.coordinates.left
					
					//_______________________________
			End case 
			
		Else 
			
			$e.start:=$o.coordinates.left-$e.spacing
			
		End if 
	End for each 
	
	$this:=This:C1470
	
	//════════════════════════════════════════════
/*
Performs a centered alignment of the elements according to their best size
	
.centerVertically({obj})
	
The optional widget name parameter allow to specify the reference
If ommited, the distribution is relative to the form
*/
Function centerVertically($reference : Text)->$this : cs:C1710.group
	
	var $bottom; $height; $left; $middle; $right; $top; $width : Integer
	var $o : Object
	
	If (Count parameters:C259>=1)
		
		OBJECT GET COORDINATES:C663(*; $reference; $left; $top; $right; $bottom)
		$middle:=($right-$left)\2
		
	Else 
		
		OBJECT GET SUBFORM CONTAINER SIZE:C1148($width; $height)
		$middle:=$width\2
		
	End if 
	
	For each ($o; This:C1470.members)
		
		OBJECT GET COORDINATES:C663(*; $o.name; $left; $top; $right; $bottom)
		$width:=$right-$left
		$left:=$middle-($width\2)
		$right:=$left+$width
		OBJECT SET COORDINATES:C1248(*; $o.name; $left; $top; $right; $bottom)
		
	End for each 
	
	$this:=This:C1470
	
	//════════════════════════════════════════════
Function alignLeft($reference)->$this : cs:C1710.group
	
	var $left : Integer
	var $o : Object
	
	If (Count parameters:C259>=1)
		
		Case of 
				
				//______________________________________________________
			: (Value type:C1509($reference)=Is object:K8:27)
				
				// We assume it is from the static class (or extend)
				// #TO_DO: test the class
				$left:=$reference.updateCoordinates().coordinates.left
				
				//______________________________________________________
			: (Value type:C1509($reference)=Is integer:K8:5)\
				 | (Value type:C1509($reference)=Is real:K8:4)
				
				$left:=$reference
				
				//______________________________________________________
			: (Value type:C1509($reference)=Is text:K8:3)
				
				$left:=cs:C1710.formObject.new($reference).coordinates.left
				
				//______________________________________________________
			Else 
				
				// #ERROR
				
				//______________________________________________________
		End case 
		
	Else 
		
		// Default reference is the first member of the group
		$left:=This:C1470.members[0].updateCoordinates().coordinates.left
		
	End if 
	
	For each ($o; This:C1470.members)
		
		$o.moveHorizontally($left-$o.coordinates.left)
		
	End for each 
	
	$this:=This:C1470
	
	//════════════════════════════════════════════
Function alignRight($reference)->$this : cs:C1710.group
	
	var $right : Integer
	var $o : Object
	
	If (Count parameters:C259>=1)
		
		Case of 
				
				//______________________________________________________
			: (Value type:C1509($reference)=Is object:K8:27)
				
				// We assume it is from the static class (or extend)
				// #TO_DO: test the class
				$right:=$reference.updateCoordinates().coordinates.right
				
				//______________________________________________________
			: (Value type:C1509($reference)=Is integer:K8:5)\
				 | (Value type:C1509($reference)=Is real:K8:4)
				
				$right:=$reference
				
				//______________________________________________________
			: (Value type:C1509($reference)=Is text:K8:3)
				
				$right:=cs:C1710.formObject.new($reference).coordinates.right
				
				//______________________________________________________
			Else 
				
				// #ERROR
				
				//______________________________________________________
		End case 
		
	Else 
		
		// Default reference is the first member of the group
		$right:=This:C1470.members[0].updateCoordinates().coordinates.right
		
	End if 
	
	For each ($o; This:C1470.members)
		
		$o.moveHorizontally($right-$o.coordinates.right)
		
	End for each 
	
	$this:=This:C1470
	
	//════════════════════════════════════════════
Function show($visible : Boolean)->$this : cs:C1710.group
	
	var $o : Object
	
	If (Count parameters:C259>=1)
		
		For each ($o; This:C1470.members)
			
			$o.show($visible)
			
		End for each 
		
	Else 
		
		For each ($o; This:C1470.members)
			
			$o.show()
			
		End for each 
	End if 
	
	$this:=This:C1470
	
	//════════════════════════════════════════════
Function hide->$this : cs:C1710.group
	
	var $o : Object
	
	For each ($o; This:C1470.members)
		
		$o.hide()
		
	End for each 
	
	$this:=This:C1470
	
	//════════════════════════════════════════════
Function enable($enabled : Boolean)->$this : cs:C1710.group
	
	var $o : Object
	
	If (Count parameters:C259>=1)
		
		For each ($o; This:C1470.members)
			
			$o.enable($enabled)
			
		End for each 
		
	Else 
		
		For each ($o; This:C1470.members)
			
			$o.enable()
			
		End for each 
	End if 
	
	$this:=This:C1470
	
	//════════════════════════════════════════════
Function disable->$this : cs:C1710.group
	
	var $o : Object
	
	For each ($o; This:C1470.members)
		
		$o.disable()
		
	End for each 
	
	$this:=This:C1470
	
	//════════════════════════════════════════════
Function setFontStyle($style : Integer)->$this : cs:C1710.group
	
	var $o : Object
	
	If (Count parameters:C259>=1)
		
		For each ($o; This:C1470.members)
			
			$o.setFontStyle($style)
			
		End for each 
		
	Else 
		
		For each ($o; This:C1470.members)
			
			$o.setFontStyle()
			
		End for each 
	End if 
	
	$this:=This:C1470