# webArea

The `webArea` class provides an interface to manage properties and actions of webArea widget.

The `webArea` class is available via the [`form`](form.md#objects) class through the `WebArea` interface.

```4d
This.form:=cs.form.new(This)
...
This.myWidget:=This.form.WebArea("myWebArea")
...
This.myWidget.open(File("/RESOURCES/Index.html"))
```

This class is, more generally, available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

```4d
Form.myWidget:=cs.ui.webArea.new("form object")
Form.myWidget.open("https://4D.com")
```

<hr>
📌 <b>Conventions</b>

1. To simplify the distinction between form objects and object type, this documentation uses the term “*widget*” for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).
2. All functions that return `This` return the current widget object and can include one call after another. 

<hr>

## <a name="Constructor">cs.webArea.new()</a>

**cs.webArea.new** ( *name* : Text) : `cs.webArea`<br>
**cs.webArea.new** ( *name* : Text ; *data* : any) : `cs.webArea`<br>
**cs.webArea.new** ( *name* : Text ; *data* : any ; *parent* : Object) : `cs.webArea`<br>
**cs.webArea.new** ( ) : `cs.webArea`

|Parameter|Type||Description|
|---|---|---|---|
| name | Text | → | Widget name |
| data | Text | Collection | → | allowed URLs |
| parent | `cs.form` | → | `form` object containing the *widget* |
| result | cs.webArea |←| New `cs.webArea`

### Description

`cs.webArea.new()` creates & returns a new instance of the class.
 
