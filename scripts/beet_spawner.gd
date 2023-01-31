extends Node

@export var radius := 20.0
@export var interval := 3.0

var beet := preload("res://scenes/beet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_beets_periodically()

func spawn_beets_periodically():
	while true:
		var randomized_interval =  interval + randf_range(-interval/2.0, interval/2.0) 
		await get_tree().create_timer(randomized_interval).timeout
		var new_beet = beet.instantiate()
		add_child(new_beet)
		new_beet.position = Vector3(randf_range(-radius, radius),\
		-2 , randf_range(-radius, radius))



