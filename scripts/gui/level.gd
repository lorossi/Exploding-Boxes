class_name Level

extends Node2D

var _mouse_pressed: bool

var _cell_size: int
var _score: int

var _base_cell_probability: float = 0.75

var _drag_started: Vector2
var _drag_position: Vector2

var _max_cells: Vector2i

var _cells: Array
var _active_cells: Array

var _cells_container: Node2D
var _level_area: ColorRect

var _active_rect: ActiveRect
var _gui: GUI
var _game_over: GameOver
var _sound_player: SoundPlayer


func _init() -> void:
	_cell_size = 64


func _ready() -> void:
	_cells_container = $CellsContainer
	_active_rect = $ActiveRect
	_level_area = $LevelArea
	_gui = $Gui
	_game_over = $GameOver
	_sound_player = $SoundPlayer

	_gui.reset.connect(_restart_game)
	_gui.skip.connect(_skip_turn)

	_game_over.reset.connect(_restart_game)

	_active_rect.rect_changed.connect(_on_rect_size_changed)
	_active_rect.rect_reset.connect(_on_rect_size_reset)

	_max_cells = _level_area.size / _cell_size
	_restart_game()


func _restart_game() -> void:
	_game_over.visible = false

	for c in _cells_container.get_children():
		c.queue_free()

	_cells = []
	_active_cells = []
	for y in range(_max_cells.y):
		for x in range(_max_cells.x):
			var cell = CellFactory.create_random_cell(_base_cell_probability)
			var cell_position = Vector2(x, y) * _cell_size + _level_area.position
			_create_cell(cell, cell_position)

	_score = 0
	_gui.set_score(_score)
	_mouse_pressed = false


func _skip_turn() -> void:
	if _is_game_over():
		return

	if _is_any_cell_exploding():
		return

	while true:
		if _update_cells():
			return


func _create_cell(
	cell: Cell,
	pos: Vector2,
	index: int = -1,
	skip_first_update: bool = false,
) -> Cell:
	_cells_container.add_child(cell)

	cell.position = pos
	cell.dead.connect(_on_cell_dead)
	cell.set_size(Vector2.ONE * _cell_size)
	cell.set_number((randi() % 9) + 1)
	cell.set_skip_first_update(skip_first_update)

	if index == -1:
		_cells.append(cell)
	else:
		if _cells[index] != null:
			_cells[index].die()

		_cells[index] = cell

	return cell


func _replace_cell(old_cell: Cell, new_cell: Cell, min_life: int = 0) -> Cell:
	_cells_container.add_child(new_cell)
	new_cell.copy_cell(old_cell)
	new_cell.set_skip_first_update(true)

	if new_cell.get_number() < min_life:
		new_cell.set_number(min_life)

	var index = _cells.find(old_cell)
	_cells[index] = new_cell

	old_cell.die()

	return new_cell


func _on_cell_dead(cell: Cell) -> void:
	var explosion_played: bool = false

	if cell is ExplosiveCell and not cell.is_exploding():
		_explode_cell(cell)

		if not explosion_played:
			_sound_player.play_cell_explosion()
			explosion_played = true


func _on_rect_size_changed(new_rect: Rect2, old_rect: Rect2) -> void:
	var new_a = new_rect.get_area()
	var old_a = old_rect.get_area()

	if new_a == old_a or new_a == 0:
		return

	var area_ratio = new_a / _level_area.get_rect().get_area()
	var pitch = remap(area_ratio, 0, 1, 0.5, 2)
	if new_a > old_a:
		_sound_player.play_rect_up(pitch)
		return
	_sound_player.play_rect_down(pitch)


func _on_rect_size_reset() -> void:
	_sound_player.play_rect_reset()


func _explode_cell(cell: ExplosiveCell, radius: int = 1) -> void:
	var cell_position = _get_pos_from_cell(cell)

	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			var pos = cell_position + Vector2i(x, y)
			if x == 0 and y == 0:
				continue

			var c = _get_cell_from_pos(pos)
			if c == null:
				continue

			if c is ExplosiveCell:
				continue
			else:
				# reduce the number of the cell by a normal random number
				var delta = max(2, int(randfn(5, 2)))
				c.decrement_number(delta)
				c.update()


func _grow_cell(cell_position: Vector2i) -> void:
	for x in range(-1, 2):
		for y in range(-1, 2):
			var pos = Vector2i(x, y) + cell_position
			if pos.x < 0 or pos.x >= _max_cells.x or pos.y < 0 or pos.y >= _max_cells.y:
				continue

			var old_cell = _get_cell_from_pos(pos)
			if old_cell != null and not old_cell.is_dead():
				continue

			var new_cell = CellFactory.create_random_cell(_base_cell_probability)
			var index = _max_cells.y * pos.y + pos.x
			var new_cell_position = Vector2(pos.x, pos.y) * _cell_size + _level_area.position

			_create_cell(new_cell, new_cell_position, index, true)


func _get_cell_from_mouse(mouse_pos: Vector2) -> Cell:
	var pos = _get_pos_from_mouse(mouse_pos)
	return _get_cell_from_pos(pos)


func _get_pos_from_cell(cell: Cell) -> Vector2i:
	var index = _cells.find(cell)
	if index == -1:
		return Vector2i(-1, -1)

	var x = int(index % _max_cells.y)
	var y = int(index / float(_max_cells.y))

	return Vector2i(x, y)


func _get_cell_from_pos(pos: Vector2i) -> Cell:
	var index = pos.y * _max_cells.y + pos.x
	if index < 0 or index >= _cells.size():
		return null

	if _cells[index] == null:
		return null

	return _cells[index]


