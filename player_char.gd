extends CharacterBody2D


var speed = 300
var is_control = true

func get_input():
	var input_direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = input_direction * speed
	
func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)

func _process(delta):
	if Input.is_action_pressed("sprint") && is_control==true:
		is_control = false
		speed = 900
		$SprintTimer.start()
		$GPUParticles2D.emitting = true
		$"../SprintCD/SprintCDBar".show()
		$"../SprintCD/SprintCDBar".value = 3
		$"../SprintCD/SprintCDTimer".start()

func _on_sprint_timer_timeout():
	speed = 400
	$GPUParticles2D.emitting = false




func _on_sprint_cd_timer_timeout():
	is_control = true
	$"../SprintCD/SprintCDBar".hide()
	
