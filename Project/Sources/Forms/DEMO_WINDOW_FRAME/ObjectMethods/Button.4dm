var $state : Integer
$state:=OBJECT Get value:C1743("bar")
OBJECT SET VALUE:C1742("bar"; $state ?? 0 ? $state ?- 0 : $state ?+ 0)