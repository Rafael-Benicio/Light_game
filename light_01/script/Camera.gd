extends Node2D

export(NodePath) var Element_To_Follow

onready var Tween_node=$Tween

var node

func _ready():
	node=get_node(Element_To_Follow)
	node.connect("go_To_Init", self,'go_To_Init_Position')

func _physics_process(_delta):
	if node.canMove:
		global_position=node.global_position

func go_To_Init_Position():
	Tween_node.interpolate_property(self,"position",position,node.ini_position,1,Tween_node.TRANS_LINEAR,Tween.EASE_IN)
	Tween_node.start()
