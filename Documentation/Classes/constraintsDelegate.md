# constraintsDelegate

The `constraintsDelegate` class retains the rules for moving and resizing form objects, and manages them during resizing.

> 📌 Note that, for the moment, only horizontal rules are supported.    
> (I've never needed vertical constraints, but perhaps I will in the future...).

## Properties

|Properties|Description|Type|default|
|:----------|:-----------|:-----------:|:-----------|
|**.rules** | The constraints [rules](#rule) |`Collection`| [ ]
|**.scrollBarWidth** | Width of scroll bar |`Integer`| macOS = 15px<br>Windows = 15px
|**.marginH** | Default horizontal spacing between items |`Integer`| macOS = 20px<br>Windows = 20px
|**.labelMargin** | Default spacing between label and input box |`Integer`| macOS = 10px<br>Windows = 10px
|**.offset** | Default offset |`Integer`| macOS = 2px<br>Windows = 2px


| Functions | Action |
|:-------- |:------ |   
|.**load**(file: `4D.File`) | Load rules and default values from a file|
|.**setMetrics**(metrics: `Object`) | Allow to set in one time the default values|
|.**add**(rule: `Object`)  → `cs.constraintsDelegate`| Stores a [rule](#rule) or a [set of rules](#set)|
|.**apply**() | Dealing with constraints|


|**.set** | A collection of [rule objects](#rule)|`Collection`| All others properties are ignored

## <a name="rule">Rule object</a>

A rule can have one or more of the following properties.

|Properties|Description|Type||
|:----------|:-----------|:-----------:|:-----------|
|**.formula** | A formula that will be executed|`Text` \| `4D.Function`| All others properties are ignored
|**.target** | The item to which the rule applies.<br>**Mandatory if not a [set of rules](#set)**|`Text` \| `widget`|<br>It can be a comma-separated list of names
|**.type** |[Constraint](#constraint) type.<br>**Mandatory if formula is null**|`Text`| 
|**.alignment** | Alignment for certain constraints |`Text`|
|**.value** | Value in percent or px|`Real`| \*
|**.margin** | Margin to respect in px |`Integer`|\*\*
|**.reference** | Name of the element to take as reference|`Text`| Default is current viewport <br>(dialog or container size)
|**.label**|Name of the associated label|`Text`| \*\*\*
|**.toDelete**|**True** if the rule should be deleted after application|`Boolean`|Enables a rule to be applied only once, usually on loading.

\* for `right`, `left`, `minimum-width`, `maximum-width`, `tile` & `float` rules

\*\* for `fit-width`, `margin` left or right, `horizontal-alignment` left or right, `anchor` left or right, `inline` & `float` left or right

\*\*\* If ommitted use "\<target>.label" if exists

## <a name="set">Set of rules</a>

Allow to store more than one rule for a same target.

|Properties|Description|Type||
|:----------|:-----------|:-----------:|:-----------|
|**.target** | The item to which the rule applies. <br>Mandatory!|`Text` \| `widget`|<br>It can be a comma-separated list of names
|**.set** | Collection of [rule objects](#rule) without target|`Collection`|All others properties are ignored


## <a name="constraint">Constraint types</a>

|Properties|Description| |
|:----------|:-----------|:-----------|
|"right"|Keeps the right edge of an element as % of the ref|`value`  From 0 to 1 or 1 to 100
|"left"|Keeps the left edge of an element as % of the ref|`value`  From 0 to 1 or 1 to 100
|"minimum-width"|Sets the minimum width of an element|`value` = limit in px
|"maximum-width"|Sets the maximum width of an element|`value` = limit in px
|"fit-width"|Adjusts width to ref |Optional `margin` left & right in px, default is 0
|"margin"|Maintains a horizontal margin from the ref |`alignment` should be "auto", "left" or "right"
|"horizontal-alignment"| Maintains vertical alignment with the reference |`alignment` should be "center", "left" or "right". <br>`margin` if passed is used for "left" & "right" alignments
|"anchor"| Maintains vertical alignment with the reference |`alignment` should be "center", "left" or "right". <br>`margin` if passed is used for "left" & "right" alignments
|"inline"| Maintains the element at the right of the reference | use `margin`if passed, `marginH` if not
|"tile"|  Set element width as percent of the reference | `value`  From 0 to 1 or 1 to 100


## <a name="sample">Code sample</a>

```4d
// Class _myDialog_Controller
Class constructor		This.isSubform:=False	This.toBeInitialized:=False		// Instantiate the formDelegate	This.form:=cs.formDelegate.new(This)
	
	...
	
	This.form.init()
	
Function init()
	
	This.listbox:=This.form.listbox.new("List Box")
	
	...

	// The right edge of the lisbox must be in the middle (50%) of the dialog,	// & the width must be no less than 130px and no more than 520 px	This.form.constraints.add({target: This.listbox; set: [\	  {type: "right"; value: 50}; \	  {type: "minimum-width"; value: 150}; \	  {type: "maximum-width"; value: 520}\	]})	
			// The "input" box must stay centered in the dialog.	// 📌 The "input.label" is automatically attached to the input box.	This.form.constraints.add({\	  target: "input"; \	  type: "horizontal-alignment"; \	  alignment: "center"\	})
	
	...
	
Function handleEvents($e : cs.evt)		$e:=$e || cs.evt.new()		If ($e.form)				// Mark: FORM METHOD				Case of 								//==============================================			: ($e.load)								This.form.onLoad()								//==============================================			: ($e.resize)								// Applying the constraints				This.form.constraints.apply()								//==============================================		End case 			Else 				// Mark: WIDGETS METHOD
		
	   ...			End if
	
Function onLoad()
	
	...	
		// Applying the constraints	This.form.constraints.apply()
	
```

