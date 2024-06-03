class_name ExplosiveCell

extends SpecialCell

var _exploding: bool = false


func post_inner_ready() -> void:
	set_special_color(Color.from_string("ef476f", Color.WHITE))
	set_replace_ratio(0.9)
	inner.set_decrease_chance(0.25)


func explode():
	_exploding = true


func is_exploding() -> bool:
	return _exploding
