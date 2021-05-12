extends StaticBody2D

export(NodePath) var Interruptor
export(bool) var Pariculas_Emitindo:bool=true
export(bool) var Interruptor_Invert:bool=false

onready var par:Particles2D=$Particles2D
onready var col:CollisionShape2D=$CollisionShape2D

var node:Area2D

func _ready():
	if Interruptor:
		node=get_node(Interruptor)
		if Interruptor_Invert:
			var _a=node.connect("interruptor_off",self,"Low_Smook")
			var _b=node.connect("interruptor_on",self,"Up_Smook")
		else:
			var _a=node.connect("interruptor_on",self,"Low_Smook")
			var _b=node.connect("interruptor_off",self,"Up_Smook")
	par.amount=100	
	par.emitting=Pariculas_Emitindo
	if Pariculas_Emitindo:
		col.disabled=false
	else:
		col.disabled=true

func Low_Smook():
	par.emitting=false
	col.disabled=true

func Up_Smook():
	par.emitting=true
	col.disabled=false
	
	
	
