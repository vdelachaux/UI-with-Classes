# dropDown

The`dropDown` class provides an interface to manage properties and actions of [Drop-down List](https://developer.4d.com/docs/20/FormObjects/dropdownListOverview) widgets using an Object.

The `dropDown` class is available via the [`form`](form.md#objects) class through the `DropDown` interface.

```4d
This.form:=cs.form.new(This)
...
This.myDropDown:=This.form.DropDown("dropDownList"; {\		values: [\		Localized string("latest"); \		Localized string("upToNextMajorVersion"); \		Localized string("upToNextMinorVersion"); \		Localized string("exactVersion"); \		Localized string("follow4dVersion")]; \		index: 0})
```

In the form editor, you set the *Variable or expression* property of the drop-down list to `formGetInstance.myDropDown.data` and you can later do:

```4d
// Select exact version
This.myDropDown.index:=3
```

This class is, more generally, available from the `cs` class store, or `cs.ui` class store if you use the `UI` component:

```4d
Form.myDropDown:=cs.ui.widget.new("dropDownList"; {\		values: ["one";"two";"three";"four"]; \		index: 0; \		placeholder: "Select one…"})
```

In the form editor, you set the *Variable or expression* property of the drop-down list to `Form.myDropDown.data` and you can later retrieve the user's selection like this:
```4d
// Get user selection
var $selectedIndex : Integer:=Form.myDropDown.index
var $selected : Text:=Form.myDropDown. currentValue
```
<br>
<hr>

📌 <b>Important</b>

1. This class inherit from the [`widget`](widget.md) class
2. To simplify the distinction between form objects and object type, this documentation uses the term `widget` for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).
3. All functions that return `This` return the current *widget* object and can include one call after another. 


## <a name="Constructor">cs.dropDown.new()</a>

**cs.dropDown.new** ( ) : `cs.dropDown`
<br>**cs.dropDown.new** ( *name* : Text ) : `cs.dropDown`
<br>**cs.dropDown.new** ( *name* : Text ; data : Object ) : `cs.dropDown`
<br>**cs.dropDown.new** ( *name* : Text ; data : Object ; *parent* : Object ) : `cs.dropDown`

|Parameter|Type||Description|
|---|---|---|---|
| name | Text | →| Widget name |
| data | `Object` | → | Parameters to be used for the drop-down list management |
| parent | **cs**.form | → | `form` object containing the *widget* |
| result | **cs**.dropDown | ← | New `cs.dropDown`

### Description

`cs.dropDown.new()` creates & returns a new instance of the class.
 
 * The optional `data` parameter is the object to be used as the data source of the drop-down list. The object contain the following properties:

|Parameter|Type| Mandatory |Description|
|---|---|:---:|---|
`values` | Collection | Yes | Collection of scalar values. All values must be of the same type. Supported types:<br>• strings<br>• numbers<br>• dates<br>• times<br>If empty or not defined, the drop-down list is empty
`index` | number | No | Index of the currently selected item (value between 0 and collection.length-1). If you set -1, currentValue is displayed as a placeholder string
`currentValue` | same as Collection | No | Currently selected item (used as placeholder value if set by code)
`placeholder` | same as Collection | No | Default is `currentValue` if exists
  
 * The optional `parent` parameter is the [`cs.form`](form.md) object containing the *widget*. This parameter is automatically set if instantiation is performed via a [form widget instantiation function](form.md#objects) of the `cs.form` class.
* If the `name` parameter is ommited, the constructor use the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_ )

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

# Summary

## <a name="Inherited">Inherited Properties & Functions</a>

Inherited properties and functions are described in the parent classes:

* [`static` class](static.md)
* [`widget` class](widget.md)

## <a name="Properties">Properties</a>

|Properties|Description|Type|default|Writable|
|:----------|:-----------|:-----------|:-----------|:-----------:| 
|**.value** | Currently selected item | same as Collection |  | <font color="green">✓</font>
|**.index** | Currently selected index | `Integer` | -1 | <font color="green">✓</font>
|**.placeholder** | The placeholder to use if no item selected | same as Collection | `currentValue` | <font color="green">✓</font>
|**.values** | The collection of scalar values used as datasource| `Collection` | [ ] | <font color="green">✓</font>

## <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ | 
|.**clear** () | Unselect item & restore the placeholder
|.**reinit** ( *data* ) | Uses the passed object to redefine the datasource of the dropdown.
