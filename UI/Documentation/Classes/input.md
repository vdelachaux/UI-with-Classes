# input

The `input` class is intended to handle input widget.  

♻️ This class inherit from the [`widget`](widget.md) class   

#### This class is available via the [`form`](form.md#objects) class as `input` interface.    

```4D
This.form.input.new("formObjectName")
```

#### This class can also be instantiated on its own.

```4D
cs.input.new({"formObjectName"})
```
If the `formObjectName` parameter is ommited, the constructor use the result of **[OBJECT Get name](https://doc.4d.com/4Dv18R6/4D/18-R6/OBJECT-Get-name.301-5198296.en.html)** ( _Object current_ )

> 📌 Omitting the object name can only be used if the constructor is called from the object method.

## Properties

All the properties of the extended class, plus: 

|Properties|Description|Type|default|Writable|
|:----------|:-----------|:-----------|:-----------|:-----------:| 
|**.asPassword** | Input field as password entry | `Boolean` | **False** | <font color="green">X</font>
|**.filter** | The entry filter | `Integer`\* \| `Text`\* | - | <font color="green">X</font>
|**.placeholder** | The placeholder text | `Text`\*\* | - | <font color="green">X</font>
|**.modified** | Modified state of the field after calling the `backup()` function| `Boolean` | **False** 
|**.autoSpellcheck** | Auto spellcheck option for the widget| `Boolean` | - | <font color="green">X</font> 
|**.dictionary** | Current dictionary \*| `Object` | - | 

\* When you read the dictionary property is an object 

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

## Functions

All the functions of the extended class, plus: 

| Function | Action |
| -------- | ------ | 
|.**getFilter** () → `Text` | Returns the current filter associated with the widget if any.
|.**setFilter** ( filter: `Integer`\*) → `input`<br/>.**setFilter** ( filter: `Text`\*) → `input` | Sets the entry filter for the widget.
|.**setPlaceholder** ( `Text`\*\*) → `cs.input` | Sets the placeholder text
|.**highlight** ({start: `Integer` {; end: `Integer`}}) → `cs.input` | Highlights:<br/>* All text if no parameters are passed<br/>* From `start` to the end of the text if the `end` parameter is omitted<br/>* From `start` to `end` if `start` & `end` are passed
|.**highlightLastToEnd** () → `cs.input` | Highlights the text from the last character entered to the end
|.**highlighted** () → `Object` | Returns the selection status of the field as a [selection object](#selectionObject).
|.**highlightingStart** () → `Integer` | Returns the start position of currently selected text 
|.**highlightingEnd** () → `Integer` | Returns the end position of currently selected text 
|**.backup ()** | Stores the current input value\*

\* If the input is instantiated by the `input` interface of the `form` class, a backup is automatically made during execution of the form.onload() handler.

#### <a name="selectionObject">Selection object</a>

```json
{
  start: (Integer), 
  end: (Integer), 
  length: (Integer), 
  withSeletion: (Boolean), 
  noSelection: (Boolean), 
  selection: (Text) 
}
```

> 📌 All functions that return `cs.input` may include one call after another. 

----

\* Use [4D constants](https://doc.4d.com/4Dv19/4D/19/Field-and-Variable-Types.302-5393351.en.html) (ie. _Is date_ or _Is integer_) for default predefined formats or pass the filter definition as text. Some predefined filters are available: `"url"`, `"email"`, `"noCr"`, `"noSpaceNorCr"`

\** Accepts an xliff resname, if so, uses the localized string

\*** 
