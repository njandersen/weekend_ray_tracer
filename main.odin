package main

import "core:fmt"

ASPECT_RATIO :: 16.0 / 9.0
IMAGE_WIDTH :: 400


Ray :: struct {
	origin:    Point3,
	direction: Vec3,
}

main :: proc() {
	IMAGE_HEIGHT := int(IMAGE_WIDTH / ASPECT_RATIO)
	IMAGE_HEIGHT = (IMAGE_HEIGHT < 1) ? 1 : IMAGE_HEIGHT

	// Camera
	focal_length := 1.0
	viewport_height := 2.0
	viewport_width := viewport_height * (f64(IMAGE_WIDTH) / f64(IMAGE_HEIGHT))
	camera_center := Point3{0, 0, 0}

	// Calculate the vectors across the horizontal and down the vertical viewport edges
	viewport_u := Vec3{viewport_width, 0, 0}
	viewport_v := Vec3{0, -viewport_height, 0}

	// Calculate the horizontal and vertical delta vectors from pixel to pixel
	pixel_delta_u := viewport_u / IMAGE_WIDTH
	pixel_delta_v := viewport_v / f64(IMAGE_HEIGHT)

	// Calculate the location of the upper left pixel
	viewport_upper_left :=
		camera_center - Vec3{0, 0, focal_length} - viewport_u / 2 - viewport_v / 2
	pixel00_loc := viewport_upper_left + 0.5 * (pixel_delta_u + pixel_delta_v)

	fmt.printf("P3\n%d %d\n255\n", IMAGE_WIDTH, IMAGE_HEIGHT)

	for j in 0 ..< IMAGE_HEIGHT {
		fmt.eprintf("\r\x1b[2KScanlines remaining: %d", (IMAGE_HEIGHT - j))
		for i in 0 ..< IMAGE_WIDTH {
			pixel_center := pixel00_loc + (f64(i) * pixel_delta_u) + (f64(j) * pixel_delta_v)
			ray_dir := pixel_center - camera_center
			ray := Ray{camera_center, ray_dir}
			pixel_color := ray_color(ray)
			write_color(pixel_color)
		}

	}
	fmt.eprintf("\r\x1b[2KDone. \n")
}


ray_at :: proc(ray: Ray, t: f64) -> Point3 {
	return ray.origin + (t * ray.direction)
}

ray_color :: proc(ray: Ray) -> Color {
	unit_direction := unit_vector(ray.direction)
	a := 0.5 * (unit_direction.y + 1.0)
	return (1.0 - a) * Color{1.0, 1.0, 1.0} + a * Color{0.5, 0.7, 1.0}
}
