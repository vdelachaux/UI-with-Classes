/* Example from the documentation

// Form.myDrop is the datasource of the form object
Form.myDrop:=New object
Form.myDrop.values:=New collection("apples"; "nuts"; "pears"; "oranges"; "carrots")
Form.myDrop.index:=-1  //currentValue is a placeholder
Form.myDrop.currentValue:="Select a fruit" 

*/

var $e:=FORM Event:C1606

Case of 
		
		// ______________________________________________________
	: ($e.code=On Load:K2:1)
		
		// Define a drop-down list for navigating through dialogue pages
		// There's no need to keep the instance, as 4D will do the work for you 🤗
		cs:C1710.ui.dropDown.new("pages").action:=ak goto page:K76:64
		
		// Just for the demo, in order to allow the change of data source, we define 2 of them…
		Form:C1466.fruits:={values: ["apples"; "nuts"; "pears"; "oranges"; "carrots"]; placeholder: "Select a fruit..."}
		Form:C1466.cities:={values: ["Philadelphia"; "Pittsburg"; "Grand Blanc"; "Bad Axe"; "Frostbite Falls"; "Green Bay"]; placeholder: "Select a city.."}
		// … & define the current one
		Form:C1466.current:=Form:C1466.fruits
		
		// Instantiate the dropdown widget: Form.myDrop.data is the datasource of the form object
		Form:C1466.myDrop:=cs:C1710.ui.dropDown.new("Popup Dropdown List"; Form:C1466.current)
		
		// Instantiate the “Clear” button and deactivate it
		Form:C1466.clear:=cs:C1710.ui.button.new("Button").disable()
		
		// ______________________________________________________
	: ($e.code=On Timer:K2:25)
		
		SET TIMER:C645(0)  // Don't forget to always turn off the timer ;-)
		
		Form:C1466.clear.enable(Form:C1466.myDrop.index#-1)
		
		// ______________________________________________________
End case 