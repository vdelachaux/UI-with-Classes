# group

Widget groups are available in the form editor but are not recognized at runtime. 

A classic way to handle this is to create name patterns to handle a group of widgets at once. This is sometimes a problem when you want to change the organization of the form.

The purpose of the`group` class is to allow the manipulation of a collection of widgets without having to worry about the name of the widget in the form

## Properties

|Properties|Description|Type||
|----------|-----------|:--:|-------|
|**.members** | The collection of wigdets that belong to the group |`Collection`| empty |


## 🔸 cs.group.new()

The class constructor`cs.group.new({members})` creates a new class instance.

The constructor accepts an optional`members` parameter of type **`Collection`**, **`Object`**, or **`text`**.

|Syntax|  |
|----------|-----------|
| **cs.group.new()** | Creates a group instance with an empty collection of members |
| **cs.group.new ( members`:Collection` )** | Creates a group instance and initialize the members collection to the passed collection.
| **cs.group.new ( members`:cs.widget`\|`cs.group` {; … {; membersN`:cs.widget`\|`cs.group`}})** | Creates a group instance and initializes its members with passed widgets or members of passed groups.
| **cs.group.new ( members`:Text`)** | Creates a group instance and initialize the members with the comma separated list of object names. In this case, each of the objects will be treated as a`cs.widget`

Members can then be added with the function of this class **.addMember()** or the function **.addToGroup()** of the [formObject](formObject.md) class (or inherited classes).

## Summary

> 📌 All functions that return`cs.group` may include one call after another. 

| Function | Action |
| -------- | ------ |  
|.**addMember** (members`:Collection`\|`cs.group`\|`cs.widget`\|`Text`) →`cs.group` | Adds one or more widgets to the group. (same syntax as the constructor)| 
|.**belongsTo** (objectName`:Text`) →`:Boolean`<br/>.**belongsTo** (widget`:Object`) →`:Boolean` | Returns True if the passed object or object name is part of the group| 
|.**enclosingRect** () → coordinates`:Object`| Returns the coordinates of the enclosing rect as an object {"left":`Integer`,"top":`Integer`,"right":`Integer`,"bottom":`Integer`}| 
|.**moveVertically** (offset`:Integer`) | Moves all members vertically| 
|.**moveHorizontally** (offset`:Integer`) | Moves all members horizontally| 
|.**distributeLeftToRight** ({params`:Object`}) →`cs.group` | Performs a horizontal distribution, from left to right, of the elements according to their best size\*| 
|.**distributeRigthToLeft** ({params`:Object`}) →`cs.group` | Performs a horizontal distribution, from right to left, of the elements according to their best size\*| 
|.**centerVertically** ({referenceObjectName`:Text`}) →`cs.group` | Performs a centered alignment of the elements.<br/>The optional widget name parameter allow to specify the reference. If ommited, the distribution is relative to the form| 
|.**alignLeft** (reference`:Object`) →`cs.group`<br/>.**alignLeft** (left`:Integer`) →`cs.group`<br/>.**alignLeft** (referenceObjectName`:Text`) →`cs.group` | Performs a left alignment of the elements relative to the left position of the reference or the pixel value passed| 
|.**alignRight** (reference`:Object`) →`cs.group`<br/>.**alignLeft** (left`:Integer`) →`cs.group`<br/>.**alignLeft** (referenceObjectName`:Text`) →`cs.group` | Performs a right alignment of the elements relative to the left position of the reference or the pixel value passed| 
|.**show** ({visible`:Boolean`}) →`cs.group` | To make all elements visible (without parameter) or invisible (`visible` = **False**)| 
|.**hide** () →`cs.group` | To make all elements invisible| 
|.**enable** ({enabled`:Boolean`}) →`cs.group` | To enable all elements (without parameter) or not (`enabled` = **False**)| 
|.**disable** () →`cs.group` | To disable all elements| 
|.**setFontStyle** (style`:Integer`) →`cs.group` | Sets the font style of all elements. Use the [4D Font style](https://doc.4d.com/4Dv19/4D/19/Font-Styles.302-5393339.en.html) constantes| 

\* The optional object type parameter allow to specify:

* The starting point x in pixels in the form ("start":`Integer`)
* The spacing in pixels to respect between the elements ("spacing":`Integer`)
* The minimum width to respect in pixels ("minWidth":`Integer`)
* The maximum width to respect in pixels ("maxWidth":`Integer`)
