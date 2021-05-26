extends KinematicBody2D

#Pariculas Emitidas no spawn
var reborn=preload("res://scenas/Features/Reborn.tscn")
var closeEyes=load("res://imgesFonts/icon_eyes.png")
var boll=load("res://imgesFonts/icon_boll.png")

#Gravidade
export(int) var GRAVITY=25
#Velocidade
export(int) var SPEED=10000
#Altura do pulo
export(int) var HEIGHT_JUMP=600

#Sprites do player
onready var pHead:Sprite=$player_head
onready var pBoll:Sprite=$Boll
onready var pBody:Sprite=$player_body
onready var pCloa:Sprite=$player_clouth
onready var pLegs:Sprite=$player_legs
onready var pOlhos:Sprite=$player_olhos
#Colisão
onready var coli:CollisionShape2D=$Cabeca
#Node de animação
onready var animation:AnimationPlayer=$AnimationPlayer
#Itens do canvas
onready var colorFade:ColorRect=$CanvasLayer/ColorRect
onready var Icons_use:TextureRect=$CanvasLayer/TextureRect
#Hurt box
onready var coliCa:CollisionShape2D=$Hurt/cab

#A Variavel canMove Deifne se ocorrera a moviemntação de player por input e aplicação de gravidade
var canMove:bool=true
#Armazena a posição em que o player inicia
var ini_position:Vector2
#Vector de movimentção 
var input_vector:Vector2=Vector2.ZERO
#Sinal para camera ir para ponto 'ini_position'
var useOK:bool=true
var Eyes_close_open:bool=true

var habilit:String="?"
var boll_Mode_Is_Active:bool=false

signal go_To_Init
signal Active_eyes
signal Active_boll_Mode
signal Death_Player


func _ready():
#	init
	ini_position=global_position
	VisualServer.set_default_clear_color(Color(0,0,0,0.5))
	$particulas.emitting=false
	$particulas.visible=true
#	todos os sprites são configurados como visivel
	pHead.visible=true
	pBody.visible=true
	pLegs.visible=true
	pOlhos.visible=true
	pCloa.visible=true
	modulate="#ffffffff"
#	Color fade
	colorFade.color.a=0
	colorFade.color.r=0
	colorFade.color.g=0
	colorFade.color.b=0
	colorFade.visible=true
#	Icons UI
	Icons_use.texture=null
	Eyes_close_open=true
#	Boll habilit
	pBoll.visible=false
	
func _physics_process(delta):
	input_vector.x=0
#	movimentação por input
	if Input.is_action_pressed("Left") and canMove:
		input_vector.x=-1
		pHead.flip_h=true
		pBody.flip_h=true
		pLegs.flip_h=true
		pOlhos.flip_h=true
		pCloa.flip_h=true
	elif Input.is_action_pressed("Right") and canMove:
		input_vector.x=+1
		pHead.flip_h=false
		pBody.flip_h=false
		pLegs.flip_h=false
		pCloa.flip_h=false
		pOlhos.flip_h=false
	else:
		input_vector.x=0

#	Aplica animações e a permição para saltar
	if canMove:
	#	Aplica gravidade
		if Input.is_action_pressed("Up") and boll_Mode_Is_Active:
			input_vector.y+=GRAVITY*0.25
		elif Input.is_action_pressed("Up"):
			input_vector.y+=GRAVITY*0.5
		else:
			input_vector.y+=GRAVITY 
			
#		Usar Habilidades caso o 'useOk' não esteja em false 
		if Input.is_action_pressed("Ok") and useOK:
			if habilit=="eyes_close":
				emit_signal("Active_eyes")
			if habilit=="body_boll":
				emit_signal("Active_boll_Mode")
				
	#	Caso esteja no chão, Pula, anda pra esquerda ou direitra
		if is_on_floor():
#			Click para pulo
			if Input.is_action_pressed("Up"):
				input_vector.y-=HEIGHT_JUMP

#			Aplica animação de 'walk' ou 'idle' 
			if is_on_floor() and Input.is_action_pressed("Right") or is_on_floor() and Input.is_action_pressed("Left") :
				animation.play("walk")
				pHead.rotation_degrees=0
				pOlhos.rotation_degrees=0
				if Eyes_close_open:
					pOlhos.frame=3
				else:	
					pOlhos.frame=5
			elif is_on_floor():
				animation.play("idle")
				pHead.rotation_degrees=0
				pOlhos.rotation_degrees=0
				if Eyes_close_open:
					pOlhos.frame=3
				else:	
					pOlhos.frame=5
	#	Animações de pulo e queda
		else:
#			Aplica animação de olhar para cima e para baixo durante o pulo
			if input_vector.y<0:
				animation.play("jump_up")
				if pBody.flip_h==true:
					pHead.rotation_degrees=30
					pOlhos.rotation_degrees=30
					if Eyes_close_open:
						pOlhos.frame=0
					else:	
						pOlhos.frame=4
				else:
					pHead.rotation_degrees=325
					pOlhos.rotation_degrees=325	
					if Eyes_close_open:
						pOlhos.frame=0
					else:	
						pOlhos.frame=4
			else:
				animation.play("jump_down")
				if pBody.flip_h==true:
					pHead.rotation_degrees=325
					pOlhos.rotation_degrees=325
					if Eyes_close_open:
						pOlhos.frame=0
					else:	
						pOlhos.frame=4
				else:
					pOlhos.rotation_degrees=30
					pHead.rotation_degrees=30
					if Eyes_close_open:
						pOlhos.frame=0
					else:	
						pOlhos.frame=4
#	Aplica o movimento ao corpo kinematico
	input_vector=move_and_slide(Vector2(input_vector.x * SPEED * delta,input_vector.y),Vector2.UP)

#Inicia a animçãod e morte
func Death_Player():
	canMove=false
	animation.play("Death")
	emit_signal("Death_Player")
	var re=reborn.instance()
	get_parent().add_child(re)
	re.global_position=global_position
	re.emitting=true
	visible=false

func to_init_position():
	global_position=ini_position	
	
#Faz o personagem votar para o ponto de spawn 'ini_position'
func return_to_init_position():
	global_position=ini_position
	reborn.emitting=true
	
#Emiti o sinal para que a camera vá para a posição de spawn
func Emit_Signal_To_Init_Position():
	emit_signal("go_To_Init")

#Muda variavel canMove para verdadeiro
func set_canMove():
	canMove=true

func icon_Habilite_change(x):
	match x:
		"Eyes_Close":
			habilit="eyes_close"
			Icons_use.texture=closeEyes
		"Boll":
			habilit="body_boll"
			Icons_use.texture=boll

func Boll_Mode(tf:bool):
	pHead.visible=tf
	pBoll.visible=tf
	pBody.visible=tf
	pCloa.visible=tf
	pLegs.visible=tf
	pOlhos.visible=tf
	pBoll.visible=!tf
	coli.disabled=!tf
	coliCa.disabled=!tf
	boll_Mode_Is_Active=!tf
	
	
func hurt(body):
	if body.is_in_group("wall"):
		Death_Player()
