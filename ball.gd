extends RigidBody2D

signal game_over

var direction =Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(direction * delta)
	if collision:
		direction = direction.bounce(collision.get_normal())
		move_and_collide(direction * delta)
		var collider = collision.get_collider()
		if collider.has_method("damage"):
			collider.damage()
			
func _on_node_2d_start_game():
	direction = Vector2(200,500)

func _on_visible_on_screen_notifier_2d_screen_exited():
	hide()
	direction = Vector2.ZERO
	game_over.emit()


