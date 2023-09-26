extends Node2D

@onready var br = preload("res://brick.tscn")
@onready var player = preload("res://player.tscn")

var score = 0
signal start_game
signal win
# Called when the node enters the scene tree for the first time.
func _ready():
	$ball.hide()
	$score.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_bricks():
	var numbricks = 0
	var other_row = 0
	for i in range (5):
		for j in range(6):
			var brick = br.instantiate()
			brick.add_to_group("bricks-stage")
			brick.position = Vector2((other_row+100)+200*j,70+50*i)
			numbricks +=1
			add_child(brick)
			brick.score.connect(on_score)
		if other_row == 0:
			other_row = 50
		else:
			other_row = 0

func on_score():
	score += 100
	$score.text = "SCORE: "+str(score)
	if score == 3000:
		win.emit()



func _on_hud_start_countdown():
	var hitter = player.instantiate()
	hitter.add_to_group("player")
	add_child(hitter)
	hitter.sprint_cooldown.connect(on_sprint)
	$score.show()
	$ball.show()
	$ball.position = $StartPositionball.position
	$score.text = "SCORE: 0"
	set_bricks()
	$HUD/StartTimer.start()
	var countdown = 3
	$HUD/TimerMessage.show()
	$HUD/TimerMessage.text = str(countdown)
	for i in range (3):
		await $HUD/StartTimer.timeout
		countdown -= 1
		$HUD/TimerMessage.text = str(countdown)
	$HUD/TimerMessage.hide()
	$HUD/StartTimer.stop()
	start_game.emit()

func _on_ball_game_over():
	score=0
	for nodes in get_tree().get_nodes_in_group("player"):
		nodes.queue_free()
	$HUD/GameOverMessage.show()
	$HUD/RetryButton.show()
	$ball.hide()
	for nodes in get_tree().get_nodes_in_group("bricks-stage"):
		nodes.queue_free()
		
func _on_win():
	for nodes in get_tree().get_nodes_in_group("player"):
		nodes.queue_free()
	$HUD/WinMessage.show()
	$HUD/WinTimer.start()
	$ball.queue_free()

func on_sprint():
	$Cooldown/Sprint/SprintCDBar.value=3
	$Cooldown/Sprint/SprintCDBar.show()
	$Cooldown/Sprint/SprintCDTimer.start()
	

	
