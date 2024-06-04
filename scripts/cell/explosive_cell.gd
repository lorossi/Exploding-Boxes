class_name ExplosiveCell

extends SpecialCell

var _exploding: bool = false


func post_inner_ready() -> void:
	set_special_color(Color(0.937, 0.278, 0.435))
	set_replace_ratio(0.9)
	inner.set_decrease_chance(0.25)


func die(explode: bool = false) -> void:
	_dead = true
	_exploding = explode
	inner.die(explode)


func is_exploding() -> bool:
	return _exploding
