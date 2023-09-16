## menu
The aim of this class is to simplify the code used to create and manipulate menus.

## Code sample

```4d
$m:=cs.menu.new()                                // Create a main menu
$m.append("Line 1";"fisrtLine")                  // Append a first item
$m.line()                                        // Append a line
$m.append("Line 3";"thirdLine";True)             // Append a second item with check mark
$s:=cs.menu.new()                                // Create a sub menu
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
# Summary

## Properties:

|Properties|Type|Description|Initial value|
|:---------|:----|:------|:------|
| .**ref** | Text | The menu reference|**Null**|
| .**autoRelease** | Boolean | Indicates whether the memory should be automatically freed after a call to the function `.popup()` or after adding the menu as a submenu.| **True\*** 🚨|
| .**released** | Boolean | True if the menu has been unloaded|**False**|
| .**localize** | Boolean | Indicates whether item text are considered as a xliff resname. In this case, the code tries to get the corresponding localized string.| **True** |
| .**metacharacters** | Boolean | Indicates whether metacharacters are considered as standard characters.| **False** |
| .**selected** | Boolean | Indicates whether, after displaying the context menu, an item has been selected. | **False** |
| .**choice** | Text | The reference of the selected context menu item, if any. | "" |
| .**submenus** | Collection | Submenus associated with the menu. | [ ] |
| .**data** | Collection | Associated data of the selected item reference, if any. | [ ] |

\* 🚨 If `.autoRelease` is set to **False** (or if you don't call a function that automatically release the memory), once you no longer need the menu, remember to call the function `.release()` in order to free up the memory.

## Functions:
> 📌 With the exception of functions that return a specific result (getter function), each call returns the original `cs.menu` object, and you can include one call after another.

```4d
$menu:=cs.menu.new()\
.append("Line 1";"1st")\
.append("Line 2";"2nd";True)\
.line()\
.append("Sub menu";cs.menu.new().append("Sub line 1";"sub1st").append("Sub line 2";"sub2nd"))\
.popup("2nd")
```

> 📌 When `itemIndex` parameter is not passed to the function, the action is applied to the last added item

### Definition  

|Function|Action|
|:--------|:------|    
|.**new** ( {`Text`\|`Integer`\|`Collection` } ) → `cs.menu` | [Constructor](#constructor)
|.**append** ( item  {; parameter {; mark  }} {; after } ) → `cs.menu`<br/>.**append** ( item  ; submenu  ) → `cs.menu`<br/>.**append** ( items  ) → `cs.menu` | [Adds a new item to the menu](#append)
|.**line** ({after } ) → `cs.menu` | Adds a line at the end of the menu or after the `after` item index item.<br> If `after` < 0, it is considered as the offset from the item count of the menu
|.**delete** ( { itemIndex : `Integer`} ) → `cs.menu`| Delete a menu item 
|.**release** () | Removes the menu from memory

### Item Properties

|Function|Action|
|:--------|:------|   
|.**icon** ( proxy : `Text` {; itemIndex : `Integer` } ) → `cs.menu`| Modifies the [icon](#icon) associated with a item. See 
|.**mark** ( {checked : `Boolean` {;  itemIndex : `Integer` }} ) → `cs.menu` | Sets the checked or unchecked status of a item
|.**parameter** ( parameter : `Text` {;  itemIndex : `Integer` } ) → `cs.menu` |  Associates a custom parameter to a item
|.**action** ( action : `Text`\|`Integer` {; itemIndex : Integer }} ) → `cs.menu` | Associate a standard action with a item
|.**method** ( methodName : `Text` {;  itemIndex : `Integer` } ) → `cs.menu` | Defines the project method associated with an item
|.**shortcut** ( key  : `Text`\|`Object` {; itemIndex : `Integer` }} ) → `cs.menu` | Sets the shortcut key associated with the item
|.**property** ( property : `Text` ; value : `Text`\|`Number`\| `Boolean` {;  itemIndex : `Integer` } ) → `cs.menu` |  Associates a property to an item
|.**setStyle** ( style : `Integer` {;  itemIndex : `Integer` } ) → `cs.menu` | Changes the font style of the menu item
|.**indent** ( { itemIndex : `Integer` {; number : `Integer` } ) → `cs.menu`| Set indentation of the item by one level or by `number` levels
|.**enable** () → `cs.menu`<br/>.**enable** ( enabled : Boolean {; itemIndex : Integer } ) → `cs.menu`| Defines the activated status of theitem
|.**disable** ( { itemIndex : `Integer` } ) → `cs.menu`| Disable a menu item

### Data

|Function|Action|
|:--------|:------|   
|.**setData** ( name  : `Text`; value : `Variant` {; itemIndex : `Integer` } ) → `cs.menu` |  Associates data to a menu item
|.**getData** ( name  : `Text` ) → value : `Variant` |  Retrieve data by name

### Informations

|Function|Action|
|:--------|:------|   
|.**itemCount** ( ) → number : `Integer`|  Returns the number of menu items present in the menu
|.**item** ( item `Text`\|`Integer`) → item : `Object`|  Returns an [item object description](#itemObject) from its title or index
|.**items** ( ) → items : `Collection`|  Returns a collection of top-level [item object description](#itemObject)
|.**isSeparatorItem** ( item `Integer` ) : `Boolean`|  Returns True if the item is a separator
|.**getProperty** ( property : `Text` ; item `Integer`) : `Boolean`\|`Real`\|`Text`|  Returns a property associated to a menu item

### Tools

|Function|Action|
|:--------|:------|   
|.**popup** ( ) → `cs.menu`<br/>.**popup** ( { default : `Text` } ;  x : `Integer` ;  y : `Integer` ) → `cs.menu`<br/>.**popup** ( widget : `cs.widget` {; default : `Text` } ) → `cs.menu`|  Display the current menu as a [contextual menu](#popup) \*
|.**file** ( )→ `cs.menu`| Returns a default file menu
|.**edit** ( )→ `cs.menu`| Returns a default edit menu
|.**fonts** ( { withStyles : Boolean } )→ `cs.menu`| Returns a menu of fonts with or without styles
|.**windows** ( )→ `cs.menu`| Returns a menu of open windows

>\* If the `.autoRelease` property is **True**, the menu is automatically released

# 🔸 <a name="constructor">Constructor ()</a>

.**new**() : cs.menu    
.**new**( param : `Text`) : **cs**.menu    
.**new**( param : `Integer`) : **cs**.menu    
.**new**( param : `Collection`) : **cs**.menu    

Parameter|Type|Description
:----:|:----:|----
param | `Text`\| Integer`\|`Collection` | Menu to load

