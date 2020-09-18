extends KinematicBody2D
export (float) var friction = 1.5
export (float) var speed = 1
var dir 
var target:Vector2
var velocity := Vector2.ZERO

onready var player = get_parent().get_parent().get_node("Player")
#onready var tween = get_node("Tween")
#var property = "transform/pos"


func _ready():
	set_physics_process(true)
	
func _physics_process(delta):
	look_at(player.global_position)
	target = player.global_position - global_position
	velocity += target.normalized() * speed * friction
	global_position +=  velocity * delta


func _on_Lifetime_timeout():
	queue_free()
