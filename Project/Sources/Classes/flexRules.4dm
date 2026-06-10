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

Class constructor($metrics : Object)
	
	If ($metrics#Null:C1517)
		
		var $key : Text
		For each ($key; $metrics)
			
			This:C1470[$key]:=$metrics[$key]
			
		End for each 
	End if 