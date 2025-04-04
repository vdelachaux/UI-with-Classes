# scrollable

The`scrollable` class is intended to handle widgets that accept scrollbars, i.e. images, listboxes, hierarchical list, text input and subforms.  

<hr>
📌 <b>Conventions</b>

1. This class inherit from the [`widget`](static.md) class
2. It's a transition class between the `widget` class and scrollable widget specific classes like `listbox`, `picture`, `hList`…
3. Normally, you'll never have to instantiate the **cs**.scrollable class, since instantiation is automatic with a more specialized widget.
4. All functions that return **cs**.scrollable may include one call after another.

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
|.**setHorizontalScrollbar** ( display \* ) →`:cs.scrollable` | To display or hide the horizontal scrollbar of the widget |
|.**setVerticalScrollbar** ( display \* ) →`:cs.scrollable` | To display or hide the vertical scrollbar of the widget |
|.**setScrollbars** (horizontal \* ; vertical \* ) →`:cs.scrollable` | To display or hide the horizontal and vertical scrollbars of the widget |
|.**getScrollbars** () → [Scrollbars object](#scrollbars) | Returns the current state of the toolbar display & update the`.scroolbars` property. |
|.**getScrollPosition** () → [Scroll object](#scroll) \|`Integer`| Returns the position of the scroll bars of the widget  & update the`. scroll` property.|
|.**setScrollPosition** (vertical {; horizontal}) →`:cs.scrollable` | Sets the position of the scroll bars of the widget  & update the `.scroll` property.|

\* Could be either a boolean or a numeric value (0,1 or 2) to access to the automatic mode, where scrollbars are only displayed when necessary.

> 📌 Picture, hierarchical list and list box type objects support scrollbars in automatic mode.

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


