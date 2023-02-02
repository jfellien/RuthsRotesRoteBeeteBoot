extends Node3D

@export var sensitivity: float = 0.1

#Werte werden ein bisschen prewarmed damit man nicht auf 0 speed startet
@onready var inertia_x : float = randf_range(0, sensitivity)
@onready var inertia_y : float = randf_range(0, sensitivity)

#bounding box/limits
#if you want to, you can create a real bounding box/polygon and check overlap
var x_min := -65.0
var x_max := 65.0
var y_min := -144.0
var y_max := 6.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	check_position()
	translate(Vector3(inertia_x, 0, inertia_y))
	pass

#Dein Sensor sollte mir quasi kontinuierlich Werte liefern, wenn nicht: Ab damit in die _process
func _input(event) -> void:
	inertia_x += sensitivity * (event.get_action_strength("steer_left") - event.get_action_strength("steer_right"))
	inertia_y += sensitivity * (event.get_action_strength("steer_up") - event.get_action_strength("steer_down"))
	
	#Damit man bei keyboard control das Boot nicht zum Stillstand bekommt. War sonst langweilig.
	if inertia_x == 0.0:
		inertia_x += randf_range(0, sensitivity) * (event.get_action_strength("steer_left") - event.get_action_strength("steer_right"))
		
	if inertia_y == 0.0:
		inertia_y += randf_range(0, sensitivity) * (event.get_action_strength("steer_up") - event.get_action_strength("steer_down"))


#Ugliest function i've written in a hot minute, but I can't be bothered anymore
func check_position():
	if position.x < x_min:
		position.x = x_min
		inertia_x = -inertia_x
	elif position.x > x_max:
		position.x = x_max
		inertia_x = -inertia_x
	if position.z < y_min:
		position.z = y_min
		inertia_y = -inertia_y
	elif position.z > y_max:
		position.z = y_max
		inertia_y = -inertia_y

