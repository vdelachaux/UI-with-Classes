# coordinates

The `coordinates` class provides an interface for manipulating the coordinates of a widget or window, for example.

This class is available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

<hr>
📌 <b>Conventions</b>

To simplify the distinction between form objects and object type, this documentation uses the term `widget` for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).

<hr>

## <a name="Constructor">cs.coordinates.new()</a>

**cs.coordinates.new**( *widget* : Object ) : `cs.coordinates`<br>
**cs.coordinates.new** ( *name* : Text ) : `cs.coordinates`<br>
**cs.coordinates.new** ( *left* : Integer; *top* : Integer; *right* : Integer; *bottom* : Integer ) : `cs.coordinates`<br>
**cs.coordinates.new** ( ) : `cs.coordinates`

|Parameter|Type||Description|
|---|---|---|---|
| widget | Object | -> | A widget class object like `cs.static`, `cs.input`, `cs.button`… |
| name | Text | -> | A name of a widget |
| left<br>top<br>right<br>bottom| Integer | -> | Coordinates in pixels, in the form coordinate system\*.|
| result | cs.coordinates | <- | New `cs.coordinates`

\* Origin is top left corner of current form

### Description

`cs.coordinates.new()` creates & returns a new instance of the class.
 
* If the `widget` or `name` parameter is passed, the coordinates `left`, `top`, `right` & `bottom` of the `widget` in the form coordinate system\* are retrieved & used as stored coordinates.
* If parameters `left`, `top`, `right` and `bottom` are passed, these are the stored coordinates. In that case, `name`is **undefined**.
* If no parameter is given, all coordinates are initialized with a value of 0.

# Summary

## <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|**.left**<br>**.top**<br>**.right**<br>**.bottom** | Coordinates, in pixels, in the form coordinate system| `Integer` |<font color="green">✓</font>
|**.height**<br>**.width**| Height & width, in pixels, calculated from the current coordinates | `Integer` |<font color="red">x</font>
|**.dimensions**| Dimension object from the current coordinates | [`cs.dimensions`](dimensions.md) |<font color="red">x</font>
|**.name**| Name of the widget registered when using the constructor | `Text` |<font color="red">x</font>
|**.screenCoordinates**| Converted current coordinates into the screen coordinate system (origin is top left corner of main screen) | `{left,top,right,bottom}` |<font color="red">x</font>
|**.windowCoordinates**| Converted current coordinates into the window coordinate system (origin is top left corner of current window) | `{left,top,right,bottom}` |<font color="red">x</font>

## <a name="Functions">Functions</a>

| Functions | Action |
|:-------- |:------ | 
|[.**apply** ({*name*})](#apply) | Sets the coordinates of a widget |


# <a name="apply">.apply()</a>

.**apply** ({*name*})

|Parameter|Type||Description|
|---|---|---|---|
| name | Text | <- | form object name |

### Description

Sets the coordinates of a widget.
 
If the `name` parameter is omitted, the method uses the `name` registered by the constructor.    
If no name is available, an assert is triggered.

### Example

```4d
var $coordinates:=cs.coordinates.new("Input")$coordinates.left+=10$coordinates.top+=10$coordinates.apply()
```
