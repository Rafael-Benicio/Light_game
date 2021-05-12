extends Area2D

export(String, "Eyes_Close", "Boll") var Habilit:String="Eyes_Close"

onready var sp=$Sprite
onready var col=$CollisionShape2D
onready var timer=$Timer

var ec=load("res://imgesFonts/icon_eyes.png")
var b=load("res://imgesFonts/icon_boll.png")

func _ready():
	if Habilit=="Eyes_Close":
		sp.texture=ec
	elif Habilit=="Boll":
		sp.texture=b

func Give_item(body):
	if body.is_in_group("player"):
		body.icon_Habilite_change(Habilit)
		sp.visible=false
		col.set_deferred("disabled",true)
		timer.start(6)

func _on_Timer_timeout():
	sp.visible=true
	col.set_deferred("disabled",false)
