property height : Integer
property width : Integer

Class constructor($width : Integer; $height : Integer)
	
	This:C1470.width:=$width
	This:C1470.height:=$height
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function area() : Integer
	
	return This:C1470.width*This:C1470.height
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function perimeter() : Integer
	
	return (This:C1470.width+This:C1470.height)*2