class_name TimerInOut

extends Node2D

signal timeout

var _use_wait_timer: bool

var _wait_timer: Timer
var _fade_timer: Timer


func _init() -> void:
	_use_wait_timer = true


func _ready() -> void:
	_wait_timer = Timer.new()
	_fade_timer = Timer.new()

	_wait_timer.autostart = false
	_fade_timer.autostart = false

	_wait_timer.one_shot = true
	_fade_timer.one_shot = true

	_wait_timer.timeout.connect(_on_wait_timer_timeout)
	_fade_timer.timeout.connect(_on_fade_timer_timeout)

	add_child(_wait_timer)
	add_child(_fade_timer)


func get_use_wait_timer() -> bool:
	return _use_wait_timer


func set_use_wait_timer(use: bool) -> void:
	_use_wait_timer = use


func get_fade_time() -> float:
	return _fade_timer.get_fade_time()


func set_fade_time(time: float) -> void:
	_fade_timer.wait_time = time


func get_time_left() -> float:
	return _fade_timer.get_time_left()


func get_percent() -> float:
	return _fade_timer.get_time_left() / _fade_timer.get_wait_time()


func get_in_eased_time(n: float = 2) -> float:
	if is_stopped() or not _wait_timer.is_stopped():
		return 0

	var t = 1 - _fade_timer.get_time_left() / _fade_timer.get_wait_time()
	return Easings.ease_in_poly(t, n)


func get_out_eased_time(n: float = 2) -> float:
	if is_stopped() or not _wait_timer.is_stopped():
		return 1

	var t = _fade_timer.get_time_left() / _fade_timer.get_wait_time()
	return Easings.ease_out_poly(t, n)


func get_inout_eased_time(n: float = 2) -> float:
	if is_stopped() or not _wait_timer.is_stopped():
		return 0

	var t = 1 - _fade_timer.get_time_left() / _fade_timer.get_wait_time()

	if t < 0.5:
		return Easings.ease_in_poly(t * 2, n) / 2

	return Easings.ease_out_poly((t - 0.5) * 2, n) / 2 + 0.5


func start() -> void:
	if _use_wait_timer:
		_wait_timer.set_wait_time(abs(randfn(0.05, 0.1)))
		_wait_timer.start()
	else:
		_fade_timer.start()


func is_stopped() -> bool:
	return _wait_timer.is_stopped() and _fade_timer.is_stopped()


func _on_wait_timer_timeout():
	_fade_timer.start()


func _on_fade_timer_timeout():
	timeout.emit()
