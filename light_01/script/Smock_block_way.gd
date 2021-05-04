extends StaticBody2D

export(NodePath) var inter
export(bool) var Pariculas_Emitindo=true

onready var par=$Particles2D
onready var col=$CollisionShape2D

var node

func _ready():
	par.amount=100	
	par.emitting=Pariculas_Emitindo
	node=get_node(inter)
	node.connect("interruptor_on",self,"Up_Smook")
	node.connect("interruptor_off",self,"Low_Smook")

func Low_Smook():
	par.emitting=false
	col.disabled=true

func Up_Smook():
	par.emitting=true
	col.disabled=false
	
	
	
