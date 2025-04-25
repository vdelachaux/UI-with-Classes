# static

The `static` class provides an interface to manage properties and actions common to all widgets, and is the parent class of all form widget UI classes

The `static` class is available via the [`form`](form.md#objects) class through the `Static` interface.

#### Example

```4d
This.form:=cs.form.new(This)
...
This.myWidget:=This.form.Static("form object")
...
This.myWidget.hide()
```

This class is, more generally, available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

#### Example

```4d
Form.myWidget:=cs.ui.static.new("form object")
Form.myWidget.hide()
```

<hr>

ℹ️ <b>Conventions</b>

1. To simplify the distinction between form objects and object type, this documentation uses the term “widget” for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).
2. All functions that return `This` return the current widget object and can include one call after another. 

<hr>

## <a name="Constructor"> cs.static.new()</a>

**cs.static.new** ( *name* : Text) : `cs.static`<br>
**cs.static.new** ( *name* : Text ; *parent* : Object) : `cs.static`<br>
**cs.static.new** ( ) : `cs.static`

|Parameter|Type||Description|
|---|---|---|---|
| name | Text | → | Widget name |
| parent | **cs**.form |→ | `form` object containing the widget |
| result | **cs**.static | ← | New `cs.static`

### Description

`cs.static.new()` creates & returns a new instance of the class.
 
* The optional `parent` parameter is the [`cs.form`](form.md) object containing the widget. This parameter is automatically set if instantiation is performed via a [form widget instantiation function](form.md#objects) of the `cs.form` class.
* If the `name` parameter is ommited, the constructor use the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_ )

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

## <a name="Inherited">Properties & Functions</a>

