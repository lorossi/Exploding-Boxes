class_name TimerInOut

extends Node2D

signal timeout

var _start_in: bool
var _start_out: bool
var _use_wait_timer: bool

var _wait_timer: Timer
var _in_timer: Timer
var _out_timer: Timer


func _init() -> void:
	_start_in = false
	_start_out = false


func _ready() -> void:
	_wait_timer = $WaitTimer
	_in_timer = $InTimer
	_out_timer = $OutTimer

	_wait_timer.timeout.connect(_on_wait_timer_timeout)
	_in_timer.timeout.connect(_on_in_timer_timeout)
	_out_timer.timeout.connect(_on_out_timer_timeout)


func get_use_wait_timer() -> bool:
	return _use_wait_timer


func set_use_wait_timer(use: bool) -> void:
	_use_wait_timer = use


func get_wait_time() -> float:
	return _in_timer.get_wait_time()


func set_wait_time(time: float) -> void:
	_in_timer.set_wait_time(time)
	_out_timer.set_wait_time(time)


func get_in_eased_time(n: float = 2) -> float:
	var t = 1 - _in_timer.get_time_left() / _in_timer.get_wait_time()
	if is_equal_approx(n, 1):
		return t
	return Easings.ease_in_poly(t, n)


func get_out_time_left() -> float:
	return _out_timer.get_time_left()


func get_out_eased_time(n: float = 2) -> float:
	var t = _out_timer.get_time_left() / _out_timer.get_wait_time()
	if is_equal_approx(n, 1):
		return t
	return Easings.ease_out_poly(t, n)


func start_in_timer() -> void:
	_start_in = true

	if _use_wait_timer:
		_wait_timer.wait_time = abs(randfn(0.05, 0.1))
		_wait_timer.start()
	else:
		_in_timer.start()


func start_out_timer() -> void:
	_start_out = true

	if _use_wait_timer:
		_wait_timer.wait_time = abs(randfn(0.05, 0.1))
		_wait_timer.start()
	else:
		_out_timer.start()


func is_stopped() -> bool:
	return not (_start_in or _start_out) and _wait_timer.is_stopped()


func _on_wait_timer_timeout():
	if _start_in:
		_in_timer.start()
	elif _start_out:
		_out_timer.start()


func _on_in_timer_timeout():
	_start_in = false
	timeout.emit()


func _on_out_timer_timeout():
	_start_out = false
	timeout.emit()
