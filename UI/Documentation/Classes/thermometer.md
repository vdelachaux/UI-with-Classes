# thermometer

The `thermometer` class is intended to manage thermometer widgets.  

<hr>
📌 <b> Important </b>

1. This class inherit from the [`widget`](widget.md) class
2. All functions that return **cs**.input may include one call after another. 

<hr><br>
 
#### This class is available via the [`form`](form.md#objects) class as `Thermometer` interface.

```4d
This.form:=cs.form.new(This)
...
This.myThermo:=This.form.Thermometer("Thermometer")
...
This.myThermo.barber().start()
```

#### This class can also be instantiated on its own.

```4d
Form.myThermo:=cs.thermometer.new("Thermometer")
Form.myThermo.barber().start()
```

## <a name="Constructor"> Constructor </a>

The class constructor `cs.thermometer.new({formObjectName {; parent }})` creates a new class instance.

>📌 The optional `parent` parameter is the **cs**.form object containing the widget. This parameter is automatically set if instantiation is performed via a [form widget instantiation function](form.md#objects) of the **cs**.form class.

If the `formObjectName` parameter is ommited, the constructor use the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_ )

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

# Summary

## <a name="Inherited">Inherited Properties & Functions</a>

Inherited properties and functions are described in the parent classes:

* [`static` class](static.md)
* [`widget` class](widget.md)

## <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ |  
|.**asynchronous** ()  →`cs.thermometer ` | Sets the progress indicator as circular indicator displaying continuous animation |
|.**isAsynchronous** ()  →`Boolean` | Returns True if the progress indicator is asynchronous |
|.**barber** ()  →`cs.thermometer` | Sets the progress indicator as bar displaying continuous animation |
|.**isBarber** ()  →`Boolean` | Returns True if the progress indicator is a barber shop |
|.**progress** ()  →`cs.thermometer` | Sets the progress indicator as standard progress bar |
|.**isProgress** ()  →`Boolean` | Returns True if the progress indicator is a standard progress bar |
|.**getIndicatorType** ()  →`Integer` | Returns the indicator type |
|.**start** ()  →`cs.thermometer` | Starts an asynchronous progress indicator |
|.**stop** ()  →`cs.thermometer` | Stops an asynchronous  progress indicator |

> 📌 To set the value of a standard progress bar use the property `value` or the inherited function .**setValue**()
