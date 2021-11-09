# widget

The `widget` class is intended to manipulate active form objects.  
It's a transition class between the static class and more specific classes like `input`, `buttons`, `listbox`…

> #### 📌 This class inherit from the [`static`](static.md) class

## Properties

|Properties|Description|Type||
|----------|-----------|:--:|-------|
|**.action** | The name & , if any, parameter of the standard action associated with the object | `Text` | cf. [Standard actions](https://doc.4d.com/4Dv18R6/4D/18-R6/Standard-actions.300-5217689.en.html)|
|**.assignable** | Is the object accessible by a pointer | `Boolean` | **True** or **False** it depends |
|**.pointer** | The pointer, if any, to the widget | `Pointer` | **Nil** if not assignable |
|**.value** | The value of the datasource, if any | `Variant` |  |
|**.name** | The name of the form object| `Text` | *inherited* |
|**.type** | The type of the form object| `Integer` | *inherited* |
|**.coordinates** | The coordinates of the form object in the form| `Object` | *inherited* |
|**.dimensions** | The dimensions of the form object| `Object` | *inherited* |
|**.windowCoordinates** | The coordinates of the form object in the current window|`Object` | *inherited* |

## 🔸 cs.widget.new()

The class constructor `cs.widget.new({formObjectName})` creates a new class instance.

If the `formObjectName` parameter is ommited, the constructor use the result of **[OBJECT Get name](https://doc.4d.com/4Dv18R6/4D/18-R6/OBJECT-Get-name.301-5198296.en.html)** ( _Object current_ )
> 📌 Omitting the object name can only be used if the constructor is called from the object method.

## Summary

> 📌 All functions that return `cs.widget` may include one call after another. 

| Function | Action |
| -------- | ------ |  
|.**updatePointer** ()  → `pointer` | Update of the widget pointer. Useful when reloading the form |
|.**pointer** ()  → `pointer` | Returns the pointer to the widget |
|.**setFormat** (format : `Text`)  → `cs.widget` | Sets the format for the widget |
|.**setPicture** (proxy : `Text`)  → `cs.widget` | Attaches an image to the widget - *cf*. *infra* |
## 🔹 .setPicture()
.**setPicture** ( { proxy : `Text`} )  → `cs.widget`

This function is intended to set the image of the compatible `3D button`, `3D checkbox`, `3D radio button`, `picture button`, `picture popup menu`, `listbox header` or `static picture`.

Possible values for the `proxy` parameter are:
* The string `#{folder/}picturename` or `file:{folder/}picturename` if the picture comes from a file stored in the `Resources` folder
* A variable name if the picture comes from a `picture variable`
* A number, preceded with a question mark (ex.: “?250”) if the picture comes from a `picture library` (OBSOLETE)If the `proxy` parameter is omitted, the picture is removed