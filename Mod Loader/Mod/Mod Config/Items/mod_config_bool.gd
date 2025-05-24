class_name ModConfigBoolItem
extends ModConfigItem

@export var default_value: bool = true

static func scene() -> PackedScene:
	return load("res://Mod Loader/Mod/Mod Config/Items/mod_config_bool_node.tscn")
