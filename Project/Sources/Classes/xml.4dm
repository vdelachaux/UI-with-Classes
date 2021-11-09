Class constructor($variable)
	
	This:C1470.root:=Null:C1517
	This:C1470.file:=Null:C1517
	This:C1470.xml:=Null:C1517
	
	This:C1470.success:=False:C215
	This:C1470.autoClose:=True:C214
	
	This:C1470.errors:=New collection:C1472
	
	If (Count parameters:C259>=1)
		
		This:C1470.load($variable)
		
	Else 
		
		This:C1470.success:=True:C214
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Creates a XML tree in memory
Function newRef($root : Text)->$this : cs:C1710.xml
	
	var ${2} : Text
	var $t : Text
	var $countParam; $i : Integer
	
	$countParam:=Count parameters:C259
	
	OK:=0
	
	This:C1470._reset()
	
	Case of 
			
			//______________________________________________________
		: ($countParam=0)
			
			This:C1470.root:=DOM Create XML Ref:C861("root")
			
			//______________________________________________________
		: ($countParam=1)  // -> root
			
			This:C1470.root:=DOM Create XML Ref:C861($root)
			
			//______________________________________________________
		: ($countParam=2)  // -> root + namespace
			
			This:C1470.root:=DOM Create XML Ref:C861($root; $2)
			
			//______________________________________________________
		: (($countParam%2)=0)  // -> root + namespace's pairs
			
			$t:="DOM Create XML Ref:C861("
			
			For ($i; 1; $countParam; 2)
				
				$t:=$t+(";"*Num:C11($i>1))+"\""+${$i}+"\";\""+${$i+1}+"\""
				
			End for 
			
			$t:=$t+")"
			
			This:C1470.root:=Formula from string:C1601($t).call()
			
			//______________________________________________________
		Else   // -> root + namespace + namespace's pairs
			
			$t:="DOM Create XML Ref:C861("+$root+";"+$1
			
			For ($i; 2; $countParam; 2)
				
				$t:=$t+";\""+${$i}+"\";\""+${$i+1}+"\""
				
			End for 
			
			$t:=$t+")"
			
			This:C1470.root:=Formula from string:C1601($t).call()
			
			//______________________________________________________
	End case 
	
	This:C1470.success:=Bool:C1537(OK)
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Set the value of one option for the structure
Function setOption($selector : Integer; $value : Integer)->$this : cs:C1710.xml
	
	This:C1470.success:=(Count parameters:C259=2)
	
	If (This:C1470.success)
		
		XML SET OPTIONS:C1090(This:C1470.root; $selector; $value)
		
	Else 
		
		This:C1470.errors.push(Current method name:C684+" -  Unbalanced selector/value pairs")
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Set the value of one or more XML options for the structure
Function setOptions($selector : Integer; $value : Integer)->$this : cs:C1710.xml
	var ${3} : Integer
	
	var $i : Integer
	
	This:C1470.success:=((Count parameters:C259%2)=0)
	
	If (This:C1470.success)
		
		For ($i; 1; Count parameters:C259; 2)
			
			XML SET OPTIONS:C1090(This:C1470.root; ${$i}; ${$i+1})
			
		End for 
		
	Else 
		
		This:C1470.errors.push(Current method name:C684+" -  Unbalanced selector/value pairs")
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Parse a variable (TEXT or BLOB)
Function parse($source : Variant; $validate : Boolean; $schema : Text)->$this : cs:C1710.xml
	
	Case of 
			
			//……………………………………………………………………………………………
		: (Count parameters:C259=3)
			
			$this:=This:C1470.load($source; $validate; $schema)
			
			//……………………………………………………………………………………………
		: (Count parameters:C259=2)
			
			$this:=This:C1470.load($source; $validate)
			
			//……………………………………………………………………………………………
		: (Count parameters:C259=1)
			
			$this:=This:C1470.load($source)
			
			//……………………………………………………………………………………………
		Else 
			
			$this:=This:C1470.load()
			
			//……………………………………………………………………………………………
	End case 
	
	//———————————————————————————————————————————————————————————
	// Open and parse a file
Function open($file : 4D:C1709.File; $validate : Boolean; $schema : Text)->$this : cs:C1710.xml
	
	Case of 
			
			//……………………………………………………………………………………………
		: (Count parameters:C259=3)
			
			$this:=This:C1470.load($file; $validate; $schema)
			
			//……………………………………………………………………………………………
		: (Count parameters:C259=2)
			
			$this:=This:C1470.load($file; $validate)
			
			//……………………………………………………………………………………………
		: (Count parameters:C259=1)
			
			$this:=This:C1470.load($file)
			
			//……………………………………………………………………………………………
		Else 
			
			$this:=This:C1470.load()
			
			//……………………………………………………………………………………………
	End case 
	
	//———————————————————————————————————————————————————————————
	// Load a variable (TEXT or BLOB) or a file
