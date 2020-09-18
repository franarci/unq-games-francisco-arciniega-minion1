extends Node2D

class_name VectorDireccion


export(Vector2) var vector = Vector2.ZERO setget set_vector


func set_vector(v):
	vector = v
	update()


