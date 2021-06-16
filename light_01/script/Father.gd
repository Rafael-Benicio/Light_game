extends Node

var main_menu:Control=preload("res://scenas/Main_scenes/Main_Menu.tscn").instance()
var nivel_1:Node2D=preload("res://scenas/Main_scenes/Nivel_1.tscn").instance()
var nivel_1_1:Node2D=preload("res://scenas/Main_scenes/Nivel_1_1.tscn").instance()
var nivel_1_2:Node2D=preload("res://scenas/Main_scenes/Nivel_1_2.tscn").instance()
var nivel_2:Node2D=preload("res://scenas/Main_scenes/Nivel_2.tscn").instance()
var nivel_2_1:Node2D=preload("res://scenas/Main_scenes/Nivel_2_1.tscn").instance()
var nivel_2_2:Node2D=preload("res://scenas/Main_scenes/Nivel_2_2.tscn").instance()
var nivel_3:Node2D=preload("res://scenas/Main_scenes/Nivel_3.tscn").instance()
var nivel_3_1:Node2D=preload("res://scenas/Main_scenes/Nivel_3_1.tscn").instance()
var nivel_3_2:Node2D=preload("res://scenas/Main_scenes/Nivel_3_2.tscn").instance()
var nivel_4:Node2D=preload("res://scenas/Main_scenes/Nivel_4.tscn").instance()
var nivel_4_1:Node2D=preload("res://scenas/Main_scenes/Nivel_4_1.tscn").instance()
var nivel_5:Node2D=preload("res://scenas/Main_scenes/Nivel_5.tscn").instance()

export(int) var level:int=0
#Icons de colet
onready var icon_T1:TextureRect=$CanvasLayer/TextureRect
onready var icon_T2:TextureRect=$CanvasLayer/TextureRect2
onready var icon_T3:TextureRect=$CanvasLayer/TextureRect3
#Audio
onready var mus_1:AudioStreamPlayer=$Musica/Music_1
onready var mus_2:AudioStreamPlayer=$Musica/Music_2
#Menu
onready var menu_game:Control=$CanvasLayer/Menu
onready var reload_bt:Button=$CanvasLayer/Menu/VBoxContainer/Rolad
onready var config_bt:Button=$CanvasLayer/Menu/VBoxContainer/Configui
onready var exit_bt:Button=$CanvasLayer/Menu/VBoxContainer/Exit

#O array que vai armazenar os niveis da faze
var nivel:Array
#O array que vai armazenar os itens do menu
var menu_lista:Array
#O valor que vai apontar o nivel no array "nivel" à ser instanciado
var level_controler:int


func _ready():
	menu_game.visible=false
#	Instancias os niveis
	nivel=[
		main_menu,
		nivel_1,
		nivel_1_1,
		nivel_1_2,
		nivel_2,
		nivel_2_1,
		nivel_2_2,
		nivel_3,
		nivel_3_1,
		nivel_3_2,
		nivel_4,
		nivel_4_1,
		nivel_5]
#	controla o nivel que vai ser instanciado 
	level_controler=level
#	get door
	
	add_child(nivel[level_controler])
	
	if level_controler==0:
		var _x=get_node("Main_Menu").connect("level_next",self,"change_level")
	elif level_controler!=0:
		#	inicia musicas
		mus_1.play()
		
		var _x=get_node("Nivel/Features/Door_To_next_Level").connect("nextLevel",self,"change_level")
		var _m=get_node("Nivel/Features/Icon_colet/Icons_Eyes_Close1").connect("get_colet",self,"Icon_ImT1")
		var _n=get_node("Nivel/Features/Icon_colet/Icons_Eyes_Close2").connect("get_colet",self,"Icon_ImT2")
		var _o=get_node("Nivel/Features/Icon_colet/Icons_Eyes_Close3").connect("get_colet",self,"Icon_ImT3")
		var _q=get_node("Nivel/Seres/player").connect("Death_Player",self,"Death_And_Restart")
		var _t=get_node("Nivel/Seres/player").connect("mostra_menu",self,"Visualiza_menu")
		
	level_controler+=1
	set_process(false)
	
func _process(delta):
	if Input.is_action_just_pressed("Up"):
		pass
	elif Input.is_action_just_pressed("Down"):
		pass
	
func change_level():
	if level_controler+1 > nivel.size():
		var _x=get_tree().change_scene("res://scenas/Main_scenes/test.tscn")
	else:
		print(level_controler)
		icon_T1.modulate="#fff"
		icon_T2.modulate="#fff"
		icon_T3.modulate="#fff"
		add_child(nivel[level_controler])
		nivel[level_controler].get_node("Features/Door_To_next_Level").connect("nextLevel",self,"change_level")
		nivel[level_controler].get_node("Features/Icon_colet").get_child(0).connect("get_colet",self,"Icon_ImT1")
		nivel[level_controler].get_node("Features/Icon_colet").get_child(1).connect("get_colet",self,"Icon_ImT2")
		nivel[level_controler].get_node("Features/Icon_colet").get_child(2).connect("get_colet",self,"Icon_ImT3")
		nivel[level_controler].get_node("Seres/player").connect("Death_Player",self,"Death_And_Restart")
		nivel[level_controler].get_node("Seres/player").connect("mostra_menu",self,"Visualiza_menu")
		
		
		if level_controler==1:
			if get_node("Main_Menu"):
				get_node("Main_Menu").queue_free()
			mus_1.play()
			mus_2.playing=false
		elif level_controler==3:
			mus_1.playing=false
			mus_2.play()
		
		level_controler+=1
		
func Death_And_Restart():
	icon_T1.modulate="#fff"
	icon_T2.modulate="#fff"
	icon_T3.modulate="#fff"

func Icon_ImT1():
	icon_T1.modulate="#00ff00"
func Icon_ImT2():
	icon_T2.modulate="#00ff00"
func Icon_ImT3():
	icon_T3.modulate="#00ff00"

func Visualiza_menu():
	if menu_game.visible:
		menu_game.visible=false
		nivel[level_controler-1].get_node("Seres/player").canMove=true
		set_process(false)
	else:
		menu_game.visible=true
		set_process(true)
		nivel[level_controler-1].get_node("Seres/player").canMove=false
				
func _on_Rolad_pressed():
	if menu_game.visible:
		nivel[level_controler-1].reload_current_scene()
		menu_game.visible=false
		set_process(false)
		nivel[level_controler-1].get_node("Seres/player").canMove=true

func _on_Exit_pressed():
	if menu_game.visible:
		level_controler=0
		change_level()

