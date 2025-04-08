# coordinates

The `coordinates` class provides an interface for manipulating the coordinates of a widget or window, for example.

<hr>
📌 <b>Conventions</b>

To simplify the distinction between form objects and object type, this documentation uses the term “widget” for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).
<br>

## <a name="Constructor">Constructor</a>

The class constructor `cs.coordinates.new()` creates a new class instance.

### ① cs.coordinates.new( widget `:Object`)

 → `widget` is a widget class object like **cs**.static, **cs**.input, **cs**.button… The current widget coordinates in the form coordinate system\* are used.

### ② cs.coordinates.new( name `:Text`)

 → `name` is the name of widget. Its current coordinates in the form coordinate system\* are used.

### ③ cs.coordinates.new( left `:Integer`; top `:Integer`; right `:Integer`; bottom `:Integer`)

 → `left`, `top`, `right` and `bottom` parameters are the coordinates, in the form coordinate system\*, to be stored.
  
<br>
<br> 
\* Origin is top left corner of current form

## <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|**.left**<br>**.top**<br>**.right**<br>**.bottom** | Registered coordinates of object in pixels| `Integer` |<font color="green">✓</font>
|**.height**<br>**.width**| Height & width, calculated in pixels | `Integer` |<font color="red">x</font>
|**.dimensions**| Dimension object | [**cs**.dimensions](dimensions.md) |<font color="red">x</font>
|**.name**| Name of the widget registered when using the constructor (syntax ① & ② | `Integer` |<font color="red">x</font>
|**.screenCoordinates**| Converted registered coordinates into the screen coordinate system. ie. Origin is top left corner of main screen | `{left,top,right,bottom}` |<font color="red">x</font>
|**.windowCoordinates**| Converted registered coordinates into the window coordinate system. ie. Origin is top left corner of current window | `{left,top,right,bottom}` |<font color="red">x</font>

## <a name="Functions">Functions</a>

| Functions | Action |
|:-------- |:------ | 
|.**apply** ({name}) | Sets the coordinates of the widget whose name is passed, <br>or, if no parameter, the name was registered by the constructor |

### example

```4d
var $coordinates:=cs.coordinates.new("Input")$coordinates.left+=10$coordinates.top+=10$coordinates.apply()
```
