class_name FadeOutColorRect

extends FadeOutRect

var _rect: ColorRect


func _ready() -> void:
	timer_in_out = $TimerInOut

	_rect = $ColorRect
	_rect.visible = false
	modulate.a = 0


func set_rect_size(rect_size: Vector2) -> void:
	_rect.size = rect_size


func get_rect_size() -> Vector2:
	return _rect.size


func get_rect_color() -> Color:
	return _rect.color


func set_rect_color(color: Color) -> void:
	_rect.color = color


func get_color_rect() -> ColorRect:
	return _rect


func start() -> void:
	_rect.visible = true
	timer_in_out.start_out_timer()


func _process(_delta) -> void:
	if timer_in_out.is_stopped():
		return

	var e = timer_in_out.get_out_eased_time(2)
	modulate.a = e


func on_timer_timeout() -> void:
	_rect.visible = false
	modulate.a = 0
	ended.emit()
