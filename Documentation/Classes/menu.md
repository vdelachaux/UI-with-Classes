<!-- Type your summary here -->
## menu
The goal of this class is to reduce the complexity of code to create and manipulate menus.

## Code sample

```4d
$m:=cs.menu.new()                                // Create a main menu
$m.append("Line 1";"fisrtLine")                  // Append a first item
$m.line()                                        // Append a line
$m.append("Line 3";"thirdLine";True)             // Append a second item with check mark
$s:=menu                                         // Create a sub menu
$s.append("Sub menu line 1";"subFisrtLine")      // Append a first item
$s.append("Sub menu line 2";"subSecondLine")     // Append a second item
$m.line()                                        // Add a line (will be automatically deleted because this is the last item)
$m.append("Sub menu";$s)                         // Append the sub menu to the main menu (memory is automatically released)
$m.popup("thirdLine")                            // Display as popup with third line selected (memory is automatically released)
If ($m.selected)                                 // If user select an item
  Case of                                        // Do something according to the user's choice
    : ($m.choice="fisrtLine")
      // …
    : ($m.choice="thirdLine")
      // …
    : ($m.choice="subFisrtLine")
      // …
    : ($m.choice="subSecondLine")
      // …
  End case
End if
```
## Summary

## Properties:

|Properties|Type|Description|Initial value|
|---------|:----:|------|:------:|
| .**ref** | Text | The menu reference|**Null**|
| .**autoRelease** | Boolean | Indicates whether the memory should be automatically freed after a call to one of the functions: `.setBar()`, `.popup()` or after adding the menu as a submenu.| **True\*** 🚨|
| .**localize** | Boolean | Indicates whether item text are considered as a xliff resname. In this case, the code tries to get the corresponding localized string.| **True** |
| .**metacharacters** | Boolean | Indicates whether metacharacters are considered as standard characters.| **Null** |
| .**selected** | Boolean | Indicates whether, after displaying the context menu, an item has been selected. | **False** |
| .**choice** | Text | The reference of the selected context menu item, if any. | "" |
| .**data** | Collection | Associated data of the selected item reference, if any. | [] |

\* 🚨 If `.autoRelease` is set to **False** (or if you don't call a function that automatically release the memory), once you no longer need the menu, remember to call the function `.release()` in order to free up the memory.

## Functions:
> 📌 With the exception of functions that return a specific result (getter function), each call returns the original `cs.menu` object, and you can include one call after another.

```4d
$m:=cs.menu.new()\
.append("Line 1";"fisrtLine").line().append("Line 3";"thirdLine";True)\
.append("Sub menu";menu .append("Sub menu line 1";"subFisrtLine")\
.append("Sub menu line 2";"subSecondLine"))\
.popup("thirdLine")
```

> 📌 When `itemIndex` parameter is not passed to the function, the action is applied to the last added item

|Function|Action|
|--------|------|   
|.**action** ( action : `Text` \| `Integer` \| `Boolean` {; itemIndex : Integer }} ) → `cs.menu` | Associate a standard action with a menu item
|.**append** ( item : `Text` {; param : `Text` {; mark : `Boolean` }} ) → `cs.menu`<br/>.**append** ( item : `Text` ; submenu : `cs.menu`\* ) → `cs.menu`<br/>.**append** ( items : `Collection` ) → `cs.menu` | Adds a new item to the menu
|.**delete** ( { itemIndex : `Integer`} ) → `cs.menu`| Delete a menu item
|.**disable** ( { itemIndex : `Integer` } ) → `cs.menu`| Disable a menu item
|.**enable** () → `cs.menu`<br/>.**enable** ( enabled : Boolean {; itemIndex : Integer } ) → `cs.menu`| Defines the activated status of a menu item
|.**icon** ( icon : `Text` {; itemIndex : `Integer` } ) → `cs.menu`| Modifies the icon associated with a menu item
|.**itemCount** () → number : `Integer`|  Returns the number of menu items present in the menu
|.**item** ( item `Text` \| `Integer` {; reference : `Text`}) → item : `Object`|  Returns a menu item properties from its title or index
|.**isSeparatorItem** ( item `Integer` ) → is : `Boolean`|  Returns True if the item is a separator
|.**items** () → items : `Collection`|  Returns a collection of the first level menu items {item,ref}
|.**line** () → `cs.menu` | Adds a line to the menu
|.**mark** ( {checked : `Boolean` {;  itemIndex : `Integer` }} ) → `cs.menu` | Sets the checked or unchecked status of a menu item
|.**method** ( methodName : `Text` {;  itemIndex : `Integer` } ) → `cs.menu` | Defines the project method associated with a menu item
|.**parameter** ( parameter : `Text` {;  itemIndex : `Integer` } ) → `cs.menu` |  Associates a custom parameter to a menu item
|.**popup** () → `cs.menu`<br/>.**popup** ( { default : `Text` } ;  x : `Integer` ;  y : `Integer` ) → `cs.menu`<br/>.**popup** ( widget : `cs.widget` {; default : `Text` } ) → `cs.menu`|  Display the current menu as a pop-up menu \*
|.**property** ( property : `Text` ; value : `Text` \| `Number`\| `Boolean` {;  itemIndex : `Integer` } ) → `cs.menu` |  Associates a property to a menu item
|.**release** () | Removes the menu from memory
|.**setBar** () | Replaces the current menu bar with the current menu \*
|.**shortcut** ( key  : `Text` \| `Object` {; itemIndex : `Integer` }} ) → `cs.menu` | Replaces the shortcut key associated with the menu item
| | |
|.**setData** ( name  : `Text`; value : `Variant` {; itemIndex : `Integer` } ) → `cs.menu` |  Associates data to a menu item
|.**getData** ( name  : `Text` ) → value : `Variant` |  Retrieve data by name

\* After the execution, if `.autoRelease`is True, the memory is automatically released

## Utilities:

|Function|Action|
|--------|------|  
| `cs.menu.new().file()`| To get a default file menu
| `cs.menu.new().edit()`| To get a default edit menu
| `cs.menu.new().fonts( { withStyles : Boolean } )`| To get a menu of fonts with or without styles
| `cs.menu.new().windows()`| To get a menu of open windows
| `cs.menu.new().defaultMinimalMenuBar()`| To get a default minimal menu bar


