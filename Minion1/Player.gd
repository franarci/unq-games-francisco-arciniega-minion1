extends Area2D
signal hit
signal dash

onready var dir = $VectorDireccion
export(float) var speed = 250
var dash_speed = speed * 3
var target:Vector2
var velocity := Vector2.ZERO

var distancia_limite = 10
var dashing = false


func _ready():
	pass

func start(pos):
	global_position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_Player_body_entered(body):
	hide() 
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func _process(delta):
	_update_position(get_local_mouse_position())


func _physics_process(delta):
	if velocity.length() <2:
		velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("ui_accept"):
		dashing = true
		$Dash.start()
	
	else:
		if dashing:
			velocity = target.normalized() * dash_speed
		else:
			velocity = target.normalized() * speed	
	
	position += velocity * delta


func _update_position(mouse_pos:Vector2):

	if(not dashing):
		target = mouse_pos
		dir.vector = mouse_pos
	if velocity.length() <2:
		velocity = Vector2.ZERO	

func _on_Dash_timeout():
	dashing = false
