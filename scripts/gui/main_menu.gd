class_name MainMenu
extends Control

var _cell_size: int

var _background: ColorRect

var _cells_container: Node2D
var _start_button: Button
var _tutorial_button: Button
var _center_container: CenterContainer

var _level_scene: PackedScene

var _tutorial: Tutorial


func _init() -> void:
	_level_scene = ResourceLoader.load("res://scenes/gui/level.tscn")
	_cell_size = 64


func _ready() -> void:
	_background = find_child("Background")
	_start_button = find_child("StartButton")
	_tutorial_button = find_child("TutorialButton")
	_center_container = find_child("CenterContainer")
	_cells_container = find_child("CellsContainer")
	
	_tutorial = find_child("Tutorial")

	_start_button.grab_focus()

	_connect()
	_create_cells_background()


func _connect() -> void:
	_start_button.pressed.connect(_on_start_pressed)
	_tutorial_button.pressed.connect(_on_tutorial_pressed)
	_tutorial.exit.connect(_on_tutorial_exit_pressed)


func _create_cells_background():
	# create cells all around the screen
	for x in range(0, get_viewport_rect().size.x, _cell_size):
		for y in range(0, get_viewport_rect().size.y, _cell_size):
			_create_cell(x, y, _cell_size)


func _create_cell(x: int, y: int, cell_size: int) -> void:
	var cell = CellFactory.create_random_cell()
	_cells_container.add_child(cell)
	cell.position = Vector2(x, y)
	cell.set_number((randi() % 9) + 1)
	cell.set_size(Vector2.ONE * cell_size)


func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(_level_scene)


func _on_tutorial_pressed() -> void:
	_center_container.visible = false
	_tutorial.visible = true


func _on_tutorial_exit_pressed() -> void:
	_center_container.visible = true
	_tutorial.visible = false


func _on_cells_update_timer_timeout():
	if _cells_container.get_child_count() == 0:
		_create_cells_background()
		return

	for c in _cells_container.get_children():
		c.update()
