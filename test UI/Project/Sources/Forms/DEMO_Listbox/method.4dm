var $e : Object
$e:=FORM Event:C1606

Case of 
		//______________________________________________________
	: ($e.code=On Load:K2:1)
		
		// === 2. Tableau nommé (variable process) ===
		ARRAY TEXT:C222(aValues; 3)
		aValues{1}:="Alpha"
		aValues{2}:="Bravo"
		aValues{3}:="Charlie"
		
		// === 3. Tableau multi-colonnes (types variés) ===
		ARRAY TEXT:C222(aNames; 3)
		ARRAY LONGINT:C221(aAges; 3)
		ARRAY BOOLEAN:C223(aActive; 3)
		aNames{1}:="Alice"
		aNames{2}:="Bob"
		aNames{3}:="Carol"
		aAges{1}:=30
		aAges{2}:=25
		aAges{3}:=42
		aActive{1}:=True:C214
		aActive{2}:=False:C215
		aActive{3}:=True:C214
		
		// === 4. Tableau hiérarchique ===
		ARRAY TEXT:C222(aPays; 4)
		ARRAY TEXT:C222(aRegion; 4)
		ARRAY TEXT:C222(aVille; 4)
		aPays{1}:="France"
		aPays{2}:="France"
		aPays{3}:="France"
		aPays{4}:="Italie"
		aRegion{1}:="Île-de-France"
		aRegion{2}:="Île-de-France"
		aRegion{3}:="PACA"
		aRegion{4}:="Latium"
		aVille{1}:="Paris"
		aVille{2}:="Versailles"
		aVille{3}:="Nice"
		aVille{4}:="Rome"
		
		ARRAY POINTER:C280($hierarchy; 3)
		$hierarchy{1}:=->aPays
		$hierarchy{2}:=->aRegion
		$hierarchy{3}:=->aVille
		LISTBOX SET HIERARCHY:C1098(*; "arrayHier"; True:C214; $hierarchy)
		
		// === 6. Collection de scalaires ===
		Form:C1466.scalars:=["Rouge"; "Vert"; "Bleu"]
		
		// === 7 & 8. Collection d'objets ===
		Form:C1466.objects:=[{name: "Alpha"; age: 10}; {name: "Bravo"; age: 20}; {name: "Charlie"; age: 30}]
		
		// === 9. Collection liée à une variable process ===
		var myColl:=[{name: "Xavier"; age: 1}; {name: "Yannick"; age: 2}]
		
		// === Données table (cas 10, 11, 12) ===
		// Les enregistrements et la sélection nommée "mySel" sont préparés par la
		// méthode qui ouvre le formulaire (avant DIALOG).
		
		// === 10. Entity selection ===
		Form:C1466.entitySel:=ds:C1482.Table_1.all()
		
		// === 11. Sélection courante ===
		ALL RECORDS:C47([Table_1:1])
		
		// === Instanciation des wrappers + affichage de l'image des sources ===
		Form:C1466.lb:={}
		
		Form:C1466.lb.arrayDyn:=cs:C1710.ui.listbox.new("arrayDyn")
		OBJECT SET VALUE:C1742("in_arrayDyn"; Form:C1466.lb.arrayDyn.dataSources)
		
		Form:C1466.lb.arrayNamed:=cs:C1710.ui.listbox.new("arrayNamed")
		OBJECT SET VALUE:C1742("in_arrayNamed"; Form:C1466.lb.arrayNamed.dataSources)
		
		Form:C1466.lb.arrayMulti:=cs:C1710.ui.listbox.new("arrayMulti")
		OBJECT SET VALUE:C1742("in_arrayMulti"; Form:C1466.lb.arrayMulti.dataSources)
		
		Form:C1466.lb.arrayHier:=cs:C1710.ui.listbox.new("arrayHier")
		OBJECT SET VALUE:C1742("in_arrayHier"; Form:C1466.lb.arrayHier.dataSources)
		
		Form:C1466.lb.collNone:=cs:C1710.ui.listbox.new("collNone")
		OBJECT SET VALUE:C1742("in_collNone"; Form:C1466.lb.collNone.dataSources)
		
		Form:C1466.lb.collScalars:=cs:C1710.ui.listbox.new("collScalars")
		OBJECT SET VALUE:C1742("in_collScalars"; Form:C1466.lb.collScalars.dataSources)
		
		Form:C1466.lb.collObjects:=cs:C1710.ui.listbox.new("collObjects")
		OBJECT SET VALUE:C1742("in_collObjects"; Form:C1466.lb.collObjects.dataSources)
		
		Form:C1466.lb.collFull:=cs:C1710.ui.listbox.new("collFull")
		OBJECT SET VALUE:C1742("in_collFull"; Form:C1466.lb.collFull.dataSources)
		
		Form:C1466.lb.collVar:=cs:C1710.ui.listbox.new("collVar")
		OBJECT SET VALUE:C1742("in_collVar"; Form:C1466.lb.collVar.dataSources)
		
		Form:C1466.lb.entitySel:=cs:C1710.ui.listbox.new("entitySel")
		OBJECT SET VALUE:C1742("in_entitySel"; Form:C1466.lb.entitySel.dataSources)
		
		Form:C1466.lb.currentSel:=cs:C1710.ui.listbox.new("currentSel")
		OBJECT SET VALUE:C1742("in_currentSel"; Form:C1466.lb.currentSel.dataSources)
		
		Form:C1466.lb.namedSel:=cs:C1710.ui.listbox.new("namedSel")
		OBJECT SET VALUE:C1742("in_namedSel"; Form:C1466.lb.namedSel.dataSources)
		
		
		
		//______________________________________________________
	Else 
		
		// A "Case of" statement should never omit "Else"
		
		//______________________________________________________
End case 
