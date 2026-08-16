//%attributes = {}
#DECLARE($name : Text)->$result : Object

var $formula:=OBJECT Get data source formula:C1852(*; $name)

$result:={\
name: $name; \
datasource: ""; \
source: $formula.source; \
data: $formula\
}

var $tableName : Text
var $tableNum : Integer

LISTBOX GET TABLE SOURCE:C1014(*; $name; $tableNum; $tableName)

If ($tableNum>0)
	
	$result.datasource:=Length:C16($tableName)=0 ? "Current Selection" : "Named Selection"
	
Else 
	
	var $ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $name)
	
	Case of 
			
			//–––––––––––––––––––––––––––––––––
		: ($ptr=Null:C1517)
			
			If (Position:C15("$"; $result.data.source)=1)  // Dynamic form variable
				
				$result.datasource:="Array (Dynamic form variable)"
				
			Else 
				
				var $target:=$formula.call()
				var $type:=Type:C295($target)
				
			End if 
			
			//–––––––––––––––––––––––––––––––––
		: (Type:C295($ptr->)=Is collection:K8:32)
			
			$result.datasource:="Collection or entity selection"
			
			//–––––––––––––––––––––––––––––––––
		: (Type:C295($ptr->)=Boolean array:K8:21)
			
			$result.datasource:="Array"
			
			//–––––––––––––––––––––––––––––––––
		: (Type:C295($ptr->)=Is longint:K8:6)\
			 | (Type:C295($ptr->)=Is real:K8:4)
			
			$result.datasource:="Collection or entity selection"
			
			//–––––––––––––––––––––––––––––––––
	End case 
	
	If ($result.datasource="Collection or entity selection")
		
		$result.currentItemExpression:=LISTBOX Get property:C917(*; $name; lk current item expression:K53:79)
		$result.currentItemPosExpression:=LISTBOX Get property:C917(*; $name; lk current item pos expression:K53:80)
		$result.selectedItemsExpression:=LISTBOX Get property:C917(*; $name; lk selected items expression:K53:81)
		
/*
If ($result.currentItemExpression="")
		
$result.currentItemExpression:="Form."+$name+"CurrentItem"
LISTBOX SET PROPERTY(*; $name; lk current item expression; $result.currentItemExpression)
		
End if 
		
If ($result.currentItemPosExpression="")
		
$result.currentItemPosExpression:="Form."+$name+"CurrentItemPos"
LISTBOX SET PROPERTY(*; $name; lk current item pos expression; $result.currentItemPosExpression)
		
End if 
		
If ($result.selectedItemsExpression="")
		
$result.selectedItemsExpression:="Form."+$name+"SeelectedItems"
LISTBOX SET PROPERTY(*; $name; lk selected items expression; $result.selectedItemsExpression)
		
End if 
*/
		
	End if 
End if 
