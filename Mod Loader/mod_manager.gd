class_name ModManager
extends Node

func has_mod(id: String) -> bool:
	return get_mod(id) != null

func get_mod(id: String) -> Mod:
	for child in get_children():
		if child.id() == id: return child
	return null

func mods() -> Array[Mod]:
	var return_array: Array[Mod] = []
	for child in get_children():
		if child is Mod: return_array.append(child)
	return return_array
