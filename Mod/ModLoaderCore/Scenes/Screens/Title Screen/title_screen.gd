extends Node2D

@onready var mods_button: CustomButton = % "Mods Button"
@onready var mods_menu: Control = % "Mods Menu Popup"

func _ready() -> void:
	mods_button.pressed.connect(_on_mods_button_pressed)

func _on_mods_button_pressed() -> void:
	mods_menu.visible = true

func _on_mods_menu_visibility_changed() -> void:
	if mods_menu.visible == false:
		mods_button.grab_focus()
