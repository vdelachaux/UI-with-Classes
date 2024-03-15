
// The constructor expects a timeout in milliseconds
Class constructor($timeout : Integer)
	
	This:C1470.startTime:=Milliseconds:C459
	This:C1470.endTime:=This:C1470.startTime+$timeout
	This:C1470.stepDelay:=30
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// With a start delay
Function withDelay($delay : Integer) : cs:C1710.wait
	
	DELAY PROCESS:C323(Current process:C322; $delay)
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// With a specific delay for each check
Function withStep($delay : Integer) : cs:C1710.wait
	
	This:C1470.stepDelay:=$delay
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Stop on condition or timeout
/*
If (cs.wait.new(1000).until(Formula(myFormula)))
//
End if 
*/
Function until($condition : 4D:C1709.Function) : Boolean
	
	var $milliseconds : Integer
	$milliseconds:=Milliseconds:C459
	
	While ($condition.call())\
		 && ($milliseconds<This:C1470.endTime)
		
		DELAY PROCESS:C323(Current process:C322; This:C1470.stepDelay)
		
		$milliseconds:=Milliseconds:C459
		
	End while 
	
	return ($milliseconds<This:C1470.endTime)