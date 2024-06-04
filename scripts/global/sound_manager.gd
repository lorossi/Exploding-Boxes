class_name SoundManager

extends Node

var _sounds: Dictionary


func _init() -> void:
	_sounds = {
		"cell_damaged": ResourceLoader.load("res://assets/music/cell/cell-damage.mp3"),
		"cell_explosion": ResourceLoader.load("res://assets/music/cell/cell-explosion.mp3"),
		"cell_gathered": ResourceLoader.load("res://assets/music/cell/cell-gathered.mp3"),
		"cell_grown": ResourceLoader.load("res://assets/music/cell/cell-grown.mp3"),
		"rect_down": ResourceLoader.load("res://assets/music/active_rect/active-rect-down.mp3"),
		"rect_reset": ResourceLoader.load("res://assets/music/active_rect/active-rect-reset.mp3"),
		"rect_up": ResourceLoader.load("res://assets/music/active_rect/active-rect-up.mp3"),
	}


func get_sound(sound_name: String) -> AudioStreamMP3:
	if not has_sound(sound_name):
		print_debug("Sound ", sound_name, " not in SoundManager")
		return null

	return _sounds[sound_name]


func has_sound(sound_name: String) -> bool:
	return sound_name in _sounds
