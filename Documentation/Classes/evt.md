# evt

The `evt` class provides a typed wrapper for 4D form events.
It is used to inspect the current event, detect its kind, and implement shared event handling inside form controller classes.

<hr>

ℹ️ <b>Important</b>

1. This class is typically created at the beginning of `handleEvents()`.
2. It is used to distinguish form-level events from widget events.
3. The class exposes boolean getters for each built-in 4D form event.

<hr>

This class is available via the `cs` class store through `cs.evt.new()`.

#### Example

```4d
Function handleEvents($e : cs.evt)
  $e:=$e || cs.evt.new()

  If ($e.objectName=Null)  // FORM METHOD
    If ($e.load)
      // initial form load
    End if

    If ($e.pageChange)
      // form page changed
    End if

    If ($e.unload)
      // cleanup before unload
    End if
    
    return
  End if

  If (This.myButton.catch($e))
    // handle widget action
  End if
End function
```

## <a name="Constructor">cs.evt.new()</a>

**cs.evt.new** ( *event* : Object ) : `cs.evt`

|Parameter|Type||Description|
|---|---|---|---|
| event | Object | → | Optional raw form event object |
| result | **cs**.evt | ← | New `cs.evt`

### Description

`cs.evt.new()` creates and returns a typed event wrapper.

* If no event object is provided, the constructor uses the current `FORM Event`.
* The class exposes the raw event payload via standard properties such as `objectName`, `code`, and `description`.

## <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:|
|**.objectName** | Event object name | `Text` | <font color="red">x</font> |
|**.code** | Event code | `Integer` | <font color="red">x</font> |
|**.description** | Event description | `Text` | <font color="red">x</font> |
|**.form** | True for form-level events | `Boolean` | <font color="red">x</font> |
|**.load** | True when the event is `onLoad` | `Boolean` | <font color="red">x</font> |
|**.unload** | True when the event is `onUnload` | `Boolean` | <font color="red">x</font> |
|**.click** | True when the event is `onClick` | `Boolean` | <font color="red">x</font> |
|**.pageChange** | True when the event is `onPageChange` | `Boolean` | <font color="red">x</font> |
|**.selectionChange** | True when the event is `onSelectionChange` | `Boolean` | <font color="red">x</font> |
|**.scroll** | True when the event is `onScroll` | `Boolean` | <font color="red">x</font> |

> 📌 The class also includes boolean getters for many additional built-in form events, such as `mouseEnter`, `mouseLeave`, `dataChange`, `beforeKeystroke`, `afterKeystroke`, `resize`, and more.
