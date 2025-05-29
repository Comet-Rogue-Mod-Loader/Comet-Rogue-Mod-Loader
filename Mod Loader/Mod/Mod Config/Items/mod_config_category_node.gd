extends Control

@onready var button: TextureButton = % "Button"
@onready var button_icon: TextureRect = $ "%ButtonIcon"
@onready var content: Control = % "Content"
@onready var hbox: HBoxContainer = % "HBoxContainer"

@onready var icon_down: Texture = load("res://Mod/ModLoaderCore/Resources/Themes/drop_down_icon_down.png")
@onready var icon_up: Texture = load("res://Mod/ModLoaderCore/Resources/Themes/drop_down_icon_up.png")
@onready var icon_down_highlight: Texture = load("res://Mod/ModLoaderCore/Resources/Themes/drop_down_icon_down_highlight.png")
@onready var icon_up_highlight: Texture = load("res://Mod/ModLoaderCore/Resources/Themes/drop_down_icon_up_highlight.png")

var item: ModConfigCategoryItem

var toggle_on: bool = true

func _ready() -> void:
	button.message = ""
	button.pressed.connect(
		func():
			toggle_on = !toggle_on
			button.message = item.display_name
			button_icon.texture = icon_down if toggle_on else icon_up
	)
	update()

func _process(delta: float) -> void:
	if !visible: return
	hbox.visible = toggle_on
	var icon: Texture = icon_down if toggle_on else icon_up
	var icon_highlight: Texture = icon_down_highlight if toggle_on else icon_up_highlight
	button_icon.texture = icon_highlight if button.has_focus() else icon

func update(new_value: Variant = null) -> void:
	button.message = item.display_name
	for child in content.get_children():
		child.queue_free()
	for i: ModConfigItem in item.get_value():
		var scene := i.scene()
		if scene == null: continue
		var instance: Node = scene.instantiate()
		instance.item = i
		content.add_child(instance)
		if "default_value" in i:
			i.set_value(i.default_value)
