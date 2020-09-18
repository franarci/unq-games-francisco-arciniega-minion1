extends CanvasLayer
signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	
	yield($MessageTimer, "timeout")

	$Message.text = "Esquiva los\nTriangulos!"
	$Message.show()
  
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MessageTimer_timeout():
	 $Message.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
