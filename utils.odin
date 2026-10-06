package main

import "core:fmt"
write_color :: proc(colors: Color) {
	r := colors.x
	g := colors.y
	b := colors.z

	rbyte := int(255.999 * r)
	gbyte := int(255.999 * g)
	bbyte := int(255.999 * b)

	fmt.printf("%d %d %d\n", rbyte, gbyte, bbyte)

}
