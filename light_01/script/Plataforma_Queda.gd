extends StaticBody2D

export(bool) var Visible_Tangible:bool=true
export(bool) var Area_to_Vanishing:bool=true
export(float) var Timer_Desaparece:float=3
export(float) var Timer_Reaparece:float=1
export(NodePath) var Interruptor
export(bool) var Interruptor_Invert:bool=false

onready var sprite1:Sprite=$Sprite
onready var sprite2:Sprite=$Sprite2
onready var timer:Timer=$Timer
onready var timer2:Timer=$Timer2
onready var timer3:Timer=$Timer3
onready var bodyColi:CollisionShape2D=$CollisionShape2D
onready var bodyArea:CollisionShape2D=$Area/CollisionShape2D

var can:bool=true
var node:Area2D

func _ready():
	if Interruptor:
		node=get_node(Interruptor)
		if Interruptor_Invert:
			var _a=node.connect("interruptor_off",self,"Tangible_and_visible")
			var _b=node.connect("interruptor_on",self,"Intangible_and_Invisible")
		else:
			var _a=node.connect("interruptor_on",self,"Tangible_and_visible")
			var _b=node.connect("interruptor_off",self,"Intangible_and_Invisible")
	set_physics_process(false)
	sprite1.visible=true
	sprite2.visible=true
	
	if Visible_Tangible:
		visible=true
		bodyArea.disabled=false
		bodyColi.disabled=false
	else:
		visible=false
		bodyColi.disabled=true
		bodyArea.disabled=true
		
	if Area_to_Vanishing:
		bodyArea.disabled=false
	else:
		bodyArea.disabled=true	

#quando o player enta no nivel do chão
func _on_Area_body_entered(body):
	if body.is_in_group("player") and can:
		can=false
		timer.start(Timer_Desaparece)

#faz a plataforma desaparece ao tim do timer 
func desaparece():
	bodyColi.disabled=true
	sprite1.visible=false
	sprite2.visible=false
	set_physics_process(true)
	timer2.start(Timer_Reaparece)

#faz a plataforam reaparecer ao fim do timer2
func reaparece():
	bodyColi.disabled=false
	sprite1.visible=true
	sprite2.visible=true
	can=true

func Tangible_and_visible():
	sprite1.visible=true
	sprite2.visible=true
	bodyColi.disabled=false
	bodyArea.disabled=false
	visible=true
	
func Intangible_and_Invisible():
	sprite1.visible=false
	sprite2.visible=false
	bodyColi.disabled=true
	bodyArea.disabled=true
	visible=false
