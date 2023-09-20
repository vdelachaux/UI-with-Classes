//%attributes = {}
var $winRef : Integer

If (Shift down:C543)
	
	$winRef:=Open form window:C675("DEMO_constraints"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	
Else 
	
	$winRef:=Open form window:C675("DEMO_constraints"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	
End if 

DIALOG:C40("DEMO_constraints")
CLOSE WINDOW:C154($winRef)