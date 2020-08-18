extends Entity

const TYPE = "ENEMY"

var enemy_sprite 
var enemy_animator

func _ready():
	velocity = Vector2.ZERO
	speed.x = 20
	gravity = 2000
	enemy_sprite = $Slime_sprite
	enemy_animator = $Slime_animation
	speed = speed * -1
	velocity.x = speed.x
	
func _process(delta):
	enemy_animator.play("move")
	if is_on_wall():
		speed.x = speed.x * -1
	if speed.x < 0:
		enemy_sprite.set_flip_h(false)
	else:
		enemy_sprite.set_flip_h(true)
	velocity.x = speed.x 
	velocity.y = gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func enemy_death():
	var SlimeDeath = load("res://Scenes/Enemies/Slime_Death.tscn")
	var slimeDeath = SlimeDeath.instance()
	var world = get_tree().current_scene
	world.add_child(slimeDeath)
	slimeDeath.global_position = global_position

func _on_Hurtbox_area_entered(_area):
	enemy_death()
	queue_free()
