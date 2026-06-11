# picture

The `picture` class provides an interface to manage picture widgets and images.

<hr>

ℹ️ <b>Important</b>

1. This class inherits from the [`scrollable`](scrollable.md) class
2. All functions that return `This` may include one call after another.
3. To simplify the distinction between form objects and object type, this documentation uses the term `widget` for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).

<hr>

This class is available via the [`form`](form.md#objects) class through the `Picture` interface.

#### Example

```4d
This.form:=cs.form.new(This)
...
This.myPicture:=This.form.Picture("picture1")
...
This.myPicture.thumbnail(120; 90)
```

This class is also available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

#### Example

```4d
Form.myPicture:=cs.ui.picture.new("picture1"; Null; This.form)
Form.myPicture.read($file)
```

## <a name="Constructor">cs.picture.new()</a>

**cs.picture.new** ( *name* : Text ; *data* ; *parent* : Object ) : `cs.picture`<br>
**cs.picture.new** ( *name* : Text ) : `cs.picture`<br>
**cs.picture.new** ( ) : `cs.picture`

|Parameter|Type||Description|
|---|---|---|---|
| name | Text | → | Widget name |
| data | `Picture` \\ `Object` | → | Picture data or a `File` object to read |
| parent | **cs**.form | → | `form` object containing the widget |
| result | **cs**.picture | ← | New `cs.picture`

### Description

`cs.picture.new()` creates & returns a new instance of the class.

* If the `name` parameter is omitted, the constructor uses the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_).
* The constructor also accepts picture data or a `File` object. If a `File` object is passed, the image is read from disk.

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

## <a name="Inherited">Properties & Functions</a>

Inherited properties and functions are described in the parent classes:

* [static class](static.md)
* [widget class](widget.md)
* [scrollable class](scrollable.md)

### <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:|
|**.fileName** | Name of the current image file | `Text` | <font color="red">x</font> |
|**.size** | Size of the current picture in bytes | `Integer` | <font color="red">x</font> |

### <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ |
|.**findByCoordinates**() →`Text` | Returns the SVG element ID located at the current mouse coordinates |
|.**getAttribute**(*id* : `Text`; *attribute* : `Text`; *type* : `Integer`) →`Variant` | Gets an SVG attribute value from the current picture |
|.**setAttributes**(*id* : `Text`; *attributes* : `Collection`) | Sets several SVG attributes at once |
|.**setAttribute**(*id* : `Text`; *name* : `Text`; *value*) | Sets a single SVG attribute |
|.**getCoordinates**() →`cs.coordinates` | Returns the widget coordinates and updates scrollbars and rect |
|.**getRect**() →`cs.rect` | Returns the picture rectangle from current image size |
|.**read**(*file* : `4D.File`) →`cs.picture` | Reads the picture from a file |
|.**thumbnail**(*width* : `Integer`; *height* : `Integer`; *mode* : `Integer`) →`cs.picture` | Generates and sets a thumbnail version of the image |
|.**getThumbnail**(*width* : `Integer`; *height* : `Integer`; *mode* : `Integer`) →`Picture` | Returns a picture thumbnail |
|.**horizontalConcatenation**(*file* : `4D.File`) →`cs.picture` | Adds an image to the right of the current one |
|.**verticalConcatenation**(*file* : `4D.File`) →`cs.picture` | Adds an image below the current one |
|.**superImposition**(*file* : `4D.File`; *horOffset* : `Integer`; *vertOffset* : `Integer`) →`cs.picture` | Superimposes another image onto the current one |

> 📌 Internal helper: `.__combine()` is used to merge images and is not typically called directly.
