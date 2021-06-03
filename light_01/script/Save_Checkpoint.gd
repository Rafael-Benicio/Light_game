extends StaticBody2D

onready var d:Sprite=$draw
onready var s:AudioStreamPlayer=$AudioStreamPlayer

func _ready():
	d.visible=false

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if d.visible==false:
			body.ini_position=body.global_position
			d.visible=true
			s.play()
