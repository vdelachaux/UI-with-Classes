
// The first widget group should be right-aligned and its members treated as buttons.
cs:C1710.ui.group.new("Button,Button1,Button2"; "button").distributeRigthToLeft()

// The second group of widgets must be left-aligned and have no special type.
// (it will be treated as a group of statics)
cs:C1710.ui.group.new("Button5,Button4,Button3").distributeLeftToRight()

// The third group is a group of buttons and should be distributed around its center.
cs:C1710.ui.group.new([cs:C1710.ui.button.new("Button6"); cs:C1710.ui.button.new("Button7"); cs:C1710.ui.button.new("Button8")]).distributeAroundCenter()

// The fourth group of widgets should be distributed around its center, and its members treated as buttons.
// They must also be separated by 2 px and the minimum width of a button is 20 px.
cs:C1710.ui.group.new("Button9"; "Button10"; "Button11"; "button").distributeAroundCenter({spacing: 2; minWidth: 20})

// No widget has the focus at dialog opening.
cs:C1710.ui.form.new().removeFocus()