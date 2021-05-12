extends Area2D

export(bool) var emiter:bool=false

onready var light=$Light2D

var can:bool=false

signal interruptor_on
signal interruptor_off

func _ready():
	set_process(false)

func _process(_delta):
	if Input.is_action_just_pressed("Ok") and can:
		if emiter==false:
			emiter=true
			light.enabled=false
			emit_signal("interruptor_on")
		else:
			emiter=false
			light.enabled=true
			emit_signal("interruptor_off")

func _on_interupitor_body_entered(body):
	if body.is_in_group("player"):
		can=true
		body.useOK=false
		set_process(true)


func _on_interupitor_body_exited(body):
	if body.is_in_group("player"):
		can=false
		body.useOK=true
		set_process(false)
		
