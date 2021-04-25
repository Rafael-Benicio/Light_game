extends Area2D

export(NodePath) var node_A
var node
var can=false

func _ready():
	node=get_node(node_A)

func _process(_delta):
	if Input.is_action_just_pressed("Ok") and can:
			node.light_on()

func _on_interupitor_body_entered(body):
	if body.is_in_group("player"):
		can=true


func _on_interupitor_body_exited(body):
	if body.is_in_group("player"):
		can=false