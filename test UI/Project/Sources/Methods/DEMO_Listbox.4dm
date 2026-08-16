var $winRef : Integer

// Prepare the table data + named selection BEFORE the form is displayed:
// a named-selection list box binding is validated when the form is parsed (at
// DIALOG start), so "mySel" must already exist — otherwise 4D discards it.
If (ds:C1482.Table_1.all().length=0)
	var $i : Integer
	For ($i; 1; 4; 1)
		var $entity : cs:C1710.Table_1Entity
		$entity:=ds:C1482.Table_1.new()
		$entity.Field_2:="Enregistrement "+String:C10($i)
		$entity.save()
	End for 
End if 

ALL RECORDS:C47([Table_1:1])
COPY NAMED SELECTION:C331([Table_1:1]; "mySel")

$winRef:=Open form window:C675("DEMO_Listbox"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)

SET WINDOW TITLE:C213("Listbox — sources de données")

DIALOG:C40("DEMO_Listbox")
CLOSE WINDOW:C154($winRef)
