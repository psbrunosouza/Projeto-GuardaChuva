extends Particles2D

func _ready():
	emitting = true
	$Dust_timer.start(2)

func _on_Timer_timeout():
	queue_free()

