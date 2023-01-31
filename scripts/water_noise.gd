extends Node3D

@onready var noise_tex = preload("res://materials/noise_tex.tres")

@export var speed = 5

func _process(delta):
	noise_tex.offset.x += delta * (speed/2.0)
	noise_tex.offset.z += delta * (speed/3.0)
