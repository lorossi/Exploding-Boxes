class_name FadeInRect

extends Control

signal ended

var timer_in_out: TimerInOut

var _parent: Node2D


func _ready() -> void:
	timer_in_out = $TimerInOut

	_parent = get_parent()


func set_fade_time(duration: float) -> void:
	timer_in_out.set_fade_time(duration)


func get_fade_time() -> float:
	return timer_in_out.get_fade_time()


func start() -> void:
	_parent.modulate.a = 0
	timer_in_out.start()


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
