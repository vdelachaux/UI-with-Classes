var $ui : Object
var $menu : cs:C1710.menu

$ui:=Form:C1466.$

If (Bool:C1537($ui.trace))
	
	$ui.trace:=False:C215
	TRACE:C157
	
End if 

GOTO OBJECT:C206(*; "Input2")

// Create edit menu
$menu:=cs:C1710.menu.new().edit()

// Display as popup
$menu.popup()