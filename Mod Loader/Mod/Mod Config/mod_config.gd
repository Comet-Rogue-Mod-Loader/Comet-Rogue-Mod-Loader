class_name ModConfig
extends Resource

@export var items: Array[ModConfigItem]
var mod: Mod

func get_item(id: String) -> ModConfigItem:
	for item in items:
		if item.id != id: continue
		return item
	return null

func get_value(id: String) -> Variant:
	for item in items:
		if item.id != id: continue
		return item.get_value()
	return null

func set_value(id: String, new_value: Variant) -> void:
	for item in items:
		if item.id != id: continue
		item.set_value(new_value)
		return