Function load($source : Variant; $validate : Boolean; $schema : Text)->$this : cs:C1710.xml
	
	var $root : Text
	
	This:C1470.close()  // Release memory
	
	Case of 
			
			//______________________________________________________
		: (Count parameters:C259=0)
			
			This:C1470.success:=False:C215
			This:C1470.errors.push(Current method name:C684+" -  Missing the target to load")
			
			//______________________________________________________
		: (Value type:C1509($source)=Is text:K8:3)\
			 | (Value type:C1509($source)=Is BLOB:K8:12)  // Parse a given variable
			
			Case of 
					
					//……………………………………………………………………………………………
				: (Count parameters:C259=1)
					
					$root:=DOM Parse XML variable:C720($source)
					
					//……………………………………………………………………………………………
				: (Count parameters:C259=2)
					
					$root:=DOM Parse XML variable:C720($source; $validate)
					
					//……………………………………………………………………………………………
				Else 
					
					$root:=DOM Parse XML variable:C720($source; $validate; $schema)
					
					//……………………………………………………………………………………………
			End case 
			
			This:C1470.success:=Bool:C1537(OK)
			
			If (This:C1470.success)
				
				This:C1470.root:=$root
				
			Else 
				
				This:C1470.errors.push(Current method name:C684+" -  Failed to parse the "+Choose:C955(Value type:C1509($source)=Is text:K8:3; "text"; "blob")+" variable")
				
			End if 
			
			//______________________________________________________
		: (Value type:C1509($source)=Is object:K8:27)  // File to load
			
			This:C1470.success:=OB Instance of:C1731($source; 4D:C1709.File)
			
			If (This:C1470.success)
				
				This:C1470.success:=Bool:C1537($source.isFile) & Bool:C1537($source.exists)
				
				If (This:C1470.success)
					
					Case of 
							
							//……………………………………………………………………………………………
						: (Count parameters:C259=1)
							
							$root:=DOM Parse XML source:C719($source.platformPath)
							
							//……………………………………………………………………………………………
						: (Count parameters:C259=2)
							
							$root:=DOM Parse XML source:C719($source.platformPath; $validate)
							
							//……………………………………………………………………………………………
						Else 
							
							$root:=DOM Parse XML source:C719($source.platformPath; $validate; $schema)
							
							//……………………………………………………………………………………………
					End case 
					
					This:C1470.success:=Bool:C1537(OK)
					
					If (This:C1470.success)
						
						This:C1470.root:=$root
						This:C1470.file:=$source
						
					End if 
					
				Else 
					
					This:C1470.errors.push(Current method name:C684+" -  File not found: "+String:C10($source.platformPath))
					
				End if 
				
			Else 
				
				This:C1470.errors.push(Current method name:C684+" -  The parameter is not a File object")
				
			End if 
			
			//______________________________________________________
		Else 
			
			This:C1470.errors.push(Current method name:C684+" -  Unmanaged type: "+String:C10(Value type:C1509($source)))
			
			//________________________________________
	End case 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function save($file : Variant; $keepStructure : Boolean)->$this : cs:C1710.xml
	
	var $close : Boolean
	var $t : Text
	var $fileƒ : 4D:C1709.File
	
	If (Count parameters:C259>=2)
		
		$fileƒ:=$file
		$close:=$keepStructure
		
	Else 
		
		If (Count parameters:C259>=1)
			
			If (Value type:C1509($file)=Is object:K8:27)
				
				$fileƒ:=$file
				
			Else 
				
				$fileƒ:=This:C1470.file
				$close:=Bool:C1537($file)
				
			End if 
			
		Else 
			
			$fileƒ:=This:C1470.file
			
		End if 
	End if 
	
	This:C1470.success:=OB Instance of:C1731($fileƒ; 4D:C1709.File)
	
	If (This:C1470.success)
		
		DOM EXPORT TO VAR:C863(This:C1470.root; $t)
		This:C1470.success:=Bool:C1537(OK)
		
		If (This:C1470.success)
			
			This:C1470.xml:=$t
			$fileƒ.setText($t)
			
		Else 
			
			This:C1470.errors.push(Current method name:C684+" -  Failed to export XML")
			
		End if 
		
	Else 
		
		This:C1470.errors.push(Current method name:C684+" -  File is not defined")
		
	End if 
	
	If (This:C1470.success)
		
		If (Count parameters:C259>=1)
			
			This:C1470._close($close)
			
		Else 
			
			This:C1470._close()
			
		End if 
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Close the XML tree
Function close()->$this : cs:C1710.xml
	
	This:C1470.success:=(This:C1470.root#Null:C1517)
	
	If (This:C1470.success)
		
		DOM CLOSE XML:C722(This:C1470.root)
		This:C1470.success:=Bool:C1537(OK)
		This:C1470.root:=Null:C1517
		
	End if 
	
	$this:=This:C1470
	
/*———————————————————————————————————————————————————————————*/
Function create($target : Text; $XPath : Variant; $attributes : Variant)->$node : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (This:C1470.isReference($target))
			
			$node:=DOM Create XML element:C865($target; $XPath)
			
			If (Count parameters:C259>=3)
				
				This:C1470.setAttributes($node; $attributes)
				
			End if 
			
		Else 
			
			$node:=DOM Create XML element:C865(This:C1470.root; $target)
			
			If (Count parameters:C259>=2)
				
				This:C1470.setAttributes($node; $XPath)
				
			End if 
		End if 
		
		This:C1470.success:=Bool:C1537(OK)
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Append a source element to the target element
Function append($target : Text; $source : Text)->$node : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 2))
		
		$node:=DOM Append XML element:C1082($target; $source)
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Insert a XML element among the child elements of the $target element
Function insert($target : Text; $source : Text; $index : Integer)->$node : Text
	
	var $indx : Integer
	
	If (This:C1470._requiredParams(Count parameters:C259; 2))
		
		If (Count parameters:C259>=3)
			
			$indx:=$index
			
		End if 
		
		$node:=DOM Insert XML element:C1083($target; $source; $indx)
		This:C1470.success:=Bool:C1537(OK)
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Makes a copy of the given object
Function clone($source : Text; $target : Text)->$node : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 2))
		
		$node:=DOM Append XML element:C1082($target; $source)
		This:C1470.success:=Bool:C1537(OK)
		
	End if 
	
	//———————————————————————————————————————————————————————————/
	// Returns the XML tree as text
