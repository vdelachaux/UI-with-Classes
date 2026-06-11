# flexRules

The `flexRules` class defines sizing and alignment constraints for widgets managed by a `flexContainer`.

<hr>

ℹ️ <b>Important</b>

1. This class is typically used as a property on a widget, for example `widget.flexRules`.
2. It is not a visual widget itself.
3. It controls how a widget behaves inside a flex layout.

<hr>

This class is available via the `cs` class store through `cs.flexRules.new()`.

#### Example

```4d
This.form.input1.flexRules:=cs.flexRules.new({
  flexBasis: 150;
  flexGrow: 1;
  minWidth: 100;
  alignSelf: "center";
})
```

> 📌 In the `test UI` project, `flexRules` are assigned to widgets in a responsive layout where the container recomputes positions and sizes on resize events.

## <a name="Constructor">cs.flexRules.new()</a>

**cs.flexRules.new** ( *metrics* : Object ) : `cs.flexRules`

|Parameter|Type||Description|
|---|---|---|---|
| metrics | Object | → | Layout metrics and constraints |
| result | **cs**.flexRules | ← | New `cs.flexRules`

### Description

`cs.flexRules.new()` creates a set of layout constraints used by a flex container.

* The metrics object may include sizing and alignment properties.
* Defaults are applied when a parameter is omitted.

## <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:|
|**.flexGrow** | Expansion factor when space is available | `Real` | <font color="green">✓</font> |
|**.flexShrink** | Shrink factor when space is limited | `Real` | <font color="green">✓</font> |
|**.flexBasis** | Initial size before growing/shrinking | `Real` | <font color="green">✓</font> |
|**.adjustHeight** | Allow the widget height to adapt | `Boolean` | <font color="green">✓</font> |
|**.adjustWidth** | Allow the widget width to adapt | `Boolean` | <font color="green">✓</font> |
|**.alignSelf** | Cross-axis alignment for the widget | `Text` | <font color="green">✓</font> |
|**.minWidth** | Minimum width allowed | `Integer` | <font color="green">✓</font> |
|**.maxWidth** | Maximum width allowed | `Integer` | <font color="green">✓</font> |
|**.minHeight** | Minimum height allowed | `Integer` | <font color="green">✓</font> |
|**.maxHeight** | Maximum height allowed | `Integer` | <font color="green">✓</font> |

> 📌 Use `flexRules` to adjust a widget's size and alignment inside a `flexContainer`, especially when you need responsive behavior on window or form resize.
