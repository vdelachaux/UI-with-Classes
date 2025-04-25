var $e:=FORM Event:C1606

Case of 
		
		// ______________________________________________________
	: ($e.code=On Load:K2:1)
		
		// Instantiate a Countries widget: Form.Countries.data is the datasource of the form object
		Form:C1466.Countries:=cs:C1710.ui.comboBox.new("Combo Box"; {values: ["France"; "Italy"; "Germany"]})
		
		// Instantiate a Fruits widget: Form.Fruits.data is the datasource of the form object
		// The list should be ordered and displayed when the widget is selected.
		Form:C1466.Fruits:=cs:C1710.ui.comboBox.new("Combo Box1"; {\
			values: ["apples"; "nuts"; "pears"; "oranges"; "carrots"]; \
			ordered: True:C214; \
			automaticExpand: True:C214; \
			placeholder: "Enter a fruit name"})
		
		// Instantiate the “Clear” button for Fruits & deactivate it
		Form:C1466.clearFruits:=cs:C1710.ui.button.new("Button1").disable()
		
		// Instantiate a Cities widget: Form.Cities.data is the datasource of the form object
		// The list should be ordered and if a value entered is not found in the list, this value is added to the list in memory
		Form:C1466.Cities:=cs:C1710.ui.comboBox.new("Combo Box2"; {\
			values: ["Philadelphia"; "Pittsburg"; "Grand Blanc"; "Bad Axe"; "Frostbite Falls"; "Green Bay"]; \
			ordered: True:C214; \
			automaticInsertion: True:C214})
		
		// Instantiate the “Reset” button for Cities & deactivate it
		Form:C1466.resetCities:=cs:C1710.ui.button.new("Button3").disable()
		
		// A numerical list with automatic insertion
		// The filter and the form events are set automatically by the constructor.
		Form:C1466.Numbers:=cs:C1710.ui.comboBox.new("Combo Box3"; {values: [1; 2; 3]; automaticInsertion: True:C214; ordered: True:C214})
		
		// ______________________________________________________
End case 