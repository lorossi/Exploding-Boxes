class_name FadeInRect

extends Control

signal ended

var timer_in_out: TimerInOut

var _parent: Node2D


func _ready() -> void:
	timer_in_out = $TimerInOut

	_parent = get_parent()
	if _parent:
		_parent.modulate.a = 0


func get_timer_duration() -> float:
	return timer_in_out.get_in_time_left()


func set_timer_duration(time: float) -> void:
	timer_in_out.set_in_wait_time(time)


func start() -> void:
	timer_in_out.start_in_timer()


func _process(_delta) -> void:
	if not _parent:
		return

	if timer_in_out.is_stopped():
		return

	var e = timer_in_out.get_in_eased_time(2)
	_parent.modulate.a = e


func on_timer_timeout() -> void:
	_parent.modulate.a = 1
	ended.emit()
