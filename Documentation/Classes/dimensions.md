# dimensions

The `dimensions` class provides an interface for manipulating width and height values of a widget.

This class is available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

<hr>

## <a name="Constructor">cs.dimensions.new()</a>

**cs.dimensions.new**( *widget* : Object ) : `cs.dimensions`<br>
**cs.dimensions.new**( *name* : Text ) : `cs.dimensions`<br>
**cs.dimensions.new**( *width* : Integer; *height* : Integer ) : `cs.dimensions`<br>
**cs.dimensions.new**() : `cs.dimensions`

|Parameter|Type||Description|
|---|---|---|---|
| widget | Object | → | A widget class object like `cs.static`, `cs.input`, `cs.button`... |
| name | Text | → | Widget name |
| width | Integer | → | Width in pixels |
| height | Integer | → | Height in pixels |
| result | **cs**.dimensions | ← | New `cs.dimensions` |

### Description

`cs.dimensions.new()` creates and returns a new class instance.

* If `widget` or `name` is passed, dimensions are read from the current object coordinates.
* If `width` and `height` are passed, they are used directly.
* If no parameter is passed, width and height default to 0.

## Properties

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:|
|**.width**| Width in pixels | `Integer` | <font color="green">✓</font>
|**.height**| Height in pixels | `Integer` | <font color="green">✓</font>

## Functions

| Functions | |
|:-------- |:------ |
|.**area**() → `Integer` | Returns `width * height` |
|.**perimeter**() → `Integer` | Returns `(width + height) * 2` |

## Compatibility Note

`cs.dimensions` is introduced as a transition companion to `cs.rect`.

* Existing `rect` APIs remain valid.
* Newer integrations may expose both `.rect` and `.dimensions` aliases for backward compatibility.
