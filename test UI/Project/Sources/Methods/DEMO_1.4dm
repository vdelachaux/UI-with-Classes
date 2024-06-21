//%attributes = {"invisible":true}
var $password : Text
var $winRef : Integer
var $data : Object

$winRef:=Open form window:C675("DEMO_1"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)

$data:={pwd: ""}

DIALOG:C40("DEMO_1"; $data)
CLOSE WINDOW:C154($winRef)

If (Bool:C1537(OK))
	
	$password:=$data.pwd
	
End if 