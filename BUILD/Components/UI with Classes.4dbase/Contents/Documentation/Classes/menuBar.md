## menuBar
The aim of this class is to simplify the code used to create and manipulate menu bars.

This class extend the class [menu](menu.md)

## Code sample

To define & install a menu bar with:

* a menu "File",
*  a Standard "Edit" menu 
* an empty "Windows" menu that will be filled in later.


```4d
// Create the menu Filevar $menuFile : cs.menu$menuFile:=cs.menu.new()\  .append("Close").shortcut("W").action(ak cancel)\  .line()\  .append("MSC").shortcut("M"; Option key mask).action(ak msc)\  .line()\  .append("Settings"; "settings").method(Formula(formMenuHandle).source)// Get a standard edit menuvar $menuEdit : cs.menu$menuEdit:=cs.menu.new().edit()

// Create an empty menu for the widowsvar $menuWindows : cs.menu
$menuWindows:= cs.menu.new()// Populate & install the menu barcs.menuBar.new([\  ":xliff:CommonMenuFile"; $menuFile; \  ":xliff:CommonMenuEdit"; $menuEdit; \  "Windows"; $menuWindows\
  ]).set()```

# Summary

## Properties (inherited):

|Properties|Type|Description|Initial value|
|:---------|:----|------|:------|
| .**ref** | Text | The menu bar reference|**Null**|
| .**autoRelease** | Boolean | Indicates whether the memory should be automatically ffreed after a call to the function `.set()`| **True\*** 🚨|
| .**released** | Boolean | True if the menu has been unloaded|**False**|

\* 🚨 If `.autoRelease` is set to **False** (or if you don't call a function that automatically release the memory), once you no longer need the menu bar, remember to call the function `.release()` in order to free up the memory.

## Functions:

### Definition  

|Function|Action|
|:--------|:------|   
|.**new** ( `Collection` ) → `cs.menuBar` | Instantiates a new menu bar and fills it, if any, with the menus collection if passed.
|.**populate** ( `Collection` ) → `cs.menuBar` | Create a menu bar from a collection of menus
|.**set** () → `cs.menuBar` |  Replaces the current menu bar with the current one
|.**setHelpMenu** (`Collection` } ) → `cs.menuBar` | Set the [Help menu](https://doc.4d.com/4dv20/help/command/en/page1801.html) of the application mode
|.**update** ( menuIndex: `Integer`; menu : `cs.menu` ) → `cs.menuBar`| Replace a menu with a new one 
|.**release** () | Removes the menu from memory

### Menu item Properties  

|Function|Action|
|:--------|:------|   
|.**enableItem** ( itemParameter: `Text` {; enabled: `Boolean`} ) → `cs.menuBar` | Activates a menu item defined by the value of its parameter.<br>If `enabled` is passed, activates/deactivates the item according to the value of this parameter.
|.**disableItem** ( itemParameter: `Text` ) → `cs.menuBar` | Deactivates a menu item defined by the value of its parameter.

### Informations  

|Function|Action|
|:--------|:------|   
|.**menuSelected** () → `Object`| Returns the menu item selected as an object: <br>{<br>   ref: \<subMenuReference>,<br>   menu: \<menuIndex>,<br>   item: \<itemIndex><br>}
|.**getMenuItemParameter** ( {type: `Integer`) → `Variant`| Returns the menu item selected  associated parameter

### Tools  

|Function|Action|
|:--------|:------|    
|.**defaultMinimalMenuBar** () → `cs.menuBar` | Returns a preconfigured menu bar with the default "File" menu & a menu "Edit"
