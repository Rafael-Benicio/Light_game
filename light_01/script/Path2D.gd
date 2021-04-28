extends Path2D

var a=true

func _ready():
	pass

func _physics_process(delta):
	if a==true:
		$PathFollow2D.offset+=100.0	*delta	
	elif a==false:
		$PathFollow2D.offset-=100.0
	
	if $PathFollow2D.unit_offset==1:
		a=false
	elif $PathFollow2D.unit_offset==0:
		a=true
	
