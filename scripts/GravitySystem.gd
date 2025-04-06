extends Node

@export var G = 1. / 100.
@export var objects:Array[CelestialBody]

func append_object(object:CelestialBody):
	objects.append(object)

func calculate_orbital_velocity(object1:CelestialBody, object2:CelestialBody, orbit_axis:Vector3):
	var r := object1.global_position - object2.global_position
	var orbit_direction := r.normalized().cross(orbit_axis.normalized())
	var orbit_speed := sqrt(G*object2.mass*r.length())
	return orbit_direction * orbit_speed

func calculate_partial_gravity(object1:CelestialBody, object2:CelestialBody):
	var gravity_direction := (object2.global_position-object1.global_position)
	var gravity_magnitude:float = G * object1.mass * object2.mass / gravity_direction.length()
	return gravity_direction * gravity_magnitude

func calculate_gravity(object:CelestialBody):
	var net_gravity_force := Vector3.ZERO
	for other_object in objects:
		# skip self
		if object == other_object:
			continue
		net_gravity_force += calculate_partial_gravity(object, other_object)
	return net_gravity_force
