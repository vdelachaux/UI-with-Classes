//%attributes = {"invisible":true}
C_TEXT:C284($0)
C_VARIANT:C1683($1)
C_VARIANT:C1683($2)
C_LONGINT:C283($3)

C_LONGINT:C283($indx)
C_VARIANT:C1683($container;$this)

If (False:C215)
	C_TEXT:C284(htuProgressDoSomething ;$0)
	C_VARIANT:C1683(htuProgressDoSomething ;$1)
	C_VARIANT:C1683(htuProgressDoSomething ;$2)
	C_LONGINT:C283(htuProgressDoSomething ;$3)
End if 

$this:=$1  // Current item
$container:=$2  // All values
$indx:=$3  // Current index

DELAY PROCESS:C323(Current process:C322;5)  // Make it look like we're doing something ;-)

Case of 
		
		  //______________________________________________________
	: (Value type:C1509($container)=Is collection:K8:32)
		
		If (Value type:C1509($this)=Is text:K8:3)
			
			$0:=$this
			
		Else 
			
			  // Use index
			$0:="Processing item #"+String:C10($indx);
			
		End if 
		
		  //______________________________________________________
	: (Value type:C1509($container)=Is object:K8:27)
		
		$0:="Processing key: "+String:C10($this)
		
		  //______________________________________________________
	Else 
		
		$0:="Processing: "+String:C10($indx)
		
		  //______________________________________________________
End case 