property rules : Collection

Class constructor($metrics : Object)
	
	This:C1470.rules:=[]
	
	This:C1470.scrollBarWidth:=$metrics.scrollBarWidth || Is macOS:C1572 ? 15 : 15
	This:C1470.marginV:=$metrics.marginV || Is macOS:C1572 ? 2 : 2
	This:C1470.marginH:=$metrics.marginH || Is macOS:C1572 ? 20 : 20
	
	This:C1470.offset:=2
	
	This:C1470._matrix:=Not:C34(Is compiled mode:C492)  // True if Dev mode
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
Function add($rule : Object) : cs:C1710.constraintsDelegate
	
	var $name : Text
	var $o : Object
	
	If ($rule.set#Null:C1517)
		
		If (Value type:C1509($rule.target)=Is object:K8:27)\
			 && ($rule.target.name#Null:C1517)
			
			$name:=$rule.target.name
			
		Else 
			
			$name:=String:C10($rule.target)
			
		End if 
		
		For each ($o; $rule.set)
			
			$o.target:=$name
			
			If ($o.reference#Null:C1517)\
				 && (Value type:C1509($o.reference)=Is object:K8:27)\
				 && ($o.reference.name#Null:C1517)
				
				
				$o.reference:=$o.reference.name
				
			End if 
			
			This:C1470.rules.push($o)
			
		End for each 
		
	Else 
		
		If (Value type:C1509($rule.target)=Is object:K8:27)\
			 && ($rule.target.name#Null:C1517)
			
			$rule.target:=$rule.target.name
			
		End if 
		
		If ($rule.reference#Null:C1517)\
			 && (Value type:C1509($rule.reference)=Is object:K8:27)\
			 && ($rule.reference.name#Null:C1517)
			
			$rule.reference:=$rule.reference.name
			
		End if 
		
		
		This:C1470.rules.push($rule)
		
	End if 
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === ===
	// Dealing with constraints
Function apply()
	
	var $offset : Real
	var $alignment; $name : Text
	var $horizontal; $vertical : Boolean
	var $height; $max; $type; $width : Integer
	var $rule : Object
	var $targets : Collection
	var $cur; $ref; $viewport : cs:C1710.coord
	
	// Get the viewport
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($width; $height)
	$viewport:=cs:C1710.coord.new(0; 0; $width; $height)
	
	For each ($rule; This:C1470.rules)
		
		If ($rule.formula#Null:C1517)\
			 && (OB Instance of:C1731($rule.formula; 4D:C1709.Function))
			
			$rule.formula.call(Null:C1517)
			continue
			
		End if 
		
		Case of 
				
				//______________________________________________________
			: (Value type:C1509($rule.target)=Is collection:K8:32)
				
				$targets:=$rule.target
				
				//______________________________________________________
			: (Value type:C1509($rule.target)=Is text:K8:3)
				
				// Can be a comma-separated list of object names
				$targets:=Split string:C1554($rule.target; ","; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
				
				//______________________________________________________
			Else 
				
				ASSERT:C1129(This:C1470._matrix; "rule.target should be a Text or a collection")
				continue
				
				//______________________________________________________
		End case 
		
		If ($targets.length=0)
			
			continue
			
		End if 
		
		For each ($name; $targets)
			
			$type:=OBJECT Get type:C1300(*; $name)
			
			If ($type=Object type unknown:K79:1)
				
				ASSERT:C1129(This:C1470._matrix; "Unknown object name:"+$name)
				continue
				
			End if 
			
			// Current object
			$cur:=cs:C1710.coord.new($name)
			
			// Reference object
			If ($rule.reference#Null:C1517)
				
				$ref:=cs:C1710.coord.new($rule.reference)
				
			Else 
				
				// The reference is the viewport
				$ref:=$viewport
				
				// FIXME:For a sub-form, determine whether there is a vertical scroll bar.
				// This is a property of the container…
				//$ref.right-=This.scrollBarWidth
				
			End if 
			
			Case of 
					
					//______________________________________________________
					// Defines the right edge of an element as a percentage of the reference or the form width
				: ($rule.type="right")  // Set the right edge in percent of the reference
					
					// MARK:right
					$width:=$ref.width*($rule.value<1 ? $rule.value : $rule.value/100)
					$width-=$cur.left
					$cur.right:=$cur.left+$width
					
					Case of 
							
							//……………………………………………………………………………………………………………
						: ($type=Object type text input:K79:4)
							
							// The scrollbar is outside
							OBJECT GET SCROLLBAR:C1076(*; $name; $horizontal; $vertical)
							
							If ($vertical)
								
								$cur.right-=This:C1470.scrollBarWidth
								
							End if 
							
							//……………………………………………………………………………………………………………
						: ($type=Object type picture input:K79:5)
							
							$cur.right+=This:C1470.offset
							
							//……………………………………………………………………………………………………………
						: ($type=Object type rectangle:K79:32)
							
							$cur.right+=(This:C1470.offset*2)
							
							//……………………………………………………………………………………………………………
						: ($type=Object type popup dropdown list:K79:13)
							
							$cur.right+=5
							
							//……………………………………………………………………………………………………………
					End case 
					
					$cur.apply()
					
					//______________________________________________________
				: ($rule.type="minimum-width")  // Minimum object width
					
					// MARK:minimum-width
					$width:=Num:C11($rule.value)
					
					Case of 
							
							//……………………………………………………………………………………………………………
						: ($type=Object type popup dropdown list:K79:13)
							
							$width+=4
							
							//……………………………………………………………………………………………………………
					End case 
					
					If ($cur.width<$width)
						
						$cur.right:=$cur.left+$width
						$cur.apply()
						
					End if 
					
					//______________________________________________________
				: ($rule.type="maximum-width")  // Maximum object width
					
					// MARK:maximum-width
					$width:=Num:C11($rule.value)
					
					Case of 
							
							//……………………………………………………………………………………………………………
						: ($type=Object type popup dropdown list:K79:13)
							
							$width+=4
							
							//……………………………………………………………………………………………………………
					End case 
					
					If ($cur.width>$width)
						
						$cur.right:=$cur.left+$width
						$cur.apply()
						
					End if 
					
					//______________________________________________________
				: ($rule.type="fit-width")  // Adjust width to reference width minus offset if any
					
					// MARK:fit-width
					$cur.right:=$cur.left+($ref.right-$cur.left)-($rule.margin#Null:C1517 ? Num:C11($rule.margin) : This:C1470.marginH)
					$cur.apply()
					
					//______________________________________________________
				: ($rule.type="margin")  // Horizontal offset
					
					// MARK:margin
					$alignment:=String:C10($rule.alignment)
					
					Case of 
							
							//……………………………………………………………………………………………
						: ($alignment="auto")  // Center objects vertically
							
							$offset:=($ref.width-$cur.width)/2
							
							If ($offset>0)
								
								$width:=$cur.width
								$cur.left:=$ref.left+$offset
								$cur.right:=$cur.left+$width
								
							End if 
							
							//……………………………………………………………………………………………
						: ($alignment="left")  // Horizontal offset from left side of reference
							
							$width:=$cur.width
							$cur.left:=$ref.right+($rule.margin#Null:C1517 ? Num:C11($rule.margin) : This:C1470.marginH)
							$cur.right:=$cur.left+$width
							
							//……………………………………………………………………………………………
						: ($alignment="right")  // Horizontal offset from right side of reference
							
							$cur.right:=$ref.left-($rule.margin#Null:C1517 ? Num:C11($rule.margin) : This:C1470.marginH)
							
							//……………………………………………………………………………………………
					End case 
					
					$cur.apply()
					
					//______________________________________________________
				: ($rule.type="horizontal-alignment")
					
					// MARK:horizontal-alignment
					$alignment:=String:C10($rule.alignment)
					
					Case of 
							
							//……………………………………………………………………………………………
						: ($alignment="center")  // Center objects vertically
							
							$offset:=(($ref.width/2)+$ref.left)-(($cur.width/2)+$cur.left)
							$cur.left+=$offset
							$cur.right+=$offset
							
							//……………………………………………………………………………………………
						: ($alignment="left")  // Keep objects aligned on the left
							
							$width:=$cur.width
							$cur.left:=$ref.left+($rule.margin#Null:C1517 ? Num:C11($rule.margin) : This:C1470.marginH)
							$cur.right:=$cur.left+$width
							
							//……………………………………………………………………………………………
						: ($alignment="right")  // Keep objects aligned on the right
							
							$width:=$cur.width
							$cur.right:=$ref.right-($rule.margin#Null:C1517 ? Num:C11($rule.margin) : This:C1470.marginH)
							$cur.left:=$cur.right-$width
							
							//……………………………………………………………………………………………
					End case 
					
					$cur.apply()
					
					//______________________________________________________
				: ($rule.type="vertical-alignment")
					
					// TODO:Vertical alignment
					
					//______________________________________________________
				: ($rule.type="anchor")
					
					// MARK:anchor
					$alignment:=String:C10($rule.alignment)
					
					Case of 
							
							//……………………………………………………………………………………………
						: ($alignment="center")  // Center objects vertically
							
							$offset:=(($ref.width/2)+$ref.left)-(($cur.width/2)+$cur.left)
							$cur.left+=$offset
							$cur.right+=$offset
							
							//……………………………………………………………………………………………
						: ($alignment="left")  // Keep objects aligned on the left
							
							$width:=$cur.width
							$cur.left:=$ref.left+Num:C11($rule.margin)
							$cur.right:=$cur.left+$width
							
							//……………………………………………………………………………………………
						: ($alignment="right")  // Keep objects aligned on the right
							
							$width:=$cur.width
							$cur.right:=$ref.right-Num:C11($rule.margin)
							$cur.left:=$cur.right-$width
							
							//……………………………………………………………………………………………
					End case 
					
					$cur.apply()
					
					//______________________________________________________
				: ($rule.type="inline")
					
					// MARK:inline
					If ($rule.reference=Null:C1517)
						
						ASSERT:C1129(This:C1470._matrix; "Do not omit reference!")
						continue
						
					End if 
					
					$width:=$cur.width
					$cur.left:=$ref.left+$ref.width+($rule.margin#Null:C1517 ? Num:C11($rule.margin) : This:C1470.offset)
					$cur.right:=$cur.left+$width
					$cur.apply()
					
					//______________________________________________________
				: ($rule.type="tile")  // Set width as percent of the reference
					
					// MARK:tile
					// Calculate proportional width
					$width:=Int:C8(($ref.width)*Num:C11($rule.value))
					
					If ($rule.parent#Null:C1517)
						
						// Left is the parent right
						$ref:=cs:C1710.coord.new($rule.parent)
						$cur.left:=$ref.right+Num:C11(OBJECT Get type:C1300(*; $name+".border")#Object type unknown:K79:1)
						
					End if 
					
					$cur.right:=$cur.left+$width
					$cur.apply()
					
					//______________________________________________________
				: ($rule.type="float")
					
					// MARK:float
					$alignment:=String:C10($rule.value)
					
					Case of 
							
							//……………………………………………………………………………………………
						: ($alignment="left")
							
							$width:=$cur.width
							
							$cur.right:=$ref.left-($rule.margin#Null:C1517 ? Num:C11($rule.margin) : This:C1470.marginH)
							$max:=Num:C11($rule.maximum)
							
							If ($max#0)
								
								$cur.right:=$cur.right>$max ? $max : $cur.right
								
							End if 
							
							$cur.left:=$cur.right-$width
							
							//……………………………………………………………………………………………
						Else 
							
							ASSERT:C1129(This:C1470._matrix; "Unmanaged alignment:"+$alignment)
							continue
							
							//……………………………………………………………………………………………
					End case 
					
					$cur.apply()
					
					//______________________________________________________
				Else 
					
					ASSERT:C1129(This:C1470._matrix; "Unknown constraint:"+String:C10($rule.type))
					continue
					
					//______________________________________________________
			End case 
			
			// Adjust the border if any
			If (OBJECT Get type:C1300(*; $name+".border")=Object type unknown:K79:1)
				
				continue
				
			End if 
		End for each 
	End for each 
	
	// Delete one-shot rules
	This:C1470.rules:=This:C1470.rules.filter(Formula:C1597($1.result:=Bool:C1537($1.value.toDelete)=False:C215))