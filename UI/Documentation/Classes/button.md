# button

The `button` class is intended to manage button widgets.  

<hr>
📌 <b> Important </b>

1. This class inherit from the [`widget`](widget.md) class
2. All functions that return **cs**.button may include one call after another. 

<hr><br>

#### This class is available via the [`form`](form.md#objects) class as `Button` interface.

```4d
This.form:=cs.form.new(This)
...
This.myButton:=This.form.Button("Button 10")
...
This.myButton.disable()
```

#### This class can also be instantiated on its own.

```4d
Form.myButton:=cs.button.new("Button 10")
Form.myButton.disable()
```

## <a name="Constructor"> Constructor </a>

The class constructor `cs.button.new({formObjectName {; parent }})` creates a new class instance.

Where relevant, the constructor defines the height of the button to suit the system's interface rules.<br>The width can also be adapted to ensure correct label display and a better user experience, particularly for checkboxes and radio buttons.

>📌 The optional `parent` parameter is the **cs**.form object containing the widget. This parameter is automatically set if instantiation is performed via a [form widget instantiation function](form.md#objects) of the **cs**.form class.

If the `formObjectName` parameter is ommited, the constructor use the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_ )

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

#Summary

## <a name="Inherited">Inherited Properties & Functions</a>

Inherited properties and functions are described in the parent classes:

* [`static` class](static.md)
* [`widget` class](widget.md)

## <a name="Properties">Properties</a>

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

## <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ | 
|.**highlightShortcut** ( ) →`cs.button` | Underlines the first uppercase letter of the title corresponding to the keyboard shortcut. If not found, the first lowercase letter, if any<br>📌 Automatically called when you use the .**setShortcut**() function.
|.**is3DButton** ( style ) →`cs.button` | Returns **True** if the current button is a 3D button
|.**setBackgroundPicture** ( proxy ) →`cs.button` | Sets the background picture (deletes it if the `proxy` parameter is omitted)
|.**setLinkedPopupMenu** () →`cs.button` | Sets the button to display and manage a linked pop-up menu
|.**setNoPopupMenu** () →`cs.button` | Removes associated pop-up menu
|.**setNumStates** ( state ) →`cs.button` | Sets number of states present in picture (restore to 4 if no parameter)
|.**setPicture** ( proxy ) →`cs.button` | Sets the associated picture (deletes it if the `proxy` parameter is omitted)
|.**setSeparatePopupMenu** () →`cs.button` | Sets the button to display and manage a separate pop-up menu
|.**setStyle** ( style ) →`cs.button` | Defines button style\*

<hr>
> 📌 Adding or deleting a linked or associated menu automatically activates/deactivates the object's form event of the `On Alternative Click`. 
<br>

\* The following style values are possible:
>style = 0: None (default)<br>style = 1: Background offset<br>style = 2: Push button<br>style = 3: Toolbar button<br>style = 4: Custom<br>style = 5: Circle<br>style = 6: Small system square<br>style = 7: Office XP<br>style = 8: Bevel<br>style = 9: Rounded bevel<br>style = 10: Collapse/Expand<br>style = 11: Help<br>style = 12: OS X Textured<br>style = 13: OS X Gradient
	


