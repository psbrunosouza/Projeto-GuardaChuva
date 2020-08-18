extends StaticBody2D

func _ready():
	var candle = get_node("Candle_animation")
	candle.play("candle")

	
