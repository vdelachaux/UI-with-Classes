# hList

The `hList` class is intended to handle hierarchical list widgets.

<hr>

ℹ️ <b>Important</b>

1. This class inherits from the [`scrollable`](scrollable.md) class
2. This class is a transition class between the `widget` class and scrollable more specific classes like `input`, `hList`, `listbox`…
3. <u>Normally, you'll never have to instantiate the **cs.**scrollable class directly</u>, since instantiation is automatic with a more specialized widget.
4. To simplify the distinction between form objects and object type, this documentation uses the term `widget` for all form objects, whether static (a line, a rectangle…) or not (a button, a subform…).
5. All functions that return `This` may include one call after another.

<hr>

This class is available via the [`form`](form.md#objects) class through the `HList` interface.

#### Example

```4d
This.form:=cs.form.new(This)
...
This.myHList:=This.form.HList("hlist1")
...
This.myHList.append("Item 1"; 1; 0; False)
```

This class is also available from the `cs` class store, or `cs.ui` class store if you use the `UI` component.

#### Example

```4d
Form.myHList:=cs.ui.hList.new("hlist1"; 0; This.form)
Form.myHList.append("Item 1"; 1; 0; False)
```

## <a name="Constructor">cs.hList.new()</a>

**cs.hList.new** ( *name* : Text ) : `cs.hList`<br>
**cs.hList.new** ( *name* : Text ; *ref* : Integer ) : `cs.hList`<br>
**cs.hList.new** ( *name* : Text ; *ref* : Integer ; *parent* : Object ) : `cs.hList`<br>
**cs.hList.new** ( ) : `cs.hList`

|Parameter|Type||Description|
|---|---|---|---|
| name | Text | → | Widget name |
| ref | Integer | → | List reference |
| parent | **cs**.form | → | `form` object containing the widget |
| result | **cs**.hList | ← | New `cs.hList`

### Description

`cs.hList.new()` creates & returns a new instance of the class.

* The optional `parent` parameter is the [`cs.form`](form.md) object containing the widget. This parameter is automatically set if instantiation is performed via a [form widget instantiation function](form.md#objects) of the `cs.form` class.
* If the `name` parameter is omitted, the constructor uses the result of **[OBJECT Get name](https://doc.4d.com/4Dv19/4D/19/OBJECT-Get-name.301-5392401.en.html)** (_Object current_)

> ⚠️ Omitting the widget name can only be used if the constructor is called from the object method.

## <a name="Inherited">Properties & Functions</a>

Inherited properties and functions are described in the parent classes:

* [static class](static.md)
* [widget class](widget.md)
* [scrollable class](scrollable.md)

### <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:|
|**.ref** | Associated list reference | `Integer` | <font color="green">✓</font> |
|**.latest** | Last inserted item reference | `Integer` | <font color="green">✓</font> |
|**.isList** | True if the current reference is a valid list | `Boolean` | <font color="red">x</font> |
|**.itemCount** | Total number of items present in the list | `Integer` | <font color="red">x</font> |
|**.visibleItemCount** | Number of items currently visible | `Integer` | <font color="red">x</font> |
|**.properties** | List appearance and behavior properties. Works only with a datasource | `Object` | <font color="green">✓</font> |
|**.selected** | Selected item positions | `Collection` | <font color="red">x</font> |
|**.selectedReferences** | Selected item references | `Collection` | <font color="red">x</font> |
|**.collapsable** | True if at least one element can be collapsed | `Boolean` | <font color="red">x</font> |
|**.expandable** | True if at least one element can be expanded | `Boolean` | <font color="red">x</font> |
|**.itemValue** | Value of the current list item | `Text` | <font color="green">✓</font> |
|**.itemRef** | Reference of the current list item | `Integer` | <font color="green">✓</font> |
|**.itemSublist** | Sublist reference of the current item | `Integer` | <font color="green">✓</font> |
|**.itemExpanded** | Expanded state of the current item | `Boolean` | <font color="green">✓</font> |
|**.itemIcon** | Icon associated with the current item | `Picture` | <font color="green">✓</font> |
|**.itemPosition** | Position of the current item | `Integer` | <font color="red">x</font> |
|**.parameters** | Parameters names and values of the current item | `Collection` | <font color="red">x</font> |
|**.parent** | Parent item reference | `Integer` | <font color="red">x</font> |
|**.selectedItemIndexes** | Selected item positions | `Collection` | <font color="red">x</font> |
|**.selectedItemReferences** | Selected item references | `Collection` | <font color="red">x</font> |

### <a name="Functions">Functions</a>

| Function | Action |
| -------- | ------ |
|.**create**() → `Integer` | Creates a new list in memory and returns its unique list reference |
|.**clear**(*keepSubLists* : `Boolean`) | Deletes the current reference list |
|.**copy**() → `cs.hList` | Returns a copy of the current list |
|.**clone**() → `cs.hList` | Alias of `copy()` |
|.**set properties**(*properties* : `Object`) | Updates list behavior and appearance properties |
|.**append**(*itemText* : `Text`; *ref* : `Integer`; *sublist* : `Integer`; *expanded* : `Boolean`) | Appends a new item to the current list |
|.**insert**(*itemText* : `Text`; *ref* : `Integer`; *sublist* : `Integer`; *expanded* : `Boolean`; *beforeItemRef* : `Integer`) | Inserts an item before the given item reference |
|.**collapseAll**(*keep* : `Boolean`) | Collapses all expanded items |
|.**expandAll**() | Expands all collapsed items |
|.**collapse**(*itemPos* : `Integer`) | Collapses a single item |
|.**expand**(*itemPos* : `Integer`) | Expands a single item |
|.**getItemPositionByRef**(*ref* : `Integer`) → `Integer` | Returns the position of the item with the given reference |
|.**_getItem**(*request* : `Text`; *itemPos* : `Integer`) → `Variant` | Returns item information |
|.**_setItem**(*request* : `Text`; *value*; *itemPos* : `Integer`) | Sets item information |
|.**getSublist**(*pos* : `Integer`) → `Integer` | Returns the sublist of the item at the given position |
|.**getSublistByRef**(*ref* : `Integer`) → `Integer` | Returns the sublist of the item with the given reference |
|.**findPosition**(*itemText* : `Text`; *scope* : `Integer`) → `Integer` | Returns the position of the first item matching the text |
|.**findReference**(*itemText* : `Text`; *scope* : `Integer`) → `Integer` | Returns the reference of the first item matching the text |
|.**selectByPosition**(*itemPos* : `Integer`) | Selects the item at the given position |
|.**selectByReference**(*ref* : `Integer`) | Selects the item with the given reference |
|.**selectAll**() | Selects all items |
|.**unselect**() | Deselects all items |

> 📌 Some internal helpers like `._getItem()` and `._setItem()` are used to read and write current item properties.
