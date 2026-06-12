property direction:="row"  // = row || column
property padding:=0
property alignItems:="start"
property flexWrap:=True:C214  // Default is wrap
property uniformWrapWidth:=False:C215
property justifyContent:="start"

property children:=[]

property width : Real
property height : Real

property _container : Object

// === === === === === === === === === === === === === === === === === === === === === === === === === ===
// Constructor
// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Class constructor($container : Object; $options : Object)
	
	This:C1470.container:=$container
	
	var $key : Text
	For each ($key; $options || {})
		
		Case of 
				//______________________________________________________
			: ($key="children")\
				 && (Value type:C1509($options[$key])=Is collection:K8:32)
				
				var $child : Object
				For each ($child; $options[$key])
					
					This:C1470.add($child)
					
				End for each 
				
				//______________________________________________________
			Else 
				
				This:C1470[$key]:=$options[$key]
				
				//______________________________________________________
		End case 
		
		
	End for each 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function add($widget : cs:C1710.static) : cs:C1710.flexContainer
	
	var $rule:=$widget.flexRules
	
	Case of 
			
			// ______________________________________________________
		: ($rule=Null:C1517)
			
			// <NOTHING MORE TO DO>
			
			// ______________________________________________________
		: ($rule.type="bakground")
			
			$widget.setResizingOptions(Resize horizontal grow:K42:8; Resize vertical grow:K42:11)
			
			If ($rule.minHeight#Null:C1517)
				
				var $resize : Boolean
				var $min; $max : Integer
				FORM GET VERTICAL RESIZING:C1078($resize; $min; $max)
				FORM SET VERTICAL RESIZING:C893($resize; $rule.minHeight; $max)
				
			End if 
			
			If ($rule.minWidth#Null:C1517)
				
				FORM GET HORIZONTAL RESIZING:C1077($resize; $min; $max)
				FORM SET HORIZONTAL RESIZING:C892($resize; $rule.minWidth; $max)
				
			End if 
			
			// ______________________________________________________
		: (This:C1470.direction="column")
			
			
			If (This:C1470.alignItems="stretch")
				
				$widget.setResizingOptions(Resize horizontal grow:K42:8; Resize vertical grow:K42:11)
				
			Else 
				
				$widget.setResizingOptions($widget.resizingOptions.horizontal; Resize horizontal grow:K42:8)
				
			End if 
			
			// ______________________________________________________
		: (This:C1470.direction="row")
			
			If (This:C1470.alignItems="stretch")
				
				$widget.setResizingOptions(Resize horizontal grow:K42:8; Resize vertical grow:K42:11)
				
			Else 
				
				$widget.setResizingOptions(Resize horizontal grow:K42:8)
				
			End if 
			
			// ______________________________________________________
	End case 
	
	This:C1470.children.push($widget)
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function set container($container : Object)
	
	This:C1470._container:=$container
	
	If ($container#Null:C1517)
		
		This:C1470.height:=Num:C11($container.height)
		This:C1470.width:=Num:C11($container.width)
		
	Else 
		
		var $with; $height : Integer
		OBJECT GET SUBFORM CONTAINER SIZE:C1148($with; $height)
		
		This:C1470.width:=$with
		This:C1470.height:=$height
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function layout()
	
	This:C1470._getContainerDimensions()
	
	If (This:C1470.direction="row")
		
		If (This:C1470.flexWrap)
			
			This:C1470._layoutRowWrap()
			
		Else 
			
			This:C1470._layoutRow()
			
		End if 
		
	Else 
		
		This:C1470._layoutColumn()
		
	End if 
	
	// MARK:- Keywords
	// _______________________________________________________________________________________________________
Function get wrap() : cs:C1710.flexContainer
	
	This:C1470.flexWrap:=True:C214
	return This:C1470
	
	// _______________________________________________________________________________________________________
Function get noWrap() : cs:C1710.flexContainer
	
	This:C1470.flexWrap:=False:C215
	return This:C1470
	
	// _______________________________________________________________________________________________________
Function get directionRow() : cs:C1710.flexContainer
	
	This:C1470.direction:="row"
	return This:C1470
	
	// _______________________________________________________________________________________________________
Function get directionColumn() : cs:C1710.flexContainer
	
	This:C1470.direction:="column"
	return This:C1470
	
	// _______________________________________________________________________________________________________
Function get alignStart() : cs:C1710.flexContainer
	
	This:C1470.alignItems:="start"
	return This:C1470
	
	// _______________________________________________________________________________________________________
Function get alignCenter() : cs:C1710.flexContainer
	
	This:C1470.alignItems:="center"
	return This:C1470
	
	// _______________________________________________________________________________________________________
Function get alignEnd() : cs:C1710.flexContainer
	
	This:C1470.alignItems:="end"
	return This:C1470
	
	// _______________________________________________________________________________________________________
Function get alignSpaceBetween() : cs:C1710.flexContainer
	
	This:C1470.alignItems:="space-between"
	return This:C1470
	
	// _______________________________________________________________________________________________________
Function get uniformWidth() : cs:C1710.flexContainer
	
	This:C1470.uniformWrapWidth:=True:C214
	return This:C1470
	
	// _______________________________________________________________________________________________________
Function get variableWidth() : cs:C1710.flexContainer
	
	This:C1470.uniformWrapWidth:=False:C215
	return This:C1470
	
	// MARK:- Private
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _getContainerDimensions()
	
	var $container:=This:C1470._container
	
	If ($container#Null:C1517)
		
		This:C1470.height:=Num:C11($container.height)
		This:C1470.width:=Num:C11($container.width)
		
	Else 
		
		var $with; $height : Integer
		OBJECT GET SUBFORM CONTAINER SIZE:C1148($with; $height)
		
		This:C1470.width:=$with
		This:C1470.height:=$height
		
	End if 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _layoutRow()
	
	var $count:=This:C1470.children.length
	
	If ($count=0)
		
		return 
		
	End if 
	
	var $available : Real:=This:C1470.width-(This:C1470.padding*2)-(This:C1470.padding*($count-1))
	
	If ($available<0)
		
		$available:=0
		
	End if 
	
	var $totalBasis; $totalGrow; $totalShrink : Real
	var $child : Object
	var $constraints : Object
	var $width : Real
	
	For each ($child; This:C1470.children)
		
		$constraints:=This:C1470._getConstraints($child)
		$totalBasis+=$constraints.flexBasis
		$totalGrow+=$constraints.flexGrow
		$totalShrink+=$constraints.flexShrink
		
	End for each 
	
	var $remaining : Real:=$available-$totalBasis
	var $x:=This:C1470.padding
	var $gap:=This:C1470.padding
	
	// Pass 1: compute effective widths after grow/shrink and min/max clamps.
	var $effectiveWidths:=[]
	var $usedWidth : Real:=0
	
	For each ($child; This:C1470.children)
		
		$constraints:=This:C1470._getConstraints($child)
		
		If ($remaining<0)
			
			// In nowrap mode, keep base widths and let content overflow horizontally.
			// This avoids visual truncation caused by automatic shrink.
			$width:=$constraints.flexBasis
			
		Else 
			
			If ($totalGrow>0)
				
				$width:=$constraints.flexBasis+(($constraints.flexGrow/$totalGrow)*$remaining)
				
			Else 
				
				$width:=$constraints.flexBasis
				
			End if 
		End if 
		
		If ($constraints.minWidth#Null:C1517) && ($width<$constraints.minWidth)
			
			$width:=$constraints.minWidth
			
		End if 
		
		If ($constraints.maxWidth#Null:C1517) && ($width>$constraints.maxWidth)
			
			$width:=$constraints.maxWidth
			
		End if 
		
		If ($width<0)
			
			$width:=0
			
		End if 
		
		$effectiveWidths.push($width)
		$usedWidth+=$width
		
	End for each 
	
	var $effectiveRemaining : Real:=$available-$usedWidth
	
	If ($effectiveRemaining>0)
		
		Case of 
				
				// ________________________________________________________________________________
			: (This:C1470.justifyContent="center")
				
				$x+=$effectiveRemaining/2
				
				// ________________________________________________________________________________
			: (This:C1470.justifyContent="end")
				
				$x+=$effectiveRemaining
				
				// ________________________________________________________________________________
			: (This:C1470.justifyContent="space-between")
				
				If ($count>1)
					
					$gap+=$effectiveRemaining/($count-1)
					
				End if 
				
				// ________________________________________________________________________________
		End case 
	End if 
	
	// Pass 2: apply geometry with effective widths.
	var $index : Integer:=0
	For each ($child; This:C1470.children)
		
		$constraints:=This:C1470._getConstraints($child)
		$width:=$effectiveWidths[$index]
		
		$child.left:=$x
		$child.width:=$width
		
		var $height : Real:=This:C1470.height-(This:C1470.padding*2)
		
		If (This:C1470.alignItems="stretch")
			
			$child.height:=$height
			
		Else 
			
			If ($constraints.adjustHeight)
				
				$child.height:=$height
				
			End if 
		End if 
		
		If ($constraints.minHeight#Null:C1517) && ($child.height<$constraints.minHeight)
			
			$child.height:=$constraints.minHeight
			
		End if 
		
		If ($constraints.maxHeight#Null:C1517) && ($child.height>$constraints.maxHeight)
			
			$child.height:=$constraints.maxHeight
			
		End if 
		
		This:C1470._alignCrossAxis($child; "row")
		$x+=$width+$gap
		
		$index+=1
		
	End for each 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _layoutRowWrap()
	
	var $count:=This:C1470.children.length
	
	If ($count=0)
		
		return 
		
	End if 
	
	var $contentWidth : Real:=This:C1470.width-(This:C1470.padding*2)
	$contentWidth:=$contentWidth<0 ? 0 : $contentWidth
	
	var $lineItems:=[]
	var $lines:=[]
	
	var $baseGap:=This:C1470.padding
	
	var $lineUsedWidth:=0
	var $lineHeight:=0
	
	// MARK: Pass 1: split children into lines using clamped base widths.
	var $child : Object
	For each ($child; This:C1470.children)
		
		var $constraints:=This:C1470._getConstraints($child)
		var $width : Real:=$constraints.flexBasis
		
		If ($width<=0)
			
			If (($child.initialPosition#Null:C1517)\
				 && ($child.initialPosition.width>0))
				$width:=Num:C11($child.initialPosition.width)
				
			Else 
				
				$width:=Num:C11($child.width)
				
			End if 
		End if 
		
		If (($constraints.minWidth#Null:C1517)\
			 && ($width<$constraints.minWidth))
			
			$width:=$constraints.minWidth
			
		End if 
		
		If (($constraints.maxWidth#Null:C1517)\
			 && ($width>$constraints.maxWidth))
			
			$width:=$constraints.maxWidth
			
		End if 
		
		$width:=$width<0 ? 0 : $width
		
		var $height : Real
		If ($child.initialPosition#Null:C1517)
			
			$height:=Num:C11($child.initialPosition.height)
			
		Else 
			
			$height:=Num:C11($child.height)
			
		End if 
		
		If (($constraints.minHeight#Null:C1517)\
			 && ($height<$constraints.minHeight))
			
			$height:=$constraints.minHeight
			
		End if 
		
		If (($constraints.maxHeight#Null:C1517)\
			 && ($height>$constraints.maxHeight))
			
			$height:=$constraints.maxHeight
			
		End if 
		
		$height:=$height<0 ? 0 : $height
		
		If (($lineItems.length>0)\
			 && ($lineUsedWidth+$baseGap+$width>$contentWidth))
			
			$lines.push({items: $lineItems; lineHeight: $lineHeight})
			$lineItems:=[]
			$lineUsedWidth:=0
			$lineHeight:=0
			
		End if 
		
		If ($lineItems.length>0)
			
			$lineUsedWidth+=$baseGap
			
		End if 
		
		$lineUsedWidth+=$width
		$lineHeight:=This:C1470._max($lineHeight; $height)
		$lineItems.push({child: $child; constraints: $constraints; basis: $width; baseHeight: $height})
		
	End for each 
	
	If ($lineItems.length>0)
		
		$lines.push({items: $lineItems; lineHeight: $lineHeight})
		
	End if 
	
	// MARK: Pass 2a: if uniformWrapWidth, pre-calculate target width based on column count.
	var $uniformTargetWidth : Real:=0
	
	If (This:C1470.uniformWrapWidth)
		
		// Find max items on any line (determines column count)
		var $maxItemsPerLine : Integer:=0
		var $line : Object
		For each ($line; $lines)
			
			$maxItemsPerLine:=This:C1470._max($maxItemsPerLine; $line.items.length)
			
		End for each 
		
		If ($maxItemsPerLine>0)
			
			// Calculate uniform width: (contentWidth - gaps) / columns
			var $lineGaps : Real:=($maxItemsPerLine>1) ? (($maxItemsPerLine-1)*$baseGap) : 0
			var $uniformAvailable:=$contentWidth-$lineGaps
			
			If ($uniformAvailable<0)
				
				$uniformAvailable:=0
				
			End if 
			
			$uniformTargetWidth:=$uniformAvailable/$maxItemsPerLine
			
		End if 
		
		If ($uniformTargetWidth<0)
			
			$uniformTargetWidth:=0
			
		End if 
		
	End if 
	
	// MARK: Pass 2b: flex distribution per line, then placement.
	var $y:=This:C1470.padding
	
	For each ($line; $lines)
		
		var $items : Collection:=$line.items
		var $currentLineHeight : Real:=$line.lineHeight
		var $gapsWidth : Real:=($items.length>1) ? (($items.length-1)*$baseGap) : 0
		var $lineAvailable:=$contentWidth-$gapsWidth
		
		If ($lineAvailable<0)
			
			$lineAvailable:=0
			
		End if 
		
		var $totalBasis:=0
		var $totalGrow:=0
		var $totalShrink:=0
		
		var $item : Object
		For each ($item; $items)
			
			$constraints:=$item.constraints
			$totalBasis+=$item.basis
			$totalGrow+=$constraints.flexGrow
			$totalShrink+=$constraints.flexShrink
			
		End for each 
		
		var $remaining:=$lineAvailable-$totalBasis
		var $effectiveWidths:=[]
		var $usedItemsWidth:=0
		
		For each ($item; $items)
			
			$constraints:=$item.constraints
			$width:=$item.basis
			
			If ($remaining<0)
				
				If ($totalShrink>0)
					
					$width:=$item.basis+(($constraints.flexShrink/$totalShrink)*$remaining)
					
				End if 
				
			Else 
				
				If ($totalGrow>0)
					
					$width:=$item.basis+(($constraints.flexGrow/$totalGrow)*$remaining)
					
				End if 
			End if 
			
			If (($constraints.minWidth#Null:C1517)\
				 && ($width<$constraints.minWidth))
				
				$width:=$constraints.minWidth
				
			End if 
			
			If (($constraints.maxWidth#Null:C1517)\
				 && ($width>$constraints.maxWidth))
				
				$width:=$constraints.maxWidth
				
			End if 
			
			If ($width<0)
				
				$width:=0
				
			End if 
			
			$effectiveWidths.push($width)
			$usedItemsWidth+=$width
			
		End for each 
		
		var $usedWidth:=$usedItemsWidth+$gapsWidth
		var $lineRemaining:=$contentWidth-$usedWidth
		var $x:=This:C1470.padding
		var $gap:=$baseGap
		
		If ($lineRemaining>0)
			
			Case of 
					
					//________________________________________________________________________________
				: (This:C1470.justifyContent="center")
					
					$x+=$lineRemaining/2
					
					//________________________________________________________________________________
				: (This:C1470.justifyContent="end")
					
					$x+=$lineRemaining
					
					//________________________________________________________________________________
				: (This:C1470.justifyContent="space-between")
					
					If ($items.length>1)
						
						$gap+=$lineRemaining/($items.length-1)
						
					End if 
					
					//________________________________________________________________________________
			End case 
		End if 
		
		// MARK: Phase 3 - apply
		var $index : Integer:=0
		For each ($item; $items)
			
			$child:=$item.child
			$constraints:=$item.constraints
			
			If (This:C1470.uniformWrapWidth)
				
				// Use pre-calculated uniform width, clamped to constraints
				$width:=$uniformTargetWidth
				
				If (($constraints.minWidth#Null:C1517) && ($width<$constraints.minWidth))
					
					$width:=$constraints.minWidth
					
				End if 
				
				If (($constraints.maxWidth#Null:C1517) && ($width>$constraints.maxWidth))
					
					$width:=$constraints.maxWidth
					
				End if 
				
			Else 
				
				// Standard per-line distribution
				$width:=$effectiveWidths[$index]
				
			End if 
			
			$height:=$item.baseHeight
			
			$child.left:=$x
			$child.width:=$width
			
			var $align : Text:=($constraints.alignSelf#Null:C1517) ? $constraints.alignSelf : This:C1470.alignItems
			
			Case of 
					
					//________________________________________________________________________________
				: ($align="center")
					
					$child.top:=$y+(($currentLineHeight-$height)/2)
					$child.height:=$height
					
					//________________________________________________________________________________
				: ($align="end")
					
					$child.top:=$y+($currentLineHeight-$height)
					$child.height:=$height
					
					//________________________________________________________________________________
				: ($align="stretch")
					
					$child.top:=$y
					$child.height:=$currentLineHeight
					
					//________________________________________________________________________________
				Else 
					$child.top:=$y
					$child.height:=$height
					
					//________________________________________________________________________________
			End case 
			
			$x+=$width+$gap
			$index+=1
			
		End for each 
		
		$y+=$currentLineHeight+This:C1470.padding
		
	End for each 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _layoutColumn()
	
	var $count:=This:C1470.children.length
	
	If ($count=0)
		
		return 
		
	End if 
	
	var $available : Real:=This:C1470.height-(This:C1470.padding*2)-(This:C1470.padding*($count-1))
	
	If ($available<0)
		
		$available:=0
		
	End if 
	
	var $totalBasis; $totalGrow; $totalShrink : Real
	var $child : Object
	var $constraints : Object
	var $height : Real
	
	For each ($child; This:C1470.children)
		
		$constraints:=This:C1470._getConstraints($child)
		$totalBasis+=$constraints.flexBasis
		$totalGrow+=$constraints.flexGrow
		$totalShrink+=$constraints.flexShrink
		
	End for each 
	
	var $remaining : Real:=$available-$totalBasis
	var $y:=This:C1470.padding
	var $gap:=This:C1470.padding
	
	// Pass 1: compute effective heights after grow/shrink and min/max clamps.
	var $effectiveHeights:=[]
	var $usedHeight : Real:=0
	
	For each ($child; This:C1470.children)
		
		$constraints:=This:C1470._getConstraints($child)
		
		If ($remaining<0)
			
			If ($totalShrink>0)
				
				$height:=$constraints.flexBasis+($constraints.flexShrink/$totalShrink)*$remaining
				
			Else 
				
				$height:=$constraints.flexBasis
				
			End if 
			
		Else 
			
			If ($totalGrow>0)
				
				$height:=$constraints.flexBasis+($constraints.flexGrow/$totalGrow)*$remaining
				
			Else 
				
				$height:=$constraints.flexBasis
				
			End if 
		End if 
		
		If ($constraints.minHeight#Null:C1517)
			
			If ($height<$constraints.minHeight)
				
				$height:=This:C1470._max($height; $constraints.minHeight)
				
			End if 
		End if 
		
		If ($constraints.maxHeight#Null:C1517)
			
			If ($height>$constraints.maxHeight)
				
				$height:=This:C1470._min($height; $constraints.maxHeight)
				
			End if 
		End if 
		
		If ($height<0)
			
			$height:=0
			
		End if 
		
		$effectiveHeights.push($height)
		$usedHeight+=$height
		
	End for each 
	
	var $effectiveRemaining : Real:=$available-$usedHeight
	
	If ($effectiveRemaining>0)
		
		Case of 
				
				// ________________________________________________________________________________
			: (This:C1470.justifyContent="center")
				
				$y+=$effectiveRemaining/2
				
				// ________________________________________________________________________________
			: (This:C1470.justifyContent="end")
				
				$y+=$effectiveRemaining
				
				// ________________________________________________________________________________
			: (This:C1470.justifyContent="space-between")
				
				If ($count>1)
					
					$gap+=$effectiveRemaining/($count-1)
					
				End if 
				
				// ________________________________________________________________________________
		End case 
	End if 
	
	// Pass 2: apply geometry with effective heights.
	var $index : Integer:=0
	For each ($child; This:C1470.children)
		
		$index+=1
		
		$constraints:=This:C1470._getConstraints($child)
		$height:=$effectiveHeights[$index-1]
		
		$child.top:=$y
		$child.height:=$height
		
		If (This:C1470.alignItems="stretch")
			
			$child.width:=This:C1470.width-(This:C1470.padding*2)
			
		Else 
			
			If ($constraints.adjustWidth)
				
				$child.width:=This:C1470.width-(This:C1470.padding*2)
				
			End if 
		End if 
		
		If ($constraints.minWidth#Null:C1517)
			
			If ($child.width<$constraints.minWidth)
				
				$child.width:=$constraints.minWidth
				
			End if 
		End if 
		
		If ($constraints.maxWidth#Null:C1517)
			
			If ($child.width>$constraints.maxWidth)
				
				$child.width:=$constraints.maxWidth
				
			End if 
		End if 
		
		This:C1470._alignCrossAxis($child; "column")
		$y+=$height+$gap
		
	End for each 
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _getConstraints($child : Object) : Object
	
	var $constraints : Object:=$child.flexRules || {}
	
	$constraints.flexBasis:=$constraints.flexBasis#Null:C1517 ? $constraints.flexBasis : 0
	$constraints.flexGrow:=$constraints.flexGrow#Null:C1517 ? $constraints.flexGrow : 10
	$constraints.flexShrink:=$constraints.flexShrink#Null:C1517 ? $constraints.flexShrink : 1
	$constraints.adjustHeight:=$constraints.adjustHeight#Null:C1517 ? $constraints.adjustHeight : False:C215
	$constraints.adjustWidth:=$constraints.adjustWidth#Null:C1517 ? $constraints.adjustWidth : False:C215
	
	return $constraints
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _max( ...  : Real) : Real
	
	var $i : Integer
	var $value:=0
	
	For ($i; 1; Count parameters:C259; 1)
		
		If ($i>1)\
			 && (${$i}<=$value)
			
			continue
			
		End if 
		
		$value:=${$i}
		
	End for 
	
	return $value
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _min( ...  : Real) : Real
	
	var $i : Integer
	var $value:=0
	
	For ($i; 1; Count parameters:C259; 1)
		
		If ($i>1)\
			 && (${$i}>=$value)
			
			continue
			
		End if 
		
		$value:=${$i}
		
	End for 
	
	return $value
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _alignCrossAxis($child : Object; $mode : Text)
	
	var $constraints:=This:C1470._getConstraints($child)
	
	If ($constraints.alignSelf#Null:C1517)
		
		var $align : Text:=$constraints.alignSelf
		
	Else 
		
		$align:=This:C1470.alignItems
		
	End if 
	
	Case of 
			
			//________________________________________________________________________________
		: ($mode="row")
			
			Case of 
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
				: ($align="center")
					
					$child.top:=(This:C1470.height-$child.height)/2
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
				: ($align="end")
					
					$child.top:=This:C1470.height-$child.height
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
				Else 
					
					$child.top:=0
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
			End case 
			
			$child.top+=This:C1470.padding
			
			//________________________________________________________________________________
		: ($mode="column")
			
			Case of 
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
				: ($align="center")
					
					$child.left:=(This:C1470.width-$child.width)/2
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
				: ($align="end")
					
					$child.left:=This:C1470.width-$child.width
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
				Else 
					
					$child.left:=0
					
					// ┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
			End case 
			
			$child.left+=This:C1470.padding
			
			//________________________________________________________________________________
	End case 
	
	