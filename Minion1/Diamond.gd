extends Area2D
signal collected


func _ready():
	pass


func _on_Diamond_collected():
	get_parent().sumar_punto()


func _on_Diamond_area_entered(area):
		
		hide()	
		queue_free()
		emit_signal("collected")


func _on_ScreenTime_timeout():
	queue_free()
	
