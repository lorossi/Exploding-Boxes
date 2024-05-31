class_name ExplosiveCell

extends SpecialCell


func post_inner_ready() -> void:
	set_special_color(Color(0.91, 0.46, 0.46))
	set_replace_ratio(0.9)
	inner.set_decrease_chance(0.25)
