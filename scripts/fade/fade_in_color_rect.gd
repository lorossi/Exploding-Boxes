class_name FadeInColorRect

extends FadeOutColorRect


func start() -> void:
	get_color_rect().visible = true
	timer_in_out.start_in_timer()


func _process(_delta) -> void:
	if timer_in_out.is_stopped():
		return

	var e = timer_in_out.get_in_eased_time(2)
	modulate.a = e


func on_timer_timeout() -> void:
	get_color_rect().visible = false
	modulate.a = 1
	ended.emit()
