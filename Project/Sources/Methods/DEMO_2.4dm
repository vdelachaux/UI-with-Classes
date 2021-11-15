//%attributes = {}
var $data : Object

// Create and install a minimal menu bar
cs:C1710.menu.new().defaultMinimalMenuBar().setBar()

$data:=New object:C1471(\
"window"; Open form window:C675("HDI_FORM"; Plain form window:K39:10; Horizontally centered:K39:1; At the top:K39:5; *))

DIALOG:C40("HDI_FORM"; $data)

CLOSE WINDOW:C154($data.window)