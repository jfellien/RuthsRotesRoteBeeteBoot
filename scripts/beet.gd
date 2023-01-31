extends Node3D

@export var surface := 0.0
@export var innertia := 0.0
@export var innertia_step = 0.05
@export var rot_time = 3

@onready var sprite: Node = $Sprite3D
var rotting := false
var tween: Tween = null

func _physics_process(delta):
	if (not rotting) and innertia < 0 and position.y < surface:
		rot()
	translate(Vector3.UP * innertia * delta)
	if position.y < surface:
		innertia += innertia_step * 3
	else:
		innertia -= innertia_step
	
	
func rot():
	rotting = true
	tween = create_tween()
	tween.tween_interval(rot_time)
	tween.tween_property(sprite, "modulate", Color.BROWN, 2)
	tween.tween_interval(1)
	tween.tween_callback(self.queue_free)

func collect():
	if is_instance_valid(tween):
		tween.kill()
	queue_free()
