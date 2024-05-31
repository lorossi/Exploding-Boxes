class_name ExtraPointsCell

extends SpecialCell


func post_inner_ready() -> void:
	set_special_color(Color(0.264, 0.264, 0.472))
	set_replace_ratio(0.75)
	inner.set_decrease_chance(0.5)


func get_score() -> int:
	return 2
