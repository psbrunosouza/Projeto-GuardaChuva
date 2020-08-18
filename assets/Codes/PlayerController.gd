extends Entity

class_name PlayerController

const TYPE = "PLAYER"

var knockback_dir = Vector2.ZERO

func _ready():
	sprite_hitbox = $Hitbox/Hitbox_collider
	Player_animation = $Player_animation
	Player_sprite = $Player_sprite
	place_holderDust = $Dust_placeholder
	anim_tree = $Player_animation_machine
	dust_particle = preload("res://Scenes/Objects/Dust.tscn")
	state_machine = anim_tree["parameters/playback"] 
	state = States.IDLE
	PlayerStats.set_health(3)
	
func _process(_delta):
	direction = get_direction()
	get_transitions()
	match state:
		States.IDLE:
			idle_()
		States.RUN_RIGHT:
			run_right_()
		States.RUN_LEFT:
			run_left_()
		States.JUMP:
			jump_()
		States.ATTACK:
			attack_()
	velocity.y += gravity * _delta
	velocity = move_and_slide(velocity, Vector2.UP)

func get_transitions():
	if direction.x == 0 and direction.y == 1:
		change_state(States.IDLE)
	if direction.x > 0:
		change_state(States.RUN_RIGHT)
	if direction.x < 0:
		change_state(States.RUN_LEFT)
	if direction.y < 0 and jump_count < 2:
		change_state(States.JUMP)
	if Input.is_action_just_pressed("action_c"):
		change_state(States.ATTACK)
	if is_on_floor():
		jump_count = 0

func change_state(new_state):
	self.state = new_state

func get_direction():
	var input_left = Input.get_action_strength("input_left")
	var input_right = Input.get_action_strength("input_right")
	var input_jump = Input.is_action_just_pressed("input_jump")
	var direction = Vector2(input_right - input_left,
	 -1.0 if input_jump else 1.0)
	return direction

func idle_():
	velocity.x = 0 #lerp(velocity.x, 0, friction)
	state_machine.travel("Idle")
	
func run_right_():	
	velocity.x = min(velocity.x + acceleration, speed.x)
	Player_sprite.set_flip_h(false)
	state_machine.travel("Run")
	
func run_left_():
	velocity.x = max(velocity.x - acceleration, -speed.x)
	Player_sprite.set_flip_h(true)
	state_machine.travel("Run")
	
func jump_():
	velocity.y = direction.y * speed.y
	var dust = dust_particle.instance()
	dust.global_position = place_holderDust.global_position
	$Dust_particles.add_child(dust)
	state_machine.travel("Jump")
	jump_count += 1
	
func attack_():
	velocity = Vector2.ZERO
	state_machine.travel("attack")


func _on_Healthbox_body_entered(_body):
	PlayerStats.take_damage_health()
	if PlayerStats.get_health() <= 0:
		queue_free()


func _on_Healthbox_body_exited(_body):
	pass
