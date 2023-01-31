extends Node3D

@export var sensitivity: float = 0.1

@onready var inertia_x : float = randf_range(0, sensitivity)
@onready var inertia_y : float = randf_range(0, sensitivity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	translate(Vector3(inertia_x, 0, inertia_y))
	pass

func _input(event) -> void:
	inertia_x += sensitivity * (event.get_action_strength("steer_left") - event.get_action_strength("steer_right"))
	inertia_y += sensitivity * (event.get_action_strength("steer_up") - event.get_action_strength("steer_down"))
	
	if inertia_x == 0.0:
		inertia_x += randf_range(0, sensitivity) * (event.get_action_strength("steer_left") - event.get_action_strength("steer_right"))
		
	if inertia_y == 0.0:
		inertia_y += randf_range(0, sensitivity) * (event.get_action_strength("steer_up") - event.get_action_strength("steer_down"))
