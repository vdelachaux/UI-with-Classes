Class extends widget

Class constructor($name : Text; $datasource)
	
	If (Count parameters:C259>=2)
		
		Super:C1705($name; $datasource)
		
	Else 
		
		Super:C1705($name)
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function highlight($startSel : Integer; $endSel : Integer)->$this : cs:C1710.input
	
	Case of 
			
			//______________________________________________________
		: (Count parameters:C259=0)  // Select all
			
			HIGHLIGHT TEXT:C210(*; This:C1470.name; 1; MAXLONG:K35:2)
			
			//______________________________________________________
		: (Count parameters:C259=1)
			
			If ($startSel=-1)
				
				This:C1470.highlightLastToEnd()
				
			Else   // From $startSel to end
				
				HIGHLIGHT TEXT:C210(*; This:C1470.name; $startSel; MAXLONG:K35:2)
				
			End if 
			
			//______________________________________________________
		Else   // From $startSel to $endSel
			
			HIGHLIGHT TEXT:C210(*; This:C1470.name; $startSel; $endSel)
			
			//______________________________________________________
	End case 
	
	$this:=This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === ===
	// From the last character entered to the end
Function highlightLastToEnd()->$this : cs:C1710.input
	
	HIGHLIGHT TEXT:C210(*; This:C1470.name; This:C1470.highlightingStart()+1; MAXLONG:K35:2)
	
	$this:=This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function highlighted()->$highlight : Object
	
	var $end; $start : Integer
	GET HIGHLIGHT:C209(*; This:C1470.name; $start; $end)
	
	$highlight:=New object:C1471(\
		"start"; $start; \
		"end"; $end)
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function highlightingStart()->$pos : Integer
	
	var $end : Integer
	GET HIGHLIGHT:C209(*; This:C1470.name; $pos; $end)
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function highlightingEnd()->$pos : Integer
	
	var $start : Integer
	GET HIGHLIGHT:C209(*; This:C1470.name; $start; $pos)
	
	// === === === === === === === === === === === === === === === === === === === === ===
/*
.setFilter(int) -> This
.setFilter(text) -> This
*/
Function setFilter($filter; $separator : Text)->$this : cs:C1710.input
	
	var $t : Text
	
	If (Value type:C1509($filter)=Is longint:K8:6)\
		 | (Value type:C1509($filter)=Is real:K8:4)
		
		// Predefined formats
		
		Case of 
				
				//………………………………………………………………………
			: ($filter=Is integer:K8:5)\
				 | ($filter=Is longint:K8:6)\
				 | ($filter=Is integer 64 bits:K8:25)
				
				OBJECT SET FILTER:C235(*; This:C1470.name; "&\"0-9;-;+\"")
				
				//………………………………………………………………………
			: ($filter=Is real:K8:4)
				
				If (Count parameters:C259>=2)  // Separator
					
					$t:=$separator
					
				Else 
					
					GET SYSTEM FORMAT:C994(Decimal separator:K60:1; $t)
					
				End if 
				
				OBJECT SET FILTER:C235(*; This:C1470.name; "&\"0-9;"+$t+";.;-;+\"")
				
				//………………………………………………………………………
			: ($filter=Is time:K8:8)
				
				If (Count parameters:C259>=2)  // Separator
					
					$t:=$separator
					
				Else 
					
					GET SYSTEM FORMAT:C994(Time separator:K60:11; $t)
					
				End if 
				
				OBJECT SET FILTER:C235(*; This:C1470.name; "&\"0-9;"+$t+";:\"")
				
				//………………………………………………………………………
			: ($filter=Is date:K8:7)
				
				If (Count parameters:C259>=2)  // Separator
					
					$t:=$separator
					
				Else 
					
					GET SYSTEM FORMAT:C994(Date separator:K60:10; $t)
					
				End if 
				
				OBJECT SET FILTER:C235(*; This:C1470.name; "&\"0-9;"+$t+";/\"")
				
				//………………………………………………………………………
			Else 
				
				OBJECT SET FILTER:C235(*; This:C1470.name; "")  // Text as default
				
				//………………………………………………………………………
		End case 
		
	Else 
		
		OBJECT SET FILTER:C235(*; This:C1470.name; String:C10($filter))
		
	End if 
	
	$this:=This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function getFilter()->$filter : Text
	
	$filter:=OBJECT Get filter:C1073(*; This:C1470.name)