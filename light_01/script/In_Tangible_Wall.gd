extends StaticBody2D

export(NodePath) var player
export(float) var timer_module=3


onready var sp1=$Sprite
onready var sp2=$Sprite2
onready var timer=$Timer
onready var col=$CollisionShape2D

var get_Player:KinematicBody2D

var color_change:bool=true

func _ready():
	get_Player=get_node(player)	
	var _ok=get_Player.connect("Active_eyes",self,"change_modules")
	set_physics_process(false)

func _physics_process(delta):
	if color_change:
		col.disabled=true
		if sp1.modulate.a>0:
			sp1.modulate.a-=1*delta/1
			sp2.modulate.a-=1*delta/1
	else:
		col.disabled=false
		if sp1.modulate.a<1:
			sp1.modulate.a+=1*delta/1
			sp2.modulate.a+=1*delta/1
		else:
			color_change=true
			set_physics_process(false)

func change_modules():
	set_physics_process(true)
	timer.start(timer_module)


func _on_Timer_timeout():
	color_change=false
