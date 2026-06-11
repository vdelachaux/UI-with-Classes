# subform

The `subform` class provides an interface to manage subform widgets and their embedded form behavior.

<hr>

ℹ️ <b>Important</b>

1. This class inherits from the [`scrollable`](scrollable.md) class
2. All functions that return `This` may include one call after another.
3. To simplify the distinction between form objects and object type, this documentation uses the term `widget` for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).

<hr>

This class is available via the [`form`](form.md#objects) class through the `Subform` interface.

#### Example

```4d
This.form:=cs.form.new(This)
...
This.mySubform:=This.form.Subform("subform1")
...
This.mySubform.refresh()
```

This class is also available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

#### Example

```4d
Form.mySubform:=cs.ui.subform.new("subform1"; Null; Null; Null; This.form)
Form.mySubform.enable("field1")
```

#### Example from test UI

```4d
This.windowFrame:=This.form.Subform("windowFrame")
This.searchBox:=This.form.Subform("search")
This.windowFrame.refresh()
```

## <a name="Constructor">cs.subform.new()</a>

**cs.subform.new** ( *name* : Text ; *events* : Object ; *super* : Object ; *form* : Object ; *parent* : Object ) : `cs.subform`<br>
**cs.subform.new** ( *name* : Text ) : `cs.subform`

|Parameter|Type||Description|
|---|---|---|---|
| name | Text | → | Widget name |
| events | Object | → | Event definitions for the subform container |
| super | Object | → | Super object used for event propagation |
| form | Object | → | Form instance for the subform |
| parent | **cs**.form | → | `form` object containing the widget |
| result | **cs**.subform | ← | New `cs.subform`

### Description

`cs.subform.new()` creates & returns a new instance of the class.

* The optional `parent` parameter is the [`cs.form`](form.md) object containing the widget.
* If the `name` parameter is omitted, the constructor uses the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_).

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

## <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:|
|**.isSubform** | Indicates that the widget is a subform | `Boolean` | <font color="red">x</font> |
|**.form** | Embedded form controller for the subform | `cs.form` | <font color="red">x</font> |
|**.privateEvents** | Events stored for the subform container | `Object` | <font color="green">✓</font> |
|**.parent** | Parent container information | `Object` | <font color="green">✓</font> |

## <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ |
|.**setPrivateEvents**(*events* : `Object`) | Defines container events available to the embedded subform |
|.**set data**(*data* ) | Updates the user data attached to the widget |
|.**execute**(*formula* : `4D.Function`) | Executes a formula in the current subform |
|.**refresh**(*delay* : `Integer`) | Refreshes the subform, optionally after a delay |
|.**stopTimer**() | Disables the subform timer |
|.**focus**(*widget* : `Text`) | Gives focus to a widget inside the subform |
|.**removeFocus**() | Removes the current focus from the subform |
|.**enable**(*widget* : `Text`) | Enables a widget or all widgets in the subform |
|.**disable**(*widget* : `Text`) | Disables a widget or all widgets in the subform |
|.**getParentRect**() →`cs.rect` | Returns the subform container rectangle |
|.**getSubforms**() →`Object` | Returns the associated detail and list form names |
|.**detailForm**() →`Text` | Returns the associated detail form name |
|.**listForm**() →`Text` | Returns the associated list form name |
|.**setSubform**(*detail* : `Text`; *list* : `Text`; *table* : `Pointer`) →`cs.subform` | Sets the subform associations |
|.**alignHorizontally**(*alignment* : `Integer`; *reference* ) | Aligns the subform widget horizontally |

> 📌 Internal helpers like `._execute()` and `._getWidget()` are used to run code inside the current subform and resolve widget names.
