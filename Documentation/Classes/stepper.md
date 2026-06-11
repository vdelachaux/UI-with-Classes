# stepper

The `stepper` class provides an interface to manage stepper widgets.

<hr>

ℹ️ <b>Important</b>

1. This class inherits from the [`widget`](widget.md) class
2. All functions that return `This` may include one call after another.
3. To simplify the distinction between form objects and object type, this documentation uses the term `widget` for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).

<hr>

This class is available via the [`form`](form.md#objects) class through the `Stepper` interface.

#### Example

```4d
This.form:=cs.form.new(This)
...
This.myStepper:=This.form.Stepper("stepper1")
...
This.myStepper.start(True)
```

This class is also available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

#### Example

```4d
Form.myStepper:=cs.ui.stepper.new("stepper1"; This.form)
Form.myStepper.isRunning()
```

## <a name="Constructor">cs.stepper.new()</a>

**cs.stepper.new** ( *name* : Text ; *parent* : Object ) : `cs.stepper`<br>
**cs.stepper.new** ( *name* : Text ) : `cs.stepper`<br>
**cs.stepper.new** ( ) : `cs.stepper`

|Parameter|Type||Description|
|---|---|---|---|
| name | Text | → | Widget name |
| parent | **cs**.form | → | `form` object containing the widget |
| result | **cs**.stepper | ← | New `cs.stepper`

### Description

`cs.stepper.new()` creates & returns a new instance of the class.

* If the `name` parameter is omitted, the constructor uses the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_).

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

## <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ |
|.**start**(*show* : `Boolean`) →`cs.stepper` | Starts the stepper and optionally shows it |
|.**stop**(*hide* : `Boolean`) →`cs.stepper` | Stops the stepper and optionally hides it |
|.**isRunning**() →`Boolean` | Returns **True** when the stepper is active |
