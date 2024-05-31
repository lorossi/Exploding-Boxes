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
	var l = float(get_number()) / 10.0 * 0.5
	var c = _special_color.lerp(inner.get_background().get_background_color(), l)
	set_background(c)
