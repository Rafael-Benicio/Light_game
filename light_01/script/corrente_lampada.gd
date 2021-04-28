extends Node2D

onready var lamp=$lampada/Light2D

func _ready():
	lamp.enabled=false

func light_on():
	lamp.enabled=true
	lamp.visible=true

func light_off():
	lamp.enabled=false
	lamp.visible=false

func _on_area_body_entered(body):
	if body.is_in_group("seg_seg") and lamp.enabled:
		body.end_idle()
