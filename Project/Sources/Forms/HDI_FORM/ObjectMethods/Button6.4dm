var $ui : Object
var $menu : cs:C1710.menu

$ui:=Form:C1466.$

If (Bool:C1537($ui.trace))
	
	$ui.trace:=False:C215
	TRACE:C157
	
End if 

// Create a fonts menu
If (OBJECT Get value:C1743("fontStyles"))
	
	$menu:=cs:C1710.menu.new().fonts(True:C214)
	
Else 
	
	$menu:=cs:C1710.menu.new().fonts()
	
End if 

// Display as popup
$menu.popup()

If ($menu.selected)
	
	OBJECT SET FONT:C164(*; "Input2"; $menu.choice)
	
End if 

$ui.goTo("Input2")