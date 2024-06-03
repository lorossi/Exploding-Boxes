class_name FadeOutRect

extends FadeInRect


func _ready() -> void:
	timer_in_out = $TimerInOut
	_parent = get_parent()
	if _parent:
		_parent.modulate.a = 1


func _process(_delta) -> void:
	if not _parent:
		return

	if timer_in_out.is_stopped():
		return

	var e = timer_in_out.get_out_eased_time(2)

	_parent.modulate.a = e


func start() -> void:
	timer_in_out.start_out_timer()


func on_timer_timeout() -> void:
	_parent.modulate.a = 0
	ended.emit()
