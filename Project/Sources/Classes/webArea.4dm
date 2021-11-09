/*═══════════════════*/
Class extends formObject
/*═══════════════════*/

Class constructor
	var $1 : Text
	var $2 : Variant
	
	Super:C1705($1)
	
	This:C1470.success:=False:C215
	This:C1470.errors:=New collection:C1472
	This:C1470.lastError:=""
	
	This:C1470.url:=WA Get current URL:C1025(*; This:C1470.name)
	
	If (Count parameters:C259>=1)
		
		This:C1470.init($1)
		
	Else 
		
		This:C1470.init()
		
	End if 
	
	//==================================================
Function init
	var $1 : Variant
	
	ARRAY TEXT:C222($_filters; 0x0000)
	ARRAY BOOLEAN:C223($_allowed; 0x0000)
	
	// All are forbidden
	APPEND TO ARRAY:C911($_filters; "*")  // All
	APPEND TO ARRAY:C911($_allowed; False:C215)
	
	APPEND TO ARRAY:C911($_filters; "about:blank")  // Allow  blank HTML document
	APPEND TO ARRAY:C911($_allowed; True:C214)
	
	WA SET URL FILTERS:C1030(*; This:C1470.name; $_filters; $_allowed)
	
	If (Count parameters:C259>=1)
		
		This:C1470.allow($1)
		
	Else 
		
		// Allow WA SET PAGE CONTENT
		APPEND TO ARRAY:C911($_filters; "file*")
		APPEND TO ARRAY:C911($_allowed; True:C214)  // To allow including HTML files
		
		WA SET URL FILTERS:C1030(*; This:C1470.name; $_filters; $_allowed)
		
	End if 
	
	WA SET PREFERENCE:C1041(*; This:C1470.name; _o_WA enable Java applets:K62:3; False:C215)
	WA SET PREFERENCE:C1041(*; This:C1470.name; _o_WA enable JavaScript:K62:4; True:C214)
	WA SET PREFERENCE:C1041(*; This:C1470.name; _o_WA enable plugins:K62:5; False:C215)
	
	// Active the contextual menu in debug mode
	WA SET PREFERENCE:C1041(*; This:C1470.name; WA enable contextual menu:K62:6; Not:C34(Is compiled mode:C492) | (Structure file:C489=Structure file:C489(*)))
	WA SET PREFERENCE:C1041(*; This:C1470.name; WA enable Web inspector:K62:7; True:C214)
	
	This:C1470.success:=True:C214
	
	//==================================================
Function openURL
	var $1 : Variant
	
	This:C1470.success:=True:C214
	
	Case of 
			
			//……………………………………………………………………………………………………
		: (Count parameters:C259=0)
			
			// <NOTHING MORE TO DO>
			
			//……………………………………………………………………………………………………
		: (Value type:C1509($1)=Is text:K8:3)
			
			This:C1470.url:=$1
			
			//……………………………………………………………………………………………………
		: (Value type:C1509($1)=Is object:K8:27)
			
			If (OB Instance of:C1731($1; 4D:C1709.File))
				
				This:C1470.url:="file:///"+$1.path
				
			Else 
				
				This:C1470.success:=False:C215
				This:C1470.lastError:=Current method name:C684+": $1 is not a File object"
				This:C1470.errors.push(This:C1470.lastError)
				
			End if 
			
			//……………………………………………………………………………………………………
		Else 
			
			This:C1470.success:=False:C215
			This:C1470.lastError:=Current method name:C684+": $1 must be a text or a File object"
			This:C1470.errors.push(This:C1470.lastError)
			
			//……………………………………………………………………………………………………
	End case 
	
	Case of 
			
			//……………………………………………………………………………………………………
		: (Not:C34(This:C1470.success))
			
			// <NOTHING MORE TO DO>
			
			//……………………………………………………………………………………………………
		: (Length:C16(This:C1470.url)=0)
			
			This:C1470.url:="about:blank"
			
			//……………………………………………………………………………………………………
		: (This:C1470.url="internal")  // Current database server
			
			This:C1470.url:="127.0.0.1:"+String:C10(WEB Get server info:C1531.options.webPortID)
			
			//……………………………………………………………………………………………………
		: (This:C1470.url="localhost")\
			 & Is macOS:C1572  //#TURN_AROUND - In some cases, using "localhost" we get the error -30 "Server unreachable"
			
			This:C1470.url:="127.0.0.1"
			
			//……………………………………………………………………………………………………
	End case 
	
	This:C1470.allow(This:C1470.url)
	
	WA OPEN URL:C1020(*; This:C1470.name; This:C1470.url)
	
	//==================================================