Function getText($keepStructure : Boolean)->$xml : Text
	
	DOM EXPORT TO VAR:C863(This:C1470.root; $xml)
	This:C1470.success:=Bool:C1537(OK)
	
	If (This:C1470.success)
		
		This:C1470.xml:=$xml
		
		If (Count parameters:C259>=1)
			
			This:C1470._close($keepStructure)
			
		Else 
			
			This:C1470._close()
			
		End if 
		
	Else 
		
		This:C1470.errors.push(Current method name:C684+" -  Failed to export XML to text.")
		
	End if 
	
	//———————————————————————————————————————————————————————————/
	// Return the  XML tree as BLOB
Function getContent($keepStructure : Boolean)->$content : Blob
	
	DOM EXPORT TO VAR:C863(This:C1470.root; $content)
	This:C1470.success:=Bool:C1537(OK)
	
	If (This:C1470.success)
		
		If (Count parameters:C259>=1)
			
			This:C1470._close($keepStructure)
			
		Else 
			
			This:C1470._close()
			
		End if 
		
	Else 
		
		This:C1470.errors.push(Current method name:C684+" -  Failed to export XML to BLOB.")
		
	End if 
	
	//———————————————————————————————————————————————————————————/
	// 
Function toObject($withAdresses : Boolean)->$object : Object
	
	If (Count parameters:C259>=1)
		
		$object:=This:C1470._elementToObject(This:C1470.root; $withAdresses)
		
	Else 
		
		$object:=This:C1470._elementToObject(This:C1470.root)
		
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Search for an element by its id
Function findById($id : Text)->$reference : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		$reference:=DOM Find XML element by ID:C1010(This:C1470.root; $id)
		This:C1470.success:=Bool:C1537(OK)
		
	Else 
		
		This:C1470.errors.push(Current method name:C684+" - Missing id parameter")
		
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Looks  for the 1st element corresponding to an XPath & returns its reference if success.
Function findByXPath($xpath : Text; $node : Text)->$reference : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (Count parameters:C259>=2)
			
			$reference:=DOM Find XML element:C864($node; $xpath)
			
		Else 
			
			// Search from the root
			$reference:=DOM Find XML element:C864(This:C1470.root; $xpath)
			
		End if 
		
		This:C1470.success:=Bool:C1537(OK)
		
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Searches for one or more elements corresponding to an XPath & returns a references collection if success.
Function find($node : Text; $xpath : Text)->$references : Collection
	
	$references:=New collection:C1472()
	ARRAY TEXT:C222($nodes; 0x0000)
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (This:C1470.isReference($node))\
			 & (Count parameters:C259>=2)
			
			$nodes{0}:=DOM Find XML element:C864($node; $xpath; $nodes)
			
		Else 
			
			// Start at the root, query string is the 1st parameter
			$nodes{0}:=DOM Find XML element:C864(This:C1470.root; $node; $nodes)
			
		End if 
		
		This:C1470.success:=Bool:C1537(OK)
		
		If (This:C1470.success)
			
			ARRAY TO COLLECTION:C1563($references; $nodes)
			
		End if 
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Search for elements by there name & returns a references collection if success.
Function findByName($target : Text; $name : Text)->$references : Collection
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		ARRAY TEXT:C222($nodes; 0x0000)
		
		If (Count parameters:C259>=2)
			
			If (This:C1470.isReference($target))
				
				If (This:C1470._requiredParams(Count parameters:C259; 2))
					
					$nodes{0}:=DOM Find XML element:C864($target; $name; $nodes)
					This:C1470.success:=Bool:C1537(OK)
					
				Else 
					
					This:C1470.success:=False:C215
					This:C1470.errors.push(Current method name:C684+" - Missing name parameter")
					
				End if 
				
			Else 
				
				$nodes{0}:=DOM Find XML element:C864(This:C1470.root; "//"+$target; $nodes)
				This:C1470.success:=Bool:C1537(OK)
				
			End if 
			
		Else 
			
			$nodes{0}:=DOM Find XML element:C864(This:C1470.root; "//"+$target; $nodes)
			This:C1470.success:=Bool:C1537(OK)
			
		End if 
		
		If (This:C1470.success)
			
			$references:=New collection:C1472
			ARRAY TO COLLECTION:C1563($references; $nodes)
			
		End if 
		
	Else 
		
		This:C1470.success:=False:C215
		This:C1470.errors.push(Current method name:C684+" - Missing name parameter")
		
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Search for elements by there attribute
Function findByAttribute($target : Text; $name : Text; $value : Text; $valor)->$references : Collection
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		ARRAY TEXT:C222($nodes; 0x0000)
		
		If (This:C1470.isReference($1))
			
			Case of 
					
					//______________________________________________________
				: (Count parameters:C259=2)  // Elements with the attribute $name
					
					$nodes{0}:=DOM Find XML element:C864($target; "//@"+$name; $nodes)
					
					//______________________________________________________
				: (Count parameters:C259=3)  // Elements with the attribute $name equal to $value
					
					$nodes{0}:=DOM Find XML element:C864($target; "//[@"+$name+"=\""+$value+"\"]"; $nodes)
					
					//______________________________________________________
				: (Count parameters:C259>=4)  // Elements $name with the attribute $value equal to $valor
					
					$nodes{0}:=DOM Find XML element:C864($target; "//"+$name+"[@"+$value+"=\""+$valor+"\"]"; $nodes)
					
					//______________________________________________________
				Else 
					
					OK:=0
					
					//______________________________________________________
			End case 
			
		Else 
			
			Case of 
					
					//______________________________________________________
				: (Count parameters:C259=1)  // Elements with the attribute $1
					
					$nodes{0}:=DOM Find XML element:C864(This:C1470.root; "//@"+$target; $nodes)
					
					//______________________________________________________
				: (Count parameters:C259=2)  // Elements with the attribute $target equal to $name
					
					$nodes{0}:=DOM Find XML element:C864(This:C1470.root; "//*[@"+$target+"=\""+$name+"\"]"; $nodes)
					
					//______________________________________________________
				: (Count parameters:C259>=3)  // Elements $name with the attribute $name equal to $value
					
					$nodes{0}:=DOM Find XML element:C864(This:C1470.root; "//"+$target+"[@"+$name+"=\""+$value+"\"]"; $nodes)
					
					//______________________________________________________
				Else 
					
					OK:=0
					
					//______________________________________________________
			End case 
		End if 
		
		This:C1470.success:=Bool:C1537(OK)
		
		If (This:C1470.success)
			
			$references:=New collection:C1472
			ARRAY TO COLLECTION:C1563($references; $nodes)
			
		End if 
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Search for an element by its name and create it if it is not found
Function findOrCreate($target : Text; $value : Text)->$reference : Text
	
	var $c : Collection
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (This:C1470.isReference($target))
			
			If (This:C1470._requiredParams(Count parameters:C259; 2))
				
				$c:=This:C1470.findByName($target; $value)
				
				If (This:C1470.success)
					
					$reference:=$c[0]
					
				Else 
					
					// Create
					$reference:=DOM Create XML element:C865($target; $value)
					
				End if 
			End if 
			
		Else 
			
			$c:=This:C1470.findByName($target)
			
			If (This:C1470.success)
				
				$reference:=$c[0]
				
			Else 
				
				// Create
				$reference:=DOM Create XML element:C865(This:C1470.root; $target)
				
			End if 
		End if 
		
		This:C1470.success:=Bool:C1537(OK)
		
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Returns a reference to the parent of a node
	// If a name is passed, goes up in the hierarchy to find the named element
