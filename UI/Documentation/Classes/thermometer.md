# thermometer

The `thermometer` class provides an interface to manage properties and actions of thermometer widgets. 

<hr>

ℹ️ <b>Important</b>

1. This class inherit from the [`widget`](widget) class
2. To simplify the distinction between form objects and object type, this documentation uses the term `widget` for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).
3. All functions that return `This` return the current *widget* object and can include one call after another. 

<hr>

This class is available via the [`form`](form.md#objects) class through the `Thermometer` interface.

#### Example

```4d
This.form:=cs.form.new(This)
...
This.myThermo:=This.form.Thermometer("Thermometer")
...
This.myThermo.barber().start()
```

This class is, more generally, available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

#### Example

```4d
Form.myThermo:=cs.thermometer.new("Thermometer")
Form.myThermo.barber().start()
```
 
## <a name="Constructor">cs.thermometer.new()</a>

**cs.thermometer.new** ( *name* : Text) : `cs.thermometer`<br>
**cs.thermometer.new** ( *name* : Text ; *parent* : Object) : `cs.thermometer`<br>
**cs.thermometer.new** ( ) : `cs.thermometer`

|Parameter|Type||Description|
|---|---|---|---|
| name | Text | → | Widget name |
| parent | **cs**.form | → | `form` object containing the *widget* |
| result | **cs**.thermometer | ← | New `cs.thermometer`

### Description

`cs.thermometer.new()` creates & returns a new instance of the class.
 
* The optional `parent` parameter is the [`cs.form`](form.md) object containing the *widget*. This parameter is automatically set if instantiation is performed via a [form widget instantiation function](form.md#objects) of the `cs.form` class.
* If the `name` parameter is ommited, the constructor use the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_ )

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

## <a name="Inherited">Properties & Functions</a>

Inherited properties and functions are described in the parent classes:

* [static class](static.md)
* [widget class](widget.md)

### <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ |  
|.**asynchronous** ()  → `This` | Sets the progress indicator as circular indicator displaying continuous animation |
|.**isAsynchronous** ()  → `Boolean` | Returns True if the progress indicator is asynchronous |
|.**barber** ()  → `This` | Sets the progress indicator as bar displaying continuous animation |
|.**isBarber** ()  → `Boolean` | Returns True if the progress indicator is a barber shop |
|.**progress** ()  → `This` | Sets the progress indicator as standard progress bar |
|.**isProgress** ()  → `Boolean` | Returns True if the progress indicator is a standard progress bar |
|.**getIndicatorType** ()  → `Integer` | Returns the indicator type |
|.**start** ()  → `This` | Starts an asynchronous progress indicator |
|.**stop** ()  → `This` | Stops an asynchronous  progress indicator |

> 📌 To set the value of a standard progress bar use the property `value` or the inherited function .**setValue**()

