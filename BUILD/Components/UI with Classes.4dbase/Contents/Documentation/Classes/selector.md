# selector

The `selector` class is intended to manage Dropdown, Combo Box and Tab Control widgets.

<hr>

ℹ️ <b>Important</b>

1. This class inherits from the [`widget`](widget.md) class
2. All functions that return `This` may include one call after another.
3. To simplify the distinction between form objects and object type, this documentation uses the term `widget` for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).

<hr>

This class is available via the [`form`](form.md#objects) class through the `Selector` interface.

#### Example

```4d
This.form:=cs.form.new(This)
...
This.mySelector:=This.form.Selector("list1"; ["First"; "Second"])
...
This.mySelector.current:="First"
```

This class is also available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

#### Example

```4d
Form.mySelector:=cs.ui.selector.new("list1"; ["First"; "Second"]; This.form)
Form.mySelector.select(1)
```

## <a name="Constructor">cs.selector.new()</a>

**cs.selector.new** ( *name* : Text ; *values* : Collection ; *parent* : Object ) : `cs.selector`<br>
**cs.selector.new** ( *name* : Text ; *values* : Collection ) : `cs.selector`<br>
**cs.selector.new** ( *name* : Text ) : `cs.selector`

|Parameter|Type||Description|
|---|---|---|---|
| name | Text | → | Widget name |
| values | Collection | → | Displayed values |
| parent | **cs**.form | → | `form` object containing the widget |
| result | **cs**.selector | ← | New `cs.selector`

### Description

`cs.selector.new()` creates & returns a new instance of the class.

* The optional `parent` parameter is the [`cs.form`](form.md) object containing the widget.
* If the `name` parameter is omitted, the constructor uses the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_).

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

## <a name="Inherited">Properties & Functions</a>

Inherited properties and functions are described in the parent classes:

* [static class](static.md)
* [widget class](widget.md)

### <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:|
|**.values** | Displayed values | `Collection` | <font color="green">✓</font> |
|**.binding** | Underlying values bound to displayed values | `Collection` | <font color="green">✓</font> |
|**.index** | Current selected index | `Integer` | <font color="green">✓</font> |
|**.current** | Current selected value or bound value | `Text` | <font color="green">✓</font> |

### <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ |
|.**select**(*element*) | Selects an element by visible value, bound value, or index |

> 📌 When `binding` is set and the selected element is matched by a bound value, the corresponding displayed text is used for the widget while preserving the original bound value.
