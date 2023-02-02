extends Node

@onready var label = $Panel/Label

var currentPoints = 0
#Den Score kann man bestimmt an ne nettere stelle packen wenn man die Zeit dafür hat

func _ready():
	label.text = "0 Points"

func _on_beet_spawner_beet_collected(points:int)-> void:
	currentPoints += points
	label.text = str(currentPoints, " Points")