Function setContent
	var $1 : Text
	var $2 : Text
	
	var $base : Text
	
	If (Count parameters:C259>=2)
		
		$base:=$2
		
	Else 
		
		$base:="/"
		
	End if 
	
	WA SET PAGE CONTENT:C1037(*; This:C1470.name; $1; $base)
	
	This:C1470.success:=True:C214
	
	//==================================================
Function load
	var $1 : 4D:C1709.File
	
	var $text : Text
	var $index : Integer
	var $x : Blob
	var $file; $o : Object
	
	This:C1470.success:=(Count parameters:C259>=1)
	
	If (This:C1470.success)
		
		This:C1470.success:=$1.exists
		
		If (This:C1470.success)
			
			DOCUMENT TO BLOB:C525($1.platformPath; $x)
			This:C1470.success:=Bool:C1537(OK)
			
			If (This:C1470.success)
				
				$text:=Convert to text:C1012($x; "UTF-8")
				This:C1470.success:=Bool:C1537(OK)
				
				If (This:C1470.success)
					
					// Process tags
					PROCESS 4D TAGS:C816($text; $text)
					
					// Cleanup
					$text:=Replace string:C233($text; "\r\n"; "")
					$text:=Replace string:C233($text; "\r"; "")
					$text:=Replace string:C233($text; "\n"; "")
					$text:=Replace string:C233($text; "\t"; "")
					
					// Temporary allow "file:// "
					ARRAY TEXT:C222($_filters; 0x0000)
					ARRAY BOOLEAN:C223($_allowed; 0x0000)
					WA GET URL FILTERS:C1031(*; This:C1470.name; $_filters; $_allowed)
					
					$o:=New object:C1471(\
						"filters"; New collection:C1472; \
						"allowDeny"; New collection:C1472)
					
					ARRAY TO COLLECTION:C1563($o.filters; $_filters)
					ARRAY TO COLLECTION:C1563($o.allowDeny; $_allowed)
					
					$index:=Find in array:C230($_filters; "file*")
					
					If ($index>0)
						
						$_allowed{$index}:=True:C214
						
					Else 
						
						APPEND TO ARRAY:C911($_filters; "file*")
						APPEND TO ARRAY:C911($_allowed; True:C214)  // Allowed
						
					End if 
					
					WA SET URL FILTERS:C1030(*; This:C1470.name; $_filters; $_allowed)
					
					$file:=Folder:C1567(Temporary folder:C486; fk platform path:K87:2).file($1.fullName)
					$file.setText($text)
					
					WA OPEN URL:C1020(*; This:C1470.name; $file.platformPath)
					
					// Restore filters
					COLLECTION TO ARRAY:C1562($o.filters; $_filters)
					COLLECTION TO ARRAY:C1562($o.allowDeny; $_allowed)
					
					WA SET URL FILTERS:C1030(*; This:C1470.name; $_filters; $_allowed)
					
				Else 
					
					This:C1470.lastError:=Current method name:C684+": Convert to text failed"
					This:C1470.errors.push(This:C1470.lastError)
					
				End if 
				
			Else 
				
				This:C1470.lastError:=Current method name:C684+": DOCUMENT TO BLOB failed"
				This:C1470.errors.push(This:C1470.lastError)
				
			End if 
			
		Else 
			
			This:C1470.lastError:=Current method name:C684+": File not found: \""+$1.path+"\""
			This:C1470.errors.push(This:C1470.lastError)
			
		End if 
		
	Else 
		
		This:C1470.lastError:=Current method name:C684+": Missing parameter"
		This:C1470.errors.push(This:C1470.lastError)
		
	End if 
	
	//==================================================
Function execute
	var $0 : Variant
	var $1 : Text
	var $2 : Integer
	
	If (Count parameters:C259>=1)
		
		If (Count parameters:C259>=2)
			
			$0:=WA Evaluate JavaScript:C1029(*; This:C1470.name; $1; $2)
			
		Else 
			
			$0:=WA Evaluate JavaScript:C1029(*; This:C1470.name; $1)
			
		End if 
		
	End if 
	
	//==================================================
Function content
	var $0 : Text
	
	$0:=WA Get page content:C1038(*; This:C1470.name)
	
	//==================================================
