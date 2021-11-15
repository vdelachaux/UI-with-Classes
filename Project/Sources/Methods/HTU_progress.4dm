//%attributes = {}
var $i : Integer
var $o : Object
var $c : Collection
var $progress : cs:C1710.progress

$c:=New collection:C1472()
$c[19]:=True:C214

Progress QUIT(0)

$progress:=cs:C1710.progress.new("PROCESSING A COLLECTION")

$progress.forEach($c; Formula:C1597(htuProgressDoSomething); True:C214)

$progress.setTitle("Waiting for next step…")
DELAY PROCESS:C323(Current process:C322; 60)

$o:=New object:C1471

For ($i; 1; 50; 1)
	
	$o["property_"+String:C10($i)]:=$i
	
End for 

$progress.setTitle("PROCESSING AN OBJECT").setDelay(60*2).showStop()\
.forEach($o; Formula:C1597(htuProgressDoSomething); True:C214)

If ($progress.stopped)
	
	$progress.close()
	
	$progress:=cs:C1710.progress.new("Cancelling operation…").show()
	DELAY PROCESS:C323(Current process:C322; 60)
	$progress.close()
	
Else 
	
	$progress.setTitle("Waiting for next step…").hideStop()
	DELAY PROCESS:C323(Current process:C322; 60)
	
	$c:=New collection:C1472
	
	For ($i; 1; 50; 1)
		
		$c.push("Array item #"+String:C10($i))
		
	End for 
	
	$progress.setTitle("PROCESSING AN ARRAY")\
		.forEach($c; Formula:C1597(htuProgressDoSomething))
	
End if 
