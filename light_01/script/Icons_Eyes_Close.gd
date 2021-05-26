extends Area2D

export(String, "Eyes_Close", "Boll", "Coletavel") var Habilit:String="Eyes_Close"

onready var sp:Sprite=$Sprite
onready var col:CollisionShape2D=$CollisionShape2D
onready var timer:Timer=$Timer
onready var lamp:Light2D=$Light2D

var ec=load("res://imgesFonts/icon_eyes.png")
var b=load("res://imgesFonts/icon_boll.png")
var cole=load("res://imgesFonts/icon_coletavel.png")

signal get_colet

func _ready():
	if Habilit=="Eyes_Close":
		sp.texture=ec
		sp.modulate="#0000ff"
		lamp.color="#00002c"
		lamp.energy=3
		lamp.visible=true
		lamp.enabled=true
	elif Habilit=="Boll":
		sp.texture=b
		sp.modulate="#ff0000"
		lamp.color="#2c0000"
		lamp.energy=3
		lamp.visible=true
		lamp.enabled=true
	elif Habilit=="Coletavel":
		sp.texture=cole
		sp.modulate="#00ff00"
		lamp.color="#002c00"
		lamp.energy=3
		lamp.visible=true
		lamp.enabled=true

func Give_item(body):
	if body.is_in_group("player"):
		if Habilit=="Coletavel":
			emit_signal("get_colet")	
		else:
			body.icon_Habilite_change(Habilit)
		sp.visible=false
		lamp.enabled=false
		col.set_deferred("disabled",true)
		timer.start(6)

func _on_Timer_timeout():
	sp.visible=true
	lamp.enabled=true
	
	col.set_deferred("disabled",false)
