class_name GUI

extends Control

signal reset
signal skip

var _score_label: Label
var _best_score_label: Label
var _version_label: Label
var _skip_button: Button
var _restart_button: Button

var _restart_confirmation: RestartConfirmation


func _ready() -> void:
	_score_label = find_child("ScoreLabel")
	_best_score_label = find_child("BestScoreLabel")
	_version_label = find_child("VersionLabel")
	_skip_button = find_child("SkipButton")
	_restart_button = find_child("RestartButton")
	_restart_confirmation = find_child("RestartConfirmation")

	_skip_button.pressed.connect(_on_skip_button_pressed)
	_restart_button.pressed.connect(_on_restart_button_pressed)

	_restart_confirmation.yes.connect(_on_restart_yes)
	_restart_confirmation.no.connect(_on_restart_no)

	var version = ProjectSettings.get_setting("application/config/version")
	_version_label.text = "v" + version


func get_score() -> int:
	return int(_score_label.text)


func set_score(score: int) -> void:
	_score_label.text = str(score)
	
func get_best_score() -> int:
	return int(_best_score_label.text)

func set_best_score(score: int) -> void:
	_best_score_label.text = str(score)


func _on_restart_button_pressed() -> void:
	_restart_confirmation.visible = true


func _on_restart_yes() -> void:
	_restart_confirmation.visible = false
	reset.emit()


func _on_restart_no() -> void:
	_restart_confirmation.visible = false


func _on_skip_button_pressed() -> void:
	skip.emit()