### <a name="Properties">General</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|**.class** | List of space-separated words used as class selectors| `Text` <br>See [Style sheets documentation](https://developer.4d.com/docs/FormEditor/stylesheets)|<font color="red">x</font>
|**.initialPosition**| The widget's coordinates on instantiation| [`cs.coordinates`](coordinates.md)|<font color="red">x</font>
|**.name**                        | The name of the widget | `Text`|<font color="red">x</font>
|**.title** | The title of the widget \**  |`Text`|<font color="green">✓</font>
|**.type** | The type of the widget<br>Use the [Form object Types](https://doc.4d.com/4Dv18R6/4D/18-R6/Form-Object-Types.302-5199153.en.html) constant theme | `Integer` |<font color="red">x</font>

| Functions | Action |
|:-------- |:------ | 
|.**setTitle** ( *title* : Text ) →`This`| To change the title of the widget (if the title is a `resname`, the localization is performed) \** |
  
\** Can be applied to a static text and will be avalaible for the inherited classes (buttons, check boxes, radio buttons, …)

### <a name="Dimensions">Coordinates & Sizing</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|.**bottom**| The bottom position of the widget |`Integer`|<font color="green">✓</font>
|.**coordinates** | The coordinates of the widget|[`cs.coordinates`](coordinates.md)|<font color="green">✓</font>
|.**height**| The height of the widget |`Integer`|<font color="green">✓</font>
|.**horizontallyMovable** | Can the widget be moved horizontally |`Boolean`|<font color="green">✓</font>
|.**horizontallyResizable** | Can the widget be resized horizontally |`Boolean`|<font color="green">✓</font>
|.**left**| The left position of the widget |`Integer`|<font color="green">✓</font>
|.**rect**| The dimensions of the widget |[`cs.rect`](rect.md)|<font color="green">✓</font>
|.**resizingOptions** | The current resizing options for the widget<br>as an object {`horizontal`,`vertical`} |`Object`|<font color="red">x</font>
|.**right**| The right position of the widget |`Integer`|<font color="green">✓</font>
|.**top**| The top position of the widget |`Integer`|<font color="green">✓</font>
|.**verticallyResizable** | Can the widget be resized vertically  |`Boolean`|<font color="green">✓</font>
|.**verticallyMovable** | Can the widget be moved vertically  |`Boolean`|<font color="green">✓</font>
|.**width**| The width of the widget |`Integer`|<font color="green">✓</font>
|.**windowCoordinates**| The coordinates of the widget in the current window <br>as an object {`left`,`top`,`right`,`bottom`} |`Object`|<font color="red">x</font>

| Functions | Action |
|:-------- |:------ | 
|.**backupCoordinates** () →`This` | Updates `initialPosition` with the widget's current coordinates \*  |
|.**bestSize** (*alignement* {; *minWidth* {; *maxWidth*}}) →`This`<br>.**bestSize** ({*options*:`Object`}) →`This`  | Set the size of the widget to its best width according to its content <br>(e.g. a localized string) \* |
|.**bestHeight** ({*width*}) →`This` | Set the size of the widget to its best height according to its content <br>(e.g. a localized string) \* |
|.**getCoordinates** () →`Object` | Returns the widget's updated coordinates \* |
|.**getBestWidth** ({*maxWidth*}) → `Integer` | Returns the best width of the widget according to its content <br>(e.g. a localized string) \* |
|.**getBestHeight** ({*maxWidth*}) → `Integer` | Returns the best height of the widget according to its content <br>(e.g. a localized string) \* |
|.**moveAndResizeHorizontally** (*offset*; *resize*) →`This` | To move and resize the widget horizontally \*  |
|.**moveAndResizeVertically** (*offset*; *resize*) →`This` | To move and resize the widget vertically \*  |
|.**moveDown** (*offset*) →`This` | To move the widget down \*  |
|.**moveHorizontally** (*offset*) →`This` | To move the widget horizontally \*  |
|.**moveLeft** (*offset*) →`This` | To move the widget to the left \*  |
|.**moveRight** (*offset*) →`This` | To move the widget to the right \*  |
|.**moveUp** (*offset*) →`This` | To move the widget up \*  |
|.**moveVertically** (*offset*) →`This` | To move the widget vertically \*  |
|.**resize** (*offset*) →`This` | To resize the widget horizontally & vertically \*  |
|.**resizeHorizontally** (*offset*) →`This` | To resize the widget horizontally \*  |
|.**resizeVertically** (*offset*) →`This` | To resize the widget vertically \*  |
|.**restorePosition** () | Sets the widget coordinates with the contents of `initialPosition` \*  |
|.**setCoordinates** (*left*; *top* {; *right*; *bottom* }) →`This`<br>.**setCoordinates** (*coordinates*:`Object`) →`This` | To modifies the coordinates and, optionally, the size of the widget \* |
|.**setHeight** (*height*) →`This` | To modify the widget height \*  |
|.**setRect** (*width* {; *height* }) →`This` | To modify the widget width & height \*  |
|.**setWidth** (*width*) →`This` | To modify the widget width \*  |
|.**setResizingOptions** (*horizontal* {; *vertical* }) →`This` | Modifies the resizing options for the widget |
|.**updateCoordinates** ({*left*; *top*; *right*; *bottom* })   →`This` | To force update of properties:<br>  - `coordinates`<br>  - `rect`<br>  - `windowCoordinates`<br>with the passed values or the current widget coordinates if omitted.|
    
\* Automatically update the `coordinates`, `rect` and `windowCoordinates` properties.  

### <a name="Entry">Entry</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|.**disabled**| Is the widget disabled |`Boolean `|<font color="green">✓</font>
|.**enabled**| Is the widget enabled |`Boolean`|<font color="green">✓</font>

| Functions | Action |
|:-------- |:------ | 
|.**disable** () →`This` | To disable the widget |
|.**enable** ({*state* }) →`This` | To enable (no parameter) or disable (`state` = **False**) the widget |

### <a name="Display">Display</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|.**format**| The [display format](https://developer.4d.com/docs/commands/object-get-format) of the widget |`Text`|<font color="green">✓</font>
|.**hidden**| Is the widget hidden |`Boolean `|<font color="green">✓</font>
|.**visible**| Is the widget visible |`Boolean `|<font color="green">✓</font>

| Functions | Action |
|:-------- |:------ | 
|.**hide** () →`This` | Hides the widget |
|.**show** ( {*state* }) →`This` | Makes the widget visible (no parameter) or invisible (`state` = **False**) | 
|.**setFormat** (*format* ) →`This` | Sets the [display format](https://developer.4d.com/docs/commands/object-set-format) of the widget |
|.[**setPicture**](#setPicture) (*proxy* ) →`This` | Defines the image associated with: `3D button`, `picture button`, `picture popup menu`, `listbox header` or `static picture`.<br>Clears the associated image if proxy is empty |

### <a name="Colors">Colors</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|.**altBackgroundColor**| The alternating background color of the widget|`Variant`|<font color="green">✓</font>
|.**backgroundColor**| The backgound color of the widget |`Variant`|<font color="green">✓</font>
|.**colors**| The colors of the widget as object <br> {foreground,background,altBackground} |`Object`|<font color="green">✓</font>
|.**foregroundColor**| The foreground color of the widget |`Variant`|<font color="green">✓</font>

| Functions | Action |
|:-------- |:------ | 
|.**removeAltBackgroundColor** ()  | Removes widget alternating background color | 
|.**removeBackgroundColor** ()  | Removes widget background color | 
|.**restoreAltBackgroundColor** ()  | Restores the widget alternating background color set in structure | 
|.**restoreBackgroundColor** ()  | Restores the widget background color set in structure | 
|.**restoreForegroundColor** ()  | Restores the widget foreground color set in structure | 
|.**setColors** (*background* {; *altBackground* }) →`This` | Sets the widget's colors | 

### <a name="Text">Text</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|.**font**| The name of the character font used by the widget |`Text`|<font color="green">✓</font>
|.**fontSize**| The font size used by the widget |`Integer`|<font color="green">✓</font>
|.**fontStyle**| The font style used by the widget<br>Use the predefined constants, placed in the "Font Styles" theme |`Integer`|<font color="green">✓</font>
|.**horizontalAlignment**| The type of horizontal alignment applied to the widget |`Integer`|<font color="green">✓</font>
|.**verticalAlignment**| The type of vertical alignment applied to the widget |`Integer`|<font color="green">✓</font>

| Functions | Action |
|:-------- |:------ | 
|.**alignLeft** () →`This` | Sets horizontal alignment of widget to left | 
|.**alignRight** () →`This` | Sets horizontal alignment of widget to right | 
|.**alignTop** () →`This` | Sets vertical alignment of widget to top | 
|.**alignBottom** () →`This` | Sets vertical alignment of widget to bottom | 
|.**alignCenter** (*vertical* ) →`This` | Sets the widget's horizontal or vertical alignment (if `vertical` = **True**) to centered. | 
|.**setFont** (*fontName* ) →`This` | Defines the fonts used by the widget to display text. If `fontName` is omitted, empty or equal to “default” or “system”, the default system font is used. | 
|.**setFontStyle** (*style* ) →`This` | Defines the fonts style used by the widget to display text.<br>Use the predefined constants, placed in the "Font Styles" theme. | 

### <a name="Miscellaneous">Miscellaneous</a>

| Functions | Action |
|:-------- |:------ | 
|.**addToGroup** (*group* ) →`This` | Adds this widget to a group. | 
|.**hiddenFromView** () →`This` | Sets the widget's coordinates so that it is outside the viewing window. | 
|.**jsonFormDefinition** () →`Object` | Returns the json widget definition as defined in the structure.<br>⚠️ Only available if the `parent` parameter has been passed to the constructor when using from a component.| 

## <a name="setPicture">.setPicture()</a>

.**setPicture** ({ *proxy* })

|Parameter|Type||Description|
|---|---|---|---|
| proxy | Text | → | proxy picture |
| result | `This`| ← | Current widget object |

### Description

This function is intended to set the image of the compatible `3D button`, `3D checkbox`, `3D radio button`, `picture button`, `picture popup menu`, `listbox header` or `static picture`.

Possible values for the `proxy` parameter are:

* The string `#{folder/}picturename` or `file:{folder/}picturename` if the picture comes from a file stored in the `Resources` folder
* A variable name if the picture comes from a `picture variable`

If the `proxy` parameter is omitted, the picture is removed



