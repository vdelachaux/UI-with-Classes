# input

The `input` class is intended to handle input widget.  

<hr>
📌 <b> Important </b>

1. This class inherit from the [`widget`](widget.md) class
2. All functions that return **cs**.input may include one call after another. 

<hr><br>
 

#### This class is available via the [`form`](form.md#objects) class as `Input` interface.

```4d
This.form:=cs.form.new(This)
...
This.myInput:=This.form.Input("password")
...
This.myInput.asPassword := True
```

#### This class can also be instantiated on its own.

```4d
Form.myInput:=cs.input.new("date")
Form.myInput.filter := Is date
```

## <a name="Constructor"> Constructor </a>

The class constructor `cs. input.new({formObjectName {; parent }})` creates a new class instance.

>📌 The optional `parent` parameter is the **cs**.form object containing the widget. This parameter is automatically set if instantiation is performed via a [form widget instantiation function](form.md#objects) of the **cs**.form class.

If the `formObjectName` parameter is ommited, the constructor use the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_ )

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

# Summary

## <a name="Inherited">Inherited Properties & Functions</a>

Inherited properties and functions are described in the parent classes:

* [`static` class](static.md)
* [`widget` class](widget.md)


## <a name="Properties">Properties</a>

|Properties|Description|Type|default|Writable|
|:----------|:-----------|:-----------|:-----------|:-----------:| 
|**.asPassword** | Treat input as password entry if **True** | `Boolean` | **False** | <font color="green">✓</font>
|**.autoSpellcheck** | Auto spellcheck option for the widget| `Boolean` | - | <font color="green">✓</font>
|**.dictionary** | Current dictionary \*\*\*\*| `Object` | - | 
|**.filter** | Modify the entry filter | `Integer`\* \| `Text` | - | <font color="green">✓</font>
|**.modified** | Modified state of the field after calling the `backup()` function\*\*\*| `Boolean` | **False** |<font color="red">x</font>
|**.placeholder** | The placeholder text | `Text`\*\* | - | <font color="green">✓</font>

## <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ | 
|.**getFilter** () → `Text` | Returns the current filter associated with the widget if any.
|.**setFilter** ( filter: `Integer`\* {; decimalSeparator }) → `input`<br/>.**setFilter** ( filter: `Text`\*) → `input` | Sets the entry filter for the widget.
|.**setPlaceholder** ( `Text`\*\*) → `cs.input` | Sets the placeholder text
|.**highlight** ({start: `Integer` {; end: `Integer`}}) → `cs.input` | Highlights:<br/>* All text if no parameters are passed<br/>* From `start` to the end of the text if the `end` parameter is omitted<br/>* From `start` to `end` if `start` & `end` are passed
|.**highlightLastToEnd** () → `cs.input` | Highlights the text from the last character entered to the end
|.**highlighted** () → `Object` | Returns the selection status of the field as a [selection object](#selectionObject).
|.**highlightingStart** () → `Integer` | Returns the start position of currently selected text 
|.**highlightingEnd** () → `Integer` | Returns the end position of currently selected text 
|**.backup** () | Stores the current input value\*\*\*
|**.swapDecimalSeparator** () | Replace the point by the decimal parameter in a text box<br>Must be called during management of the `On Before Keystroke` event
|**.truncateWithEllipsis** ( where {; target {; char}}) | Truncate label with ellipsis, according to the widget current width.

<br>\* Use [4D constants](https://doc.4d.com/4Dv19/4D/19/Field-and-Variable-Types.302-5393351.en.html) (possible values : `Is integer`, `Is longint`, `Is real`, `Is time` or `Is date`) for default predefined formats or pass the filter definition as text. Some predefined filters name are available: `"url"`, `"email"`, `"noCr"`, `"noSpaceNorCr"`
<br>\** Accepts an xliff resname, if so, uses the localized string
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
