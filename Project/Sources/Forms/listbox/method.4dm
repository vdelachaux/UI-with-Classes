var $e:=FORM Event:C1606

Case of 
		//______________________________________________________
	: ($e.code=On Load:K2:1)
		
		var myCollection:=[]
		Form:C1466.data:=myCollection
		
		Form:C1466.dynamicArray:=cs:C1710.listbox.new("dynamicArray")
		OBJECT SET VALUE:C1742("input"; Form:C1466.dynamicArray.dataSources)
		
		Form:C1466.array:=cs:C1710.listbox.new("array")
		OBJECT SET VALUE:C1742("input1"; Form:C1466.array.dataSources)
		
		
		//OBJECT SET VALUE("input"; getListBoxDatasource("dynamicArray"))
		//OBJECT SET VALUE("input1"; getListBoxDatasource("array"))
		
		//OBJECT SET VALUE("input2"; getListBoxDatasource("collection"))
		Form:C1466.collection:=cs:C1710.listbox.new("collection")
		OBJECT SET VALUE:C1742("input2"; Form:C1466.collection.dataSources)
		
		//OBJECT SET VALUE("input3"; getListBoxDatasource("collection1"))
		Form:C1466.collection1:=cs:C1710.listbox.new("collection1")
		OBJECT SET VALUE:C1742("input3"; Form:C1466.collection1.dataSources)
		
		//OBJECT SET VALUE("input4"; getListBoxDatasource("collection2"))
		Form:C1466.collection2:=cs:C1710.listbox.new("collection2")
		OBJECT SET VALUE:C1742("input4"; Form:C1466.collection2.dataSources)
		
		
		//OBJECT SET VALUE("input5"; getListBoxDatasource("collection3"))
		Form:C1466.collection3:=cs:C1710.listbox.new("collection3")
		OBJECT SET VALUE:C1742("input5"; Form:C1466.collection3.dataSources)
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($e.code=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		var $type:=Form:C1466.collection2.dataSourceType
		
		//______________________________________________________
	Else 
		
		// A "Case of" statement should never omit "Else"
		
		//______________________________________________________
End case 