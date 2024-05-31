class_name GUI

extends Control

signal reset
signal skip

var _score_value: Label


func _ready() -> void:
	_score_value = find_child("ScoreValue")


func get_score() -> int:
	return int(_score_value.text)


func set_score(score: int) -> void:
	_score_value.text = str(score)


func _on_restart_button_pressed() -> void:
	reset.emit()


func _on_skip_button_pressed() -> void:
	skip.emit()
