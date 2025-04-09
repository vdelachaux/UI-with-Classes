# dimensions

The `dimensions` class provides an interface for manipulating the dimensions of a widget.

This class is available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

<br><hr><br>
📌 <b>Conventions</b>

To simplify the distinction between form objects and object type, this documentation uses the term *widget* for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).

<hr><br>

## <a name="Constructor">cs.dimensions.new()</a>

**cs.dimensions.new**( *widget* : Object ) : `cs.dimensions`<br>
**cs.dimensions.new** ( *name* : Text ) : `cs.dimensions`<br>
**cs.dimensions.new** ( *width* : Integer; *height* : Integer ) : `cs.dimensions`<br>
**cs.dimensions.new** ( ) : `cs.dimensions`

|Parameter|Type||Description|
|---|---|---|---|
| widget | Object | -> | A widget class object like `cs.static`, `cs.input`, `cs.button`… |
| name | Text | -> | A name of a *widget* |
| width<br>height| Integer | -> | Sizes in pixels, in the form coordinate system\*.|
| result | cs.dimensions | <- | New `cs.dimensions`

\* Origin is top left corner of current form

### Description

`cs.dimensions.new()` creates & returns a new instance of the class.
 
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
