# button

The `button` class provides an interface to manage properties and actions of [button](https://developer.4d.com/docs/20/FormObjects/buttonOverview) widget.

<hr>

ℹ️ <b>Important</b>

1. This class inherit from the [`widget`](widget.md) class
2. To simplify the distinction between form objects and object type, this documentation uses the term `widget` for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).
3. All functions that return `This` may include one call after another. 

<hr>

The `button` class is available via the [`form`](form.md#objects) class through the `Button` interface.

#### Example

```4d
This.form:=cs.form.new(This)
...
This.myButton:=This.form.Button("button1")
...
This.myButton.disable()
```

This class is, more generally, available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

#### Example

```4d
Form.myButton:=cs.ui.button.new("button")
Form.myButton.enable()
```

## <a name="Constructor">cs.button.new()</a>

**cs.button.new** ( *name* : Text) : `cs.button `<br>
**cs.button.new** ( *name* : Text ; *parent* : Object) : `cs.button`<br>
**cs.button.new** ( ) : `cs.button`

|Parameter|Type||Description|
|---|---|---|---|
| name | Text | → | Widget name |
| parent | **cs**.form | → | `form` object containing the *widget* |
| result | **cs**.button | ← | New `cs.button`

### Description

`cs.button.new()` creates & returns a new instance of the class.
 
* Where relevant, the constructor defines the height of the button to suit the system's interface rules.<br>The width can also be adapted to ensure correct label display and a better user experience, particularly for checkboxes and radio buttons.
* The optional `parent` parameter is the [`cs.form`](form.md) object containing the *widget*. This parameter is automatically set if instantiation is performed via a [form widget instantiation function](form.md#objects) of the `cs.form` class.
* If the `name` parameter is ommited, the constructor use the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_ )

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

## <a name="Inherited">Properties & Functions</a>

Inherited properties and functions are described in the parent classes:

* [static class](static.md)
* [widget class](widget.md)

### <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|.**backgroundPicture** | Associated background picture proxy  | `Text` | <font color="green">✓</font>
|.**horizontalMargin** | Number of pixels delimiting the inside left and right margins of the button | `Integer` | <font color="green">✓</font>
|.**linkedPopupMenu** | With linked pop-up menu (**False** = no associated menu)  | `Boolean` | <font color="green">✓</font>
|.**numStates** | Number of states present in picture used as icon for the button  | `Integer` | <font color="green">✓</font>
|.**picture** | Associated picture proxy  | `Text` | <font color="green">✓</font>
|.**separatePopupMenu** | With separate pop-up menu (**False** = no associated menu)  | `Boolean` | <font color="green">✓</font>
|.**style** | Button style\*  | `Integer` | <font color="green">✓</font>
|.**styleName** | The current button style name\*  | `Text` | <font color="red">x</font>

### <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ | 
|.**highlightShortcut** ( ) →`This` | Underlines the first uppercase letter of the title corresponding to the keyboard shortcut. If not found, the first lowercase letter, if any<br>📌 Automatically called when you use the .**setShortcut**() function.
|.**is3DButton** ( ) →`This` | Returns **True** if the current button is a 3D button
|.**setBackgroundPicture** (*proxy* : `Text`) →`This` | Sets the background picture (deletes it if the `proxy` parameter is omitted)
|.**setLinkedPopupMenu** () →`This` | Sets the button to display and manage a linked pop-up menu
|.**setNoPopupMenu** () →`This` | Removes associated pop-up menu
|.**setNumStates** (*state* : `Integer`) →`This` | Sets number of states present in picture (restore to 4 if no parameter)
|.**setPicture** ( *proxy* : `Text` ) →`This` | Sets the associated picture (deletes it if the `proxy` parameter is omitted)
|.**setSeparatePopupMenu** () →`This` | Sets the button to display and manage a separate pop-up menu\*
|.**setStyle** (*style* : `Integer`) →`This` | Defines button style\*\*

\* Adding or deleting a linked or associated menu automatically activates/deactivates the object's form event <u>On Alternative Click</u> of the widget. 
<br>\*\* The following style values are possible:
>style = 0: None (default)<br>style = 1: Background offset<br>style = 2: Push button<br>style = 3: Toolbar button<br>style = 4: Custom<br>style = 5: Circle<br>style = 6: Small system square<br>style = 7: Office XP<br>style = 8: Bevel<br>style = 9: Rounded bevel<br>style = 10: Collapse/Expand<br>style = 11: Help<br>style = 12: OS X Textured<br>style = 13: OS X Gradient
	