Function parent($node : Text; $name : Text)->$reference : Text
	var $elementName : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (This:C1470._requiredRef($node))
			
			$reference:=DOM Get parent XML element:C923($node; $elementName)
			
			This:C1470.success:=Bool:C1537(OK)
			
			If (This:C1470.success)
				
				If (Count parameters:C259>=2)
					
					If ($elementName#$name)
						
						Repeat 
							
							$reference:=DOM Get parent XML element:C923($reference; $elementName)
							
						Until (OK=0)\
							 | ($elementName=$name)
						
						This:C1470.success:=($elementName=$name)
						
					End if 
				End if 
			End if 
		End if 
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Returns a reference to the first “child”
	// If the node's reference isn't passed, return the first child of the root
	// If a name is passed, looks for the first child with that name
Function firstChild($node : Text; $name : Text)->$reference : Text
	var $elementName : Text
	
	If (Count parameters:C259>=1)
		
		If (This:C1470._requiredRef($node))
			
			$reference:=DOM Get first child XML element:C723($node; $elementName)
			This:C1470.success:=Bool:C1537(OK)
			
			If (This:C1470.success)
				
				If (Count parameters:C259>=2)
					
					If ($elementName#$name)
						
						Repeat 
							
							$reference:=DOM Get next sibling XML element:C724($reference; $elementName)
							
						Until (OK=0)\
							 | ($elementName=$name)
						
						This:C1470.success:=($elementName=$name)
						
					End if 
				End if 
			End if 
		End if 
		
	Else 
		
		$reference:=DOM Get first child XML element:C723(This:C1470.root)
		This:C1470.success:=Bool:C1537(OK)
		
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Returns a reference to the last “child”
	// If the node's reference isn't passed, return the last child of the root
	// If a name is passed, looks for the last child with that name
Function lastChild($node : Text; $name : Text)->$reference : Text
	var $elementName : Text
	
	If (Count parameters:C259>=1)
		
		If (This:C1470._requiredRef($1))
			
			$reference:=DOM Get last child XML element:C925($node; $elementName)
			This:C1470.success:=Bool:C1537(OK)
			
			If (This:C1470.success)
				
				If (Count parameters:C259>=2)
					
					If ($elementName#$name)
						
						Repeat 
							
							$reference:=DOM Get previous sibling XML element:C924($reference; $elementName)
							
						Until (OK=0)\
							 | ($elementName=$name)
						
						This:C1470.success:=($elementName=$name)
						
					End if 
				End if 
			End if 
		End if 
		
	Else 
		
		$reference:=DOM Get last child XML element:C925(This:C1470.root)
		This:C1470.success:=Bool:C1537(OK)
		
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Returns the list of the childs' references of a node or root if ref is omitted
Function childrens($node : Text)->$childs : Collection
	
	ARRAY TEXT:C222($nodes; 0x0000)
	
	If (Count parameters:C259>=1)
		
		If (This:C1470._requiredRef($node))
			
			$nodes{0}:=$node
			
		End if 
	End if 
	
	If (Length:C16($nodes{0})=0)
		
		$nodes{0}:=This:C1470.root
		
	End if 
	
	$nodes{0}:=DOM Find XML element:C864($nodes{0}; "*"; $nodes)
	
	$childs:=New collection:C1472
	ARRAY TO COLLECTION:C1563($childs; $nodes)
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Returns the list of the descendant' references of a node or root if ref is omitted
Function descendants($node : Text)->$descendants : Collection
	var $i : Integer
	
	$descendants:=New collection:C1472
	
	ARRAY LONGINT:C221($types; 0x0000)
	ARRAY TEXT:C222($nodes; 0x0000)
	
	If (Count parameters:C259>=1)
		
		If (This:C1470._requiredRef($node))
			
			DOM GET XML CHILD NODES:C1081($node; $types; $nodes)
			
		End if 
		
	Else 
		
		DOM GET XML CHILD NODES:C1081(This:C1470.root; $types; $nodes)
		
	End if 
	
	For ($i; 1; Size of array:C274($types); 1)
		
		If ($types{$i}=XML ELEMENT:K45:20)
			
			$descendants.push($nodes{$i})
			$descendants.combine(This:C1470.descendants($nodes{$i}))
			
		End if 
	End for 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Returns a reference to the next “sibling”
	// If a name is passed, looks for the first sibling with that name
Function nextSibling($node : Text; $name : Text)->$reference : Text
	var $elementName : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (This:C1470._requiredRef($node))
			
			$reference:=DOM Get next sibling XML element:C724($node; $elementName)
			This:C1470.success:=Bool:C1537(OK)
			
			If (This:C1470.success)
				
				If (Count parameters:C259>=2)
					
					If ($elementName#$name)
						
						Repeat 
							
							$reference:=DOM Get next sibling XML element:C724($reference; $elementName)
							
						Until (OK=0)\
							 | ($elementName=$name)
						
						This:C1470.success:=($elementName=$name)
						
					End if 
				End if 
			End if 
		End if 
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Returns a reference to the previous “sibling”
	// If a name is passed, looks for the first sibling with that name
Function previousSibling($node : Text; $name : Text)->$reference : Text
	var $elementName : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (This:C1470._requiredRef($node))
			
			$reference:=DOM Get previous sibling XML element:C924($node; $elementName)
			This:C1470.success:=Bool:C1537(OK)
			
			If (This:C1470.success)
				
				If (Count parameters:C259>=2)
					
					If ($elementName#$name)
						
						Repeat 
							
							$reference:=DOM Get previous sibling XML element:C924($reference; $elementName)
							
						Until (OK=0)\
							 | ($elementName=$name)
						
						This:C1470.success:=($elementName=$name)
						
					End if 
				End if 
			End if 
		End if 
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Returns the name of the element set by $node
Function getName($node : Text)->$name : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (This:C1470._requiredRef($node))
			
			DOM GET XML ELEMENT NAME:C730($node; $name)
			This:C1470.success:=Bool:C1537(OK)
			
		End if 
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Modifies the name of the element set by $node
Function setName($node : Text; $name : Text)->$this : cs:C1710.xml
	
	If (This:C1470._requiredParams(Count parameters:C259; 2))
		
		If (This:C1470._requiredRef($node))
			
			DOM SET XML ELEMENT NAME:C867($node; $name)
			This:C1470.success:=Bool:C1537(OK)
			
		End if 
	End if 
	
	$this:=This:C1470
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Removes the element set by $node
Function remove($node : Text)->$this : cs:C1710.xml
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (This:C1470._requiredRef($node))
			
			DOM REMOVE XML ELEMENT:C869($node)
			This:C1470.success:=Bool:C1537(OK)
			
		End if 
	End if 
	
	$this:=This:C1470
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Returns the value of the XML element designated by $node
Function getValue($node : Text)->$value
	
	var $CDATA; $elementValue : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (This:C1470._requiredRef($node))
			
			DOM GET XML ELEMENT VALUE:C731($node; $elementValue; $CDATA)
			This:C1470.success:=Bool:C1537(OK)
			
			If (This:C1470.success)
				
				If (Length:C16($elementValue)=0)
					
					// Try CDATA
					$value:=This:C1470._convert($CDATA)
					
				Else 
					
					$value:=This:C1470._convert($elementValue)
					
				End if 
			End if 
		End if 
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Returns one node attribute value if exists
Function getAttribute($node : Text; $attribute : Text)->$value
	
	var $o : Object
	
	If (This:C1470._requiredParams(Count parameters:C259; 2))
		
		$o:=OB Entries:C1720(This:C1470.getAttributes($node)).query("key = :1"; $attribute).pop()
		This:C1470.success:=($o#Null:C1517)
		
		If (This:C1470.success)
			
			$value:=$o.value
			
		Else 
			
			This:C1470.errors.push(Current method name:C684+" -  Attribute \""+$attribute+"\" not found")
			
		End if 
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// If exists, returns an attribute value & remove it
Function popAttribute($node : Text; $attribute : Text)->$value
	
	var $o : Object
	
	If (This:C1470._requiredParams(Count parameters:C259; 2))
		
		$o:=OB Entries:C1720(This:C1470.getAttributes($node)).query("key = :1"; $attribute).pop()
		This:C1470.success:=($o#Null:C1517)
		
		If (This:C1470.success)
			
			$value:=$o.value
			
			DOM REMOVE XML ATTRIBUTE:C1084($node; $attribute)
			
		Else 
			
			This:C1470.errors.push(Current method name:C684+" -  Attribute \""+$attribute+"\" not found")
			
		End if 
	End if 
	// —————————————————————————————————————————————————————————————————————————————————
	// Returns a node attributes as object
Function getAttributes($node : Text)->$attributes : Object
	
	var $key; $nodeƒ; $t; $value : Text
	var $i : Integer
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (This:C1470.isReference($node))
			
			$nodeƒ:=$node
			
		Else 
			
			// It is assumed to be an XPath
			$nodeƒ:=This:C1470.findByXPath($node)
			
		End if 
		
		If (This:C1470._requiredRef($nodeƒ))
			
			$attributes:=New object:C1471
			
			GET SYSTEM FORMAT:C994(Decimal separator:K60:1; $t)
			
			For ($i; 1; DOM Count XML attributes:C727($nodeƒ); 1)
				
				DOM GET XML ATTRIBUTE BY INDEX:C729($nodeƒ; $i; $key; $value)
				
				$attributes[$key]:=This:C1470._convert($value)
				
			End for 
		End if 
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Returns a node attributes as collection
Function getAttributesCollection($node : Text)->$attributes : Collection
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		$attributes:=OB Entries:C1720(This:C1470.getAttributes($node))
		
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Set a node attribute
Function setAttribute($node : Text; $name : Text; $value)->$this : cs:C1710.xml
	
	If (This:C1470._requiredParams(Count parameters:C259; 3))
		
		If (This:C1470._requiredRef($node))
			
			DOM SET XML ATTRIBUTE:C866($node; $name; $value)
			This:C1470.success:=Bool:C1537(OK)
			
		End if 
	End if 
	
	$this:=This:C1470
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Set a node attributes from an object or a collection (key/value pairs)
Function setAttributes($node : Text; $attributes; $value)->$this : cs:C1710.xml
	
	var $t : Text
	var $o : Object
	
	If (This:C1470._requiredParams(Count parameters:C259; 2))
		
		If (This:C1470._requiredRef($node))
			
			Case of 
					
					//______________________________________________________
				: (Value type:C1509($attributes)=Is text:K8:3)
					
					If (This:C1470._requiredParams(Count parameters:C259; 3))
						
						This:C1470.setAttribute($node; $attributes; $value)
						
					End if 
					
					//______________________________________________________
				: (Value type:C1509($attributes)=Is object:K8:27)
					
					For each ($t; $attributes) While (This:C1470.success)
						
						DOM SET XML ATTRIBUTE:C866($node; \
							$t; $attributes[$t])
						This:C1470.success:=Bool:C1537(OK)
						
					End for each 
					
					If (Not:C34(This:C1470.success))
						
						This:C1470.errors.push(Current method name:C684+" -  Failed to set attribute \""+$t+"\"")
						
					End if 
					
					//______________________________________________________
				: (Value type:C1509($attributes)=Is collection:K8:32)
					
					For each ($o; $attributes) While (This:C1470.success)
						
						DOM SET XML ATTRIBUTE:C866($node; \
							String:C10($o.key); $o.value)
						This:C1470.success:=Bool:C1537(OK)
						
						If (Not:C34(This:C1470.success))
							
							This:C1470.errors.push(Current method name:C684+" -  Failed to set attribute \""+String:C10($o.key)+"\"")
							
						End if 
					End for each 
					
					//______________________________________________________
				Else 
					
					This:C1470.success:=False:C215
					This:C1470.errors.push(Current method name:C684+" -  Unmanaged type: "+String:C10(Value type:C1509($node)))
					
					//______________________________________________________
			End case 
		End if 
	End if 
	
	$this:=This:C1470
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Removes, if it exists, the attribute designated by $name from the XML $node
Function removeAttribute($node : Text; $attribute : Text)->$this : cs:C1710.xml
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (Count parameters:C259>=2)
			
			If (OB Entries:C1720(This:C1470.getAttributes($node)).query("key=:1"; $attribute).pop()#Null:C1517)
				
				DOM REMOVE XML ATTRIBUTE:C1084($node; $attribute)
				
			End if 
			
		Else 
			
			If (OB Entries:C1720(This:C1470.getAttributes(This:C1470.root)).query("key=:1"; $attribute).pop()#Null:C1517)
				
				DOM REMOVE XML ATTRIBUTE:C1084($node; $attribute)
				
			End if 
		End if 
		
		This:C1470.success:=Bool:C1537(OK)
		
	End if 
	
	$this:=This:C1470
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Modifies the value of the element set by $node
Function setValue($node : Text; $value : Variant; $inCDATA : Boolean)->$this : cs:C1710.xml
	
	If (Count parameters:C259=3)
		
		If ($inCDATA)
			
			DOM SET XML ELEMENT VALUE:C868($node; $value; *)
			
		Else 
			
			DOM SET XML ELEMENT VALUE:C868($node; $value)
			
		End if 
		
	Else 
		
		DOM SET XML ELEMENT VALUE:C868($node; $value)
		
	End if 
	
	This:C1470.success:=Bool:C1537(OK)
	
	$this:=This:C1470
	
	// —————————————————————————————————————————————————————————————————————————————————
Function isNull($reference : Text)->$response : Boolean
	
	$response:=Match regex:C1019("0{32}"; $reference; 1)
	
	// —————————————————————————————————————————————————————————————————————————————————
Function isNotNull($reference : Text)->$response : Boolean
	
	$response:=Not:C34(This:C1470.isNull($reference))
	
	// —————————————————————————————————————————————————————————————————————————————————
	// Tests if the passed text is compliant with a XML reference
Function isReference($text : Text)->$response : Boolean
	
	$response:=Match regex:C1019("[[:xdigit:]]{32}"; $text; 1)
	
	// —————————————————————————————————————————————————————————————————————————————————
Function _requiredRef($reference : Text)->$response : Boolean
	
	$response:=Match regex:C1019("[[:xdigit:]]{32}"; $reference; 1)
	
	If (Not:C34($response))
		
		This:C1470._pushError("Invalid XML element reference")
		
	End if 
	
	This:C1470.success:=$response
	
	// —————————————————————————————————————————————————————————————————————————————————
Function _requiredParams($count; $number)->$response : Boolean
	
	$response:=$count>=$number
	
	If (Not:C34($response))
		
		This:C1470._pushError("Missing one or more parameters")
		
	End if 
	
	This:C1470.success:=$response
	
	// —————————————————————————————————————————————————————————————————————————————————
Function _convert($textValue : Text)->$value
	
	Case of 
			
			//______________________________________________________
		: (Match regex:C1019("(?m-is)^(?:[tT]rue|[fF]alse)$"; $textValue; 1))
			
			$value:=($textValue="true")
			
			//______________________________________________________
		: (Match regex:C1019("(?m-si)^(?:\\+|-)?\\d+(?:\\.|"+$textValue+"\\d+)?$"; $textValue; 1))
			
			$value:=Num:C11($textValue)
			
			//______________________________________________________
		: (Match regex:C1019("(?m-si)^\\d+-\\d+-\\d+$"; $textValue; 1))
			
			$value:=Date:C102($textValue+"T00:00:00")
			
			//______________________________________________________
		Else 
			
			$value:=$textValue
			
			//______________________________________________________
	End case 
	
	// —————————————————————————————————————————————————————————————————————————————————
Function _close($keepOpened : Boolean)
	
	If (This:C1470.autoClose)
		
		If (Count parameters:C259>=1)
			
			If (Not:C34($keepOpened))
				
				This:C1470.close()
				
			Else 
				
				// ⚠️ XML tree is not closed
				
			End if 
			
		Else 
			
			This:C1470.close()
			
		End if 
		
	Else 
		
		// ⚠️ XML tree is not closed
		
	End if 
	
	// —————————————————————————————————————————————————————————————————————————————————
Function _pushError($desription : Text)
	
	This:C1470.success:=False:C215
	This:C1470.errors.push(Get call chain:C1662[1].name+" - "+$desription)
	
	//———————————————————————————————————————————————————————————
Function _reset
	
	This:C1470.close()
	
	This:C1470.file:=Null:C1517
	This:C1470.xml:=Null:C1517
	
	This:C1470.autoClose:=True:C214
	
	This:C1470.errors:=New collection:C1472
	
	// —————————————————————————————————————————————————————————————————————————————————
Function _elementToObject($ref : Text; $withAdresses : Boolean)->$object : Object
	
	var $node; $key; $name; $tValue : Text
	var $withRef : Boolean
	var $count; $i : Integer
	
	If (Count parameters:C259>=2)
		
		$withRef:=$withAdresses
		
	End if 
	
	$object:=New object:C1471
	
	// DOM reference
	If ($withRef)
		
		$object["@"]:=$ref
		
	End if 
	
	// Attributes
	For ($i; 1; DOM Count XML attributes:C727($ref); 1)
		
		DOM GET XML ATTRIBUTE BY INDEX:C729($ref; $i; $key; $tValue)
		
		Case of   // Value types
				
				//______________________________________________________
			: (Length:C16($key)=0)
				
				// Skip malformed node
				
				//______________________________________________________
			: (Match regex:C1019("(?m-si)^\\d+\\.*\\d*$"; $tValue; 1))  // Numeric
				
				$object[$key]:=Num:C11($tValue; ".")
				
				//______________________________________________________
			: (Match regex:C1019("(?mi-s)^true|false$"; $tValue; 1))  // Boolean
				
				$object[$key]:=($tValue="true")
				
				//______________________________________________________
			Else   // Text
				
				$object[$key]:=$tValue
				
				//______________________________________________________
		End case 
	End for 
	
	// Value
	DOM GET XML ELEMENT VALUE:C731($ref; $tValue)
	
	If (Match regex:C1019("[^\\s]+"; $tValue; 1))
		
		$object["$"]:=$tValue
		
	End if 
	
	// Childs
	$node:=DOM Get first child XML element:C723($ref; $name)
	
	If (OK=1)
		
		// Many one?
		$count:=DOM Count XML elements:C726($ref; $name)
		
		If ($count>1)
			
			$object[$name]:=New collection:C1472
			
			For ($i; 1; $count; 1)
				
				$object[$name].push(This:C1470._elementToObject(DOM Get XML element:C725($ref; $name; $i); $withRef))
				
			End for 
			
		Else 
			
			$object[$name]:=This:C1470._elementToObject($node; $withRef)
			
		End if 
		
		// Next one
		$node:=DOM Get next sibling XML element:C724($node; $name)
		
		While (OK=1)
			
			// Already treated?
			If ($object[$name]=Null:C1517)
				
				// Many one?
				$count:=DOM Count XML elements:C726($ref; $name)
				
				If ($count>1)
					
					$object[$name]:=New collection:C1472
					
					For ($i; 1; $count; 1)
						
						$object[$name].push(This:C1470._elementToObject(DOM Get XML element:C725($ref; $name; $i); $withRef))
						
					End for 
					
				Else 
					
					$object[$name]:=This:C1470._elementToObject($node; $withRef)
					
				End if 
			End if 
			
			// Next one
			$node:=DOM Get next sibling XML element:C724($node; $name)
			
		End while 
	End if 
	