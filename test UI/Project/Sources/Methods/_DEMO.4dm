//%attributes = {"invisible":true}
#DECLARE($demo : Object)

var $form : Text
$form:=$demo.form

var $winRef : Integer
$winRef:=Open form window:C675($form; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)

DIALOG:C40($form)
CLOSE WINDOW:C154($winRef)