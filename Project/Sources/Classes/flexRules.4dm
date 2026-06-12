// Predefined types
property type : Text

// Comportement dans un layout
property flexGrow : Real  // Proportion d'expansion
property flexShrink : Real  // Réduction si manque de place
property flexBasis : Real:=0  // Taille initiale

property adjustHeight:=False:C215
property adjustWidth:=False:C215

property alignSelf : Text  // "start" | "center" | "end" | "stretch"

// Contraintes
property minWidth
property maxWidth
property minHeight
property maxHeight
property fixedWidth; fixedHeight : Boolean

Class constructor($metrics : Object; $widget : cs:C1710.static)
	
	If ($metrics#Null:C1517)
		
		Case of 
				
				// ______________________________________________________
			: (String:C10($metrics.type)="bakground")
				
				This:C1470.flexGrow:=100
				This:C1470.adjustHeight:=True:C214
				This:C1470.adjustWidth:=True:C214
				
				// ______________________________________________________
		End case 
		
		var $key : Text
		
		For each ($key; $metrics)
			
			This:C1470[$key]:=$metrics[$key]
			
		End for each 
	End if 
	
	If (This:C1470.flexBasis=0)\
		 && ($widget#Null:C1517)
		
		This:C1470.flexBasis:=$widget.width
		
	End if 
	
	If (This:C1470.fixedWidth)
		
		If ($widget#Null:C1517)
			
			This:C1470.minWidth:=$widget.width
			This:C1470.maxWidth:=$widget.width
			
		Else 
			
			This:C1470.minWidth:=This:C1470.flexBasis
			This:C1470.maxWidth:=This:C1470.flexBasis
		End if 
	End if 