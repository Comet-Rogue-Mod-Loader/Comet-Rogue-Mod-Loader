extends Control

@export var pages: Array[Control]

var page: int = 0
var start_game_on_close: bool = false

@onready var page_template: Control = % "Page Template"
@onready var ok_button: CustomButton = % "Ok Button"
@onready var previous_button: CustomButton = % "Previous Button"
@onready var next_button: CustomButton = % "Next Button"

signal closed


func _ready() -> void:
	create_mod_panels()
	
	page = 0
	turn_page()

func create_mod_panels() -> void:
	var mods: Array[Mod] = get_node("/root/ModLoader").mod_manager.mods()
	
	for i in range(int(len(mods) / 3)+1):
		var page := page_template.duplicate()
		add_child(page)
		
		pages.append(page)
	
	var panel_scene: PackedScene = load("res://Mod/ModLoaderCore/Scenes/UI/Mod Panel/mod_panel.tscn")
	
	for i in range(len(mods)):
		var mod := mods[i]
		var panel := panel_scene.instantiate()
		panel.id = mod.id()
		if mod.id() == "mod_loader": panel.can_toggle = false
		pages[int(i / 3)].add_child.call_deferred(panel)
		

func turn_page() -> void:
	var index: int
	for i in pages:
		if index == page:
			i.visible = true
		else:
			i.visible = false
		index += 1
	previous_button.disabled = page == 0
	next_button.disabled = page == pages.size() - 1


func _on_ok_button_pressed() -> void:
	SceneManager.change_scene(get_tree().current_scene.scene_file_path)


func _on_visibility_changed() -> void:
	if visible:
		next_button.grab_focus()
		page = 0
		turn_page()


func _on_previous_button_pressed() -> void:
	page = max(0, page - 1)
	turn_page()


func _on_next_button_pressed() -> void:
	page = min(page + 1, pages.size() - 1)
	turn_page()
