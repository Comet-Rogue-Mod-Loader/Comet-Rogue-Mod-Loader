extends Node

signal scene_changed(node: Node, path: String)

var mod_manager: ModManager
var scene_injector: SceneInjector

func _ready() -> void:
	mod_manager = ModManager.new()
	mod_manager.name = "ModManager"
	add_child(mod_manager)
	
	scene_injector = SceneInjector.new()
	scene_injector.name = "SceneInjector"
	scene_changed.connect(scene_injector.on_scene_changed)
	add_child(scene_injector)
	
	load_mods()
	
	get_tree().node_added.connect(_on_node_added)
	
	scene_changed.emit.call_deferred(get_tree().current_scene, get_tree().current_scene.scene_file_path)

func _on_node_added(node: Node) -> void:
	if node == get_tree().current_scene:
		scene_changed.emit(node, node.scene_file_path)


func load_mods() -> void:
	for file in DirAccess.get_files_at(ProjectSettings.globalize_path("res://Mods")):
		if !file.ends_with(".pck"): continue
		ProjectSettings.load_resource_pack("res://Mods/" + file)
	
	for dir in DirAccess.get_directories_at("res://Mod"):
		if !FileAccess.file_exists("res://Mod/%s/mod.gd" % dir) and !FileAccess.file_exists("res://Mod/%s/mod.gdc" % dir): 
			print("No mod.gd in %s" % dir)
			continue
		var mod: Mod = load("res://Mod/%s/mod.gd" % dir).new()
		mod.config = mod.default_config()
		mod.name = mod.id()
		mod_manager.add_child.call_deferred(mod)
