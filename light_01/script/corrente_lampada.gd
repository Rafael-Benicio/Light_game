extends Node2D

export(bool) var shadow=false
export(bool) var Lampada_on=false
export(float) var Light_Scale=2
export(float) var Light_Strength=1

onready var lamp=$lampada/Light2D
onready var dec=$area/CollisionShape2D

func _ready():
	lamp.shadow_enabled=shadow
	lamp.texture_scale=Light_Scale
	lamp.energy=Light_Strength
	if Lampada_on:
		lamp.enabled=true
		lamp.visible=true
		dec.disabled=false
	else:
		lamp.enabled=false
		lamp.visible=false
		dec.disabled=true

func light_on():
	lamp.enabled=true
	lamp.visible=true
	dec.disabled=false

func light_off():
	lamp.enabled=false
	lamp.visible=false
	dec.disabled=true

func _on_area_body_entered(body):
	if body.is_in_group("seg_seg") and lamp.enabled:
		body.end_idle()

