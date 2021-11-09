
/*══════════════════════*/
Class extends scrollable
/*══════════════════════*/

Class constructor
	
	C_TEXT:C284($1)
	C_VARIANT:C1683($2)
	
	If (Count parameters:C259>=2)
		
		Super:C1705($1; $2)
		
	Else 
		
		Super:C1705($1)
		
	End if 
	
	C_PICTURE:C286($p)
	This:C1470.value:=$p
	This:C1470.fileName:=""
	This:C1470.size:=0
	
/*════════════════════════════════════════════*/
	// ⚠️ 
Function getCoordinates()->$coordinates : Object
	
	$coordinates:=Super:C1706.getCoordinates()
	
	This:C1470.getScrollbars()
	This:C1470.getScrollPosition()
	This:C1470.getDimensions()
	
Function getDimensions
	
	C_OBJECT:C1216($0)
	C_PICTURE:C286($p)
	C_LONGINT:C283($width; $height)
	
	$p:=This:C1470.getValue()
	
	PICTURE PROPERTIES:C457($p; $width; $height)
	
	$0:=New object:C1471(\
		"width"; $width; \
		"height"; $height)
	
Function read
	
	C_OBJECT:C1216($1)
	C_PICTURE:C286($p)
	
	If (Asserted:C1132(Count parameters:C259>=1; Current method name:C684+".read(): Missing File parameter"))
		
		If (Asserted:C1132(OB Instance of:C1731($1; 4D:C1709.File); Current method name:C684+".read(): The passed parameter is not a File object"))
			
			If (Asserted:C1132($1.exists; Current method name:C684+".read(): File not found"))
				
				READ PICTURE FILE:C678($1.platformPath; $p)
				
				If (Bool:C1537(OK))
					
					This:C1470.setValue($p)
					This:C1470.fileName:=Get picture file name:C1171($p)
					This:C1470.size:=Picture size:C356($p)
					
				End if 
			End if 
		End if 
	End if 
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
Function thumbnail
	
	C_LONGINT:C283($1; $2; $3)
	
	If (Count parameters:C259>=3)
		
		This:C1470.setValue(This:C1470.getThumbnail($1; $2; $3))
		
	Else 
		
		If (Count parameters:C259>=2)
			
			This:C1470.setValue(This:C1470.getThumbnail($1; $2))
			
		Else 
			
			If (Count parameters:C259>=1)
				
				This:C1470.setValue(This:C1470.getThumbnail($1))
				
			Else 
				
				This:C1470.setValue(This:C1470.getThumbnail())
				
			End if 
		End if 
	End if 
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
Function getThumbnail
	
	C_PICTURE:C286($0; $p)
	C_LONGINT:C283($1; $2; $3; $width; $height; $mode)
	
	$p:=This:C1470.getValue()
	
	If (Count parameters:C259>=1)
		
		$width:=$1
		
		If (Count parameters:C259>=2)
			
			$height:=$1
			
			If (Count parameters:C259>=3)
				
				$mode:=$3
				
			Else 
				
				$mode:=Scaled to fit prop centered:K6:6
				
			End if 
			
		Else 
			
			$height:=$width  // Square
			$mode:=Scaled to fit prop centered:K6:6
			
		End if 
		
	Else 
		
		$width:=48
		$height:=48
		$mode:=Scaled to fit prop centered:K6:6
		
	End if 
	
	CREATE THUMBNAIL:C679($p; $p; $width; $height; $mode)
	$0:=$p
	
Function horizontalConcatenation
	
	C_OBJECT:C1216($1)
	
	This:C1470.setValue(This:C1470.__combine($1; Horizontal concatenation:K61:8))
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
Function verticalConcatenation
	
	C_OBJECT:C1216($1)
	
	This:C1470.setValue(This:C1470.__combine($1; Vertical concatenation:K61:9))
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
Function superImposition
	
	C_OBJECT:C1216($1)
	C_LONGINT:C283(${2})
	
	If (Count parameters:C259>=3)
		
		This:C1470.setValue(This:C1470.__combine($1; Superimposition:K61:10; $2; $3))
		
	Else 
		
		If (Count parameters:C259>=2)
			
			This:C1470.setValue(This:C1470.__combine($1; Superimposition:K61:10; $2))
			
		Else 
			
			This:C1470.setValue(This:C1470.__combine($1; Superimposition:K61:10))
			
		End if 
	End if 
	
	C_OBJECT:C1216($0)
	$0:=This:C1470
	
Function __combine
	
	C_OBJECT:C1216($1)
	C_LONGINT:C283(${2})
	C_PICTURE:C286($0; $p; $pp)
	
	If (Asserted:C1132(Count parameters:C259>=1; Current method name:C684+".horizontalConcatenation(): Missing File parameter"))
		
		If (Asserted:C1132(OB Instance of:C1731($1; 4D:C1709.File); Current method name:C684+".horizontalConcatenation(): The passed parameter is not a File object"))
			
			If (Asserted:C1132($1.exists; Current method name:C684+".horizontalConcatenation(): File not found"))
				
				READ PICTURE FILE:C678($1.platformPath; $p)
				
				If (Bool:C1537(OK))
					
					$pp:=This:C1470.getValue()
					
					If (Count parameters:C259>=4)
						
						COMBINE PICTURES:C987($p; $pp; $2; $p; $3; $4)
						
					Else 
						
						If (Count parameters:C259>=3)
							
							COMBINE PICTURES:C987($p; $pp; $2; $p; $3)
							
						Else 
							
							COMBINE PICTURES:C987($p; $pp; $2; $p)
							
						End if 
					End if 
					
					$0:=$p
					
				End if 
			End if 
		End if 
	End if 