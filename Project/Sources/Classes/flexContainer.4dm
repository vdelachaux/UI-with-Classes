property children:=[]
property direction:="row"
property justifyContent:="start"
property alignItems:="start"
property padding:=0

property width : Real
property height : Real

property _container : Object

// === === === === === === === === === === === === === === === === === === === === === === === === === ===
// Constructor
// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Class constructor($container : Object; $options : Object)
	
	This:C1470.container:=$container
	
	var $key : Text
	For each ($key; $options || {})
		
		Case of 
				//______________________________________________________
			: ($key="children")\
				 && (Value type:C1509($options[$key])=Is collection:K8:32)
				
				var $child : Object
				For each ($child; $options[$key])
					
					This:C1470.add($child)
					
				End for each 
				
				//______________________________________________________
			Else 
				
				This:C1470[$key]:=$options[$key]
				
				//______________________________________________________
		End case 
		
		
	End for each 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function set container($container : Object)
	
	This:C1470._container:=$container
	
	If ($container#Null:C1517)
		
		This:C1470.height:=Num:C11($container.height)
		This:C1470.width:=Num:C11($container.width)
		
	Else 
		
		var $with; $height : Integer
		OBJECT GET SUBFORM CONTAINER SIZE:C1148($with; $height)
		
		This:C1470.width:=$with
		This:C1470.height:=$height
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function add($widget : Object) : cs:C1710.flexContainer
	
	This:C1470.children.push($widget)
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function layout()
	
	var $container:=This:C1470._container
	This:C1470.height:=$container.height
	This:C1470.width:=$container.width
	
	If (This:C1470.direction="row")
		
		This:C1470._layoutRow()
		
	Else 
		
		This:C1470._layoutColumn()
		
	End if 
	
	// MARK:-
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _layoutRow()
	
	var $count:=This:C1470.children.length
	
	If ($count=0)
		
		return 
		
	End if 
	
	var $available : Real:=This:C1470.width-(This:C1470.padding*2)
	var $totalBasis; $totalGrow : Real
	
	// MARK: Phase 1: Sum of bases / grow
	var $child : Object
	For each ($child; This:C1470.children)
		
		var $constraints : Object:=$child.flexRules
		
		If ($constraints=Null:C1517)
			
			continue
			
		End if 
		
		$totalBasis+=Num:C11($constraints.flexBasis)
		$totalGrow+=Num:C11($constraints.flexGrow)
		
	End for each 
	
	var $remaining : Real:=$available-$totalBasis-This:C1470.padding
	
	// MARK: Phase 2: Positioning
	var $x:=This:C1470.padding
	
	For each ($child; This:C1470.children)
		
		$constraints:=$child.flexRules
		
		If ($totalGrow>0)
			
			var $extra : Real:=($constraints.flexGrow/$totalGrow)*$remaining
			
		Else 
			
			$extra:=0
			
		End if 
		
		var $width : Real:=$constraints.flexBasis+$extra
		
		// Clamp min/max
		If ($constraints.minWidth#Null:C1517)\
			 && ($width<=$constraints.minWidth)
			
			$width:=$constraints.minWidth
			
/*
$child.setResizingOptions(Resize horizontal none)
			
Else 
			
$child.setResizingOptions(Resize horizontal grow)
*/
			
		End if 
		
		If ($constraints.maxWidth#Null:C1517)\
			 && ($width>=$constraints.maxWidth)
			
			$width:=$constraints.maxWidth
			
/*
$child.setResizingOptions(Resize horizontal none)
			
Else 
			
$child.setResizingOptions(Resize horizontal grow)
*/
			
		End if 
		
		// Apply geometry
		$child.left:=$x
		$child.width:=$width
		
		var $height:=This:C1470.height-This:C1470.padding-(This:C1470.padding/2)
		If ($constraints.adjustHeight)
			
			$child.height:=$height
			
		End if 
		
		If ($constraints.minHeight#0)\
			 && ($height<$constraints.minHeight)
			
			$child.height:=$constraints.minHeight
			
		End if 
		
		// Align vertical
		This:C1470._alignCrossAxis($child; "row")
		
		If ($child=This:C1470.children.last())
			
			$child.width+=This:C1470.padding/2
			
		End if 
		
		$x+=$width+This:C1470.padding
		
	End for each 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _layoutColumn()
	
	var $count:=This:C1470.children.length
	
	If ($count=0)
		
		return 
		
	End if 
	
	//var $available : Real:=This.height-(($count-1)*This.padding)
	
	
	var $available; $width : Real
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($width; $available)
	var $totalBasis; $totalGrow : Real
	
	var $child : Object
	
	For each ($child; This:C1470.children)
		
		var $constraints : Object:=$child.constraints
		
		If ($constraints.flexBasis=Null:C1517)
			
			$constraints.flexBasis:=0
			
		End if 
		
		If ($constraints.flexGrow=Null:C1517)
			
			$constraints.flexGrow:=0
			
		End if 
		
		$totalBasis+=$constraints.flexBasis
		$totalGrow+=$constraints.flexGrow
		
	End for each 
	
	var $remaining : Real:=$available-$totalBasis
	
	var $y:=0
	
	For each ($child; This:C1470.children)
		
		$constraints:=$child.constraints
		
		If ($totalGrow>0)
			
			var $extra : Real:=($constraints.flexGrow/$totalGrow)*$remaining
			
		Else 
			
			$extra:=0
			
		End if 
		
		var $height : Real:=$constraints.flexBasis+$extra
		
		// Clamp
		If ($constraints.minHeight#Null:C1517)
			
			$height:=This:C1470._max($height; $constraints.minHeight)
			
		End if 
		
		If ($constraints.maxHeight#Null:C1517)
			
			$height:=This:C1470._min($height; $constraints.maxHeight)
			
		End if 
		
		$child.top:=$y
		$child.height:=$height
		
		This:C1470._alignCrossAxis($child; "column")
		
		$y+=$height+This:C1470.padding
		
	End for each 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _max( ...  : Real) : Real
	
	var $value:=0
	
	var $i : Integer
	For ($i; 1; Count parameters:C259; 1)
		
		If ($i>1)\
			 && (${$i}<=$value)
			
			continue
			
		End if 
		
		$value:=${$i}
		
	End for 
	
	return $value
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _min( ...  : Real) : Real
	
	var $value:=0
	
	var $i : Integer
	For ($i; 1; Count parameters:C259; 1)
		
		If ($i>1)\
			 && (${$i}>=$value)
			
			continue
			
		End if 
		
		$value:=${$i}
		
	End for 
	
	return $value
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _alignCrossAxis($child : Object; $mode : Text)
	
	var $constraints : Object:=$child.constraints
	
	If ($constraints.alignSelf#Null:C1517)
		
		var $align : Text:=$constraints.alignSelf
		
	Else 
		
		$align:=This:C1470.alignItems
		
	End if 
	
	Case of 
			
			//________________________________________________________________________________
		: ($mode="row")
			
			Case of 
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
				: ($align="center")
					
					$child.top:=(This:C1470.height-$child.height)/2
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
				: ($align="end")
					
					$child.top:=This:C1470.height-$child.height
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
				Else 
					
					$child.top:=0
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
			End case 
			
			$child.top+=This:C1470.padding
			
			//________________________________________________________________________________
		: ($mode="column")
			
			Case of 
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
				: ($align="center")
					
					$child.left:=(This:C1470.width-$child.width)/2
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
				: ($align="end")
					
					$child.left:=This:C1470.width-$child.width
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
				Else 
					
					$child.left:=0
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
			End case 
			
			$child.left+=This:C1470.padding
			
			//________________________________________________________________________________
	End case 