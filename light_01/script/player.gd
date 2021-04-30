extends KinematicBody2D

export(int) var GRAVITY=25
export(int) var SPEED=14000
export(int) var HEIGHT_JUMP=800

#Sprites do player
onready var pHead=$player_head
onready var pBody=$player_body
onready var pCloa=$player_clouth
onready var pLegs=$player_legs
onready var pOlhos=$player_olhos

onready var reborn=$Reborn
onready var animation=$AnimationPlayer

#A Variavel canMove Deifne se ocorrera a moviemntação de player por input e aplicação de gravidade
var canMove=true
#Armazena a posição em que o player inicia
var ini_position:Vector2
#Vector de movimentção 
var input_vector:Vector2=Vector2.ZERO

signal go_To_Init

func _ready():
#	init
	ini_position=global_position
	VisualServer.set_default_clear_color(Color(0,0,0,0.5))
	$particulas.emitting=false
	$particulas.visible=true
	reborn.emitting=false
	reborn.one_shot=true
#	todos os sprites são configurados como visivel
	pHead.visible=true
	pBody.visible=true
	pLegs.visible=true
	pOlhos.visible=true
	pCloa.visible=true
	modulate="#ffffffff"
	
func _physics_process(delta):
	input_vector.x=0
#	movimentação por input
	if Input.is_action_pressed("Left") and canMove:
		input_vector.x-=SPEED*delta
		pHead.flip_h=true
		pBody.flip_h=true
		pLegs.flip_h=true
		pOlhos.flip_h=true
		pCloa.flip_h=true
	elif Input.is_action_pressed("Right") and canMove:
		input_vector.x+=SPEED*delta
		pHead.flip_h=false
		pBody.flip_h=false
		pLegs.flip_h=false
		pCloa.flip_h=false
		pOlhos.flip_h=false
	else:
		input_vector.x=0
	
	if canMove:
	#	Aplica gravidade
		input_vector.y+=GRAVITY
		
	#	Caso esteja no chão, Pula, anda pra esquerda ou direitra
		if is_on_floor():
			if Input.is_action_pressed("Up"):
				input_vector.y-=HEIGHT_JUMP
			if is_on_floor() and Input.is_action_pressed("Right") or is_on_floor() and Input.is_action_pressed("Left") :
				animation.play("walk")
				pHead.rotation_degrees=0
				pOlhos.rotation_degrees=0
			elif is_on_floor():
				animation.play("idle")
				pHead.rotation_degrees=0
				pOlhos.rotation_degrees=0
	#	Animações de pulo ou queda
		else:
			if input_vector.y<0:
				animation.play("jump_up")
				if pBody.flip_h==true:
					pHead.rotation_degrees=30
					pOlhos.rotation_degrees=30
				else:
					pHead.rotation_degrees=325
					pOlhos.rotation_degrees=325	
			else:
				animation.play("jump_down")
				if pBody.flip_h==true:
					pHead.rotation_degrees=325
					pOlhos.rotation_degrees=325
				else:
					pOlhos.rotation_degrees=30
					pHead.rotation_degrees=30
		
	input_vector=move_and_slide(input_vector,Vector2.UP)

func Death_Player():
	canMove=false
	animation.play("Death")

func return_to_init_position():
	global_position=ini_position
	reborn.emitting=true
	
#Emiti o sinal para que a camera vá para a posição de spawn
func Emit_Signal_To_Init_Position():
	emit_signal("go_To_Init")

func set_canMove():
	canMove=true
