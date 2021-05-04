extends Area2D

export(NodePath) var node_A
var node:Node2D
var can=false

signal interruptor_on
signal interruptor_off

func _ready():
	node=get_node(node_A)

func _process(_delta):
	if Input.is_action_just_pressed("Ok") and can:
		if node.lamp.enabled:
			node.light_off()
			emit_signal("interruptor_on")
			get_node("Light2D").enabled=true
		else:
			get_node("Light2D").enabled=false
			node.light_on()
			emit_signal("interruptor_off")
			

func _on_interupitor_body_entered(body):
	if body.is_in_group("player"):
		can=true


func _on_interupitor_body_exited(body):
	if body.is_in_group("player"):
		can=false
