class_name Cell

extends Node2D

signal dead(Cell)

var inner: InnerCell


func update() -> void:
	inner.update()
	post_inner_update()


func die() -> void:
	dead.emit(self)
	queue_free()


func post_inner_ready() -> void:
	return


func post_inner_update() -> void:
	return


func _on_inner_cell_ready() -> void:
	inner = $InnerCell
	inner.dead.connect(die)
	inner.set_decrease_chance(0.1)
	post_inner_ready()


func set_number(n: int) -> void:
	if inner != null:
		inner.set_number(n)


func decrement_number(delta: int = 1) -> void:
	if inner != null:
		inner.decrement_number(delta)


func get_number() -> int:
	return inner.get_number()


func get_size() -> Vector2:
	return inner.get_size()


func set_size(size: Vector2) -> void:
	inner.set_size(size)


func get_background() -> Color:
	return inner.get_background().get_background_color()


func set_background(color: Color) -> void:
	inner.get_background().set_background_color(color)


func get_score() -> int:
	return 1


func copy_cell(other: Cell) -> void:
	set_number(other.get_number())
	set_size(other.get_size())
	set_background(other.get_background())
	position = other.position
