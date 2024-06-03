class_name FadeInRect

extends Control

signal ended

var fade_timer: Timer
var wait_timer: Timer
var _parent: Node2D


func _ready() -> void:
	fade_timer = $FadeTimer
	wait_timer = $WaitTimer

	_parent = get_parent()
	if _parent:
		_parent.modulate.a = 0


func get_timer_duration() -> float:
	return fade_timer.wait_time


func set_timer_duration(time: float) -> void:
	fade_timer.wait_time = time


func start() -> void:
	wait_timer.wait_time = abs(randfn(0.05, 0.05))
	wait_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	if not _parent:
		return

	if not fade_timer.is_stopped():
		var t = 1 - fade_timer.time_left / fade_timer.wait_time
		var e = Easings.ease_in_poly(t, 3)
		_parent.modulate.a = e


func on_fade_timer_timeout() -> void:
	_parent.modulate.a = 1
	ended.emit()


func on_wait_timer_timeout():
	fade_timer.start()
