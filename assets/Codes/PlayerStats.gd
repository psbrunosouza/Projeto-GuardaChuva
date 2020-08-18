extends Node

export(int) var max_health = 1
onready var health = max_health setget set_health

func _ready():
	pass

func set_health(value):
	health = value
	
func get_health():
	return health

func take_damage_health():
	health -= 1
