@tool
extends RigidBody3D

@export var radius: float = 1.0 : set = set_radius

@onready var mesh_instance = $MeshInstance3D
@onready var collision_shape = $CollisionShape3D

func _ready():
	# Set initial radius
	set_radius(radius)

func set_radius(new_radius):
	radius = new_radius
	
	# Update mesh
	if mesh_instance and mesh_instance.mesh is SphereMesh:
		var sphere_mesh = mesh_instance.mesh
		sphere_mesh.radius = radius
		sphere_mesh.height = radius * 2
	
	# Update collision shape
	if collision_shape and collision_shape.shape is SphereShape3D:
		var sphere_shape = collision_shape.shape
		sphere_shape.radius = radius
