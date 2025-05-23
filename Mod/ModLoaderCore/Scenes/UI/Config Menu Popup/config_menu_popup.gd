extends Control

@export var config: ModConfig : 
	set(value):
		if config == value: return
		config = value
		update_config()

@onready var content: Control = % "Config Content"
@onready var title: Label = % "Title"
@onready var ok_button: CustomButton = % "Ok Button"

func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)
	ok_button.pressed.connect(_on_ok_button_pressed)

func update_config() -> void:
	for child in content.get_children():
		child.queue_free()
	if config == null: return
	title.text = config.mod.display_name()
	for item in config.items:
		item

func _on_visibility_changed() -> void:
	if visible != true: return
	update_config()

func _on_ok_button_pressed() -> void:
	visible = false
