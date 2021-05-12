extends Node2D

#Exports de configuraçãos
export(NodePath) var Interruptor
export(bool) var shadow:bool=false
export(bool) var Lampada_on:bool=false
export(float) var Light_Scale:float=2
export(float) var Light_Strength:float=1
export(Color) var ColorLight=Color(0.992157,1,0.694118,1)
export(bool) var Interruptor_Invert:bool=false

onready var lamp:Light2D=$lampada/Light2D

var node:Area2D

func _ready():
#	Conncecta com um interuptor
	if Interruptor:
		node=get_node(Interruptor)
		if Interruptor_Invert:
			var _a=node.connect("interruptor_off",self,"light_on")
			var _b=node.connect("interruptor_on",self,"light_off")
		else:
			var _a=node.connect("interruptor_on",self,"light_on")
			var _b=node.connect("interruptor_off",self,"light_off")
#	Configura a luz
	lamp.shadow_enabled=shadow
	lamp.texture_scale=Light_Scale
	lamp.energy=Light_Strength
	lamp.color=ColorLight
#	Checa se a luza foi iniciada Ligada ou desligada
	if Lampada_on:
		lamp.enabled=true
		lamp.visible=true
	else:
		lamp.enabled=false
		lamp.visible=false
		
		
#Habilita a luz
func light_on():
	lamp.enabled=true
	lamp.visible=true
#Desabilita a luz
func light_off():
	lamp.enabled=false
	lamp.visible=false


