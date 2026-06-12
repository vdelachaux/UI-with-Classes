# window

The `window` class provides an interface to manage 4D windows from form controllers and application logic.

<hr>

ℹ️ <b>Important</b>

1. This class is not a form widget; it wraps the current or specified 4D window.
2. It can be instantiated with the current form window, a window reference, or another `window` object.
3. It is commonly used to update titles, resize the window, or trigger window actions like minimize/restore.

<hr>

This class is available via the `cs` class store through `cs.window.new()`.

#### Example

```4d
// Set the window title for the current form window.
var $w : cs.window:=cs.window.new()
$w.title:="enterYourPassword"

// Animate a failed login.
$w.vibrate()
```

#### Example with an existing window reference

```4d
var $w : cs.window:=cs.window.new(Current form window)
$w.maximize()
```

#### Example from test UI

```4d
This.form.window.title:="title_3"
This.form.window.vibrate()
This.form.window.minimize()
This.form.window.maximize()
```

## <a name="Constructor">cs.window.new()</a>

**cs.window.new** ( *param* ) : `cs.window`

|Parameter|Type||Description|
|---|---|---|---|
| param | `Integer` \ `Real` \ `Object` | → | Window reference or wrapper object |
| result | **cs**.window | ← | New `cs.window`

### Description

`cs.window.new()` creates and returns a wrapper for a 4D window.

* If `param` is omitted, the current form window is used.
* If `param` is a number, it is used as the window reference.
* If `param` is an object with a `.ref` property, that object is used as the base wrapper.

## <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:|
|**.ref** | Window reference | `Integer` | <font color="red">x</font> |
|**.title** | Window title | `Text` | <font color="green">✓</font> |
|**.type** | Window type | `Integer` | <font color="red">x</font> |
|**.process** | Process identifier owning the window | `Integer` | <font color="red">x</font> |
|**.next** | Next window in the Z-order | `Integer` | <font color="red">x</font> |
|**.left** | Left coordinate | `Integer` | <font color="green">✓</font> |
|**.top** | Top coordinate | `Integer` | <font color="green">✓</font> |
|**.right** | Right coordinate | `Integer` | <font color="green">✓</font> |
|**.bottom** | Bottom coordinate | `Integer` | <font color="green">✓</font> |

## <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ |
|.**hide**() | Hides the window |
|.**show**() | Shows the window |
|.**close**() | Closes the window |
|.**erase**() | Erases the window |
|.**drag**() | Starts window dragging |
|.**reduce**() | Toggles reduce/restore state |
|.**restore**() | Restores the window from reduced state |
|.**maximize**() | Maximizes the window |
|.**minimize**() | Minimizes the window |
|.**resize**(*hOffset* : `Integer`; *vOffset* : `Integer`) | Resizes the window by the given offsets |
|.**resizeHorizontally**(*offset* : `Integer`) | Resizes the window width |
|.**resizeVertically**(*offset* : `Integer`) | Resizes the window height |
|.**redraw**() | Forces a redraw of the window |
|.**bringToFront**() | Brings the window to the front |
|.**vibrate**(*count* : `Integer`) | Shakes the window visually |

> 📌 `vibrate()` is useful to draw attention to an invalid action, such as a failed login attempt.

## Integration Notes

Recent integration adds dimension aliases for backward compatibility with `rect`:

* `.dimensions` (`cs.dimensions`) mirrors `.rect`.
* `.setDimensions(width; height)` mirrors `.setRect(width; height)`.
