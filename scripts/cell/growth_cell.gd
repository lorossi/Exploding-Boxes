class_name GrowthCell

extends SpecialCell


func post_inner_ready() -> void:
	set_special_color(Color(0.264, 0.472, 0.264))
	set_replace_ratio(0.5)
	inner.set_decrease_chance(0.25)
