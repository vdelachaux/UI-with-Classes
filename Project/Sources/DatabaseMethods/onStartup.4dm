If (Not:C34(Is compiled mode:C492))
	
	ARRAY TEXT:C222($componentsArray; 0)
	COMPONENT LIST:C1001($componentsArray)
	
	If (Find in array:C230($componentsArray; "4DPop QuickOpen")>0)
		
		// Installing quickOpen
		EXECUTE METHOD:C1007("quickOpenInit"; *; Formula:C1597(MODIFIERS); Formula:C1597(KEYCODE))
		ON EVENT CALL:C190("quickOpenEventHandler"; "$quickOpenListener")
		
		var $icon : Picture
		READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/light_on.png").platformPath; $icon)
		var $o : Object
		$o:=New object:C1471(\
			"name"; " Demo 1"; \
			"icon"; $icon; \
			"formula"; Formula:C1597(DEMO_1))
		
		EXECUTE METHOD:C1007("quickOpenPushAction"; *; $o)
		
		$o:=New object:C1471(\
			"name"; " Demo 1"; \
			"icon"; $icon; \
			"formula"; Formula:C1597(DEMO_1))
		
		EXECUTE METHOD:C1007("quickOpenPushAction"; *; $o)
		
	End if 
End if 
