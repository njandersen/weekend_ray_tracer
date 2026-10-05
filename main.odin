package main

import "core:fmt"

IMAGE_WIDTH :: 256
IMAGE_HEIGHT :: 256


main :: proc() {
	fmt.printf("P3\n%d %d\n255\n", IMAGE_WIDTH, IMAGE_HEIGHT)

	for j in 0 ..< IMAGE_HEIGHT {
		for i in 0 ..< IMAGE_WIDTH {
			r := f64(i) / f64(IMAGE_WIDTH - 1)
			g := f64(j) / f64(IMAGE_HEIGHT - 1)
			b := 0.0

			ir := int(255.999 * r)
			ig := int(255.999 * g)
			ib := int(255.999 * b)

			fmt.printf("%d %d %d\n", ir, ig, ib)
		}

	}
}