### Description

* Called without parameters, the constructor creates a new empty menu in memory.
* If param is the text "menuBar", the constructor load the current menu bar.
* If param is a menu reference (like \|MR\|xxxxxxxxxxxx where x are digits), this menu is loaded.
* If param is a collection, the menu is filled with its contents.

# 🔹 <a name="append"> append ()</a>

.**append**( item : `Text` {; parameter : Text {; mark : Boolean }} {; after : `Integer`} ) → **cs**.menu   
.**append**( item : `Text` ; submenu : `cs.menu`) : **cs**.menu    
.**append**( items : `Collection` ) : **cs**.menu    

Parameter|Type|Description
:----:|:----:|----
item | `Text` | Label of the item\*
items | `Collection` | A collection of [menu items object description](#itemObject)
parameter | `Text` | The parameter associated with menu item
mark | `Bolean`| **True**, if the element is to be displayed with a check mark (default is **False**)
submenu | `cs.menu` | A **cs**.menu object to add as a sub-menu\**
after | `Integer` | The item index after wich the new item will be added.<br> If `after` < 0, it is considered as the offset from the item count of the menu

>\* The label can be :     
>1. The literal text to be used,  
>2. A string of the form ":xliff:resname", which will be automatically resolved by 4D,    
>3. A "resname", in which case, if the property `localize` is **True**, **[Get localized string](https://doc.4d.com/4Dv20/4D/20.1/Get-localized-string.301-6480009.en.html)** command is called to use the localized value if it has been found in the database resources.    
>
>\** If the submenu `.autoRelease` property is **True**, the menu is automatically released

# 🔸 <a name="icon"> icon ()</a> 
  
.**icon**( proxy : `Text` {; itemIndex : `Integer`}) : **cs**.menu    

Parameter|Type|Description
:----:|:----:|----
proxy | `Text` | The proxy to access the picture
itemIndex | `Integer` | Item to be modified, last added if omitted

### Description

The `.icon()` function allow to associate an icon to a menu item.

The `proxy`supported:
 
* `path:<path>` | `/<path>`, for example "path:/RESOURCES/icon.png" or  "/PROJECT/Assets/icon.png"
* `<relativePath>` | `#<relativePath>`, for example "icon.png" or "#icon.png". The picture must be located in the `Resources` folder of the database.
* `file:<relativePath>` (deprecated), for example "file:icon.png". The picture must be located in the `Resources` folder of the database.

# 🔸 <a name="popup"> popup ()</a> 
  
.**popup**( ) : **cs**.menu  
.**popup**( widget : `cs.widgetDelegate` {; default : `Text`}) : **cs**.menu    
.**popup**( default : `Text` {; x `Integer` ; y `Integer` }) : **cs**.menu     
.**popup**( x `Integer` ; y `Integer` ) : **cs**.menu   

Parameter|Type|Description
:----:|:----:|----
widget | `cs.widgetDelegate` | The widget to be used as a reference for positioning the context menu
default | `Text ` | Item selected by default
x | `Integer ` | X coordinate of top left corner
y | `Integer ` | Y coordinate of top left corner

### Description

The `.popup()` function display the current menu as a contextual menu.

If the `widget` parameter is passed, the function determines the position of the menu according to its position and type.

The optional `default` parameter can be used to set an item of the popup menu as selected by default whenever the menu appears.    
>📌 Only a top level menu item can be selected by default.

The optional `x` & `y` parameters can be used to specify the location of the pop-up menu to be displayed.
>📌 If neither the coordinates nor the widget are passed, the menu is displayed at the mouse position.

If a menu item has been selected, the `selected` property is set to **True** and the `choice` property is filled with the parameter of the selected menu item.
>📌 If the `.autoRelease` property is **True**, the menu is automatically released

# <a name="itemObject">Item object</a>

```json
{
  "label": "Text",
  "parameter": "Text",
  "marked": "Boolean",
  "action": "Text" | "Integer",
  "enabled": "Boolean",
  "icon": "Text",
  "method": "Text",
  "shortcut": "Text",
  "modifier": "Integer"
}
```
When used to define an element, all properties are optional
