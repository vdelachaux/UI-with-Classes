var $p : Picture

READ PICTURE FILE:C678(File:C1566("/RESOURCES/Images/light_on.png").platformPath; $p)

// Create the drag icon
$p:=cs:C1710.svg.new()\
.image($p).position(2; 4)\
.textArea("Bevel").fontSize(13).position(20; 2)\
.picture()

SET DRAG ICON:C1272($p)