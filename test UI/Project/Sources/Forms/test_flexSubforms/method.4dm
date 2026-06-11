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
			"mySubform"]
		
		var $form:=cs:C1710.ui.form.new()
		Form:C1466.form:=$form
		Form:C1466.back:=$form.Static("background")
		
		Form:C1466.container:=cs:C1710.ui.flexContainer.new(Form:C1466.back; {direction: "row"; padding: 20; flexWrap: "wrap"; alignItems: "start"})
		
		var $contraints:={maxWidth: 400}
		//var $contraints:={fixedWidth: True}
		
		var $i : Integer
		For each ($tool; $tools)
			
			If ($i=0)
				
				var $widget:=$form.Subform("Subform")
				
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