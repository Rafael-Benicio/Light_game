extends Node

var nivel_1:Node2D=preload("res://scenas/Main_scenes/Nivel_1.tscn").instance()
var nivel_1_2:Node2D=preload("res://scenas/Main_scenes/Nivel_1_2.tscn").instance()
var nivel_1_3:Node2D=preload("res://scenas/Main_scenes/Nivel_1_3.tscn").instance()
var nivel_2:Node2D=preload("res://scenas/Main_scenes/Nivel_2.tscn").instance()
var nivel_2_1:Node2D=preload("res://scenas/Main_scenes/Nivel_2_1.tscn").instance()
var nivel_3:Node2D=preload("res://scenas/Main_scenes/Nivel_3.tscn").instance()
var nivel_4:Node2D=preload("res://scenas/Main_scenes/Nivel_4.tscn").instance()
var nivel_5:Node2D=preload("res://scenas/Main_scenes/Nivel_5.tscn").instance()

export(int) var level:int=0

onready var icon_T1:TextureRect=$CanvasLayer/TextureRect
onready var icon_T2:TextureRect=$CanvasLayer/TextureRect2
onready var icon_T3:TextureRect=$CanvasLayer/TextureRect3

var nivel:Array
var level_controler:int

func _ready():
#	Instancias os niveis
	nivel=[
		nivel_1,
		nivel_1_2,
		nivel_1_3,
		nivel_2,
		nivel_2_1,
		nivel_3,
		nivel_4,
		nivel_5]
		
#	controla o nivel que vai ser instanciado 
	level_controler=level
#	get door
	add_child(nivel[level_controler])
	level_controler+=1
	var _x=get_node("Nivel/Features/Door_To_next_Level").connect("nextLevel",self,"change_level")
	var _m=get_node("Nivel/Features/Icon_colet/Icons_Eyes_Close1").connect("get_colet",self,"Icon_ImT1")
	var _n=get_node("Nivel/Features/Icon_colet/Icons_Eyes_Close2").connect("get_colet",self,"Icon_ImT2")
	var _o=get_node("Nivel/Features/Icon_colet/Icons_Eyes_Close3").connect("get_colet",self,"Icon_ImT3")
	var _q=get_node("Nivel/Seres/player").connect("Death_Player",self,"Death_And_Restart")
	
	
func change_level():
	if level_controler+1 > nivel.size():
		var _x=get_tree().change_scene("res://scenas/Main_scenes/test.tscn")
	else:
		icon_T1.modulate="#fff"
		icon_T2.modulate="#fff"
		icon_T3.modulate="#fff"
		add_child(nivel[level_controler])
		nivel[level_controler].get_node("Features/Door_To_next_Level").connect("nextLevel",self,"change_level")
		nivel[level_controler].get_node("Features/Icon_colet").get_child(0).connect("get_colet",self,"Icon_ImT1")
		nivel[level_controler].get_node("Features/Icon_colet").get_child(1).connect("get_colet",self,"Icon_ImT2")
		nivel[level_controler].get_node("Features/Icon_colet").get_child(2).connect("get_colet",self,"Icon_ImT3")
		nivel[level_controler].get_node("Seres/player").connect("Death_Player",self,"Death_And_Restart")
		
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
