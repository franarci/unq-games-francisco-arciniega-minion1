extends Area2D
export (PackedScene) var Mob

func start():
	$SpawnTimer.start()
	$StartTimer.start()

func stop_spawn():
	$SpawnTimer.stop()

func spawn_mob():
	if get_tree().get_nodes_in_group("Mob").size() < 10:
		var mob = Mob.instance()
		add_child(mob)
		mob.global_position = global_position


func _on_SpawnTimer_timeout():
	spawn_mob()


func _on_StartTimer_timeout():
	spawn_mob()
