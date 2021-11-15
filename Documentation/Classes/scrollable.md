# scrollable

The`scrollable` class is intended to handle widgets that accept scrollbars, i.e. images, listboxes, hierarchical list, text input and subforms.  

> #### 📌 This class inherit from the [`widget`](widget.md) class

## Properties

|Properties|Description|Type||
|----------|-----------|:--:|-------|
|**.name** | [*inherited*](formObject.md) |
|**.type** | [*inherited*](formObject.md) |
|**.coordinates** | [*inherited*](formObject.md) |
|**.dimensions** | [*inherited*](formObject.md) |
|**.windowCoordinates** | [*inherited*](formObject.md) |
|**.action** |  [*inherited*](widget.md) |
|**.assignable** | [*inherited*](widget.md) |
|**.pointer** | [*inherited*](widget.md) |
|**.value** | [*inherited*](widget.md) |
|**.scrollbars** | The current state of the toolbar display. |`Object` | {<br/>    "vertical":`Integer`,<br/>    "horizontal":`Integer`<br/>}
|**.scroll** | The current scroll position(s). |`Object` if the widget accept vertical & horizontal scrollbars <br/>`Integer` if not |{<br/>    "vertical":`Integer`,<br/>    "horizontal":`Integer`<br/>}

## 🔸 cs.scrollable.new()

The class constructor`cs.scrollable.new({formObjectName})` creates a new class instance.

If the`formObjectName` parameter is ommited, the constructor use the result of **[OBJECT Get name](https://doc.4d.com/4Dv18R6/4D/18-R6/OBJECT-Get-name.301-5198296.en.html)** (_Object current_ )

> 📌 Omitting the object name can only be used if the constructor is called from the object method.

## Summary

> 📌 All functions that return`cs.scrollable` may include one call after another. 

| Function | Action |
| -------- | ------ |  
|.**setHorizontalScrollbar** (display`:\*`) →`:cs.scrollable` | To display or hide the horizontal scrollbar of the widget |
|.**setVerticalScrollbar** (display`:\*`) →`:cs.scrollable` | To display or hide the vertical scrollbar of the widget |
|.**setScrollbars** (horizontal`:\*` ; vertical`:\*`) →`:cs.scrollable` | To display or hide the horizontal and vertical scrollbars of the widget |
|.**getScrollbars** () →`:Object` | Returns the current state of the toolbar display & update the`.scroolbars` property. |
|.**getScrollPosition** () →`:Object`\|`Integer`| Returns the position of the scroll bars of the widget  & update the`. scroll` property.|
|.**setScrollPosition** (vertical`:\*` {; horizontal`:\*`}) →`:cs.scrollable` | Sets the position of the scroll bars of the widget  & update the `.scroll` property.|

\* Could be either a boolean or a numeric value (0,1 or 2) to access to the automatic mode, where scrollbars are only displayed when necessary (Picture, hierarchical list and list box type objects support scrollbars in automatic mode.).


