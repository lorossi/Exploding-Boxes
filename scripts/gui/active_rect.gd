class_name ActiveRect

extends Node2D

var _rect: Rect2
var _border_color: Color
var _border_width: int


func _init() -> void:
	_rect = Rect2()
	_border_color = Color(1, 0.239, 0.2)
	_border_width = 4


func _draw() -> void:
	if not _rect:
		return

	draw_rect(_rect, _border_color, false, _border_width)


func reset() -> void:
	set_draw_rect(Rect2())


func get_draw_rect() -> Rect2:
	return _rect


func set_draw_rect(r: Rect2):
	_rect = r
	queue_redraw()


func get_border_width() -> int:
	return _border_width


func set_border_width(w: int):
	_border_width = w
	queue_redraw()


func get_border_color() -> Color:
	return _border_color


func set_border_color(c: Color):
	_border_color = c
	queue_redraw()
