class_name SceneInjector
extends Node

func on_scene_changed(node: Node, path: String) -> void:
	var scene_path: String = path.trim_prefix("res://")
	
	for mod: Mod in get_node("/root/ModLoader").mod_manager.get_children():
		if !mod.enabled: continue
		var mod_path: String = mod.get_script().resource_path.trim_suffix("mod.gd")
		if FileAccess.file_exists(mod_path + scene_path):
			var instance: Node = load(mod_path + scene_path).instantiate()
			node.add_child(instance)
		elif FileAccess.file_exists(mod_path + scene_path + ".remap"):
			var instance: Node = load(mod_path + scene_path).instantiate()
			node.add_child(instance)
		
	for inject_at in get_tree().get_nodes_in_group("InjectAt"):
		inject_at.reparent.call_deferred(node.get_node(inject_at.name.replace("\\","/")))
