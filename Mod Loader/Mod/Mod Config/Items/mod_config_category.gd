class_name ModConfigCategoryItem
extends ModConfigItem

@export var default_value: Array[ModConfigItem]

static func scene() -> PackedScene:
	return load("res://Mod Loader/Mod/Mod Config/Items/mod_config_category_node.tscn")
