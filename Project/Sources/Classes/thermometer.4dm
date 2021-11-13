Class extends widget

Class constructor($name : Text; $datasource : Variant)
	
	If (Count parameters:C259>=2)
		
		Super:C1705($name; $datasource)
		
	Else 
		
		Super:C1705($name)
		
	End if 
	
	//========================================================
Function asynchronous()->$this : cs:C1710.thermometer
	
	This:C1470.indicatorType(Asynchronous progress bar:K42:36)
	
	$this:=This:C1470
	
	//========================================================
Function isAsynchronous()->$yes : Boolean
	
	var $type : Integer
	
	$type:=This:C1470.getIndicatorType()
	
	$yes:=($type=Asynchronous progress bar:K42:36) | ($type=Barber shop:K42:35) | ($type=0)
	
	//========================================================
Function barber->$this : cs:C1710.thermometer
	
	This:C1470.indicatorType(Barber shop:K42:35)
	
	$this:=This:C1470
	
	//========================================================
Function isBarber()->$yes : Boolean
	
	$yes:=(This:C1470.getIndicatorType()=Barber shop:K42:35)
	
	//========================================================
Function progress->$this : cs:C1710.thermometer
	
	This:C1470.indicatorType(Progress bar:K42:34)
	
	$this:=This:C1470
	
	//========================================================
Function isProgress()->$yes : Boolean
	
	$yes:=(This:C1470.getIndicatorType()=Progress bar:K42:34)
	
	//========================================================
Function indicatorType($type : Integer)->$this : cs:C1710.thermometer
	
	OBJECT SET INDICATOR TYPE:C1246(*; This:C1470.name; $type)
	This:C1470.indicatorType:=$type
	
	$this:=This:C1470
	
	//========================================================
Function getIndicatorType()->$type : Integer
	
	$type:=OBJECT Get indicator type:C1247(*; This:C1470.name)
	
	//========================================================
Function start()->$this : cs:C1710.thermometer
	
	If (Asserted:C1132(This:C1470.isAsynchronous()))
		
		This:C1470.setValue(1)
		
	End if 
	
	$this:=This:C1470
	
	//========================================================
Function stop()->$this : cs:C1710.thermometer
	
	If (Asserted:C1132(This:C1470.isAsynchronous()))
		
		This:C1470.setValue(0)
		
	End if 
	
	$this:=This:C1470
	