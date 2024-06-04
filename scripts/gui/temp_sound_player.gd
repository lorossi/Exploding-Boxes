class_name TempSoundPlayer

extends Node2D

var _area_mask: int
var _pitch_scale: float

var _player: AudioStreamPlayer2D
var _stream: AudioStreamMP3


func _init() -> void:
	_stream = null
	_area_mask = 1
	_pitch_scale = 1


func _ready() -> void:
	_player = $AudioStreamPlayer2D
	_player.finished.connect(_finished)


func set_sound(sound_name: String) -> void:
	_stream = SoundManagerInstance.get_sound(sound_name)


func set_area_mask(area_mask: int = 1) -> void:
	_area_mask = area_mask


func set_pitch_scale(pitch_scale: float = 1) -> void:
	_pitch_scale = pitch_scale


func play() -> void:
	if _stream == null:
		return

	_player.set_area_mask(_area_mask)
	_player.set_stream(_stream)
	_player.set_pitch_scale(_pitch_scale)
	_player.play()


func _finished() -> void:
	queue_free()
