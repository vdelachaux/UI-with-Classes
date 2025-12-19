# group

Widget groups are available in the form editor but are not recognized at runtime. 

A classic way to handle this is to create name patterns to handle a group of widgets at once. This is sometimes a problem when you want to change the organization of the form.

The purpose of the`group` class is to allow the manipulation of a collection of widgets without having to worry about the name of the widget in the form

The `group` class is available via the [`form`](form.md#objects) class through the `Group` interface.

#### Example

```4d
This.form:=cs.form.new(This)
...
This.bottomButtons:=This.form.Group()This.ok:=This.form.Button("Button").addToGroup(This.bottomButtons)This.cancel:=This.form.Button("Button1").addToGroup(This.bottomButtons)

...
This.bottomButtons.distributeRigthToLeft()
```

This class is, more generally, available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

#### Example

```4d
$group:=cs.ui.group.new("Button,Button1")
$group.distributeRigthToLeft().disable()
```

<hr>

ℹ️ <b>Conventions</b>

1. To simplify the distinction between form objects and object type, this documentation uses the term “widget” for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).
2. All functions that return `This` return the current group object and can include one call after another. 

<hr>

## <a name="Constructor">cs.group.new()</a>

**cs.group.new** ( ) : `cs.group`
<br>**cs.group.new** ( *members* : Collection ) : `cs.group`
<br>**cs.group.new** ( *member* : *widget* \| `cs.group` {; … {; *memberN* *widget* \| `cs.group`}}) : `cs.group`
<br>**cs.group.new** ( *member* : Text {; … {; *memberN* Text {; *type* :Text} ) : `cs.group`

The constructor accepts an optional`members` parameter of type **`Collection`**, **`Object`**, or **`text`**.

|Parameter|Type||Description|
|---|---|---|---|
| member | Variant | → |  |

### Description

`cs.group.new()` creates & returns a new instance of the class.
 
* If the constructor is called without parameters, the group is created with an empty list of members. This can be filled using the `.add()` functions or the [`addToGroup()`](static.md#Miscellaneous) function of a widget class.
* If the constructor is called with a collection, we assume it's a collection of *widgets* that make up the initial list of members.
* The constructor can be called with N parameters of type `Object` to add to the list of members. These can be `widget` or `group`. In the latter case, all group members are added to the current group.
* If the constructor can be called with N parameters of type `Text`, a last optional parameter allow to give the type you want t use like "button" or "input" (default type `static`). 
	* The first parameter could be:
		* A comma-separated list of widget names, the second parameter, if passed, being the type.
		* A text beginning or ending with “@”, the 2nd parameter, if passed, being the type. In this case, all form objects whose name matches the pattern will be added in alphabetical order.
	* In other cases, all N parameters are considered *widget* names, but the last one in the list is first analyzed to see if it could be a type.

> ⚠️ Type analysis is based on its name, checking whether the corresponding class exists in the class store. In this case, it is important to avoid confusion between the last parameter and a component class (for example, if the name is “group” or “button”). Note that the search is case-sensitive. 

## <a name="Inherited">Properties & Functions</a>

### <a name="Properties">Properties</a>

|Properties|Description|Type|default|Writable|
|:----------|:-----------|:-----------|:-----------|:-----------:| 
|**.data** | User data: anything you wish to associate with the group and retrieve at a later date. | any | **Null** |<font color="green">✓</font>
|**.members** | The collection of wigdets that belong to the group |`Collection`| empty |<font color="red">x</font>
|**.type** | The class type |`Integer`| <u>Object type group</u> |<font color="red">x</font>

### <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ | 
|.**add** (*members* ) →`This` | Adds one or more widgets to the group. (same syntax as the constructor)| 
|.**alignLeft** (*reference* :`Object`) →`This`<br/>.**alignLeft** (*left* :`Integer`) →`This`<br/>.**alignLeft** (*reference* :`Text`) →`This` | Performs a left alignment of the elements relative to the left position of the reference or the pixel value passed| 
|.**alignRight** (*reference* :`Object`) →`This`<br/>.**alignLeft** (*right* :`Integer`) →`This`<br/>.**alignLeft** (*reference* :`Text`) →`This` | Performs a right alignment of the elements relative to the left position of the reference or the pixel value passed| 
|.**belongsTo** (*name* :`Text`) →:`Boolean`<br/>.**belongsTo** (*widget* :`Object`) →:`Boolean` | Returns True if the passed object or object name is part of the group| 
|.**center** (*horizontally* :`Boolean`) | Center all members on the first| 
|.**centerVertically** (*reference* :`Text`) | Performs a centered alignment of the elements according to their best size| 
|.**disable** () →`This` | To disable all elements| 
|.**enable** ({*enabled* :`Boolean`}) →`This` | To enable all elements (without parameter) or not (`enabled` = **False**)| 
|.**moveAndResizeHorizontally** (*offset* :`Integer` ; *resize* :`Integer`) | Moves & resize all members horizontally| 
|.**distributeAroundCenter** ({*params* :`Object`}) →`This` | Performs a horizontal distribution, around the center of the group, of the elements according to their best size\*| 
|.**distributeHorizontally** ({*params* :`Object`}) →`This` | Performs an horizontal distribution of the element saccording to their best size\*| 
|.**distributeLeftToRight** ({*params* :`Object`}) →`This` | Performs a horizontal distribution, from left to right, of the elements according to their best size\*| 
|.**distributeRigthToLeft** ({*params* :`Object`}) →`This` | Performs a horizontal distribution, from right to left, of the elements according to their best size\*| 
|.**distributeVertically** ({*params* :`Object`}) →`This` | Performs a vertical distribution of the elements\*| 
|.**enclosingRect** ({*padding* :`Integer`}) →`Object`| Returns the [coordinates](#coord) of the enclosing rectangle, respecting the `padding` parameter if passed| 
|.**hide** () →`This` | Makes all elements invisible| 
|.**horizontallyCentered** ({*params* :`Object` {; *ref* :`Text`}) →`This` | Performs an horizontal alignment of the elements.<br/>The optional widget name parameter allow to specify the reference. If ommited, the distribution is relative to the form| 
|.**move** (*hOffset* :`Integer` ; *vOffset* :`Integer`) | Move all members horizontally & vertically| 
|.**moveDown** (*offset* :`Integer`) | Moves down all members| 
|.**moveUp** (*offset* :`Integer`) | Move all members upwards| 
|.**moveHorizontally** (*offset* :`Integer`) | Moves all members horizontally| 
|.**moveLeft** (*offset* :`Integer`) | Moves left all members| 
|.**moveRight** (*offset* :`Integer`) | Move right members upwards| 
|.**moveVertically** (*offset* :`Integer`) | Moves all members vertically| 
|.**setFontStyle** (*style* :`Integer`) →`This` | Sets the font style of all elements. Use the [4D Font style](https://doc.4d.com/4Dv19/4D/19/Font-Styles.302-5393339.en.html) constantes| 
|.**show** ({*visible* :`Boolean`}) →`This` | Makes all elements visible if `visible` is **True** or omitted| 
|.**switch** ({*updateEntryOrder* :`Boolean` }) →`This` | Reverses the horizontal order of the members. Useful, for example, for reversing the OK and Cancel buttons depending on the platform| 
|.**verticallyCentered** ({*params* :`Object` {; *ref*`:Text`}) →`This` | Performs a centered alignment of the elements.<br/>The optional widget name parameter allow to specify the reference. If ommited, the distribution is relative to the form| 

\* The optional object type parameter allow to specify:

* The starting point x in pixels in the form ("start":`Integer`) - default = 0
* The spacing in pixels to respect between the elements ("spacing":`Integer`) - default = 0
* The minimum width to respect in pixels ("minWidth":`Integer`) - default = none
* The maximum width to respect in pixels ("maxWidth":`Integer`) - default = none
* A reference *widget* name  ("to":`Text`) - default = none

#### <a name="coord">Coordinate object</a>

```json
{
  left: integer, 
  top: integer,
  right: integer,
  bottom: integer
}
```

