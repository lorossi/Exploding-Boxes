class_name Tutorial

extends Control

signal exit

var _text_container: VBoxContainer
var _exit_button: Button


func _ready() -> void:
	_text_container = find_child("TextContainer")
	_exit_button = find_child("ExitButton")

	_exit_button.pressed.connect(_on_exit_pressed)
	_resize()


func _resize() -> void:
	for t in _text_container.get_children():
		t.custom_minimum_size.x = _text_container.size.x
		t.custom_minimum_size.y = 64


func _on_exit_pressed() -> void:
	exit.emit()
