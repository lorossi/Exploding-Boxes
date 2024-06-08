class_name Cell

extends Node2D

signal dead(Cell)

var _dead: bool
var _skip_first_update: bool
var _inner: InnerCell


func _init() -> void:
	_dead = false
	_skip_first_update = false


func update() -> bool:
	# returns true if the cell has changed
	if _skip_first_update:
		_skip_first_update = false
		return false

	var changed = _inner.update()
	post_inner_update()

	return changed


func is_dead() -> bool:
	return _dead


func die(explode: bool = false) -> void:
	_dead = true
	_inner.die(explode)


func _inner_dead() -> void:
	dead.emit(self)
	queue_free()


func post_inner_ready() -> void:
	return


func post_inner_update() -> void:
	return


func _on_inner_cell_ready() -> void:
	_inner = $InnerCell
	_inner.dead.connect(_inner_dead)
	_inner.set_decrease_chance(0.1)
	post_inner_ready()


func set_number(n: int) -> void:
	if _inner != null:
		_inner.set_number(n)


func decrement_number(delta: int = 1) -> void:
	if _inner != null:
		_inner.decrement_number(delta)


func get_number() -> int:
	return _inner.get_number()


func get_size() -> Vector2:
	return _inner.get_size()


func set_size(size: Vector2) -> void:
	_inner.set_size(size)


func get_background_color() -> Color:
	return _inner.get_background().get_background_color()


func set_background_color(color: Color) -> void:
	_inner.get_background().set_background_color(color)


func get_border_color() -> Color:
	return _inner.get_background().get_border_color()


func set_border_color(color: Color) -> void:
	_inner.get_background().set_border_color(color)


func get_score() -> int:
	return 1


func get_skip_first_update() -> bool:
	return _skip_first_update


func get_decrease_chance() -> float:
	return _inner.get_decrease_chance()


func set_decrease_chance(chance: float) -> void:
	_inner.set_decrease_chance(chance)


func set_skip_first_update(skip: bool) -> void:
	_skip_first_update = skip


func copy_cell(other: Cell) -> void:
	set_number(other.get_number())
	set_size(other.get_size())
	set_background_color(other.get_background_color())
	set_border_color(other.get_border_color())
	set_position(other.get_position())
