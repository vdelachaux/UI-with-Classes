# input

The `input` class provides an interface to manage properties and actions of input widgets.

<hr>
📌 <b>Important</b>

1. This class inherit from the [`scrollable`](scrollable.md) class
2. All functions that return `This` return the current *widget* object and can include one call after another.  

<hr>

This class is available via the [`form`](form.md#objects) class through the `Input` interface.

```4d
This.form:=cs.form.new(This)
...
This.myInput:=This.form.Input("myWidget")
...
This.myInput.asPassword:=True
```

This class is, more generally, available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

```4d
Form.myInput:=cs.ui.input.new("date")
Form.myInput.filter := Is date
```
→
## <a name="Constructor">cs.input.new()</a>

**cs.input.new** ( *name* : Text) : `cs.input`<br>
**cs.input.new** ( *name* : Text ; *parent* : Object) : `cs.input`<br>
**cs.input.new** ( ) : `cs.input`

|Parameter|Type||Description|
|---|---|---|---|
| name | Text | → | Widget name |
| parent | `cs.form` | → | `form` object containing the *widget* |
| result | **cs**.input | ← | New `cs.input`

### Description

`cs.input.new()` creates & returns a new instance of the class.
 
* The optional `parent` parameter is the [`cs.form`](form.md) object containing the *widget*. This parameter is automatically set if instantiation is performed via a [form widget instantiation function](form.md#objects) of the `cs.form` class.
* If the `name` parameter is ommited, the constructor use the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_ )

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

# Summary

## <a name="Inherited">Inherited Properties & Functions</a>

Inherited properties and functions are described in the parent classes:

* [`static` class](static.md)
* [`widget` class](widget.md)
* [`scrollable` class](scrollable.md)

## <a name="Properties">Properties</a>

|Properties|Description|Type|default|Writable|
|:----------|:-----------|:-----------|:-----------|:-----------:| 
|**.asPassword** | Treat input as password entry if **True** | `Boolean` | **False** | <font color="green">✓</font>
|**.autoSpellcheck** | Auto spellcheck option for the widget| `Boolean` | - | <font color="green">✓</font>
|**.dictionary** | Current dictionary \*\*\*\*| `Object` | - | 
|**.filter** | Modify the entry filter | `Integer`\* \| `Text` | - | <font color="green">✓</font>
|**.modified** | Modified state of the field since the `backup()` function was called\*\*\*| `Boolean` | **False** |<font color="red">x</font>
|**.placeholder** | The placeholder text | `Text`\*\* | - | <font color="green">✓</font>

## <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ | 
|.**backup** () | Stores the current input value\*\*\*
|.**getFilter** () → `Text` | Returns the current filter associated with the widget if any.
|.**highlight** ({*start*: `Integer` {; *end*: `Integer`}}) → `This` | Highlights:<br/>* All text if no parameters are passed<br/>* From `start` to the end of the text if the `end` parameter is omitted<br/>* From `start` to `end` if `start` & `end` are passed
|.**highlighted** () → `Object` | Returns the selection status of the field as a [selection object](#selectionObject).
|.**highlightingEnd** () → `Integer` | Returns the end position of currently selected text 
|.**highlightingStart** () → `Integer` | Returns the start position of currently selected text 
|.**highlightLastToEnd** () → `This` | Highlights the text from the last character entered to the end
|.**restore** () | Restores saved widget value
|.**setFilter** ( *filter*: `Integer`\* {; *decimalSep* }) → `This`<br/>.**setFilter** ( filter: `Text`\*) → `This` | Sets the entry filter for the widget.
|.**setPlaceholder** ( `Text`\*\*) → `This` | Sets the placeholder text
|.**swapDecimalSeparator** () | Replace the point by the decimal parameter in a text box<br>Must be called during management of the `On Before Keystroke` event
|.**truncateWithEllipsis** ( *where* {; *target* {; *char* }}) | Truncate label with ellipsis, according to the widget current width.

<br>\* Use [4D constants](https://doc.4d.com/4Dv19/4D/19/Field-and-Variable-Types.302-5393351.en.html) (possible values : `Is integer`, `Is longint`, `Is real`, `Is time` or `Is date`) for default predefined formats or pass the filter definition as text. Some predefined filters name are available: `"url"`, `"email"`, `"noCr"`, `"noSpaceNorCr"`
<br>\** Accepts an `xliff resname`, if so, uses the localized string
<br>\*\*\* If the widget is instantiated by the `Input` interface of the `form` class, a backup is automatically made during execution of the form.onload() handler.
<br>\*\*\*\*  When you read the dictionary property is an object

```4d
Form.input:=cs.input.new({"input"})
$dictionary:=Form.input.dictionary
```
```json
{
  id: (Integer), 
  code: (Text), 
  name: (Text)
}
```
When you write, you pass the `id` or the `code` or the `name`

```4d
Form.input.dictionary:="fr"
```

If the dictionary is not installed, an assert is triggered.

<hr>

### <a name="selectionObject">Selection object</a>

```4d
{ start: $start;  end: $end;  length: $end-$start; \ withSelection: $end#$start;  noSelection: $end=$start; selection: ""
}
```
