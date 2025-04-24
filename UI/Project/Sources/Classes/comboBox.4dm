Class extends dropDown

Class constructor($name : Text; $data : Object; $parent : Object)
	
	Super:C1705($name; $data; $parent)
	
	If (Bool:C1537($data.ordered))
		
		This:C1470.order()
		
	End if 
	
	If ($data.automaticExpand)
		
		This:C1470._automaticExpandInit()
		
	End if 
	
	This:C1470.filter:=Num:C11(This:C1470.data.type)
	
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
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get ordered() : Boolean
	
	return Bool:C1537(This:C1470.data.ordered)
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set ordered($auto : Boolean)
	
	This:C1470.data.ordered:=$auto
	
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
Function setFilter($filter)
	
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
Function order() : cs:C1710.comboBox
	
	This:C1470.data.values:=This:C1470.data.values.orderBy()
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Display the selection list (to use in the On getting focus event)
Function expand($force : Boolean) : cs:C1710.comboBox
	
	If (This:C1470.data.automaticExpand | $force)
		
		POST KEY:C465(Down arrow key:K12:19; 0 ?+ Command key bit:K16:2)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Insert an item or the current value. 
	// Keep the list ordered if any
Function insert($item; $sort : Boolean) : cs:C1710.comboBox
	
	If (Count parameters:C259=0)\
		 || (Value type:C1509($1)=Is boolean:K8:9)
		
		var $value : Variant:=This:C1470.value
		$sort:=Count parameters:C259=1 ? $1 : Bool:C1537(This:C1470.ordered)
		
	Else 
		
		$value:=$item
		
	End if 
	
	If (Length:C16($value)=0)
		
		return 
		
	End if 
	
	var $values:=This:C1470.values
	var $index : Integer:=$values.indexOf($value)
	
	If ($index=-1)
		
		$values.push($value)
		
		If ($sort)
			
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
	/// ⚠️ Overrides the parent class function
Function reset($data : Object)
	
	Super:C1706.reset($data)
	
	This:C1470.filter:=Num:C11(This:C1470.data.type)
	
	// MARK:-
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
	// Set On Getting focus event, if any
Function _automaticExpandInit()
	
	This:C1470.addEvent(On Getting Focus:K2:7)
	