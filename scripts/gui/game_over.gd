class_name GameOver

extends Control

signal reset


func _on_restart_button_pressed():
	reset.emit()
