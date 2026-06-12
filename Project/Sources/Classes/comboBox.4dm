Class extends dropDown

property _ordered; automaticExpand : Boolean

Class constructor($name : Text; $data : Object; $parent : Object)
	
	Super:C1705($name; $data; $parent)
	
	This:C1470._ordered:=Bool:C1537($data.ordered)
	This:C1470.automaticExpand:=Bool:C1537($data.automaticExpand)
	
	If (This:C1470.automaticExpand)
		
		This:C1470._automaticExpandInit()
		
	End if 
	
	If ($data.automaticInsertion)
		
		This:C1470.addEvent(On Data Change:K2:15)
		
	End if 
	
	This:C1470.filter:=Num:C11(This:C1470.data.type)

	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get value() : Text
	
	return This:C1470.isFocused() ? Get edited text:C655 : String:C10(This:C1470.data.currentValue)

	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function predictiveTyping($input : Text) : Text
	
	If (This:C1470.isFocused())
		
		$input:=$input || Get edited text:C655
		
		If (Length:C16($input)=0)
			
			This:C1470.index:=-1
			
			return 
			
		End if 
		
		var $o:=This:C1470.checkValue($input+"@")
		
		If ($o.success)
			
			This:C1470.index:=$o.indx
			This:C1470.data.currentValue:=$o.value
			
			HIGHLIGHT TEXT:C210(*; This:C1470.name; Length:C16($input)+1; MAXLONG:K35:2)
			
			This:C1470.redraw()
			
		End if 
		
		return $input
		
	End if 

	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Force the redrawing
Function redraw()
	
	This:C1470.data:=This:C1470.data
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get automaticExpand() : Boolean
	
	return Bool:C1537(This:C1470.data.automaticExpand)
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set automaticExpand($auto : Boolean)
	
	This:C1470.data.automaticExpand:=$auto
	
	If ($auto)
		
		This:C1470._automaticExpandInit()
		
	End if 

	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get automaticInsertion() : Boolean
	
	return Bool:C1537(This:C1470.data.automaticInsertion)
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set automaticInsertion($auto : Boolean)
	
	This:C1470.data.automaticInsertion:=$auto
	
	If ($auto)
		
		This:C1470.addEvent(On Data Change:K2:15)
		
	End if 

	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get ordered() : Boolean
	
	return Bool:C1537(This:C1470.data.ordered)
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set ordered($auto : Boolean)
	
	This:C1470.data.ordered:=$auto
	
	If ($auto)
		
		This:C1470.order()
		
	End if 
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get filter() : Text
	
	return OBJECT Get filter:C1073(*; This:C1470.name)
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set filter($filter)
	
	var $separator : Text
	
	If (Value type:C1509($filter)=Is longint:K8:6)\
		 | (Value type:C1509($filter)=Is real:K8:4)  // Predefined formats
		
		Case of 
				
				//………………………………………………………………………
			: ($filter=Is integer:K8:5)\
				 | ($filter=Is longint:K8:6)\
				 | ($filter=Is integer 64 bits:K8:25)
				
				OBJECT SET FILTER:C235(*; This:C1470.name; "&\"0-9;-;+\"")
				
				//………………………………………………………………………
			: ($filter=Is real:K8:4)
				
				GET SYSTEM FORMAT:C994(Decimal separator:K60:1; $separator)
				OBJECT SET FILTER:C235(*; This:C1470.name; "&\"0-9;"+$separator+";.;-;+\"")
				
				//………………………………………………………………………
			: ($filter=Is time:K8:8)
				
				GET SYSTEM FORMAT:C994(Time separator:K60:11; $separator)
				OBJECT SET FILTER:C235(*; This:C1470.name; "&\"0-9;"+$separator+";:\"")
				
				//………………………………………………………………………
			: ($filter=Is date:K8:7)
				
				GET SYSTEM FORMAT:C994(Date separator:K60:10; $separator)
				OBJECT SET FILTER:C235(*; This:C1470.name; "&\"0-9;"+$separator+";/\"")
				
				//………………………………………………………………………
			Else 
				
				OBJECT SET FILTER:C235(*; This:C1470.name; "")  // Text as default
				
				//………………………………………………………………………
		End case 
		
	Else 
		
		OBJECT SET FILTER:C235(*; This:C1470.name; String:C10($filter))
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Display the selection list (to use in the On getting focus event)
Function expand($force : Boolean) : cs:C1710.comboBox
	
	If ($force || This:C1470.automaticExpand)
		
		// Get the current widget window coordinates
		var $o:=This:C1470.windowCoordinates
		POST CLICK:C466($o.right-10; $o.top+10; Current process:C322)
		
	End if 
	
	return This:C1470

	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function order()
	
	This:C1470.data.values:=This:C1470.data.values.orderBy()
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Display the selection list (to use in the On Data change event)
Function automaticInsertion($ordered : Boolean)
	
	var $value : Variant:=This:C1470.data.currentValue
	var $index : Integer:=This:C1470.data.values.indexOf($value)
	
	If ($index=-1)
		
		This:C1470.data.values.push($value)
		
		If ($ordered | This:C1470._ordered)
			
			This:C1470.data.values:=This:C1470.data.values.orderBy()
			$index:=This:C1470.data.values.indexOf($value)
			
		End if 
	End if 
	
	This:C1470.data.index:=$index

	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Insert an item or the current value. 
	// Keep the list ordered if any
Function insert($item; $order : Boolean) : cs:C1710.comboBox
	
	If (Count parameters:C259=0)\
		 || (Value type:C1509($1)=Is boolean:K8:9)
		
		var $value : Variant:=This:C1470.value
		
	Else 
		
		$value:=$item
		
	End if 
	
	If (Length:C16(String:C10($value))=0)
		
		return This:C1470
		
	End if 
	
	var $values:=This:C1470.values
	var $index : Integer:=$values.indexOf($value)
	
	If ($index=-1)
		
		$values.push($value)
		
		If (This:C1470.ordered | $order)
			
			$values:=$values.orderBy()
			$index:=$values.indexOf($value)
			
		End if 
	End if 
	
	This:C1470.data.values:=$values
	This:C1470.data.index:=$index
	
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function listModified() : Boolean
	
	return Not:C34(This:C1470.data.values.equal(This:C1470._backup.values))
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function eventHandler() : Object
	
	var $e:=FORM Event:C1606
	
	Case of 
			
			// ______________________________________________________
		: ($e.code=On Getting Focus:K2:7)
			
			If (This:C1470.data.automaticExpand)
				
				This:C1470.expand(True:C214)
				
			End if 
			
			// ______________________________________________________
		: ($e.code=On Data Change:K2:15)
			
			If (This:C1470.data.automaticInsertion)
				
				This:C1470.automaticInsertion()
				
			End if 
			
			// ______________________________________________________
	End case 
	
	return $e

	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
	// Set On Getting focus event, if any
Function _automaticExpandInit()
	
	This:C1470.addEvent(On Getting Focus:K2:7)