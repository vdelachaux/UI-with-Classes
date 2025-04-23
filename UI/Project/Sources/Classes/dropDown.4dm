Class extends widget

property data; _backup : Object

Class constructor($name : Text; $data : Object; $parent : Object)
	
	Super:C1705($name; $parent)
	
	This:C1470._populate($data)
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get values() : Collection
	
	return This:C1470.data.values
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set values($values : Collection)
	
	This:C1470.data.values:=$values
	This:C1470.data.index:=-1
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get value() : Text
	
	If (This:C1470.data.index#-1)\
		 || (OB Instance of:C1731(This:C1470; cs:C1710.dropDown))
		
		return This:C1470.data.currentValue
		
	End if 
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set value($value)
	
	This:C1470.data.currentValue:=$value
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get index() : Integer
	
	return This:C1470.data.index
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set index($index : Integer)
	
	This:C1470.data.index:=$index
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get placeholder() : Variant
	
	return String:C10(This:C1470.data.placeholder)
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set placeholder($placeholder : Variant)
	
	This:C1470.data.placeholder:=$placeholder
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function clear()
	
	var $current : Variant:=This:C1470.data.currentValue
	CLEAR VARIABLE:C89($current)
	This:C1470.data.currentValue:=$current
	
	This:C1470.data.currentValue:=This:C1470.data.placeholder
	This:C1470.data.index:=-1
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function reinit($data : Object)
	
	This:C1470._populate($data)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function reset()
	
	This:C1470._populate(This:C1470._backup)
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _populate($data : Object)
	
	If ($data#Null:C1517)
		
		This:C1470.data:=$data
		This:C1470.data.values:=This:C1470.data.values || []
		This:C1470.data.index:=$data.index#Null:C1517 ? $data.index : -1
		This:C1470.data.placeholder:=$data.placeholder || $data.currentValue  // Default is current value
		
	Else 
		
		This:C1470.data:={values: []}
		
	End if 
	
	This:C1470.clear()
	
	This:C1470._backup:=OB Copy:C1225(This:C1470.data)