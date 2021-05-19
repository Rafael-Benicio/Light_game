extends Node2D
#Assinala nodes
export(NodePath) var player
export(NodePath) var tiles
export(NodePath) var features
export(float) var timer_module=3
#Cria timer
onready var timer:Timer=Timer.new()
onready var Door_next=$Features/Door_To_next_Level
#Variavis para get
var get_Player:KinematicBody2D
var get_tiles:Node2D
var get_features:Node2D

var color_change:bool=true
var hab="?"

func _ready():
#	Adicionando Timer
	add_child(timer)
#	configunando timer
	timer.one_shot=true
#	obtende nodes
	get_Player=get_node(player)
	get_tiles=get_node(tiles)
	get_features=get_node(features)
#	Conectando sinais
	var _x=get_Player.connect("Active_eyes",self,"change_modules_Eyes")
	var _z=get_Player.connect("Active_boll_Mode",self,"change_modules_Boll")
	var _y=timer.connect("timeout",self,"return_to_normal")
	var _w=Door_next.connect("nextLevel",self,"return_to_normal")
#	definindo os "_physics_process(delta)" como false
	set_physics_process(false)

func _physics_process(delta):
#	Mudando cor
	if color_change :
		if get_tiles.modulate.r>0 and hab=="Eyes":
			get_tiles.modulate.r-=1*delta/1
			get_tiles.modulate.g-=1*delta/1
			get_features.modulate.r-=1*delta/1
			get_features.modulate.g-=1*delta/1
		elif get_tiles.modulate.b>0 and hab=="Boll":
			get_tiles.modulate.b-=1*delta/1
			get_tiles.modulate.g-=1*delta/1
			get_features.modulate.b-=1*delta/1
			get_features.modulate.g-=1*delta/1
#	Cor volta ao normal
	else:		
		if get_tiles.modulate.r<1 and hab=="Eyes":
			get_tiles.modulate.r+=1*delta/1
			get_tiles.modulate.g+=1*delta/1
			get_features.modulate.r+=1*delta/1
			get_features.modulate.g+=1*delta/1
		elif get_tiles.modulate.b<1 and hab=="Boll":
			get_tiles.modulate.b+=1*delta/1
			get_tiles.modulate.g+=1*delta/1
			get_features.modulate.b+=1*delta/1
			get_features.modulate.g+=1*delta/1
		else:
			get_tiles.modulate.r=1
			get_tiles.modulate.b=1
			get_tiles.modulate.g=1
			get_features.modulate.r=1
			get_features.modulate.b=1
			get_features.modulate.g=1
			get_Player.useOK=true
			color_change=true
			hab="?"
			set_physics_process(false)
#Chamando pelo sinal de player
func change_modules_Eyes():
	if hab=="?":
		hab="Eyes"
		get_Player.habilit="?"
		get_Player.useOK=false		
		get_Player.Boll_Mode(true)
		get_Player.Eyes_close_open=false
		get_Player.Icons_use.texture=null
		timer.start(timer_module)
		set_physics_process(true)

func change_modules_Boll():
	if hab=="?":
		hab="Boll"
		get_Player.habilit="?"	
		get_Player.useOK=false
		get_Player.Boll_Mode(false)
		get_Player.Eyes_close_open=true
		get_Player.Icons_use.texture=null
		timer.start(timer_module)
		set_physics_process(true)

#Chamado quando ocorre time out
func return_to_normal():
	color_change=false
	if hab=="Eyes":
		get_Player.Eyes_close_open=true
	elif hab=="Boll":
		get_Player.Boll_Mode(true)

