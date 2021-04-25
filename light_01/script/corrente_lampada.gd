extends Node2D

onready var lamp=$lampada/Light2D

func _ready():
	lamp.enabled=false

func light_on():
	lamp.enabled=true


func _on_area_body_entered(body):
	if body.is_in_group("player"):
		pass
