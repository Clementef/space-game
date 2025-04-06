extends VBoxContainer

@onready var text1: RichTextLabel = $RichTextLabel
@onready var text2: RichTextLabel = $RichTextLabel2
@onready var text3: RichTextLabel = $RichTextLabel3
@export var body:RigidBody3D
var last_velocity:Vector3
var acceleration:Vector3

func vector_to_string(input_vector:Vector3) -> String:
		return str(input_vector.x) + ", " + str(input_vector.y) + ", " + str(input_vector.z)

func _process(delta: float) -> void:
	if last_velocity:
		acceleration = body.linear_velocity - last_velocity
	last_velocity = body.linear_velocity
	
	text1.text = vector_to_string(body.position)
	text2.text = vector_to_string(body.linear_velocity)
	text3.text = vector_to_string(acceleration)
