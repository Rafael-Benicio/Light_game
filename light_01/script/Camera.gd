extends Node2D

#Caminho para o node do Player que a camera vai seguir
export(NodePath) var Element_To_Follow
#Limites de até onde na Viewport a campera pode ir
export(int) var Limit_Left=-1000000
export(int) var Limit_Top=-1000000
export(int) var Limit_Right=1000000
export(int) var Limit_Botton=1000000
#quantidade de smoot que via ser aplicado na camera
export(int) var Smooth=0
#Pega o nodee Tween
onready var Tween_node:Tween=$Tween
#Pega o node Camera2D
onready var camera:Camera2D=$Camera
#NODE Temporario para veridicar a taxa de fps
onready var fps=$CanvasLayer/Label
#Vairavel que vai armazenar o Player que vai ser seguido
var node:KinematicBody2D

func _ready():
#	Pega o nodo que vai ser seguido
	node=get_node(Element_To_Follow)
#	Conecta com o sinal "go_To_Init" que é emitido quando o Player morre
	var _ok=node.connect("go_To_Init", self,'go_To_Init_Position')
#	Seta os limites da camera
	camera.limit_left=Limit_Left
	camera.limit_bottom=Limit_Botton
	camera.limit_right=Limit_Right
	camera.limit_top=Limit_Top
#	Se 'Smooth' for diferente de 0,ele é habilitado
	if Smooth!=0:
		camera.smoothing_enabled=true
		camera.smoothing_speed=Smooth
	else:
		camera.smoothing_enabled=false

func _physics_process(_delta):
#	Camera seguindo o player
	if node.canMove:
		global_position=node.global_position
#	FPS na tela
	fps.text="FPS: "+str(Engine.get_frames_per_second())

#Camera vai para a posição armazenada na variavel 'ini_position' no node do Player
func go_To_Init_Position():
	if Tween_node.interpolate_property(self,"position",position,node.ini_position,1,Tween_node.TRANS_LINEAR,Tween_node.EASE_IN,1):
		var _ok:bool=Tween_node.start()