func _get_pos_from_mouse(mouse_pos: Vector2) -> Vector2i:
	return Vector2i((mouse_pos - _level_area.position) / _cell_size)


func _get_cells_bbox(cells: Array) -> Rect2:
	var min_x = INF
	var max_x = 0
	var min_y = INF
	var max_y = 0

	for c in cells:
		if not c:
			continue

		if c.position.x < min_x:
			min_x = c.position.x
		elif c.position.x > max_x:
			max_x = c.position.x

		if c.position.y < min_y:
			min_y = c.position.y
		elif c.position.y > max_y:
			max_y = c.position.y

	if min_x > max_x:
		max_x = min_x
	if min_y > max_y:
		max_y = min_y

	return Rect2(
		Vector2(min_x, min_y),
		Vector2(max_x - min_x + _cell_size, max_y - min_y + _cell_size),
	)


func _reset_active_cells() -> void:
	_active_cells = []


func _reset_active_rect(make_signal: bool = true) -> void:
	_active_rect.reset(make_signal)


func _delete_active_cells() -> void:
	var to_grow = []

	for c in _active_cells:
		if c is GrowthCell:
			to_grow.append(_get_pos_from_cell(c))
			c.queue_free()
		elif c is ExplosiveCell:
			c.queue_free()
		else:
			if c is SpecialCell and randf() < c.get_replace_ratio():
				_replace_special_cell()

			c.die(false)

	if to_grow.size() > 0:
		_sound_player.play_cell_grown()
		for pos in to_grow:
			_grow_cell(pos)


func _get_active_cells_sum() -> int:
	var total = 0
	for c in _active_cells:
		if c != null:
			total += c.get_number()
	return total


func _get_active_cells_score() -> int:
	var total = 0
	for c in _active_cells:
		if c != null:
			total += c.get_score()
	return total


func _update_active_cells() -> void:
	_active_cells = _cells_between(_drag_started, _drag_position)
	_active_rect.set_draw_rect(_get_cells_bbox(_active_cells))


func _replace_special_cell() -> void:
	var new_cell = CellFactory.create_random_special_cell()
	var shuffled_cells = _cells.duplicate()
	shuffled_cells.shuffle()

	for x in range(shuffled_cells.size()):
		if shuffled_cells[x] == null:
			continue

		if shuffled_cells[x] is SpecialCell:
			continue

		# cell is base
		_replace_cell(shuffled_cells[x], new_cell, 2)
		return


func _update_cells() -> bool:
	var changed = false
	for c in _cells_container.get_children():
		if c.update():
			changed = true

	if changed:
		_sound_player.play_cell_damaged()

	return changed


func _cells_between(start: Vector2, end: Vector2) -> Array:
	# Get the cells between two points
	var start_pos = _get_pos_from_mouse(start)
	var end_pos = _get_pos_from_mouse(end)

	# Calculate the angle between two points
	var direction = end_pos - start_pos
	if not direction:
		return [_get_cell_from_pos(start_pos)]

	# Swap the start and end positions if the direction is negative
	var xx = [end_pos.x, start_pos.x + 1] if direction.x < 0 else [start_pos.x, end_pos.x + 1]
	var yy = [end_pos.y, start_pos.y + 1] if direction.y < 0 else [start_pos.y, end_pos.y + 1]

	var cells = []

	for y in range(yy[0], yy[1]):
		for x in range(xx[0], xx[1]):
			var c = _get_cell_from_pos(Vector2i(x, y))
			if c == null:
				continue
			cells.append(c)

	return cells


func _is_game_over() -> bool:
	for c in _cells:
		if c != null:
			return false

	return true


func _get_board_sum() -> int:
	var total = 0
	for c in _cells:
		if c != null:
			total += c.get_number()

	return total


func _is_any_cell_exploding() -> bool:
	for c in _cells:
		if c == null or not c is ExplosiveCell:
			continue

		if c.is_exploding():
			return true

	return false


func _process(_delta):
	if _is_game_over():
		_game_over.visible = true
		_game_over.set_score(_score)
	elif _get_board_sum() < 10:
		for c in _cells:
			if c != null:
				c.die()


func _handle_mouse_button(event: InputEventMouseButton) -> void:
	# check that the event is a left click
	if event.button_index != 1:
		return

	# check that the mouse is inside the level area
	var mouse_inside = _level_area.get_rect().has_point(event.position)
	if not mouse_inside:
		_mouse_pressed = false
		_reset_active_cells()
		_reset_active_rect()
		return

	if _mouse_pressed:
		_mouse_pressed = false
		if _get_active_cells_sum() == 10:
			_score += _get_active_cells_score()
			_delete_active_cells()
			_reset_active_rect(false)
			_update_cells()
			_sound_player.play_cell_gathered()
			_gui.set_score(_score)
			if _score > _gui.get_best_score():
				_gui.set_best_score(_score)
		else:
			_reset_active_cells()
			_reset_active_rect(true)

	else:
		_drag_started = event.position
		_drag_position = event.position
		_mouse_pressed = true


func _handle_mouse_motion(event: InputEventMouseMotion) -> void:
	if (_drag_position - event.position).length() <= _cell_size / 4.0:
		return
	_update_active_cells()
	_drag_position = event.position


func _input(event) -> void:
	# check that the envent is mouse-related
	if not event is InputEventMouse:
		return

	# check if any cell is currently exploding
	if _is_any_cell_exploding():
		return

	if event is InputEventMouseButton:
		_handle_mouse_button(event)
	elif event is InputEventMouseMotion and _mouse_pressed:
		_handle_mouse_motion(event)
