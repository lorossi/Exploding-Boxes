class_name ExtraPointsCell

extends SpecialCell


func post_inner_ready() -> void:
	set_special_color(Color(0.067, 0.541, 0.698))
	set_replace_ratio(0.9)
	set_decrease_chance(0.5)


func get_score() -> int:
	return 5
