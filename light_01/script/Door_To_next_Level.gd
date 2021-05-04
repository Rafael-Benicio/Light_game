extends Node2D

export(PackedScene) var Next_Level
export(int,0,10) var Time=1

onready var animation=$AnimatedSprite
onready var canvas=$CanvasLayer/ColorRect

func _ready():
	assert(Next_Level,"Assinale um nivel")
	animation.animation="open"
	animation.frame=0
#	cores pra fade
	canvas.color.a=0
	canvas.color.r=0
	canvas.color.g=0
	canvas.color.b=0
	set_physics_process(false)

func _physics_process(delta):
	canvas.color.a+=1*delta/Time
	if canvas.color.a>1:
		var ok=get_tree().change_scene_to(Next_Level)
		print(ok)

func to_next_level(body):
	if body.is_in_group("player"):
		body.canMove=false
		set_physics_process(true)
		body.animation.play("Next_level")


func _on_open_close_body_entered(body):
	if body.is_in_group("player"):
		animation.animation="open"
		animation.playing=true


func _on_open_close_body_exited(body):
	if body.is_in_group("player"):
		animation.animation="close"
		animation.playing=true

