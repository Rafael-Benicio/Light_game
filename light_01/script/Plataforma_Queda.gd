extends StaticBody2D

onready var sprite1:Sprite=$Sprite
onready var sprite2:Sprite=$Sprite2
onready var timer:Timer=$Timer
onready var timer2:Timer=$Timer2
onready var bodyColi:CollisionShape2D=$CollisionShape2D

var can:bool=true

func _ready():
	set_physics_process(false)
	sprite1.visible=true
	sprite2.visible=true
	bodyColi.disabled=false

func _on_Area_body_entered(body):
	if body.is_in_group("player") and can:
		can=false
		timer.start(3)
		
func desaparece():
	bodyColi.disabled=true
	sprite1.visible=false
	sprite2.visible=false
	timer2.start(1)


func reaparece():
	bodyColi.disabled=false
	sprite1.visible=true
	sprite2.visible=true
	can=true
