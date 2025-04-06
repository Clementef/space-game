@tool
extends MeshInstance3D

@export var r: float = 1.0 : set = set_radius
var sphere_mesh: SphereMesh

func _ready():
	# Create a new SphereMesh
	sphere_mesh = SphereMesh.new()
	sphere_mesh.radius = r
	sphere_mesh.height = r * 2
	# Set the mesh to this MeshInstance3D
	mesh = sphere_mesh

func set_radius(new_radius):
	r = new_radius
	if sphere_mesh:
		sphere_mesh.radius = r
		sphere_mesh.height = r * 2
