class_name GUI

extends Control

signal reset
signal skip

var _score_label: Label
var _version_label: Label


func _ready() -> void:
	_score_label = find_child("ScoreLabel")
	_version_label = find_child("VersionLabel")

	var version = ProjectSettings.get_setting("application/config/version")
	_version_label.text = "v" + version


func get_score() -> int:
	return int(_score_label.text)


func set_score(score: int) -> void:
	_score_label.text = str(score)


func _on_restart_button_pressed() -> void:
	reset.emit()


func _on_skip_button_pressed() -> void:
	skip.emit()
