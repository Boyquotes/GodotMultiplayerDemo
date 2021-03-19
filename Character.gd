extends KinematicBody

export var speed = 5

var direction = Vector3()
var gravity = -30
var max_speed = 8
var mouse_sensitivity = 0.002  # radians/pixel
var velocity = Vector3()

func _ready():
	if is_network_master():
		$Camera.make_current()

remote func _set_position(pos):
	global_transform.origin = pos

func _physics_process(delta):
	direction = Vector3()
	
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	direction = direction.normalized()
	
	if is_network_master():
		move_and_slide(direction * speed, Vector3.UP)
		rpc_unreliable("_set_position", global_transform.origin)
