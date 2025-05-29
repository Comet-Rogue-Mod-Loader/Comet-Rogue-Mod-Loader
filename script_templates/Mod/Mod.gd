extends Mod

func id() -> String: return "mod_template"
func display_name() -> String: return "Mod Template"
func description() -> String: return "Mod Template"
func version() -> String: return "v0.0.0"
func icon() -> Texture2D: return load(get_script().resource_path.trim_suffix("mod.gd") + "icon.png")
func credit() -> String: return "Mod Template"

func default_config() -> ModConfig: 
	var config: ModConfig = load(get_script().resource_path.trim_suffix("mod.gd") + "config.tres")
	if config != null:
		config.mod = self
	return config

func dependencies() -> Array[String]: return []
func known_conflicts() -> Array[String]: return []

func scene_changed(node: Node, path: String) -> void:
	pass
