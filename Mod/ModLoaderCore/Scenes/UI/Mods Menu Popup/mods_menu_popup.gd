extends Control

var start_game_on_close: bool = false

@onready var page: Control = % "Page"
@onready var config_menu: Control = % "Config Menu Popup"
@onready var ok_button: CustomButton = % "Ok Button"

signal closed


func _ready() -> void:
	create_mod_panels()

func create_mod_panels() -> void:
	var mods: Array[Mod] = get_node("/root/ModLoader").mod_manager.mods()
	
	var panel_scene: PackedScene = load("res://Mod/ModLoaderCore/Scenes/UI/Mod Panel/mod_panel.tscn")
	
	for i in range(len(mods)):
		var mod := mods[i]
		var panel := panel_scene.instantiate()
		panel.id = mod.id()
		if mod.id() == "mod_loader": panel.can_toggle = false
		page.add_child.call_deferred(panel)
		panel.config_menu = config_menu


func _on_ok_button_pressed() -> void:
	SceneManager.change_scene(get_tree().current_scene.scene_file_path)


func _on_visibility_changed() -> void:
	if visible:
		ok_button.grab_focus()
