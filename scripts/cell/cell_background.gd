class_name CellBackground

extends Control

var _rect: Rect2

var _background_color: Color
var _border_color: Color
var _border_size: float


func _init() -> void:
	_background_color = Color(0.1, 0.1, 0.1, 1)
	_border_color = Color(0.2, 0.2, 0.2, 1)
	_border_size = 4


func _draw() -> void:
	draw_rect(_rect, _background_color)
	draw_rect(_rect, _border_color, false, _border_size)


func _update_rect() -> void:
	_rect = Rect2(-size / 2, size)


func get_rect_size() -> Vector2:
	return size


func set_rect_size(r: Vector2) -> void:
	size = r
	_update_rect()
	queue_redraw()


func get_background_color() -> Color:
	return _background_color


func set_background_color(c: Color) -> void:
	_background_color = c
	queue_redraw()


func get_border_color() -> Color:
	return _border_color


func set_border_color(c: Color) -> void:
	_border_color = c
	queue_redraw()


func set_border_size(s: float) -> void:
	_border_size = s
	_update_rect()
	queue_redraw()
