# static

The `static` class is the parent class of all form widget classes.

<hr>
> 📌 **Conventions**: 
<br>      1. to simplify the distinction between form objects and object type, this documentation uses the term “widget” for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).
<br>      2. All functions that return **cs**.static may include one call after another. 
<br>
<hr>

#### This class is available via the [`form`](form.md#objects) class as `Static` interface.

```4d
This.form:=cs.form.new(This)
...
This.myWidget:=This.form.Static("form object")
...
This.myWidget.hide()
```

#### This class can also be instantiated on its own.

```4d
Form.myWidget:=cs.static.new("form object")
Form.myWidget.hide()
```

<br>**Note**: 📌 The `group` class can also refer to this class even if it's not inheritance

## <a name="Constructor"> Constructor </a>

The class constructor `cs.static.new({formObjectName {; parent }})` creates a new class instance.

>📌 The optional `parent` parameter is the **cs**.form object containing the widget. This parameter is automatically set if instantiation is performed via a [form widget instantiation function](form.md#objects) of the **cs**.form class.

If the `formObjectName` parameter is ommited, the constructor use the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_ )

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

#Summary

## <a name="Properties">General</a>

> 📌 Other properties are described below in the section devoted to them.

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|**.class** | List of space-separated words used as class selectors| `Text` <br>See [Style sheets documentation](https://developer.4d.com/docs/FormEditor/stylesheets)|<font color="red">x</font>
|**.initialPosition**| The widget's coordinates on instantiation| `Object`|<font color="red">x</font>
|**.name**                        | The name of the widget | `Text`|<font color="red">x</font>
|**.title** | The title of the widget \**  |`Text`|<font color="green">✓</font>
|**.type** | The type of the widget<br>Use the [Form object Types](https://doc.4d.com/4Dv18R6/4D/18-R6/Form-Object-Types.302-5199153.en.html) constant theme | `Integer` |<font color="red">x</font>

| Functions | Action |
|:-------- |:------ | 
|.**setTitle** (title) → **cs**.static| To change the title of the widget (if the title is a `resname`, the localization is performed) \** |
  
\** Can be applied to a static text and will be avalaible for the inherited classes (buttons, check boxes, radio buttons, …)

## <a name="Dimensions">Coordinates & Sizing</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|.**bottom**| The bottom position of the widget |`Integer`|<font color="green">✓</font>
|.**coordinates** | The coordinates of the widget in the form as a [**cs**.coord](coord.md) object|`Object`|<font color="green">✓</font>
|.**dimensions**| The dimensions of the widget <br>as an object {`width`,`height`} |`Object`|<font color="green">✓</font>
|.**horizontallyMovable** | Can the widget be moved horizontally |`Boolean`|<font color="green">✓</font>
|.**horizontallyResizable** | Can the widget be resized horizontally |`Boolean`|<font color="green">✓</font>
|.**left**| The left position of the widget |`Integer`|<font color="green">✓</font>
|.**resizingOptions** | The current resizing options for the widget<br>as an object {`horizontal`,`vertical`} |`Object`|<font color="red">x</font>
|.**right**| The right position of the widget |`Integer`|<font color="green">✓</font>
|.**top**| The top position of the widget |`Integer`|<font color="green">✓</font>
|.**verticallyResizable** | Can the widget be resized vertically  |`Boolean`|<font color="green">✓</font>
|.**verticallyMovable** | Can the widget be moved vertically  |`Boolean`|<font color="green">✓</font>
|.**width**<br>.**height**| The dimensions of the widget |`Integer`|<font color="green">✓</font>
|.**windowCoordinates**| The coordinates of the widget in the current window <br>as an object {`left`,`top`,`right`,`bottom`} |`Object`|<font color="red">x</font>

| Functions | Action |
|:-------- |:------ | 
|.**setCoordinates** (left; top {; right; bottom}) → **cs**.static<br>.**setCoordinates** (coordinates`:Object`) → **cs**.static | To modifies the coordinates and, optionally, the size of the widget \* |
|.**bestSize** (alignement {; minWidth {; maxWidth}}) → **cs**.static<br>.**bestSize** ({options`:Object`}) → **cs**.static  | Set the size of the widget to its best width according to its content (e.g. a localized string) \* |
|.**bestHeight** ({ width}) → **cs**.static | Set the size of the widget to its best height according to its content (e.g. a localized string) \* |
|.**getBestWidth** ({maxWidth}) → `Integer` | Returns the best width of the widget according to its content (e.g. a localized string) \* |
|.**getBestHeight** ({maxWidth}) → `Integer` | Returns the best height of the widget according to its content (e.g. a localized string) \* |
|.**moveHorizontally** (offset) → **cs**.static | To move the widget horizontally \*  |
|.**moveLeft** (offset) → **cs**.static | To move the widget to the left \*  |
|.**moveRight** (offset) → **cs**.static | To move the widget to the right \*  |
|.**moveVertically** (offset) → **cs**.static | To move the widget vertically \*  |
|.**moveUp** (offset) → **cs**.static | To move the widget up \*  |
|.**moveDown** (offset) → **cs**.static | To move the widget down \*  |
|.**resizeHorizontally** (offset) → **cs**.static | To resize the widget horizontally \*  |
|.**resizeVertically** (offset) → **cs**.static | To resize the widget vertically \*  |
|.**resize** (offset) → **cs**.static | To resize the widget horizontally & vertically \*  |
|.**moveAndResizeHorizontally** (offset;resize) → **cs**.static | To move and resize the widget horizontally \*  |
|.**moveAndResizeVertically** (offset;resize) → **cs**.static | To move and resize the widget vertically \*  |
|.**setDimension** (width ;{ height}) → **cs**.static | To modify the widget width & height \*  |
|.**restorePosition** () | Sets the widget coordinates with the contents of .**initialPosition** \*  |
|.**backupCoordinates** () → **cs**.static | Updates .**initialPosition** with the widget's current coordinates \*  |
|.**setHeight** (height) → **cs**.static | To modify the widget height \*  |
|.**setWidth** (width ) → **cs**.static | To modify the widget width \*  |
|.**setResizingOptions** (horizontal {; vertical})) → **cs**.static | Modifies the resizing options for the widget |
|.**updateCoordinates** (left; top; right; bottom)   → **cs**.static | To force update of `coordinates`, `dimensions` & `windowCoordinates` properties. |
|.**getCoordinates** () →`Object` | Returns the widget's updated coordinates \* |
    
\* Automatically update the `coordinates`, `dimensions` and `windowCoordinates` properties.  

## <a name="Entry">Entry</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|.**disabled**| Is the widget disabled |`Boolean `|<font color="green">✓</font>
|.**enabled**| Is the widget enabled |`Boolean`|<font color="green">✓</font>

| Functions | Action |
|:-------- |:------ | 
|.**disable** () → **cs**.static | To disable the widget |
|.**enable** ({state}) → **cs**.static | To enable (no parameter) or disable (`state` = **False**) the widget |

## <a name="Display">Display</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|.**format**| The [display format](https://developer.4d.com/docs/commands/object-get-format) of the widget |`Text`|<font color="green">✓</font>
|.**hidden**| Is the widget hidden |`Boolean `|<font color="green">✓</font>
|.**visible**| Is the widget visible |`Boolean `|<font color="green">✓</font>

| Functions | Action |
|:-------- |:------ | 
|.**hide** () → **cs**.static | Hides the widget |
|.**show** ({state}) → **cs**.static | Makes the widget visible (no parameter) or invisible (`state` = **False**) | 
|.**setFormat** (format) → **cs**.static | Sets the [display format](https://developer.4d.com/docs/commands/object-set-format) of the widget |
|.**setPicture** (proxy) → **cs**.static | Defines the image associated with:<br> `3D button`, `picture button`, `picture popup menu`, `listbox header` or `static picture`.<br>Clears the associated image if proxy is empty |

## <a name="Colors">Colors</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|.**altBackgroundColor**| The alternating background color of the widget|`Variant`|<font color="green">✓</font>
|.**backgroundColor**| The backgound color of the widget |`Variant`|<font color="green">✓</font>
|.**colors**| The colors of the widget as object <br> {foreground,background,altBackground} |`Object`|<font color="green">✓</font>
|.**foregroundColor**| The foreground color of the widget |`Variant`|<font color="green">✓</font>

| Functions | Action |
|:-------- |:------ | 
|.**removeBackgroundColor** ()  | Removes widget background color | 
|.**restoreBackgroundColor** ()  | Restores the widget background color set in structure | 
|.**restoreForegroundColor** ()  | Restores the widget foreground color set in structure | 
|.**setColors** (foreground; background ; altBackground) → **cs**.static | Sets the widget's colors | 

## <a name="Text">Text</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|.**font**| The name of the character font used by the widget |`Text`|<font color="green">✓</font>
|.**fontSize**| The font size used by the widget |`Integer`|<font color="green">✓</font>
|.**fontStyle**| The font style used by the widget<br>Use the predefined constants, placed in the "Font Styles" theme |`Integer`|<font color="green">✓</font>
|.**horizontalAlignment**| The type of horizontal alignment applied to the widget |`Integer`|<font color="green">✓</font>
|.**verticalAlignment**| The type of vertical alignment applied to the widget |`Integer`|<font color="green">✓</font>

| Functions | Action |
|:-------- |:------ | 
|.**alignLeft** () → **cs**.static | Sets horizontal alignment of widget to left | 
|.**alignRight** () → **cs**.static | Sets horizontal alignment of widget to right | 
|.**alignTop** () → **cs**.static | Sets vertical alignment of widget to top | 
|.**alignBottom** () → **cs**.static | Sets vertical alignment of widget to bottom | 
|.**alignCenter** (vertical) → **cs**.static | Sets the widget's horizontal or vertical alignment (if `vertical` = **True**) to centered. | 
|.**setFont** (fontName) → **cs**.static | Defines the fonts used by the widget to display text.<br>If `fontName` is omitted, empty or equal to “default” or “system”, the default system font is used. | 
|.**setFontStyle** (stryle) → **cs**.static | Defines the fonts style used by the widget to display text.<br>Use the predefined constants, placed in the "Font Styles" theme. | 

## <a name="Miscellaneous">Miscellaneous</a>

| Functions | Action |
|:-------- |:------ | 
|.**addToGroup** (**cs**.group) → **cs**.static | Adds this widget to a group. | 
|.**hiddenFromView** () → **cs**.static | Sets the widget's coordinates so that it is outside the viewing window. | 
|.**jsonFormDefinition** () → `Object` | Returns the json widget definition as defined in the structure.<br>⚠️ Only available if the `parent` parameter has been passed to the constructor.| 

## 🔹 .setPicture()
.**setPicture** ({ proxy: `Text`} ) →`cs.widget`

This function is intended to set the image of the compatible `3D button`, `3D checkbox`, `3D radio button`, `picture button`, `picture popup menu`, `listbox header` or `static picture`.

Possible values for the `proxy` parameter are:

* The string `#{folder/}picturename` or `file:{folder/}picturename` if the picture comes from a file stored in the `Resources` folder
* A variable name if the picture comes from a `picture variable`

If the `proxy` parameter is omitted, the picture is removed
