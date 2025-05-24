class_name Mod
extends Node

var enabled: bool = true
var config: ModConfig

func id() -> String: return ""
func display_name() -> String: return ""
func description() -> String: return ""
func version() -> String: return ""
func icon() -> Texture2D: return load(get_script().resource_path.trim_suffix("mod.gd") + "icon.png")
func credit() -> String: return ""

func default_config() -> ModConfig: 
	var config: ModConfig = load(get_script().resource_path.trim_suffix("mod.gd") + "config.tres")
	config.mod = self
	return config

func dependencies() -> Array[String]: return []
func known_conflicts() -> Array[String]: return []

func scene_changed(node: Node, path: String) -> void:
	pass
