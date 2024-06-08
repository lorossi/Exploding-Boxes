class_name SpecialCell

extends Cell

var _replace_ratio: float
var _special_color: Color


func _init() -> void:
	_replace_ratio = 0.5


func get_replace_ratio() -> float:
	return _replace_ratio


func set_replace_ratio(ratio: float) -> void:
	_replace_ratio = ratio


func set_special_color(color: Color) -> void:
	_special_color = color
	_update_color()


func get_special_color() -> Color:
	return _special_color


func set_number(n: int) -> void:
	super.set_number(n)
	_update_color()


func post_inner_update() -> void:
	_update_color()


func _update_color() -> void:
	var bg = _special_color.lerp(_inner.get_background().get_background_color(), 0.9)
	set_background_color(bg)
	set_border_color(_special_color)
