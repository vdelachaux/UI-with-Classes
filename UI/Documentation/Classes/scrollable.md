# scrollable

The `scrollable` class provides an interface to manage properties and actions of scrollable widgets.
<hr>

ℹ️ <b>Important</b>

1. This class inherit from the [`widget`](widget.md) class
2. This class is a transition class between the `widget` class and scrollable more specific classes like `input`, `hList`, `listbox`…
3. _Normally, you'll never have to instantiate the **cs.**scrollable class_, since instantiation is automatic with a more specialized *widget*.
4. To simplify the distinction between form objects and object type, this documentation uses the term `widget` for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).
5. All functions that return `This` return the current *widget* object and can include one call after another. 

<hr>

## <a name="Inherited">Properties & Functions</a>

Inherited properties and functions are described in the parent classes:

* [static class](static.md)
* [widget class](widget.md)

### <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
| .**horizontalPosition** | Position of the horizontal control bar\**\* | Integer | <font color="green">✓</font>
| .**horizontalScrollbar** | Status of horizontal control bar. <br>  - When reading, returns True if status is `Always` or `Automatic`. <br>  - When writing, set status to `Always`. | Boolean | <font color="green">✓</font>
| .**horizontalScrollbarAuto** | Automatic mode status of horizontal control bar\* | Boolean | <font color="green">✓</font>
|.**scroll** | The current scroll position(s). |[`Scroll object`](#scroll) if supports horizontal scrolling `Integer` if not | <font color="red">x</font>| 
| .**scrollbars** | The current state of the toolbar display. | [`Scrollbars object`](#scrollbars) |<font color="red">x</font>
| .**verticalPosition** | Position of the vertical control bar. | Integer | <font color="green">✓</font>
| .**verticalScrollbar** | Status of vertical control bar. <br>  - When reading, returns True if status is `Always` or `Automatic`. <br>  - When writing, set status to `Always`. | Boolean | <font color="green">✓</font>
| .**verticalScrollbarAuto** | Automatic mode status of vertical control bar\* | Boolean | <font color="green">✓</font>

### <a name="Functions">Functions</a>

| Function | Action |
| -------- | ------ |  
|.**getScrollbars** () → [Scrollbars object](#scrollbars) | Update the `scrollbars` property & returns the current status. |
|.**setScrollbars** (*horizontal*\* ; *vertical*\* ) →`This` | To display or hide the horizontal and vertical scrollbars of the widget |
|.**setHorizontalScrollbar** (*display*\** ) →`This` | Show or hide the widget's horizontal scroll bar |
|.**setVerticalScrollbar** (*display*\** ) →`This` | Show or hide the widget's vertical scroll bar |
|.**noScrollbar** ( ) →`This` | To remove horizontal & vertical scrollbar of the widget |
|.**getScrollPosition** () → [Scroll object](#scroll) \|`Integer`| Returns the position of the scroll bars of the widget  & update the `scroll` property.|
|.**setScrollPosition** (*vertical* {; *horizontal*\*\*\*} {; *firstPosition* }) →`This` | Sets the position of the scroll bars of the widget & update the `scroll` property.<br>The `firstPosition` parameter allow to isplay of line (and column if the `horizontal` parameter is passed) in 1st position after scroll |

\* Only *Image*, *Hierarchical list* and *Listbox* support automatic scrollbars.
<br>\** Could be either a `Boolean` or an `Integer` value (0,1 or 2) to access to the automatic mode, where scrollbars are only displayed when necessary..
<br>\*\*\* Only *Image* and *Listbox* support horizontal position.

#### <a name="scrollbars">Scrollbars object</a>

```json
{
  vertical: Integer, 
  horizontal: Integer, 
  horizontalAuto: Boolean, 
  verticalAuto: Boolean
 }
```

 Values for horizontal & vertical could be:
 
 > = 0: Hide<br> = 1: Show<br> = 2: Automatic

#### <a name="scroll">Scroll object</a>

```json
{
  vertical: (px), 
  horizontal: (px)
 }
```

