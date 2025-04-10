# colors

The `colors` class provides an interface for manipulating the colors of a widget.

This class is available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

<hr>
📌 <b>Important</b>

1. To simplify the distinction between form objects and object type, this documentation uses the term *widget* for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).
2. All functions that return `cs.colors` return the current widget object and can include one call after another. 

<hr>

## <a name="Constructor">cs.colors.new()</a>

**cs.colors.new**( {*foreground* : Text | Integer {; *background* : Text | Integer {; *altBackground* : Text | Integer }}}) : `cs.colors`<br>

|Parameter|Type||Description|
|---|---|---|---|
| foreground | Text \| Integer | → | The color to store as foreground color |
| background | Text \| Integer | → | The color to store as background color\* |
| altBackground | Text \| Integer | → | The color to store as alternative background color\** |
| result | cs.colors | ← | New `cs.colors`

<br>\* This parameter is only to be use with [objects supporting the background color attribute](https://developer.4d.com/docs/FormObjects/propertiesBackgroundAndBorder#background-color--fill-color).
<br>\** This parameter is only to be use with a list box or a column of the list box.

### Description

`cs.colors.new()` creates & returns a new instance of the class.
 
* If the `foreground`, `background` or `altBackground` parameters are omitted, their values are initialized to _Foreground color_ for the first and _Background color_ for the others.

# Summary

## <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|**.altBackground**| The alternative background color | `Text` \| `Integer` |<font color="green">✓</font>
|**.background**| The background color | `Text` \| `Integer` |<font color="green">✓</font>
|**.colors** | The stored colors as object<br>`{foreground,background,altBackground}`| `Object` |<font color="green">✓</font>
|**.foreground**| The foreground color | `Text` \| `Integer` |<font color="green">✓</font>

## <a name="Functions">Functions</a>

| Functions | Action |
|:-------- |:------ | 
|[.**apply** ( *target* )](#apply) | Apply stored colors to a widget |
|.**removeAltBackgroundColor**( ) → `cs.colors` | Sets the alternative background color to _Background color none_ |
|.**removeBackgroundColor**( ) → `cs.colors` | Sets the background color to _Background color none_ |
|.**restoreAltBackgroundColor**( ) → `cs.colors` | Sets the alternative background color to _Background color_ |
|.**restoreBackgroundColor**( ) → `cs.colors` | Sets the background color to _Background color_ |
|.**restoreForegroundColor**( ) → `cs.colors` | Sets the background color to _Foreground color_ |

# <a name="apply">.apply()</a>

.**apply** ({*target*})

|Parameter|Type||Description|
|---|---|---|---|
| target | Object \| Text | → | widget object or widget name |

### Description

Sets widget colors to current colors.
 
* Target could be a *widget* object or a *widget* name.
