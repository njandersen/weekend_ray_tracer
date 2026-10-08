package main

Hit_Record :: struct {
	p:          Point3,
	normal:     Vec3,
	t:          f64,
	front_face: bool,
}

Hittable :: union {
	Sphere,
}

Hittable_List :: [dynamic]Hittable

set_face_normal :: proc(ray: Ray, outward_normal: Vec3, record: ^Hit_Record) {

	record.front_face = dot(ray.direction, outward_normal) < 0
	record.normal = record.front_face ? outward_normal : -outward_normal
}

hit_list :: proc(ray: Ray, ray_t: Interval, record: ^Hit_Record, list: Hittable_List) -> bool {
	temp_record: Hit_Record
	hit_anything := false
	closest_so_far := ray_t.max

	for object in list {
		switch shape in object {
		case Sphere:
			if hit_sphere(ray, Interval{ray_t.min, closest_so_far}, &temp_record, shape) {
				hit_anything = true
				closest_so_far = temp_record.t
				record^ = temp_record
			}
		}
	}

	return hit_anything
}
