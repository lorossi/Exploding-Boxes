class_name InnerCell

extends Area2D

signal dead

var _number: int
var _decrease_chance: float
var _color_palette: Array
var _size: Vector2

var _number_label: Label
var _collision_shape: CollisionShape2D
var _center_container: CenterContainer
var _death_particles: CPUParticles2D

var _background: CellBackground
var _damage_rect: FadeOutColorRect
var _fade_in_rect: FadeInRect
var _fade_out_rect: FadeOutRect


func _init() -> void:
	_decrease_chance = 0


func _ready() -> void:
	_collision_shape = $CollisionShape2D
	_background = $CellBackground
	_number_label = find_child("NumberLabel")
	_center_container = $CenterContainer

	_damage_rect = $DamageRect
	_fade_in_rect = $FadeInRect
	_fade_out_rect = $FadeOutRect
	_death_particles = $DeathParticles

	var c = Color.from_string("bb0a1e", Color.RED).lerp(_background.get_background_color(), 0.5)
	_damage_rect.set_rect_color(c)

	_fade_in_rect.set_fade_time(0.5)
	_fade_out_rect.set_fade_time(0.25)
	_damage_rect.set_fade_time(0.5)

	# colors: ff0000-ff8700-ffd300-deff0a-a1ff0a-0aff99-0aefff-147df5-580aff-be0aff
	# heh
	_color_palette = [
		Color(1, 0, 0),
		Color(1, 0.52, 0),
		Color(1, 0.82, 0),
		Color(0.87, 1, 0.03),
		Color(0.63, 1, 0.03),
		Color(0.03, 1, 0.60),
		Color(0.03, 0.93, 1),
		Color(0.07, 0.49, 0.96),
		Color(0.36, 0.03, 1),
		Color(0.74, 0.03, 1),
		Color(0.74, 0.03, 1),
		Color(1, 0.03, 0.60),
	]

	_resize()
	_fade_in_rect.start()


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


func get_background_color() -> CellBackground:
	return _background


func set_number(n: int) -> void:
	if n <= 0:
		die()
		return

	if n < _number:
		_damage_rect.start()

	_number = max(n, 0)
	_number_label.text = str(_number)

	_number_label.modulate = _color_palette[_number - 1]


func die(exploded: bool = false):
	if exploded:
		_damage_rect.start()
		_death_particles.color = _damage_rect.get_rect_color()
	else:
		_fade_out_rect.start()
		_death_particles.color = _color_palette[max(1, _number)]

	_death_particles.emitting = true


func decrement_number(delta: int = 1) -> void:
	set_number(_number - delta)


func update() -> bool:
	# returns true if something has changed
	if randf() < _decrease_chance:
		set_number(_number - 1)
		return true

	return false


func get_decrease_chance() -> float:
	return _decrease_chance


func set_decrease_chance(chance: float) -> void:
	_decrease_chance = clamp(chance, 0, 1)


func _on_death_particles_finished():
	dead.emit()
