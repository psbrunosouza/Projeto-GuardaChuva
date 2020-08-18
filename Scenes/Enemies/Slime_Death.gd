extends Node2D

onready var slimeDeath = $Slime_death_animation

func _ready():
	slimeDeath.frame = 0
	slimeDeath.play("animate")

func _on_Slime_death_animation_animation_finished():
	queue_free() 
