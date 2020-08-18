extends KinematicBody2D

class_name Entity

var speed = Vector2(150.0, 400.0)
var velocity = Vector2.ZERO
var gravity = 2000.0
var acceleration = 35
var friction = 0.2
var direction
var state
var jump_count = 0
var stats = PlayerStats
var sprite_hitbox
var Player_animation
var Player_sprite
var place_holderDust
var anim_tree
var dust_particle
var state_machine

enum States {
	IDLE,
	RUN_RIGHT,
	RUN_LEFT,
	JUMP,
	ATTACK
}

func enemy_death():
	pass
	
func enemy_take_damage():
	pass

