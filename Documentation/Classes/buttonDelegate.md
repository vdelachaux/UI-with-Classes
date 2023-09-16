# button

The `button` class is intended to manage button widgets.  

> #### 📌 This class inherit from the [`widget`](widget.md) class

## Properties

|Properties|Description|
|----------|-----------|
|**.name** | [*inherited*](formObject.md) |
|**.type** | [*inherited*](formObject.md) |
|**.coordinates** | [*inherited*](formObject.md) |
|**.dimensions** | [*inherited*](formObject.md) |
|**.windowCoordinates** | [*inherited*](formObject.md) |
|**.action** |  [*inherited*](widget.md) |
|**.assignable** | [*inherited*](widget.md) |
|**.pointer** | [*inherited*](widget.md) |
|**.value** | [*inherited*](widget.md) |

## 🔸 cs.button.new()

The class constructor `cs.button.new({formObjectName})` creates a new class instance.

If the `formObjectName` parameter is ommited, the constructor use the result of **[OBJECT Get name](https://doc.4d.com/4Dv18R6/4D/18-R6/OBJECT-Get-name.301-5198296.en.html)** ( _Object current_ )

> 📌 Omitting the object name can only be used if the constructor is called from the object method.

## Summary

> 📌 All functions that return `cs.button` may include one call after another. 

| Function | Action |
| -------- | ------ |  
|.**highlightShortcut** () →`cs.button` | Tryes to underline the first capital letter or, if not found the first letter, corresponding to the associated key shortcut |
|.**setLinkedPopupMenu** () →`cs.button` | Associates a linked pop-up menu with the button |
|.**setSeparatePopupMenu** () →`cs.button` | Associates a separate pop-up menu with the button |
|.**setNoPopupMenu** () →`cs.button` | Removes the pop-up menu associated with the button if any |
|.**horizontalMargin** () →`Integer` | Returns the number of pixels delimiting the inside left and right margins of the button (areas that the icon and the text must not encroach upon). |
|.**horizontalMargin** (pixel`:Integer`) →`cs.button` | Sets the number of pixels delimiting the inside left and right margins of the button (areas that the icon and the text must not encroach upon). |
|.**is3DButton** () →`Boolean` | Returns True if the current button is a 3D button. |


