# comboBox

The`comboBox` class provides an interface to manage properties and actions of [Combo Box](https://developer.4d.com/docs/20/FormObjects/comboBoxOverview) widgets using an `Object` as data source.

The `comboBox` class is available via the [`form`](form.md#objects) class through the `ComboBox` interface.

```4d
This.form:=cs.form.new(This)
...
This.myCombo:=This.form.DropDown("Combo Box"; {\	{values: ["apples"; "nuts"; "pears"; "oranges"; "carrots"]; \	ordered: True; \	automaticExpand: True; \	automaticInsertion: True})
```

In the form editor, you set the *Variable or expression* property of the drop-down list to `formGetInstance.myCombo.data` and you can later do:

```4d
// Get user selection
var $value : Text:This.myCombo.value
```

This class is, more generally, available from the `cs` class store, or `cs.ui` class store if you use the `UI` component:

```4d
Form.Cities:=cs.ui.comboBox.new("Combo Box"; {\	values: ["Philadelphia"; "Pittsburg"; "Grand Blanc"; "Bad Axe"; "Frostbite Falls"; "Green Bay"]; \	ordered: True; \	automaticExpand: True; \	automaticInsertion: True})
```

In the form editor, you set the *Variable or expression* property of the drop-down list to `Form.Cities.data` and you can later retrieve the user's selection like this:
```4d
// Get user selection
var $value : Text:=Form.Cities.value
```
<br>
<hr>

📌 <b>Important</b>

1. This class inherit from the [`dropDown`](dropDown.md) class
2. To simplify the distinction between form objects and object type, this documentation uses the term `widget` for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).
3. All functions that return `This` return the current *widget* object and can include one call after another. 


## <a name="Constructor">cs.comboBox.new()</a>

**cs.comboBox.new** ( ) : `cs.comboBox`
<br>**cs.comboBox.new** ( *name* : Text ) : `cs.comboBox`
<br>**cs.comboBox.new** ( *name* : Text ; *data* : Object ) : `cs.comboBox`
<br>**cs.comboBox.new** ( *name* : Text ; *data* : Object ; *parent* : Object ) : `cs.comboBox`

|Parameter|Type||Description|
|---|---|---|---|
| name | Text | →| Widget name |
| data | `Object` | → | Parameters to be used for the Combo Box management |
| parent | **cs**.form | → | `form` object containing the *widget* |
| result | **cs**.dropDown | ← | New `cs.dropDown`

### Description

`cs.comboBox.new()` creates & returns a new instance of the class.
 
 * The optional `data` parameter is the object to be used as the data source of the drop-down list. The object contain the following properties:

|Parameter|Type| Mandatory |Description|
|---|---|:---:|---|
`automaticExpand` | Boolean | No | Enable list to be displayed on getting focus \*.<br>Default is **False**
`automaticInsertion` | Boolean | No | Enable automatic insertion into the list in memory \*\*.<br>Default is **False**
`currentValue` | same as `values` | No | Currently selected item (used as placeholder value if set by code)
`index` | Integer | No | Index of the currently selected item (value from 0 to `values.length-1`).
`ordered` | Boolean | No | Keep the list ordered.<br>Default is **False**
`placeholder` | same as `values` | No | Default is `currentValue`
`values` | Collection | Yes | Collection of scalar values. All values must be of the same type. <br>Supported types:<br>  • strings<br>  • numbers<br>  • dates<br>  • times<br>If empty or not defined, the drop-down list is empty.

* The optional `parent` parameter is the [`cs.form`](form.md) object containing the *widget*. This parameter is automatically set if instantiation is performed via a [form widget instantiation function](form.md#objects) of the `cs.form` class.
* If the `name` parameter is ommited, the constructor use the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_ )

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

📌 The constructor checks that all values are of the same type. If this is not the case, an error is raised.

# Summary

## <a name="Inherited">Inherited Properties & Functions</a>

Inherited properties and functions are described in the parent classes:

* [`static` class](static.md)
* [`widget` class](widget.md)
* [`dropDown` class](dropDown.md)

## <a name="Properties">Properties</a>

|Properties|Description|Type|default|Writable|
|:----------|:-----------|:-----------|:-----------|:-----------:| 
|**.automaticExpand** | Enable list to be displayed on getting focus\* | `Boolean` | **False** | <font color="green">✓</font>
|**.automaticInsertion** | Enable automatic insertion into the list in memory\*\* | `Boolean` | **False**  | <font color="green">✓</font>
|**.filter** | Modify the entry filter | `Integer`\*\*\* \| `Text` | Depending on the type of values | <font color="green">✓</font>
|**.ordered** | Does the values list always need to be sorted? | `Boolean` | **False** | <font color="green">✓</font>

<br>\*\*\* Use [4D constants](https://developer.4d.com/docs/commands/value-type) (possible values: _Is longint_, _Is real_, _Is time_ or _Is date_. Default is _Is text_) for default predefined formats or pass the filter definition as text. 

## <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ | 
|[.**expand**](#expand) ( { *expand* }) → `This`| Display the values list - to use in the On getting focus event
|[.**insert**](#insert) ( { *item* }{; *order* }) → `This` | Insert an item (or the current value).<br>Sortes the list, if *order* is **True**, even if `ordered` property is **False**. <br>If *order* is omitted, the property `ordered` is used.
|.**listModified** ( ) → `Boolean` | Returns **True** if the values list was modified by a call to the function `insert()`.

<hr>
\* If **True**, the _On getting focus_ event is automatically activated for the widget, and you must call the [`.expand()`](#expand) function when this event is triggered.
<br>\*\* If **True** you must call the [`.insert()`](#insert) function (without parameter) when the event _On data change_ is triggered.

# <a name="expand">.expand()</a>

.**expand** ( ) → `This`
<br>.**expand** ( *force* ) → `This`

|Parameter|Type||Description|
|---|---|---|---|
| force | Boolean | → | Force expansion |
| result | `This`| ← | Current widget object |

### Description

This function expands the list of values. 

* If *force* is omitted, the `automaticExpand` property is used to allow or disallow expansion. 
* Must be call during the wiget's _On getting focus_ event like this, if the `automaticExpand` property is **True**:

```4D
If (FORM Event.code=On Getting Focus)		myCombo.expand()	End if 
```
# <a name="insert">.insert()</a>

.**insert** ( ) → `This`
<br>.**insert** ( *item* ) → `This`
<br>.**insert** ( *order* ) → `This`
<br>.**insert** ( *item* ; *order*) → `This`

|Parameter|Type||Description|
|---|---|---|---|
| item | same as `values` | → | Item to be added to the list of values in memory|
| order | same as `values` | → | Item to be added to the list of values in memory|
| result | `This`| ← | Current widget object |

### Description

This function add an item to the list of values in memory & keep the list ordered if any.

* If *item* is omitted, the current `value` is used.
* If *order* is omitted, the `ordered` property is used. 
* Could be call during the wiget's _On Data Change_ event like this:

```4D
If (FORM Event.code=On Data Change)		myCombo.insert()	End if 
```
* The widget's function can be called anywhere in the code to add one or more elements to the list of values:

```4D
myCombo.insert("New Item")
```

* In any case, when the widget is unloaded, the list of values is lost. If you wish, you can retrieve the collection of values in the `values` property and save it.




