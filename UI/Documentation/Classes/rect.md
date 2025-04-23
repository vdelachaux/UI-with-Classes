# rect

The `rect` class provides an interface for manipulating the → of a widget.

This class is available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

<br><hr><br>
📌 <b>Conventions</b>

To simplify the distinction between form objects and object type, this documentation uses the term *widget* for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).

<hr><br>

## <a name="Constructor">cs.rect.new()</a>

**cs.rect.new**( *widget* : Object ) : `cs.rect`<br>
**cs.rect.new** ( *name* : Text ) : `cs.rect`<br>
**cs.rect.new** ( *width* : Integer; *height* : Integer ) : `cs.rect`<br>
**cs.rect.new** ( ) : `cs.rect`

|Parameter|Type||Description|
|---|---|---|---|
| widget | Object | → | A widget class object like `cs.static`, `cs.input`, `cs.button`… |
| name | Text | → | A name of a *widget* |
| width<br>height| Integer | → | Sizes in pixels, in the form coordinate system\*.|
| result | **cs**.rect | ← | New `cs.rect`

\* Origin is top left corner of current form

### Description

`cs.rect.new()` creates & returns a new instance of the class.
 
* If the `widget` or `name` parameter is passed, the `width` & `height` of the `widget` in the form coordinate system\* are retrieved & used as stored sizes.
* If parameters `width` and `height` are passed, these are the stored sizes.
* If no parameter is given, all sizes are initialized with a value of 0.

# Summary

## <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|**.height**<br>**.width**| Height & width, in pixels | `Integer` |<font color="red">x</font>

## <a name="Functions">Functions</a>

| Functions | Action |
|:-------- |:------ | 
|.**area** ( ) | Returns the area |
|.**perimeter** ( ) | Returns the perimeter |
