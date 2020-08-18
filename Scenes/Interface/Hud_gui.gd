extends MarginContainer


func _ready():
	pass 
	
func _process(_delta):
	#Hud take damage
	var healthBar = $stack/bars/lifebarContainer/healthBar
	if PlayerStats.health == 3:
		healthBar.texture = load("res://assets/Resources/Interface/life_bar_full.png")
	elif PlayerStats.health == 2:
		healthBar.texture = load("res://assets/Resources/Interface/life_bar_full2.png")
	elif PlayerStats.health == 1:
		healthBar.texture = load("res://assets/Resources/Interface/life_bar_full1.png")
	else:
		healthBar.texture = load("res://assets/Resources/Interface/life_bar_empty.png")
