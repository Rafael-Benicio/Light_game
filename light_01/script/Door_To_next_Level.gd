extends Node2D

#Proxima cena pra qual o jogo vai
#export(PackedScene) var Next_Level
#O tempo para a tela escurecerl
export(int,0,10) var Time:int=2
#Se o sprite da porta vaoi ou não ser invertido
export(bool) var Door_invertion:bool=false
#Carrega childs
onready var animation:AnimatedSprite=$AnimatedSprite
onready var canvas:ColorRect=$CanvasLayer/ColorRect

signal nextLevel

func _ready():
#	assert(Next_Level,"Assinale um nivel")
	animation.animation="open"
	animation.frame=0
	animation.flip_h=Door_invertion
#	cores pra fade
	canvas.color.a=0
	canvas.color.r=0
	canvas.color.g=0
	canvas.color.b=0
#	Desabilira a funcção '_physics_process'
	set_physics_process(false)

#Tela escurecendo para mudade de cena
func _physics_process(delta):
	canvas.color.a+=1*delta/Time
	if canvas.color.a>1:
#		var _ok:bool=get_tree().change_scene_to(Next_Level)
		emit_signal("nextLevel")
		get_parent().get_parent().free()
				
#Habilita o fade para ir pra proxima cena
func to_next_level(body):
	if body.is_in_group("player"):
		body.canMove=false
		set_physics_process(true)
		body.animation.play("Next_level")

#A porta abre caso o player se aproxime
func _on_open_close_body_entered(body):
	if body.is_in_group("player"):
		animation.animation="open"
		animation.playing=true

#A porta se fecha caso o player se distancie
func _on_open_close_body_exited(body):
	if body.is_in_group("player"):
		animation.animation="close"
		animation.playing=true

