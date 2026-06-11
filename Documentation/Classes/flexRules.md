# flexRules

The `flexRules` class defines sizing and alignment constraints for widgets managed by a `flexContainer`.

<hr>

ℹ️ <b>Important</b>

1. This class is typically used as a property on a widget, for example `widget.flexRules`.
2. It is not a visual widget itself.
3. It controls how a widget behaves inside a flex layout.
4. Predefined `type` values allow quick configuration with sensible defaults.

<hr>

This class is available via the `cs` class store through `cs.flexRules.new()`.

#### Example — explicit constraints

```4d
This.form.input1.flexRules:=cs.flexRules.new({
  flexBasis: 150;
  flexGrow: 1;
  minWidth: 100;
  alignSelf: "center";
})
```

#### Example — predefined type

```4d
// A background widget that grows to fill all available space
This.form.background.flexRules:=cs.flexRules.new({type: "bakground"; minWidth: 200; minHeight: 100})
```

> 📌 In the `test UI` project, `flexRules` are assigned to widgets in a responsive layout where the container recomputes positions and sizes on resize events.

## <a name="Constructor">cs.flexRules.new()</a>

**cs.flexRules.new** ( *metrics* : Object ) : `cs.flexRules`

|Parameter|Type||Description|
|---|---|---|---|
| metrics | Object | → | Layout metrics, constraints, and optional `type` |
| result | **cs**.flexRules | ← | New `cs.flexRules`

### Description

`cs.flexRules.new()` creates a set of layout constraints used by a flex container.

* All properties from the `metrics` object are applied after the predefined type defaults, so any explicit value overrides the preset.
* Defaults are applied by the `flexContainer` engine when a property is omitted.

### Predefined types

Pass `type` in the metrics object to apply a preset configuration:

| type | Effect |
|:---|:---|
| `"bakground"` | Sets `flexGrow: 100`, `adjustHeight: true`, `adjustWidth: true` — widget expands to fill all available space |

> Any property explicitly passed alongside `type` overrides the preset value.

## <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:|
|**.type** | Predefined configuration shortcut | `Text` | <font color="green">✓</font> |
|**.flexGrow** | Expansion factor when space is available | `Real` | <font color="green">✓</font> |
|**.flexShrink** | Shrink factor when space is limited | `Real` | <font color="green">✓</font> |
|**.flexBasis** | Initial size before growing/shrinking (default: `0`) | `Real` | <font color="green">✓</font> |
|**.adjustHeight** | Allow the widget height to adapt to the container | `Boolean` | <font color="green">✓</font> |
|**.adjustWidth** | Allow the widget width to adapt to the container | `Boolean` | <font color="green">✓</font> |
|**.alignSelf** | Override cross-axis alignment for this widget: `"start"`, `"center"`, `"end"`, `"stretch"` | `Text` | <font color="green">✓</font> |
|**.minWidth** | Minimum width allowed (pixels) | `Integer` | <font color="green">✓</font> |
|**.maxWidth** | Maximum width allowed (pixels) | `Integer` | <font color="green">✓</font> |
|**.minHeight** | Minimum height allowed (pixels) | `Integer` | <font color="green">✓</font> |
|**.maxHeight** | Maximum height allowed (pixels) | `Integer` | <font color="green">✓</font> |
|**.fixedWidth** | Lock widget width: sets both `minWidth` and `maxWidth` to the same value | `Boolean` | <font color="green">✓</font> |
|**.fixedHeight** | Lock widget height: sets both `minHeight` and `maxHeight` to the same value | `Boolean` | <font color="green">✓</font> |

### Fixed dimensions

Set `fixedWidth: true` or `fixedHeight: true` to prevent a widget from expanding or shrinking. This is useful in wrap layouts where you want certain elements to maintain their original size regardless of available space:

```4d
// This widget will never change width, even in uniformWrapWidth mode
This.form.button.flexRules:=cs.flexRules.new({fixedWidth: true})

// This widget will keep its current height but can expand/shrink horizontally
This.form.input.flexRules:=cs.flexRules.new({fixedHeight: true; flexGrow: 1})
```

> 📌 Use `fixedWidth` and `fixedHeight` to create mixed layouts with both rigid and flexible elements.
