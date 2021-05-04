extends StaticBody2D

export(bool) var Light_Variable=false
export(int) var light_scale=1
export(float) var max_energi=2
export(float) var min_energi=0
export(float,0,20) var Time_Light=1
export(bool) var Shadow_E=false

onready var light=$Light2D

var upDonw=true
var speed

func _ready():
	light.texture_scale=light_scale
	if Light_Variable:
		light.energy=min_energi
	else:
		light.energy=max_energi
	light.shadow_enabled=Shadow_E
	speed=(max_energi-min_energi)/(60*Time_Light)
	set_physics_process(Light_Variable)
	
	
func _physics_process(_adelta):
	if upDonw:
		light.energy+=speed
		if light.energy > max_energi:
			upDonw=false
	else:
		light.energy-=speed
		if light.energy < min_energi:
			upDonw=true




func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		body.Death_Player()
