extends Area2D

var colet_green=preload("res://sons/son_colet.wav")
var colet_blue=preload("res://sons/son_colet_2.wav")
var colet_red=preload("res://sons/son_colet_3.wav")

export(String, "Eyes_Close", "Boll", "Coletavel") var Habilit:String="Eyes_Close"

onready var sp:AnimatedSprite=$AnimatedSprite
onready var col:CollisionShape2D=$CollisionShape2D
onready var timer:Timer=$Timer
onready var lamp:Light2D=$Light2D
onready var son_colet:AudioStreamPlayer=$AudioStreamPlayer


signal get_colet

func _ready():
	if Habilit=="Eyes_Close":
		son_colet.stream=colet_blue
		son_colet.volume_db=-10
		sp.animation="eyes"
		sp.modulate="#0000ff"
		lamp.color="#00002c"
		lamp.energy=3
		lamp.visible=true
		lamp.enabled=true
	elif Habilit=="Boll":
		son_colet.stream=colet_red
		son_colet.volume_db=-10
		son_colet.pitch_scale=1.5
		sp.animation="boll"
		sp.modulate="#ff0000"
		lamp.color="#2c0000"
		lamp.energy=3
		lamp.visible=true
		lamp.enabled=true
	elif Habilit=="Coletavel":
		son_colet.stream=colet_green
		son_colet.volume_db=-15
		son_colet.pitch_scale=0.8
		sp.animation="colet"
		sp.modulate="#00ff00"
		lamp.color="#002c00"
		lamp.energy=3
		lamp.visible=true
		lamp.enabled=true

func Give_item(body):
	if body.is_in_group("player"):
		son_colet.play()
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
