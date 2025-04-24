// Swap datasources
Form:C1466.current:=Form:C1466.current=Form:C1466.fruits ? Form:C1466.cities : Form:C1466.fruits
Form:C1466.myDrop.reset(Form:C1466.current)

SET TIMER:C645(-1)