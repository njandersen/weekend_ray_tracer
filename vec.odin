package main

import "core:math"

Vec3 :: [3]f64
Point3 :: Vec3
Color :: Vec3


dot :: proc(a, b: Vec3) -> f64 {
	return a.x * b.x + a.y * b.y + a.z * b.z
}

cross :: proc(a, b: Vec3) -> Vec3 {
	return {a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x}
}

length_squared :: proc(v: Vec3) -> f64 {
	return dot(v, v)
}

length :: proc(v: Vec3) -> f64 {
	return math.sqrt(length_squared(v))
}

unit_vector :: proc(v: Vec3) -> Vec3 {
	return v / length(v)
}
