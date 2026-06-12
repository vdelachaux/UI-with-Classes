# tabControl

The `tabControl` class provides an interface to manage tab control widgets.

<hr>

ℹ️ <b>Important</b>

1. This class inherits from the [`widget`](widget.md) class
2. All functions that return `This` may include one call after another.
3. To simplify the distinction between form objects and object type, this documentation uses the term `widget` for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).

<hr>

This class is available via the [`form`](form.md#objects) class through the `TabControl` interface.

#### Example

```4d
This.form:=cs.form.new(This)
...
This.myTabs:=This.form.TabControl("tab1"; {values: ["First"; "Second"]; index: 0})
...
This.myTabs.pageNumber:=2
```

This class is also available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

#### Example

```4d
Form.myTabControl:=cs.ui.tabControl.new("tab1"; {values: ["Page 1"; "Page 2"]}; 1; This.form)
Form.myTabControl.goToPage()
```

#### Example from test UI

```4d
This.TOP:=This.form.TabControl("tabControl1"; {values: ["Page 1"; "Page 2"]; index: 0})
This.BOTTOM:=This.form.TabControl("tabControl"; $list; 2)
// When using a choice list, call goToPage() on click and clearList() on unload.
This.BOTTOM.goToPage()
This.BOTTOM.clearList()
```

## <a name="Constructor">cs.tabControl.new()</a>

**cs.tabControl.new** ( *name* : Text ; *data* ; *page* : Integer ; *parent* : Object ) : `cs.tabControl`<br>
**cs.tabControl.new** ( *name* : Text ; *data* ) : `cs.tabControl`<br>
**cs.tabControl.new** ( *name* : Text ) : `cs.tabControl`

|Parameter|Type||Description|
|---|---|---|---|
| name | Text | → | Widget name |
| data | Object \\ List reference | → | Tab values or choice list data |
| page | Integer | → | Starting page number |
| parent | **cs**.form | → | `form` object containing the widget |
| result | **cs**.tabControl | ← | New `cs.tabControl`

### Description

`cs.tabControl.new()` creates & returns a new instance of the class.

* The `data` parameter may be an object defining `values` and `index`, or a choice list reference.
* If the `name` parameter is omitted, the constructor uses the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_).

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

## <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:|
|**.data** | Widget data object containing values and current state | `Object` | <font color="green">✓</font> |
|**.dataSource** | Underlying data source used by the widget | `Object` | <font color="green">✓</font> |

## <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ |
|.**pageRef**() →`Integer` | Returns the internal reference of the current page |
|.**pageNumber**() →`Integer` | Returns the current page number |
|.**set pageNumber**(*page* : `Integer`) | Sets the current page number and updates the widget |
|.**goToPage**() | Navigates to the current page |
|.**isChoiceList**() →`Boolean` | Returns **True** when the data source is a choice list |
|.**isObject**() →`Boolean` | Returns **True** when the data source is an object |
|.**clearList**() | Clears the choice list when used as a choice list source |
|.**enableTab**(*index* : `Integer` {; *enabled* : `Boolean`}) | Enables/disables a tab item when backed by a choice list |
|.**disableTab**(*index* : `Integer`) | Shortcut for `.enableTab(index; False)` |

> 📌 `pageNumber` is 1-based and updates both the form page and the list selection when the widget uses a choice list.
