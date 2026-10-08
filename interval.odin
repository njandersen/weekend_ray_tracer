package main

import "core:math"

Interval :: struct {
	min: f64,
	max: f64,
}

// Note: a zero-value Interval{} is {0, 0}, not empty. Use INTERVAL_EMPTY explicitly.
INTERVAL_EMPTY :: Interval{math.INF_F64, -math.INF_F64}
INTERVAL_UNIVERSE :: Interval{-math.INF_F64, math.INF_F64}

interval_size :: proc(interval: Interval) -> f64 {
	return interval.max - interval.min
}

interval_contains :: proc(interval: Interval, x: f64) -> bool {
	return interval.min <= x && x <= interval.max
}

interval_surrounds :: proc(interval: Interval, x: f64) -> bool {
	return interval.min < x && x < interval.max
}
