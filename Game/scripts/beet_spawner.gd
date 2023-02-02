extends Node

@export var radius := 20.0
@export var interval := 3.0

var beet := preload("res://scenes/beet.tscn")

signal beet_collected(points:int)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_beets_periodically()

#spawns a new beet every n seconds
func spawn_beets_periodically():
	#wow cool infinite loop
	while true:
		var randomized_interval =  interval + randf_range(-interval/2.0, interval/2.0) 
		await get_tree().create_timer(randomized_interval).timeout
		
		var new_beet = beet.instantiate()
		new_beet.collected.connect(on_new_beet_conected)
		add_child(new_beet)
		new_beet.position = Vector3(randf_range(-radius, radius), -2 , randf_range(-radius, radius))

#pass event from beet scene
func on_new_beet_conected(points:int) -> void:
	beet_collected.emit(points)

