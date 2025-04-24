var $e:=FORM Event:C1606

Case of 
		
		// ______________________________________________________
	: ($e.code=On Load:K2:1)
		
		// Instantiate a Countries widget: Form.Countries.data is the datasource of the form object
		Form:C1466.Countries:=cs:C1710.ui.comboBox.new("Combo Box"; {values: ["France"; "Italy"; "Germany"]})
		
		// Instantiate a Fruits widget: Form.Fruits.data is the datasource of the form object
		// The list should be ordered and displayed when the widget is selected.
		Form:C1466.Fruits:=cs:C1710.ui.comboBox.new("Combo Box1"; {values: ["apples"; "nuts"; "pears"; "oranges"; "carrots"]; ordered: True:C214; automaticExpand: True:C214; currentValue: "oranges"})
		
		// Instantiate a Cities widget: Form.Cities.data is the datasource of the form object
		// If a value entered is not found in the list, this value is added to the list in memory
		Form:C1466.Cities:=cs:C1710.ui.comboBox.new("Combo Box2"; {\
			values: ["Philadelphia"; "Pittsburg"; "Grand Blanc"; "Bad Axe"; "Frostbite Falls"; "Green Bay"]; \
			ordered: False:C215; \
			automaticExpand: False:C215; \
			automaticInsertion: True:C214; \
			placeholder: "Select a city…"})
		
		// Instantiate the “Clear” button for Fruits & deactivate it
		Form:C1466.clearFruits:=cs:C1710.ui.button.new("Button1").disable()
		
		// Instantiate the “Reset” button for Cities & deactivate it
		Form:C1466.resetCities:=cs:C1710.ui.button.new("Button3").disable()
		
		// ______________________________________________________
	: ($e.code=On Timer:K2:25)
		
		SET TIMER:C645(0)  // Don't forget to always turn off the timer ;-)
		
		// Enable Clear button if current value is not empty
		Form:C1466.clearFruits.enable(Length:C16(Form:C1466.Fruits.value)>0)
		
		// Enable Reset button if associated list was modified
		Form:C1466.resetCities.enable(Form:C1466.Cities.listModified())
		
		// ______________________________________________________
End case 