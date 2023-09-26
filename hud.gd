extends CanvasLayer

signal start_countdown

# Called when the node enters the scene tree for the first time.
func _ready():
	$TimerMessage.hide()
	$RetryButton.hide()
	$GameOverMessage.hide()
	$WinMessage.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_button_pressed():
	$StartButton.hide()
	$Title.hide()
	start_countdown.emit()
	#Global.goto_scene("res://mode_select.tscn")

func _on_retry_button_pressed():
	$RetryButton.hide()
	$GameOverMessage.hide()
	start_countdown.emit()
	
func _on_win_timer_timeout():
	get_tree().reload_current_scene()
