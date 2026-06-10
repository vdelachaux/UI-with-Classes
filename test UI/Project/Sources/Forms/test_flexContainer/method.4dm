var $e:=FORM Event:C1606

Case of 
		
		// ______________________________________________________
	: ($e.code=On Load:K2:1)
		
		var $form:=cs:C1710.ui.form.new()
		Form:C1466.form:=$form
		
		// MARK:- Background
		Form:C1466.back:=$form.Static("background")
		Form:C1466.back.flexRules:=cs:C1710.ui.flexRules.new({flexGrow: 50; minWidth: 250; /*minHeight: 250;*/maxWidth: 1000; adjustHeight: True:C214})
		Form:C1466.background:=cs:C1710.ui.flexContainer.new($form.window; {padding: 5; children: [Form:C1466.back]})
		
		// MARK:- rectangles
		Form:C1466.container:=cs:C1710.ui.flexContainer.new(Form:C1466.back; {padding: 20})
		
		var $rect:=$form.Static("Rectangle")
		$rect.flexRules:=cs:C1710.ui.flexRules.new({flexGrow: 10; minWidth: 100; adjustHeight: False:C215})
		Form:C1466.container.add($rect)
		
		$rect:=$form.Static("Rectangle1")
		$rect.flexRules:=cs:C1710.ui.flexRules.new({flexBasis: 200; flexGrow: 20; adjustHeight: False:C215})
		Form:C1466.container.add($rect)
		
		Form:C1466.background.layout()
		
		SET TIMER:C645(-1)
		
		// ______________________________________________________
	: ($e.code=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		Form:C1466.container.layout()
		
		// ______________________________________________________
	: ($e.code=On Resize:K2:27)
		
		Form:C1466.container.layout()
		Form:C1466.background.layout()
		
		// ______________________________________________________
End case 