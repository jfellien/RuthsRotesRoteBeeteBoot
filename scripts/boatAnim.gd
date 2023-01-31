extends AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	set_autoplay("boat/boat_rock")

func _process(delta):
	speed_scale += randf_range(-0.05, 0.05)
	
	if speed_scale > 2:
		speed_scale = 2
	elif speed_scale < 0.5:
		speed_scale = 0.5
