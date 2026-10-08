package main

import "core:math"

Sphere :: struct {
	center: Point3,
	radius: f64,
}

hit_sphere :: proc(ray: Ray, ray_t: Interval, record: ^Hit_Record, sphere: Sphere) -> bool {

	oc: Vec3 = sphere.center - ray.origin
	a := length_squared(ray.direction)
	h := dot(ray.direction, oc)
	c := length_squared(oc) - sphere.radius * sphere.radius
	discriminant := h * h - a * c

	if discriminant < 0 {
		return false
	}
	sqrtofd := math.sqrt(discriminant)

	// Find the nearest root that lies in the acceptable range
	root := (h - sqrtofd) / a
	if !interval_surrounds(ray_t, root) {
		root = (h + sqrtofd) / a
		if !interval_surrounds(ray_t, root) {
			return false
		}
	}

	record.t = root
	record.p = ray_at(ray, record.t)
	outward_normal := (record.p - sphere.center) / sphere.radius
	set_face_normal(ray, outward_normal, record)

	return true

}
