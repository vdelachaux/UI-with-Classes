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

$layout.add(This.form.input1).add(This.form.input2)
$layout.layout()
```

> 📌 In the `test UI` project, `flexContainer` is used to lay out form widgets dynamically on resize, calling `layout()` again inside `On Resize` and `On Timer` events.

## <a name="Constructor">cs.flexContainer.new()</a>

**cs.flexContainer.new** ( *container* : Object ; *options* : Object ) : `cs.flexContainer`

|Parameter|Type||Description|
|---|---|---|---|
| container | Object | → | Target container or widget used for sizing |
| options | Object | → | Layout options: `direction`, `flexWrap`, `justifyContent`, `alignItems`, `padding` |
| result | **cs**.flexContainer | ← | New `cs.flexContainer`

### Description

`cs.flexContainer.new()` creates a layout manager for the provided container.

* The layout manager stores child widgets in `children`.
* Calling `layout()` reads the container dimensions at that moment, then computes sizes and positions based on each child widget's `flexRules`.
* When `container` is `Null`, dimensions are read from the subform container via `OBJECT GET SUBFORM CONTAINER SIZE`.

## <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:|
|**.children** | Child widgets managed by the layout | `Collection` | <font color="green">✓</font> |
|**.direction** | Layout direction: `"row"` (default) or `"column"` | `Text` | <font color="green">✓</font> |
|**.flexWrap** | Enable line wrapping when items overflow (default: `True`) | `Boolean` | <font color="green">✓</font> |
|**.uniformWrapWidth** | In wrap mode, apply uniform width to all items across lines (default: `False`) | `Boolean` | <font color="green">✓</font> |
|**.justifyContent** | Main-axis alignment: `"start"` (default), `"center"`, `"end"`, `"space-between"` | `Text` | <font color="green">✓</font> |
|**.alignItems** | Cross-axis alignment: `"start"` (default), `"center"`, `"end"`, `"stretch"` | `Text` | <font color="green">✓</font> |
|**.padding** | Space (in pixels) around and between widgets | `Integer` | <font color="green">✓</font> |
|**.width** | Current computed container width | `Real` | <font color="red">x</font> |
|**.height** | Current computed container height | `Real` | <font color="red">x</font> |

## <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ |
|.**add**(*widget* : `cs.static`) : `cs.flexContainer` | Adds a child widget and configures its native resize options |
|.**layout**() | Reads container dimensions then computes widget positions and sizes |
|**.wrap** | Enable wrapping (chainable keyword) |
|**.noWrap** | Disable wrapping (chainable keyword) |
|**.directionRow** | Set direction to row (chainable keyword) |
|**.directionColumn** | Set direction to column (chainable keyword) |
|**.alignStart** | Set alignItems to start (chainable keyword) |
|**.alignCenter** | Set alignItems to center (chainable keyword) |
|**.alignEnd** | Set alignItems to end (chainable keyword) |
|**.alignSpaceBetween** | Set justifyContent to space-between (chainable keyword) |
|**.uniformWidth** | Enable uniform width in wrap mode (chainable keyword) |
|**.variableWidth** | Disable uniform width in wrap mode (chainable keyword) |

### Chainable keywords

Keyword getters provide a fluent API for configuring layout options inline. Each returns the container instance, allowing method chaining:

```4d
// Traditional approach
var $layout : cs.flexContainer:=cs.flexContainer.new($container; {direction: "row"; padding: 12})
$layout.flexWrap:=True
$layout.uniformWrapWidth:=True
$layout.alignItems:="center"

// Fluent approach with keywords
var $layout : cs.flexContainer:=cs.flexContainer.new($container; {padding: 12})\
  .directionRow\
  .wrap\
  .uniformWidth\
  .alignCenter
```

### add()

`add()` pushes the widget into the `children` collection and automatically configures its 4D native resize options based on `widget.flexRules.type` and the container's `direction` and `alignItems`:

| Condition | Resize options applied |
|:---|:---|
| `flexRules.type = "bakground"` | Grow horizontal + vertical; applies `minWidth`/`minHeight` to the form |
| `direction = "row"` and `alignItems = "stretch"` | Grow horizontal + vertical |
| `direction = "row"` (default) | Grow horizontal only |

> 📌 The layout engine works by reading each child widget's `flexRules` constraints, then allocating space and optionally expanding or shrinking children based on available space.

### Wrap mode

When `direction="row"` and `flexWrap=True` (the default), widgets are split into multiple lines when the available width is exceeded. Set `flexWrap=False` to keep all widgets on a single line.

```4d
// Wrap enabled (default)
var $layout : cs.flexContainer:=cs.flexContainer.new(This.form.Group("content"); {
	direction: "row";
	justifyContent: "space-between";
	alignItems: "center";
	padding: 8
})

// Wrap disabled — all widgets stay on one line
var $layout : cs.flexContainer:=cs.flexContainer.new(This.form.Group("toolbar"); {
	direction: "row";
	flexWrap: False;
	padding: 8
})
```

### Uniform width in wrap mode

When `flexWrap=True` and `uniformWrapWidth=True`, all items maintain the same width across all lines, expanding uniformly up to their `maxWidth` constraints. Without this option, items on partially-filled lines may be wider than items on full lines.

```4d
// All items will have consistent width, even when wrapping to new lines
var $layout : cs.flexContainer:=cs.flexContainer.new(This.form.Group("cards"); {
	direction: "row";
	uniformWrapWidth: True;
	padding: 12
})
```

Each item still respects its individual `minWidth` and `maxWidth` constraints:

```4d
This.form.card1.flexRules:=cs.flexRules.new({flexBasis: 200; flexGrow: 1; minWidth: 150; maxWidth: 400})
This.form.card2.flexRules:=cs.flexRules.new({flexBasis: 200; flexGrow: 1; minWidth: 150; maxWidth: 400})
```

In this example, both cards grow proportionally based on available space and will never exceed `maxWidth`, resulting in a balanced grid regardless of how many items fit on each line.
