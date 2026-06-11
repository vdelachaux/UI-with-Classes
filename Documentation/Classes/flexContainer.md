# flexContainer

The `flexContainer` class provides a simple flexbox-like layout manager for collections of widgets inside a container or subform.

<hr>

ℹ️ <b>Important</b>

1. This class is not a widget itself; it manages widgets and their layout rules.
2. It is typically used with `flexRules` constraints attached to child widgets.
3. It can lay out widgets horizontally (`row`) or vertically (`column`).

<hr>

This class is available via the `cs` class store through `cs.flexContainer.new()`.

#### Example

```4d
var $layout : cs.flexContainer:=cs.flexContainer.new(This.form.Group("content"); {direction: "row"; padding: 12})

This.form.input1.flexRules:=cs.flexRules.new({flexBasis: 150; flexGrow: 1; minWidth: 80})
This.form.input2.flexRules:=cs.flexRules.new({flexBasis: 120; flexGrow: 2; minWidth: 100})

$layout.add(This.form.input1)
$layout.add(This.form.input2)
$layout.layout()
```

> 📌 In the `test UI` project, `flexContainer` is used to lay out form widgets dynamically on resize, calling `layout()` again inside `On Resize` and `On Timer` events.

## <a name="Constructor">cs.flexContainer.new()</a>

**cs.flexContainer.new** ( *container* : Object ; *options* : Object ) : `cs.flexContainer`

|Parameter|Type||Description|
|---|---|---|---|
| container | Object | → | Target container or widget used for sizing |
| options | Object | → | Layout options: `direction`, `justifyContent`, `alignItems`, `padding` |
| result | **cs**.flexContainer | ← | New `cs.flexContainer`

### Description

`cs.flexContainer.new()` creates a layout manager for the provided container.

* The layout manager stores child widgets in `children`.
* Calling `layout()` computes sizes and positions based on each child widget's `flexRules`.

## <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:|
|**.children** | Child widgets managed by the layout | `Collection` | <font color="green">✓</font> |
|**.direction** | Layout direction | `Text` | <font color="green">✓</font> |
|**.justifyContent** | Main-axis alignment | `Text` | <font color="green">✓</font> |
|**.alignItems** | Cross-axis alignment | `Text` | <font color="green">✓</font> |
|**.padding** | Space around the layout | `Integer` | <font color="green">✓</font> |
|**.width** | Current computed container width | `Real` | <font color="red">x</font> |
|**.height** | Current computed container height | `Real` | <font color="red">x</font> |

## <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ |
|.**add**(*widget* : `Object`) : `cs.flexContainer` | Adds a child widget to the layout |
|.**layout**() | Computes widget positions and sizes |

> 📌 The layout engine works by reading each child widget's `flexRules` constraints, then allocating space and optionally expanding or shrinking children based on available width.
