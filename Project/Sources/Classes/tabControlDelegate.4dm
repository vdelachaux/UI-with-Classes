Class extends widgetDelegate

property data : Object

Class constructor($name : Text; $data : Object)
	
	Super:C1705($name)
	
	This:C1470.data:={}
	
	Case of 
			
			//______________________________________________________
		: ($data.values=Null:C1517)
			
			This:C1470.data.values:=[]
			
			//______________________________________________________
		: (Value type:C1509($data.values)=Is collection:K8:32)
			
			This:C1470.data.values:=$data.values
			
			//______________________________________________________
		: (Value type:C1509($data.values)=Is text:K8:3)
			
			This:C1470.data.values:=[$data.values]
			
			//______________________________________________________
		Else 
			
			ASSERT:C1129(False:C215; "Type not allowed for data.values!")
			
			//______________________________________________________
	End case 
	
	This:C1470.data.index:=Num:C11($data.index)
	
	This:C1470.data.currentValue:=This:C1470.data.index<=This:C1470.data.values.length\
		 ? This:C1470.data.values[This:C1470.data.index]\
		 : ""
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get pageNumber() : Integer
	
	return This:C1470.data.values.indexOf(This:C1470.data.currentValue)+1
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set pageNumber($page : Integer)
	
	$page-=1  // Map to 0 - collection.length-1
	
	This:C1470.data.index:=$page>=0 ? $page : 0
	
	This:C1470.data.currentValue:=This:C1470.data.index<=This:C1470.data.values.length\
		 ? This:C1470.data.values[This:C1470.data.index]\
		 : ""
	
	If (Value type:C1509(OBJECT Get subform container value:C1785)=Is undefined:K8:13)
		
		FORM GOTO PAGE:C247($page+1)
		
	Else 
		
		FORM GOTO PAGE:C247($page+1; *)
		
	End if 