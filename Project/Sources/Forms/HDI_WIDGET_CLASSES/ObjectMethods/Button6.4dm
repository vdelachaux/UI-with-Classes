C_OBJECT:C1216($menu)

If (Bool:C1537(Form:C1466.trace))
	
	Form:C1466.trace:=False:C215
	TRACE:C157
	
End if 

  // Create a fonts menu
If (Bool:C1537((OBJECT Get pointer:C1124(Object named:K67:5;"fontStyles"))->))
	
	$menu:=cs:C1710.menu.new().fonts(True:C214)
	
Else 
	
	$menu:=cs:C1710.menu.new().fonts()
	
End if 

  // Display as popup
$menu.popup()

If ($menu.selected)
	
	OBJECT SET FONT:C164(*;"Input2";$menu.choice)
	
End if 

GOTO OBJECT:C206(*;"Input2")