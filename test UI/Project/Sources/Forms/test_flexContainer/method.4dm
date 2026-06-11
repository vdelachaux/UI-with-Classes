var $e:=FORM Event:C1606

Case of 
		
		// ______________________________________________________
	: ($e.code=On Load:K2:1)
		
		var $form:=cs:C1710.ui.form.new()
		Form:C1466.form:=$form
		
		// MARK:- Background
		Form:C1466.back:=$form.Static("background")
		Form:C1466.back.flexRules:=cs:C1710.ui.flexRules.new({type: "bakground"/*; minWidth: 550; minHeight: 150*/})
		Form:C1466.background:=cs:C1710.ui.flexContainer.new($form.window; {padding: 0; children: [Form:C1466.back]})
		
		// MARK:- Rectangles
		// 📌 default direction is "row". If shift key is pressed, the direction will be "column"
		var $isColumn:=Shift down:C543
		var $direction:=$isColumn ? "column" : "row"
		
		
		If ($isColumn)
			
			var $title:="flexbox column"
			
		Else 
			
			$title:="flexbox row"
			
		End if 
		
		If (Macintosh option down:C545)
			
			$title+=" with wrap"
			Form:C1466.rectangles:=cs:C1710.ui.flexContainer.new(Form:C1466.back; {direction: $direction; padding: 20; flexWrap: "wrap"})
			
		Else 
			
			$title+=" no wrap"
			Form:C1466.rectangles:=cs:C1710.ui.flexContainer.new(Form:C1466.back; {direction: $direction; padding: 20})
			
		End if 
		
		$form.window.title:=$title
		
		var $rect:=$form.Static("Rectangle")
		$rect.flexRules:=$isColumn ? cs:C1710.ui.flexRules.new({minHeight: 50; maxWidth: 400; minWidth: 100}) : cs:C1710.ui.flexRules.new({flexBasis: 80})
		Form:C1466.rectangles.add($rect)
		
		$rect:=$form.Static("Rectangle1")
		$rect.flexRules:=cs:C1710.ui.flexRules.new({minWidth: 80})
		Form:C1466.rectangles.add($rect)
		
		$rect:=$form.Static("Rectangle3")
		$rect.flexRules:=$isColumn ? cs:C1710.ui.flexRules.new({minWidth: 100}) : cs:C1710.ui.flexRules.new({minWidth: 50})
		Form:C1466.rectangles.add($rect)
		
		// MARK:- Apply constraints
		Form:C1466.background.layout()
		Form:C1466.rectangles.layout()
		
		// ______________________________________________________
	: ($e.code=On Timer:K2:25)\
		 || ($e.code=On Resize:K2:27)
		
		SET TIMER:C645(0)
		
		// Apply all constraints
		Form:C1466.background.layout()
		Form:C1466.rectangles.layout()
		
		// ______________________________________________________
End case 