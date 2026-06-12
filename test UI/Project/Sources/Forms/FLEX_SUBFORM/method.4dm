var $e:=FORM Event:C1606

Case of 
		
		// ______________________________________________________
	: ($e.code=On Load:K2:1)
		
		var $widgets:=[\
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
			padding: 20}
		
		Form:C1466.container:=cs:C1710.ui.flexContainer.new(Null:C1517; $flexOptions).wrap.uniformWidth
		
		var $contraints:={maxWidth: 600}
		
		var $first:=True:C214
		var $item : Text
		For each ($item; $widgets)
			
			If ($first)
				
				var $widget:=cs:C1710.ui.subform.new("Subform")
				$first:=False:C215
				
			Else 
				
				$widget:=$widget.duplicate()
				
			End if 
			
			$widget.setSubform($item)
			$widget.flexRules:=cs:C1710.ui.flexRules.new($contraints; $widget)
			Form:C1466.container.add($widget)
			
		End for each 
		
		SET TIMER:C645(-1)
		
		// ______________________________________________________
	: ($e.code=On Timer:K2:25)\
		 || ($e.code=On Resize:K2:27)
		
		SET TIMER:C645(0)
		
		// Place widgets
		var $size : Object:=Form:C1466.container.layout()
		
		// Update the dimensions of the reference rectangle
		OBJECT SET COORDINATES:C1248(*; "background"; 0; 0; $size.width; $size.height)
		
		OBJECT SET SUBFORM CONTAINER VALUE:C1784($size.height)
		CALL SUBFORM CONTAINER:C1086(-1)
		
		// ______________________________________________________
End case 