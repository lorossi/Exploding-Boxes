class_name RecordManager

extends Node

var _record_path: String = "user://record_value.json"
var _record_value: int


func _init():
	_record_value = 0


func _save_record_file() -> int:
	var file = FileAccess.open(_record_path, FileAccess.WRITE)
	var data = {"record_value": _record_value}
	file.store_string(JSON.stringify(data))
	file.close()
	return _record_value


func _load_record_file() -> int:
	var file = FileAccess.open(_record_path, FileAccess.READ)
	var json = JSON.new()
	if json.parse(file.get_as_text()) == OK:
		_record_value = json.data.get("record_value")
	else:
		_record_value = _save_record_file()

	file.close()
	return _record_value


func get_record() -> int:
	if not FileAccess.file_exists(_record_path):
		_save_record_file()
		return _record_value

	return _load_record_file()


func set_record(value: int) -> void:
	_record_value = value
	_save_record_file()
