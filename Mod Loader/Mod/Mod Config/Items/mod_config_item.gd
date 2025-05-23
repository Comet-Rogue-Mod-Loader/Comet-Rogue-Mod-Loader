class_name ModConfigItem
extends Resource

signal value_changed(new_value: Variant)

@export var id: String
@export var display_name: String

var value: Variant

static func scene() -> PackedScene:
	return null

func get_value() -> Variant:
	return value

func set_value(new_value: Variant) -> void:
	if value == new_value: return
	value = new_value
	value_changed.emit(value)
