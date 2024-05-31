class_name FadeInRect
extends Control

var timer: Timer
var _parent: Node2D


func _ready() -> void:
	timer = $Timer
	_parent = get_parent()
	if _parent:
		_parent.modulate.a = 0


func get_timer_duration() -> float:
	return timer.wait_time


func set_timer_duration(time: float) -> void:
	timer.wait_time = time


func start() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	if not _parent:
		return

	if not timer.is_stopped():
		var t = 1 - timer.time_left / timer.wait_time
		var e = Easings.ease_in_poly(t, 3)
		_parent.modulate.a = e


func on_timer_timeout() -> void:
	_parent.modulate.a = 1
