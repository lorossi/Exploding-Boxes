class_name FadeOutRect

extends FadeInRect


func _ready() -> void:
	fade_timer = $FadeTimer
	wait_timer = $WaitTimer

	_parent = get_parent()
	if _parent:
		_parent.modulate.a = 1


func _process(_delta) -> void:
	if not _parent:
		return

	if not fade_timer.is_stopped():
		var t = fade_timer.time_left / fade_timer.wait_time
		var e = Easings.ease_out_poly(t, 3)
		_parent.modulate.a = e


func on_fade_timer_timeout() -> void:
	_parent.modulate.a = 0
	ended.emit()
