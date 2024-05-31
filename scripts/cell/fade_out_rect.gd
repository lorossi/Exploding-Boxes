class_name FadeOutRect

extends FadeInRect

var _rect: ColorRect


func _ready() -> void:
	fade_timer = $FadeTimer
	wait_timer = $WaitTimer
	
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


func start() -> void:
	_rect.visible = true
	super.start()


func _process(_delta) -> void:
	if not fade_timer.is_stopped():
		var t = fade_timer.time_left / fade_timer.wait_time
		var e = Easings.ease_out_poly(t, 3)
		modulate.a = e * 0.5


func on_fade_timer_timeout() -> void:
	_rect.visible = false
	modulate.a = 0
