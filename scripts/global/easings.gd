class_name Easings
extends Node


static func ease_in_poly(x: float, n: float = 2) -> float:
	return pow(x, n)


static func ease_out_poly(x: float, n: float = 2) -> float:
	return 1 - pow(1 - x, n)


static func ease_in_out_poly(x: float, n: float = 2) -> float:
	if x < 0.5:
		return 0.5 * pow(2 * x, n)

	return 1 - 0.5 * pow(2 * (1 - x), n)
