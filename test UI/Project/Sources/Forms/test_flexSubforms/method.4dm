var $e:=FORM Event:C1606

Case of 
		
		// ______________________________________________________
	: ($e.code=On Load:K2:1)
		
		var $tools:=[\
			"mySubform"; \
			"mySubform"; \
			"mySubform"; \
			"mySubform"; \
			"mySubform"; \
			"mySubform"; \
			"mySubform"; \
			"mySubform"; \
			"mySubform"; \
			"mySubform"; \
			"mySubform"; \
			"mySubform"; \
			"mySubform"; \
			"mySubform"; \
			"mySubform"; \
			"mySubform"; \
			"mySubform"]
		
		var $flexOptions:={\
			padding: 20; \
			flexWrap: "wrap"; \
			uniformWrapWidth: True:C214}
		
		Form:C1466.container:=cs:C1710.ui.flexContainer.new(cs:C1710.ui.static.new("background"); $flexOptions)
		
		var $contraints:={maxWidth: 600}
		//var $contraints:={fixedWidth: True}
		
		var $i : Integer
		For each ($tool; $tools)
			
			If ($i=0)
				
				var $widget:=cs:C1710.ui.subform.new("Subform")
				
			Else 
				
				$widget:=$widget.duplicate()
				
			End if 
			
			$widget.setSubform($tool)
			$widget.flexRules:=cs:C1710.ui.flexRules.new($contraints; $widget)
			Form:C1466.container.add($widget)
			
			$i+=1
			
		End for each 
		
		Form:C1466.container.layout()
		
		// ______________________________________________________
	: ($e.code=On Timer:K2:25)\
		 || ($e.code=On Resize:K2:27)
		
		SET TIMER:C645(0)
		
		Form:C1466.container.layout()
		
		// ______________________________________________________
End case 