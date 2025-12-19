//%attributes = {"invisible":true,"shared":true}
#DECLARE($name : Text; $reset : Boolean)

var $file : 4D:C1709.File
var $folder : 4D:C1709.Folder

$reset:=Count parameters:C259<2 ? Shift down:C543 : $reset

If (Not:C34($reset))
	
	return 
	
End if 

$folder:=Folder:C1567(fk user preferences folder:K87:10)
$folder:=$folder.folder(File:C1566(Structure file:C489; fk platform path:K87:2).name)
$folder:=$folder.folder("4D Window Bounds v"+Substring:C12(Application version:C493(); 1; 2))

If (Structure file:C489#Structure file:C489(*))
	
	$folder:=$folder.folder(File:C1566(Structure file:C489(*); fk platform path:K87:2).name)
	
End if 

$folder:=$folder.folder("[projectForm]")
$file:=$folder.file($name+".json")

If ($file.exists)
	
	$file.delete()
	
End if 
