var $bottom; $l; $left; $right; $top : Integer
var $ui : Object
var $menu : cs:C1710.menu

$ui:=Form:C1466.$

If (Bool:C1537($ui.trace))
	
	$ui.trace:=False:C215
	TRACE:C157
	
End if 
// Create a windows menu
$menu:=cs:C1710.menu.new().windows()

// Display as popup
$menu.popup()

If ($menu.selected)
	
	$l:=Num:C11($menu.choice)
	
	GET WINDOW RECT:C443($left; $top; $right; $bottom; $l)
	SET WINDOW RECT:C444($left; $top; $right; $bottom; $l)
	SHOW WINDOW:C435($l)
	
End if 