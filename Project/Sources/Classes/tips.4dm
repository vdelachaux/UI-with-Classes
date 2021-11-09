
// === === === === === === === === === === === === === === === === === === === === ===
Class constructor
	
	This:C1470.backup:=This:C1470.status()
	
	This:C1470.default()
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function status()->$status : Object
	
	$status:=New object:C1471(\
		"enabled"; Get database parameter:C643(Tips enabled:K37:79)=1; \
		"delay"; Get database parameter:C643(Tips delay:K37:80); \
		"duration"; Get database parameter:C643(Tips duration:K37:81))
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function default()
	
	This:C1470._enabled:=True:C214
	This:C1470._delay:=45
	This:C1470._duration:=720
	This:C1470.set()
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function enabled()->$enabled : Boolean
	
	$enabled:=(Get database parameter:C643(Tips enabled:K37:79)=1)
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function enable($enabled)
	
	If (Count parameters:C259>=1)
		
		// Could be integer or boolean
		Case of 
				//______________________________________________________
			: (Value type:C1509($enabled)=Is boolean:K8:9)
				
				This:C1470._enabled:=$enabled
				
				//______________________________________________________
			Else 
				
				This:C1470._enabled:=Num:C11($enabled)
				
				//______________________________________________________
		End case 
		
	Else 
		
		This:C1470._enabled:=True:C214
		
	End if 
	
	This:C1470.set()
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function disabled()->$disabled : Boolean
	
	$disabled:=(Get database parameter:C643(Tips enabled:K37:79)=0)
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function disable()
	
	This:C1470.enable(False:C215)
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function delay()->$delay : Integer
	
	$delay:=Get database parameter:C643(Tips delay:K37:80)
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function setDelay($delay : Integer)
	
	This:C1470._delay:=$delay
	This:C1470.set()
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function defaultDelay()
	
	This:C1470._delay:=45
	This:C1470.set()
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function duration()->$duration : Integer
	
	$duration:=Get database parameter:C643(Tips duration:K37:81)
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function setDuration($duration : Integer)
	
	This:C1470._duration:=$duration
	This:C1470.set()
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function defaultDuration()
	
	This:C1470._duration:=720
	This:C1470.set()
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function restore()
	
	SET DATABASE PARAMETER:C642(Tips enabled:K37:79; Num:C11(This:C1470.backup.enabled))
	SET DATABASE PARAMETER:C642(Tips delay:K37:80; This:C1470.backup.delay)
	SET DATABASE PARAMETER:C642(Tips duration:K37:81; This:C1470.backup.duration)
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function instantly($duration : Integer)
	
	This:C1470._enabled:=True:C214
	This:C1470._delay:=1
	
	If (Count parameters:C259>=1)
		
		This:C1470._duration:=$duration
		
	End if 
	
	This:C1470.set()
	
	// === === === === === === === === === === === === === === === === === === === === ===
Function set()
	
	SET DATABASE PARAMETER:C642(Tips enabled:K37:79; Num:C11(This:C1470._enabled))
	SET DATABASE PARAMETER:C642(Tips delay:K37:80; This:C1470._delay)
	SET DATABASE PARAMETER:C642(Tips duration:K37:81; This:C1470._duration)