# listbox

The `listbox` class is intended to handle listbox widget.  

> #### 📌 This class inherit from the [`scrollable`](scrollable.md) class

## Properties

|Properties|Description|
|----------|-----------|
|**.name** | [*inherited*](formObject.md) |
|**.type** | [*inherited*](formObject.md) |
|**.coordinates** | [*inherited*](formObject.md) |
|**.dimensions** | [*inherited*](formObject.md) |
|**.windowCoordinates** | [*inherited*](formObject.md) |
|**.scrollbars** | [*inherited*](scrollable.md) |
|**.scroll** | [*inherited*](scrollable.md) |
|**.isCollection** | **True** if the listbox datasource is a collection or an entity selection
|**.isArray** | **True** if the listbox datasources are arrays
|**.item** | Ready to be used as a current element of the data source.
|**.itemPosition** | Ready to be used as a current item position of the data source.
|**.items** | Ready to be used as selected items of the data source.
|**.cellBox** | Last updated cell coordinates as coordinate's object.
|**.definition** | Object containing the listbox columns description. *cf. infra*
|**.properties** | Object containing all available properties. *cf. infra*

## 🔸 cs.listbox.new()

The class constructor `cs.listbox.new({formObjectName})` creates a new class instance.

If the `formObjectName` parameter is omitted, the constructor uses the result of **[OBJECT Get name](https://doc.4d.com/4Dv18R6/4D/18-R6/OBJECT-Get-name.301-5198296.en.html)** ( <u>Object current</u> )

> 📌 Omitting the object name can only be used if the constructor is called from the object method.

## Summary

> 📌 All functions that return `cs.listbox` may include one call after another. 

| Function | Action |
| -------- | ------ |  
|.**select** ({row `:Integer`}) →`:cs.listbox` | Selects a row or all lines if no parameter is passed.|
|.**unselect** ({row `:Integer`}) →`:cs.listbox` | Unselects a row or all lines if no parameter is passed.|
|.**selectFirstRow** () →`:cs.listbox` | Selects the first line of the list.|
|.**selectLastRow** () →`:cs.listbox` | Selects the last line of the list.|
|.**autoSelect** () →`:cs.listbox` | Selects the last touched row (last mouse click, last selection made via the keyboard or last drop).|
|.**doSafeSelect** (row `:Integer`) →`:cs.listbox` | Selects the given row if possible, else the most appropiate one. <br/>Useful to maintain a selection after a deletion|
|.**selectAll** ( ) →`:cs.listbox` | Selects all rows |
|.**edit** ()<br/>.**edit** (event `:Object` {; item `:Integer`})<br/>.**edit** (target `:Text` {; item `:Integer`}) | To edit a listbox item |
|.**forceEdit**()<br/>.**forceEdit** (event `:Object` {; item `:Integer`})<br/>.**forceEdit** (target `:Text` {; item `:Integer`}) | Forces enterable state then starts edition of a listbox cell/item |
|.**reveal** (row `:Integer`)  → `:cs.listbox` | Selects and reveals the passed row number |
|.**selectedNumber** ()  →`:Integer` | Gives the number of selected rows |
|.**columnNumber** ()  →`:Integer` | Gives the number of columns |
|.**rowNumber** ()  →`:Integer` | Gives the number of lines |
|.**getRowCoordinates** (row`:Integer`) →`:Object` | Returns a row coordinates as coordinate's object |
|.**cellPosition** ({event`:Object`})  →`:Object` | Returns, as object `{column,row}`, the cell position of the given event (works also on Mouse Enter/Move/Leave!). Uses the  row & column of the current form event if no parameter.|
|.**cellCoordinates** ({column`:Integer`;row`:Integer`}) →`:Object` | Returns, as a coordinate's object, the designated cell coordinate & update the cellBox property. Uses the  row & column of the current form event if no parameter|
|.**popup** (menu`:cs.menu` {;default`:Text`})  →`:cs.menu` | Displays a [`cs.menu`](menu.md) at the bottom left of the current cell
|.**showColumn** (column`:Integer` {; visible`:Boolean`})| |
|.**hideColumn** (column`:Integer`)| |
|.**clear** ()  →`:cs.listbox`| |
|.**deleteRow** (row`:Integer`)  →`:cs.listbox`| |
|.**getColumnProperties** (column`:Integer`)  →`:Object`| |
|.**getProperty** (property`:Integer` {; column`:Integer`}) →`:Variant`| Returns a column or listbox (if column is omitted) property value|
|.**highlight** ({enable`:Boolean`})  →`:cs.listbox`| |
|.**noHighlight** ()  →`:cs.listbox`| |
|.**movableLines** ({enable `:Boolean`})  →`:cs.listbox`| |
|.**nonMovableLines** ()  →`:cs.listbox`| |
|.**selectable** ({enable `:Boolean`})  →`:cs.listbox`| |
|.**notSelectable** ()  →`:cs.listbox`| |
|.**singleSelectable** ()  →`:cs.listbox`| |
|.**multipleSelectable** ()  →`:cs.listbox`| |
|.**sortable** ({enable `:Boolean`})  →`:cs.listbox`| |
|.**notSortable** ()  →`:cs.listbox`| |

### Coordinates object
	
```json
{
	"left": Integer,
	"top": Integer,
	"right": Integer,
	"bottom": Integer
}
```


### Columns description object
	
```json
{
	"definition": [
		column 1 definition object,
		column 2 definition object,
		…
		column N definition object
	],
	"columns": {
		"column1Name" : column desc object,
		"column2Name" : column desc object,
		—
		"columnNName" : column desc object
	}
}
```


### Column desc object
	
```json
{
	"number": Integer,
	"enterable": Boolean,
	"visible": Boolean,
	"height": Integer (row height),
	"wordwrap": 0 | 1,
	"autoRowHeight": 0 | 1,
	"maxWidth": integer,
	"minWidth": integer,
	"resizable": 0 | 1,
	"displayType": 0 | 1,
	"fontColorExpression": text,
	"fontStyleExpression": text,
	"multiStyle": 0 | 1,
	"truncate": 0 | 1,
	"pointer": pointer
}
```

### Columns definition object

```json
{ 
	"name" : column name, 
	"header" : header name, 
	"footer" : footer name
}
```

### Properties object

```json
{
	"enterable": Boolean,
	"allowWordwrap": 0 | 1,
	"autoRowHeight": 0 | 1,
	"displayFooter": 0 | 1,
	"displayHeader": 0 | 1,
	"doubleClickOnRow": 0 | 1 | 2,
	"extraRows": 0 | 1,
	"footerHeight": integer,
	"headerHeight": integer,
	"hideSelectionHighlight": 0 | 1,
	"highlightSet": text,
	"metaExpression": text,
	"movableRows": 0 | 1,
	"resizingMode": 0 | 1,
	"rowHeight": integer,
	"rowHeightUnit": 0 | 1,
	"rowMaxHeight": integer,
	"rowMinHeight": integer,
	"selectionMode": 0 | 1 | 2,
	"singleClickEdit": 0 | 1,
	"sortable": 0 | 1,
	"truncate": 0 | 1,
	…
}
```
