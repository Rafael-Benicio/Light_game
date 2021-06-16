extends Control

onready var play:Button=$VBox/Play
onready var exit:Button=$VBox/Exit

signal level_next

func _ready():
#	desabilitar modo de focus
	play.focus_mode=0
	exit.focus_mode=0
	

func _on_Play_pressed():
	emit_signal("level_next")

func _on_Exit_pressed():
	get_tree().quit()
