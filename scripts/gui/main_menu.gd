class_name MainMenu
extends Control

var _start_button: Button
var _tutorial_button: Button
var _exit_button: Button

var _level_scene: PackedScene


func _init() -> void:
	_level_scene = ResourceLoader.load("res://scenes/gui/level.tscn")


func _ready() -> void:
	_start_button = find_child("StartButton")
	_tutorial_button = find_child("TutorialButton")
	_exit_button = find_child("ExitButton")

	_start_button.grab_focus()

	_start_button.pressed.connect(_start)
	_tutorial_button.pressed.connect(_tutorial)
	_exit_button.pressed.connect(_exit)


func _start() -> void:
	get_tree().change_scene_to_packed(_level_scene)


func _tutorial() -> void:
	print_debug("Add tutorial screen")


func _exit() -> void:
	get_tree().quit()
