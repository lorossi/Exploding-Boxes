class_name GrowthCell

extends SpecialCell


func post_inner_ready() -> void:
	set_special_color(Color.from_string("06d6a0", Color.WHITE))
	set_replace_ratio(0.5)
	inner.set_decrease_chance(0.25)
