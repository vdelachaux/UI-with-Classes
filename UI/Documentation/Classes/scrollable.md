# scrollable

The`scrollable` class provides an interface to manage properties and actions of scrollable widgets.

<hr>
📌 <b>Important</b>

1. This class inherit from the [`widget`](widget.md) class
2. This class is a transition class between the `widget` class and scrollable more specific classes like `input`, `button`, `listbox`…
3. _Normally, you'll never have to instantiate the **cs**.scrollable class_, since instantiation is automatic with a more specialized *widget*.
4. To simplify the distinction between form objects and object type, this documentation uses the term `widget` for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).
5. All functions that return `This` return the current *widget* object and can include one call after another. 

<hr>

The `widget` class is available via the [`form`](form.md#objects) class through the `Widget` interface.

```4d
This.form:=cs.form.new(This)
...
This.myWidget:=This.form.Widget("myWidget")
...
This.myWidget.droppable:=True
```

This class is, more generally, available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

```4d
Form.myWidget:=cs.ui.widget.new("form object")
Form.myWidget.setDroppable(True; False)
```

# Summary

## <a name="Inherited">Inherited Properties & Functions</a>

Inherited properties and functions are described in the parent classes:

* [`static` class](static.md)
* [`widget` class](widget.md)

## <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|**.scrollbars** | The current state of the toolbar display. | [Scrollbars object](#scrollbars) |<font color="red">x</font>| 
|**.scroll** | The current scroll position(s). |[Scroll object](#scroll) if the widget accept vertical & horizontal scrollbars <br/>`Integer` if not | <font color="red">x</font>| 

## <a name="Functions">Functions</a>

| Function | Action |
| -------- | ------ |  
|.**setHorizontalScrollbar** ( *display* \* ) →`This` | To display or hide the horizontal scrollbar of the widget |
|.**setVerticalScrollbar** ( *display* \* ) →`This` | To display or hide the vertical scrollbar of the widget |
|.**setScrollbars** (*horizontal* \* ; *vertical* \* ) →`This` | To display or hide the horizontal and vertical scrollbars of the widget |
|.**getScrollbars** () → [Scrollbars object](#scrollbars) | Returns the current state of the toolbar display & update the`.scroolbars` property. |
|.**getScrollPosition** () → [Scroll object](#scroll) \|`Integer`| Returns the position of the scroll bars of the widget  & update the`. scroll` property.|
|.**setScrollPosition** (vertical {; horizontal}) →`This` | Sets the position of the scroll bars of the widget  & update the `.scroll` property.|

\* Could be either a boolean or a numeric value (0,1 or 2) to access to the automatic mode, where scrollbars are only displayed when necessary.

> 📌 Image, hierarchical list and listbox objects support automatic scrollbars. Input widgets do not support automatic display of scrollbars.

<hr>

### <a name="scrollbars">Scrollbars object</a>

```json
{
  vertical: (Integer), 
  horizontal: (Integer)
 }
```
 Values for horizontal & vertical could be:
 
 > = 0: Hide<br> = 1: Show<br> = 2: Automatic

### <a name="scroll">Scroll object</a>

```json
{
  vertical: (px), 
  horizontal: (px)
 }
```

<hr>


