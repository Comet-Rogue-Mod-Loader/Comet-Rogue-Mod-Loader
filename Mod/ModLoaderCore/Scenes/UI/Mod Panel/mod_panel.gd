extends Control

@export var id: String
@export var can_toggle: bool = true

var config_menu: Control

@onready var icon: TextureRect = % "Icon"
@onready var display_name: Label = % "DisplayName"
@onready var version: Label = % "Version"
@onready var description: Label = % "Description"
@onready var credit_control: Control = % "CreditControl"

@onready var toggle_button: CustomButton = % "Toggle"
@onready var config_button: CustomButton = % "Config"

func _ready() -> void:
	update()
	
	toggle_button.pressed.connect(_on_toggle_button_pressed)
	config_button.pressed.connect(
		func():
			var mod: Mod = get_node("/root/ModLoader").mod_manager.get_mod(id)
			if mod == null: return
			config_menu.config = mod.config
			config_menu.visible = true
	)
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
	if visible: update()

func update() -> void:
	var mod: Mod = get_node("/root/ModLoader").mod_manager.get_mod(id)
	if mod == null:
		display_name.text = id
		config_button.visible = false
		toggle_button.visible = false
		return
	config_button.visible = mod.config != null
	icon.texture = mod.icon()
	display_name.text = mod.display_name()
	version.text = mod.version()
	description.text = mod.description()
	
	toggle_button.disabled = !can_toggle
	
	toggle_button.message = "Enabled" if mod.enabled else "Disabled"
	toggle_button.modulate = Color(0.7, 1.0, 0.7) if mod.enabled else Color(1.0, 0.7, 0.7)
	

func _on_toggle_button_pressed() -> void:
	var mod: Mod = get_node("/root/ModLoader").mod_manager.get_mod(id)
	if mod == null: return
	mod.enabled = !mod.enabled
	
	toggle_button.message = "Enabled" if mod.enabled else "Disabled"
	toggle_button.modulate = Color(0.7, 1.0, 0.7) if mod.enabled else Color(1.0, 0.7, 0.7) 
