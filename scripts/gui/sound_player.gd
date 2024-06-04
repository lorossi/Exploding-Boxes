class_name SoundPlayer

extends Node2D

var _temp_player_scene: PackedScene


func _init() -> void:
	_temp_player_scene = ResourceLoader.load("res://scenes/gui/temp_sound_player.tscn")


func _create_player(area_mask: int = 0b1) -> TempSoundPlayer:
	var player = _temp_player_scene.instantiate()
	player.set_area_mask(area_mask)
	add_child(player)
	return player


func play_rect_down(pitch_scale: float = 1) -> void:
	var player = _create_player(0b1)
	player.set_sound("rect_down")
	player.set_pitch_scale(pitch_scale)
	player.play()


func play_rect_up(pitch_scale: float = 1) -> void:
	var player = _create_player(0b1)
	player.set_sound("rect_up")
	player.set_pitch_scale(pitch_scale)
	player.play()


func play_rect_reset() -> void:
	var player = _create_player(0b1)
	player.set_sound("rect_reset")
	player.play()


func play_cell_gathered() -> void:
	var player = _create_player(0b10)
	player.set_sound("cell_gathered")
	player.play()


func play_cell_explosion() -> void:
	var player = _create_player(0b100)
	player.set_sound("cell_explosion")
	player.play()


func play_cell_damaged() -> void:
	var player = _create_player(0b1000)
	player.set_sound("cell_damaged")
	player.play()


func play_cell_grown() -> void:
	var player = _create_player(0b10000)
	player.set_sound("cell_grown")
	player.play()
