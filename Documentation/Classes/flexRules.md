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

> 📌 Use `flexRules` to adjust a widget's size and alignment inside a `flexContainer`, especially when you need responsive behavior on window or form resize.
