If (Bool:C1537(Form:C1466.trace))
	
	Form:C1466.trace:=False:C215
	TRACE:C157
	
End if 

C_TEXT:C284($t)
$t:=Select document:C905(8858;"public.image";"";Package open:K24:8+Use sheet window:K24:11)

If (Bool:C1537(OK))
	
	Form:C1466.testPicture.read(File:C1566(DOCUMENT;fk platform path:K87:2))
	
End if 