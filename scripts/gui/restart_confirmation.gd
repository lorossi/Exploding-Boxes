class_name RestartConfirmation

extends Control

signal yes
signal no

var _yes_button: Button
var _no_button: Button


func _ready() -> void:
	_yes_button = find_child("YesButton")
	_no_button = find_child("NoButton")

	_yes_button.pressed.connect(_on_yes_button_pressed)
	_no_button.pressed.connect(_on_no_button_pressed)

	_no_button.grab_focus()


func _on_yes_button_pressed() -> void:
	yes.emit()


func _on_no_button_pressed() -> void:
	no.emit()
