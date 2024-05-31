class_name InnerCell

extends Area2D

signal dead

var _background: CellBackground

var _number: int
var _decrease_chance: float
var _color_palette: Array
var _size: Vector2

var _number_label: Label
var _collision_shape: CollisionShape2D
var _center_container: CenterContainer

var _damage_rect: FadeOutRect
var _fade_in_rect: FadeInRect


func _init() -> void:
	_decrease_chance = 0


func _ready() -> void:
	_collision_shape = $CollisionShape2D
	_background = $CellBackground
	_number_label = find_child("NumberLabel")
	_center_container = $CenterContainer

	_damage_rect = $DamageRect
	_fade_in_rect = $FadeInRect

	# colors: ff595e-ff924c-ffca3a-c5ca30-8ac926-52a675-1982c4-4267ac-565aa0-6a4c93
	_color_palette = [
		Color.from_string("#ff595e", "white"),
		Color.from_string("#ff924c", "white"),
		Color.from_string("#ffca3a", "white"),
		Color.from_string("#c5ca30", "white"),
		Color.from_string("#8ac926", "white"),
		Color.from_string("#52a675", "white"),
		Color.from_string("#1982c4", "white"),
		Color.from_string("#4267ac", "white"),
		Color.from_string("#565aa0", "white"),
		Color.from_string("#6a4c93", "white"),
	]

	_resize()
	_fade_in_rect.start()


#func _process(_delta) -> void:
#if not _damage_timer.is_stopped():
#var t = _damage_timer.time_left / _damage_timer.wait_time
#var e = Easings.ease_out_poly(t)
#_damage_rect.color.a = e * 0.25


func _on_damage_timer_timeout():
	_damage_rect.color.a = 0


func _resize() -> void:
	_center_container.size = _size

	_collision_shape.shape.size = _size
	_collision_shape.position = _size / 2

	_number_label.scale = _size / (Vector2.ONE * 64)

	_damage_rect.set_rect_size(_size)

	_background.position = _size / 2
	_background.set_rect_size(_size)


func get_size() -> Vector2:
	return _size


func set_size(size: Vector2) -> void:
	_size = size
	_resize()


func get_number() -> int:
	return _number


func get_background() -> CellBackground:
	return _background


func set_number(n: int) -> void:
	if n <= 0:
		dead.emit()
	#
	if n < _number:
		_damage_rect.start()

	_number = max(n, 0)
	_number_label.text = str(_number)

	_number_label.modulate = _color_palette[_number - 1]


func decrement_number(delta: int = 1) -> void:
	set_number(_number - delta)


func update() -> void:
	if randf() < _decrease_chance:
		set_number(_number - 1)


func get_decrease_chance() -> float:
	return _decrease_chance


func set_decrease_chance(chance: float) -> void:
	_decrease_chance = clamp(chance, 0, 1)
