C_LONGINT:C283($bottom;$l;$left;$right;$top)
C_OBJECT:C1216($menu)

If (Bool:C1537(Form:C1466.trace))
	
	Form:C1466.trace:=False:C215
	TRACE:C157
	
End if 

  // Create a windows menu
$menu:=cs:C1710.menu.new().windows()

  // Display as popup
$menu.popup()

If ($menu.selected)
	
	$l:=Num:C11($menu.choice)
	
	GET WINDOW RECT:C443($left;$top;$right;$bottom;$l)
	SET WINDOW RECT:C444($left;$top;$right;$bottom;$l)
	SHOW WINDOW:C435($l)
	
End if 