* When the `webArea` *widget is instantiated without passing the `data` parameter, a default filter is installed allowing only blank HTML documents (`about:blank`). You can modify URL filtering with the [`.allow()`](#allow) & [`.deny()`](#deny) functions. 
* The optional `parent` parameter is the [`cs.form`](form.md) object containing the *widget*. This parameter is automatically set if instantiation is performed via a [form widget instantiation function](form.md#objects) of the `cs.form` class.
* If the `name` parameter is ommited, the constructor use the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_ )

<br>**Important**:
>  1. This class inherit from the [`widget`](widget.md) class
>  2. Omitting the widget name can only be used if the constructor is called from the object method.
>  3. The URL filtering applies to any request to change the primary URL of the page, whether from the user, javascript code or 4D code, except for the `.open()` function and URLs starting with "javascript:". To disable URL filtering, call the [`.allow()`](#allow) function, passing an empty string or the value `*`..

# Summary

## <a name="Inherited">Inherited Properties & Functions</a>

Inherited properties and functions are described in the parent classes:

* [`static` class](static.md)
* [`widget` class](widget.md)

## <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:| 
|**.canBackwards**| A previous URL is available in the URL sequence opened in tWeb area | `Boolena` |<font color="red">x</font> 
|**.canForwards**| A following URL is available in the URL sequence opened in tWeb area | `Boolena` |<font color="red">x</font>
|**.content**| HTML code of the page being displayed in the Web area | `Text`  |<font color="green">✓</font>\*
|**.errors**| Descriptions of errors encountered since class instantiation of the class | `Collection` |<font color="red">x</font>
|**.filterdURLs**| URLs that have been filtered in the Web zone since the instantiation of the class | `Collection` |<font color="red">x</font>
|**.lastError** | Description of the last error encountered if any | `Text` |<font color="red">x</font>
|**.loaded** | URL address of the page displayed in the Web area | `Text` |<font color="red">x</font>
|**.success** | Result of the last function execution | `Boolean` |<font color="red">x</font>
|**.url**| URL address of the page displayed in the Web area | `Text` \| `4D.File` |<font color="green">✓</font>

\* As security is tightened in modern browsers, there are more and more restrictions on modifying page content "on the fly". A more reliable approach is to use the function [`setContent()`](#setContent)

## <a name="Functions">Functions</a>

| Functions | Action |
|:-------- |:------ | 
|[.**allow** ( *data* {; *allow* })](#allow) | Removes URL from URL filtering |
|.**back** ( ) | Loads the previous URL in the sequence of URLs opened into the Web area |
|.**backMenu** ( ) | Displays a context menu containing a list of previous URLs in the URL history of the Web area, then loads the item if one is selected|
|.**clear** ( ) | Loads a blank page into the Web area |
|[.**deny** ( *data* )](#deny) | Appends URL to URL filtering |
|.**evaluateJS** ( *code* {; *typeReturn* }) | Executes, in the Web area, the JavaScript code passed in `code` and returns the result |
|.**executeJS** ( *jsFunction* }) | Executes, in the Web area, the JavaScript function `jsFunction` |
|.**forward** ( ) | Loads the next URL in the sequence of URLs opened into the Web area |
|.**forwardMenu** ( ) | Displays a context menu containing a list of next URLs in the URL history of the Web area, then loads the item if one is selected|
|.**getWebEngine** ( ) | Detects which web rendering engine is being used for the Web Area |
|.**isLoaded** ( ) | Returns **True** if the current URL is equal to the `url` property of the Web area |
|.**load** ( *file* ) | Loads a file into the Web zone after processing 4D tags, if required |
|[.**open** ( *data* )](#open) | Loads an URL passed into the Web area |
|.**refresh** ( ) | Reloads the current URL in the Web area |
|.**showInspector** ( ) | Opens a web inspector for the Web area |
|.**setContent** ( ) | Safely modify page content (the content is saved into a temporary file then open) |
|.**stop** ( ) | Stops loading the resources of the current URL of the Web area |
|.**zoom** ( *in* ) | Increases, if `in` = **True**, decreases otherwise, the size of the contents displayed in the Web area |
|.**zoomIn** ( ) | Increases the size of the contents displayed in the Web area |
|.**zoomOut** ( ) | Reduces the size of the contents displayed in the Web area |

# <a name="allow">.allow()</a>

.**allow** ( *allowed* {; *allow* })

|Parameter|Type||Description|
|---|---|---|---|
| allowed | Text \| Collection | ← | URL(s) to be allowed into the Web area |
| allow | Boolean | ← | Allow or not |

### Description

Removes the URL or all URLs in a collection from URL filtering, for the Web area.

* If the `allow` parameter is omitted, `allow` will take the default value, i.e. **True**.

This optional parameter can be useful for calling filtering or not depending on the value of a test.

### Example

```4d
Form.myWidget:=cs.ui.webArea.new("form object")
Form.myWidget.allow("https://4D.com";$lang="en")
Form.myWidget.allow(https://fr.4d.com";$lang="fr")
```

# <a name="deny">. deny()</a>

.**deny** ( *denied* })

|Parameter|Type||Description|
|---|---|---|---|
| denied | Text \| Collection | ← | URL(s) to be denied into the Web area |

### Description

Appends the URL or all URLs in a collection to URL filtering, for the Web area.


# <a name="open">.open()</a>

.**open** ( *url* )
<br>.**open** ( *file* )
<br>.**open** ( )

|Parameter|Type||Description|
|---|---|---|---|
| url | Text | ← | URL to be loaded into the Web area |
| file | `4D.File` | ←| File to be loaded into the Web area |

### Description

Loads an URL into the Web area.
 
If the `url` text parameter is passed, the url will be used.<br>
Some “special” urls are supported: 

* "internal" to open the starting HTML page of current Web server (the function retrieve the current port used)
* “localhost” which will be translated as ‘127.0.0.1’ on **macOS** where, in some cases, using ‘localhost’ gives the error -30 ‘Server unreachable’.  
* "", an emptyy string to laod `about:blank`

If a `4D.File` is passed as parameter, the url loaded will be "file:///"+ the path of the file.<br>

> 📌 In all cases, the url is automatically allowed if nay.

<!--
### Example

```4d
var $coordinates:=cs.coordinates.new("Input")$coordinates.left+=10$coordinates.top+=10$coordinates.apply()
```
-->
