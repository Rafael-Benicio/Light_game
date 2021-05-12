extends PathFollow2D

export(float) var timeSpeed:float=10

var speed:float

func _ready():
	speed=1/(60*timeSpeed)

func _physics_process(_delta):
	unit_offset+=speed
