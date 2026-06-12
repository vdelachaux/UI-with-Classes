property name : Text
property height : Integer
property width : Integer

Class constructor($width; $height : Integer)
	
	Case of 
			
			//______________________________________________________
		: (Value type:C1509($width)=Is object:K8:27)
			
			var $o : Object:=Try($width.getCoordinates())
			
			If ($o#Null:C1517)  // Wwidget
				
				$o:=$o.dimensions
				
			Else 
				
				$o:=$width
				
			End if 
			
			$width:=Num:C11($o.width)
			$height:=Num:C11($o.height)
			
			//______________________________________________________
		: (Value type:C1509($width)=Is text:K8:3)  // Object name
			
			var $left; $top; $right; $bottom : Integer
			OBJECT GET COORDINATES:C663(*; $width; $left; $top; $right; $bottom)
			
			$width:=$right-$left
			$height:=$bottom-$top
			
			//______________________________________________________
	End case 
	
	This:C1470.width:=$width
	This:C1470.height:=$height
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function area() : Integer
	
	return This:C1470.width*This:C1470.height
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function perimeter() : Integer
	
	return (This:C1470.width+This:C1470.height)*2