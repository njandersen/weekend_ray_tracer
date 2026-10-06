package main

import "core:fmt"

IMAGE_WIDTH :: 256
IMAGE_HEIGHT :: 256


main :: proc() {
	fmt.printf("P3\n%d %d\n255\n", IMAGE_WIDTH, IMAGE_HEIGHT)

	for j in 0 ..< IMAGE_HEIGHT {
		fmt.eprintf("\r\x1b[2KScanlines remaining: %d", (IMAGE_HEIGHT - j))
		for i in 0 ..< IMAGE_WIDTH {
			pixel_color := Color{f64(i) / f64(IMAGE_WIDTH - 1), f64(j) / f64(IMAGE_HEIGHT - 1), 0}
			write_color(pixel_color)
		}

	}
	fmt.eprintf("\r\x1b[2KDone. \n")
}
