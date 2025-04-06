@tool
extends RigidBody3D
class_name CelestialBody

@export var gravitation:bool = true
@export var orbiting:CelestialBody

@export var radius: float = 1.0 : set = set_radius

var orbit_axis:Vector3 = Vector3.UP
var sphere_mesh: SphereMesh
var sphere_shape: SphereShape3D
var mesh_instance: MeshInstance3D
var collision_shape: CollisionShape3D

func _ready():
	# rigidbody properties
	gravity_scale = 0.
	linear_damp = 0.
	linear_damp_mode = RigidBody3D.DAMP_MODE_REPLACE
	angular_damp = 0.
	angular_damp_mode = RigidBody3D.DAMP_MODE_REPLACE
	
	# Create the MeshInstance3D
	mesh_instance = MeshInstance3D.new()
	add_child(mesh_instance)
	
	# Create the SphereMesh
	sphere_mesh = SphereMesh.new()
	sphere_mesh.radius = radius
	sphere_mesh.height = radius * 2
	mesh_instance.mesh = sphere_mesh
	
	# Create the CollisionShape3D
	collision_shape = CollisionShape3D.new()
	add_child(collision_shape)
	
	# Create the SphereShape3D
	sphere_shape = SphereShape3D.new()
	sphere_shape.radius = radius
	collision_shape.shape = sphere_shape
	
	if Engine.is_editor_hint():
		return
	GravitySystem.append_object(self)
	if orbiting:
		apply_central_impulse(GravitySystem.calculate_orbital_velocity(self,orbiting,orbit_axis))

func set_radius(new_radius):
	radius = new_radius
	
	# Update mesh
	if mesh_instance:
		var sphere_mesh = mesh_instance.mesh
		sphere_mesh.radius = radius
		sphere_mesh.height = radius * 2
	
	# Update collision shape
	if collision_shape:
		var sphere_shape = collision_shape.shape
		sphere_shape.radius = radius

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if not gravitation:
		return
	if orbiting:
		apply_central_force(GravitySystem.calculate_partial_gravity(self,orbiting))
	else:
		apply_central_force(GravitySystem.calculate_gravity(self))
