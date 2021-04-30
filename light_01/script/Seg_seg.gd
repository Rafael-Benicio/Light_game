extends KinematicBody2D

export(int) var GRAVITY=25
export(int) var SPEED=14000
export(String, "left", "right", "idle") var direction

onready var coli=$colision_parede
onready var animation=$anima
onready var timer=$end_idle

var vector_move=Vector2.ZERO
var dir_Before="right"
var boost=true

func _ready():
#	set Particles like = true
	$Particles2D.emitting=true
	$Particles2D2.emitting=true
	$Particles2D.visible=true
	$Particles2D2.visible=true
	
	if direction=="idle":
		timer.start(6)

func _physics_process(delta):
		vector_move.x=0
#		Aplica gravidade
		vector_move.y+=GRAVITY
#		direção do movimenot
		if direction=="right":
			vector_move.x+=config_speed(delta)
			if boost:
				animation.play("walk_right_speed")
			else:
				animation.play("walk_right")
		elif direction=="left":
			vector_move.x-=config_speed(delta)
			if boost:
				animation.play("walk_left_speed")
			else:
				animation.play("walk_left")
		elif direction=="idle":
			vector_move.x=0
			animation.play("idle")
#		Aplica toda a movimentação
		vector_move=move_and_slide(vector_move,Vector2.UP)

#retorna a velocidade 
func config_speed(delta):
	if boost:
		return SPEED*delta*1.5
	else:
		return SPEED*delta*0.5
#Muda a direção da caminhada caso encontre uma parede
func colision_wall(body):
	if (randi()%100)<=30 and direction!="idle":
		direction="idle"
		timer.start(6)
	else:
		if body.is_in_group("wall"):
			if direction=="right":
				direction="left"
				dir_Before='left'
			elif direction=="left":
				direction="right"
				dir_Before='right'
#Ao final do periodo de idle, dereciona o seg_seg
func end_idle():
	if dir_Before=="right":
		direction="left"
		dir_Before='left'
	elif dir_Before=="left":
		direction="right"
		dir_Before='right'
		
#Detecta o player
func detect_player(body):
	if body.is_in_group("player"):
		boost=true

func sai_da_area_de_Perseguition(body):
	if body.is_in_group("player"):
		boost=false


func mata_Player(body):
	if body.is_in_group('player'):
		body.Death_Player()
