C_OBJECT:C1216($menu;$subMenu)

If (Bool:C1537(Form:C1466.trace))
	
	Form:C1466.trace:=False:C215
	TRACE:C157
	
End if 

  // Create a main menu
$menu:=cs:C1710.menu.new()

  // Append a first item
$menu.append("Item 1";"item1")

  // Append a line
$menu.line()

  // Append a second item with check mark
$menu.append("Item 2";"item2";True:C214)

  // Append a line
$menu.line()

  // Create a sub menu with 2 items
$subMenu:=cs:C1710.menu.new()\
.append("Sub menu 1";"subitem1")\
.append("Sub menu 2";"subitem2")

  // Append the sub menu to the main menu (memory is automatically released)
$menu.append("Sub menu";$subMenu)

  // Display as popup with third line selected (memory is automatically released)
$menu.popup("item2")

  // Do something according to the user's choice
If ($menu.selected)
	
	ALERT:C41("Choosen item: \""+$menu.choice+"\"")
	
Else 
	
	ALERT:C41("No choosen item")
	
End if 