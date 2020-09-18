extends Node
export (PackedScene) var Hole
export (PackedScene) var Diamond

var score = 0
onready var screen_size = get_viewport().get_visible_rect().size

onready var player_pos: Vector2 = $StartPosition.global_position
const safe_range = 50

var holes = []

func _get_random_spawn_position() -> Vector2:
	var spawn_pos: = Vector2(
	rand_range(0, screen_size.x),
	rand_range(0, screen_size.y))

	if not_safe(spawn_pos): 
	  spawn_pos = _get_random_spawn_position() 
	return spawn_pos

func not_safe(spawn):
	return player_pos.distance_to(spawn) < safe_range

func sumar_punto():
	score+=1

func new_spawn():
	for i in range(6):
		var hole = Hole.instance()
		var diamond = Diamond.instance()
		add_child(diamond)
		add_child(hole)
		holes.append(hole)
		hole.global_position = _get_random_spawn_position() 
		diamond.global_position = _get_random_spawn_position() 

func _ready():
	pass
		


func game_over():
	$DiamondTimer.stop()
	$Hole.stop_spawn()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("holes", "queue_free")
	get_tree().call_group("diamonds", "queue_free")
	holes.clear()

func new_game():
	score = 0
	new_spawn()
	$HUD.update_score(score)
	$HUD.show_message("Recolecta\nlos diamantes")
	for hole in holes:
		hole.start()
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$DiamondTimer.start()


func _on_StartTimer_timeout():
	for hole in holes:
		hole.start()

func _physics_process(delta):
	$HUD/ScoreLabel.text = str(score)


func _on_DiamondTimer_timeout():
	var diamond = Diamond.instance()
	add_child(diamond)
	diamond.global_position = _get_random_spawn_position() 
