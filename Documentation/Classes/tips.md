# tips

The `tips` class provides global control over help tips in the application.

<hr>

ℹ️ <b>Important</b>

1. Defining `helpTip` on widgets automatically activates the help tip system.
2. This class manages the global behavior of tips, not individual tooltips.
3. It stores its settings in database parameters.

<hr>

This class is available via the `cs` class store through `cs.tips.new()`.

#### Example

```4d
// Enable tips immediately with a shorter animation duration.
cs.tips.new().instantly(120)

// Or just enable/disable the system.
cs.tips.new().enable()
cs.tips.new().disable()
```

#### Widget help tip example

```4d
This.cancel.helpTip:="Click here to abandon"
This.ok.helpTip:="clickHereToValidateYourNewPassword"
```

## <a name="Constructor">cs.tips.new()</a>

**cs.tips.new** ( ) : `cs.tips`

|Parameter|Type||Description|
|---|---|---|---|
| result | **cs**.tips | ← | New `cs.tips`

### Description

`cs.tips.new()` creates and returns an instance of the global tips manager.

## <a name="Properties">Properties</a>

|Properties|Description|Type|Writable|
|:----------|:-----------|:-----------|:-----------:|
|**.enabled** | True when tips are enabled | `Boolean` | <font color="green">✓</font> |
|**.delay** | Delay before showing a tip, in milliseconds | `Integer` | <font color="green">✓</font> |
|**.duration** | How long the tip stays visible, in milliseconds | `Integer` | <font color="green">✓</font> |
|**.status** | Current tips status object | `Object` | <font color="red">x</font> |

## <a name="Functions">Functions</a>

| Functions | |
|:-------- |:------ |
|.**backup**() | Saves the current tips settings |
|.**restore**() | Restores the previously saved settings |
|.**default**() | Restores the default tips settings |
|.**get status**() : `Object` | Returns current settings |
|.**set status**(*param* : `Object`) | Updates current settings |
|.**enable**() | Enables tips |
|.**disable**() | Disables tips |
|.**defaultDelay**() | Restores the default delay |
|.**defaultDuration**() | Restores the default duration |
|.**instantly**(*duration* : `Integer`) | Enables tips with a minimal delay and custom duration |

> 📌 Use `tips` when you need a consistent global configuration for individual widget help tips highlighted in the UI.
