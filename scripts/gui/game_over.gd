class_name GameOver

extends Control

signal reset

var _restart_button: Button
var _score_label: Label


func _ready() -> void:
	_restart_button = find_child("RestartButton")
	_score_label = find_child("ScoreLabel")

	_restart_button.grab_focus()
	_restart_button.pressed.connect(_on_restart_button_pressed)


func set_score(score: int) -> void:
	_score_label.text = str(score)


func _on_restart_button_pressed():
	reset.emit()
