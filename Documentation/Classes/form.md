# form

The `form` class is intended to handle a form.  

## Properties

|Properties|Description|Type|default|
|----------|-----------|:-----------:|:-----------:|
|**.name** | Current form name |`Text`|
|**.window** | Current form window |`Integer`|
|**.toBeInitialized** | Has the form been initialized |`Boolean`|**True**
|**.callback** | Name of a call-back method |`Text`|**Null**
|**.worker** | Name  or ID of the associated worker  |`Text`\|`Integer`|**Null**
|**.isSubform** | Is the form used as a subform  |`Boolean`|**False**

## 🔸 cs.form.new()

The class constructor `cs.form.new({callbackMethodName})` creates a new class instance and init the `.callback` property if any.

## Summary

| Function | Action |
| -------- | ------ |  
|.**formObject** (name`:Text`{ widgetName`:Text`}) →`cs.formObject` | Instantiate a new [formObject](formObject.md) \*|
|.**widget** (name`:Text`{ widgetName`:Text`}) →`cs.widget` | Instantiate a new [widget](widget.md) \*|
|.**button** (name`:Text`{ widgetName`:Text`}) →`cs.button` | Instantiate a new [button](button.md) \*|
|.**input** (name`:Text`{ widgetName`:Text`}) →`cs.input` | Instantiate a new [input](input.md) \*|
|.**thermometer** (name`:Text`{ widgetName`:Text`}) →`cs.thermometer` | Instantiate a new [thermometer](thermometer.md) \*|
|.**listbox** (name`:Text`{ widgetName`:Text`}) →`cs.listbox` | Instantiate a new [listbox](listbox.md) \*|
|.**picture** (name`:Text`{ widgetName`:Text`}) →`cs.listbox` | Instantiate a new [picture](picture.md) \*|
|.**stepper** (name`:Text`{ widgetName`:Text`}) →`cs.stepper` | Instantiate a new [stepper](stepper.md) \*|
|.**subform** (name`:Text`{ widgetName`:Text`}) →`cs.subform` | Instantiate a new [subform](subform.md) \*|
|.**group** (name`:Text`{ widgetName`:Text`}) →`cs.group` | Instantiate a new [group](group.md) \*|
|.**appendEvents** (events`:Integer`\|`Collection`) | Adds form event(s) for the current form|
|.**removeEvents** (events`:Integer`\|`Collection`) | Removes form event(s) for the current form|
|.**setEvents** (events`:Integer`\|`Collection`) | Define the event(s) for the current form|
|.**page** () →`:Integer` | Returns the number of the currently displayed form page|
|.**goToPage** (page`:Integer`) | Changes the currently displayed form page|
|.**refresh** ({delay`:Integer`}) | Start a timer to update the user interface. Default delay is ASAP|
|.**setCallBack** (methodName`:Text`) | Sets the call-back method|
|.**callMeBack** ()<br/>.**callMeBack** (param`:Collection`)<br/>.**callMeBack** (param;…; paramN) | Generates a CALL FORM of the form using the current callback method|
|.**callMe** (method`:Text`)<br/>.**callMe** (method`:Text`;param`:Collection`)<br>.**callMe** (method`:Text`;param;…; paramN) | Generates a CALL FORM of the current form with the passed method|
|.**setWorker** (worker`:Text`\|`Integer`) | Associates a worker to the form|
|.**callWorker** (method`:Text`)<br/>.**callWorker** (method`:Text`;param`:Collection`)<br>.**callWorker** (method`:Text`;param;…; paramN) | Assigns a task to the associated worker|
|.**callChild** (subform`:Object`\|`Text`; method`:Text`)<br/>.**callChild** (subform`:Object`\|`Text`; method`:Text`;param`:Collection`)<br>.**callChild** (subform`:Object`\|`Text`; method`:Text`;param;…; paramN) | Assigns a task to the associated worker|
|.**callParent** (eventCode`:Integer`) | Sends an event to the subform container|
|.**dimensions** () →`:Object`| Returns the form dimensions as an object {`width`,`height`}|
|.**height** () →`:Integer`| Returns the height of the form|
|.**width** () →`:Integer`| Returns the width of the form|
|.**firstPage** ()| changes the currently displayed form page to the first form page|
|.**lastPage** ()| changes the currently displayed form page to the last form page|
|.**nextPage** ()| changes the currently displayed form page to the next form page|
|.**previousPage** ()| changes the currently displayed form page to the previous form page|
|.**goTo** (widget`:Text`)| Gives the focus to a widget in the current form|
|.**removeFocus** ()| Removes any focus in the current form|
|.**setCursor** (cursor`:Integer`)| Changes the mouse cursor|
|.**restoreCursor** ()| Restores the standard mouse cursor|

\* If the `widgetName` parameter is ommitted, we assume it's the same as the `name` parameter