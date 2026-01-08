
// The first widget group should be right-aligned and its members treated as buttons.
// Notes that we give the “button” type to the group members, so the height is adjusted according to the platform. 
cs:C1710.ui.group.new("Button,Button1,Button2"; "button").distributeRigthToLeft()

// The second group of widgets must be left-aligned and have no special type.
// It will be treated as a group of statics ie. the height is not adjusted.
cs:C1710.ui.group.new("Button5,Button4,Button3").distributeLeftToRight()

// The third group is a collection of buttons and should be distributed around its center.
cs:C1710.ui.group.new([cs:C1710.ui.button.new("Button6"); cs:C1710.ui.button.new("Button7"); cs:C1710.ui.button.new("Button8")]).distributeAroundCenter()

// The fourth group of widgets have a name starting with "myButton"
// They should be distributed around its center, and its members treated as buttons.
// They must also be separated by 2 px and the minimum width of a button is 15 px.
// Finally, all buttons belonging to the group are disabled.
cs:C1710.ui.group.new("myButton@"; "button").distributeAroundCenter({spacing: 2; minWidth: 15}).disable()

// No widget has the focus at dialog opening.
cs:C1710.ui.form.new().removeFocus()