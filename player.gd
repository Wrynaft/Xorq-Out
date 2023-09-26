extends Node2D

@export var speed = 400
var is_control = true

signal sprint_cooldown

func _ready():
	pass

	
func on_sprintcd_end():
	is_control = true
	$root/Cooldown/Sprint/SprintCDTimer.hide()
	
