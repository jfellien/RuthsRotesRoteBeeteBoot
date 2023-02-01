extends AnimationPlayer

#@Janek, kannst mal gucken wie man die Ani hübscher startet, GDscript wirft mir hier ne Warning
func _ready():
	set_autoplay("boat/boat_rock")

func _process(_delta):
	speed_scale += randf_range(-0.05, 0.05)
	
	if speed_scale > 2:
		speed_scale = 2
	elif speed_scale < 0.5:
		speed_scale = 0.5