Function back
	
	WA OPEN BACK URL:C1021(*; This:C1470.name)
	
	//==================================================
Function forward
	
	WA OPEN FORWARD URL:C1022(*; This:C1470.name)
	
	//==================================================
Function isLoaded
	var $0 : Boolean
	
	$0:=(WA Get current URL:C1025(*; This:C1470.name)=This:C1470.url)
	
	//==================================================
Function lastFiltered
	var $0 : Text
	
	$0:=WA Get last filtered URL:C1035(*; This:C1470.name)
	
	//==================================================
Function refresh
	
	This:C1470.openURL(This:C1470.url)
	
	//==================================================
Function getTitle
	var $0 : Text
	
	$0:=WA Get page title:C1036(*; This:C1470.name)
	
	//==================================================
Function allow
	var $1 : Variant
	var $2 : Boolean
	
	var $filter : Text
	var $allow : Boolean
	
	ARRAY TEXT:C222($_filters; 0)
	ARRAY BOOLEAN:C223($_allowed; 0)
	
	If (Count parameters:C259>=1)
		
		If (Count parameters:C259>=2)
			
			$allow:=$2
			
		Else 
			
			$allow:=True:C214
			
		End if 
		
		This:C1470.success:=True:C214
		WA GET URL FILTERS:C1031(*; This:C1470.name; $_filters; $_allowed)
		
		Case of 
				
				//______________________________________________________
			: (Value type:C1509($1)=Is text:K8:3)
				
				APPEND TO ARRAY:C911($_filters; $1)
				APPEND TO ARRAY:C911($_allowed; $allow)
				
				//______________________________________________________
			: (Value type:C1509($1)=Is collection:K8:32)
				
				For each ($filter; $1)
					
					APPEND TO ARRAY:C911($_filters; $filter)
					APPEND TO ARRAY:C911($_allowed; $allow)
					
				End for each 
				
				//______________________________________________________
			Else 
				
				This:C1470.success:=False:C215
				This:C1470.lastError:="$1 must be a text or a text collection"
				This:C1470.errors.push(This:C1470.lastError)
				
				//______________________________________________________
		End case 
		
		WA SET URL FILTERS:C1030(*; This:C1470.name; $_filters; $_allowed)
		
	Else 
		
		This:C1470.lastError:=Current method name:C684+": Missing parameter"
		This:C1470.errors.push(This:C1470.lastError)
		
	End if 
	
	//==================================================
Function deny
	var $1 : Variant
	
	This:C1470.allow($1; False:C215)
	
	//==================================================
	// Detect which web rendering engine is being used for the Web Area
	// https://kb.4d.com/assetid=78601
Function getWebEngine()->$infos : Object
	
/*
An example result:
{"Browser" : "Chrome",
"userAgent" : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36"}
	
*/
	
	var $t : Text
	
	$t:=WA Get current URL:C1025(*; This:C1470.name)
	
	If (($t=":///")\
		 | (Length:C16($t)=0))
		
		WA OPEN URL:C1020(*; This:C1470.name; "about:blank")
		
	End if 
	
	$t:="var res={\"userAgent\":navigator.userAgent};"
	
	//Chrome
	$t:=$t+"if(navigator.userAgent.indexOf(\"Chrome\") > -1) "
	$t:=$t+"{ res.Browser=\"Chrome\"}"
	
	//Safari
	$t:=$t+"else if(navigator.userAgent.indexOf(\"Safari\") > -1)"
	$t:=$t+" {res.Browser=\"Safari\";}"
	
	//Internet Explorer
	$t:=$t+"else if(navigator.userAgent.indexOf(\"MSIE\") > -1 || "
	$t:=$t+"navigator.userAgent.indexOf(\"rv:\") > -1)"
	$t:=$t+" {res.Browser= \"IE\";}"
	
	//Firefox
	$t:=$t+"else if(navigator.userAgent.indexOf(\"Firefox\") > -1)"
	$t:=$t+" {res.Browser=\"Firefox\";}"
	
	//AppleWebKit
	$t:=$t+"else if(navigator.userAgent.indexOf(\"Macintosh\") > -1)"
	$t:=$t+" {res.Browser=\"AppleWebKit\";}"
	
	$t:=$t+"; res"
	
	$infos:=WA Evaluate JavaScript:C1029(*; This:C1470.name; $t; Is object:K8:27)
	