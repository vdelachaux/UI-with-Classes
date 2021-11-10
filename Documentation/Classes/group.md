# group

Widget groups are available in the form editor but are not recognized at runtime. 

A classic way to handle this is to create name patterns to handle a group of widgets at once. This is sometimes a problem when you want to change the organization of the form.

The purpose of the `group` class is to allow the manipulation of a collection of widgets without having to worry about the name of the widget in the form

## Properties

|Properties|Description|Type||
|----------|-----------|:--:|-------|
|**.members** | The collection of wigdets that belong to the group | `Collection`| empty |


## 🔸 cs.group.new()

The class constructor `cs.group.new({members})` creates a new class instance.

The constructor accepts an optional `members` parameter of type **`Collection`**, **`Object`**, or **`text`**.

**`cs.group.new()`** Creates a group instance with an empty collection of members. Members can then be added with the function of this class `.addMember()` or the function .addToGroup() of the [formObject](formObject.md) class (or inherited classes).