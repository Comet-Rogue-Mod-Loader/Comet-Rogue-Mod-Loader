extends Control

@export var config: ModConfig
@onready var content: Control = % "Config Content"
@onready var title: Label = % "Title"
@onready var ok_button: CustomButton = % "Ok Button"

func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)
	ok_button.pressed.connect(
		func():
			visible = false
	)

func update_config() -> void:
	for child in content.get_children():
		child.queue_free()
	if config == null: return
	title.text = config.mod.display_name()
	for item in config.items:
		var scene := item.scene()
		if scene == null: continue
		var instance: Node = scene.instantiate()
		instance.item = item
		content.add_child(instance)

func _on_visibility_changed() -> void:
	if visible:
		update_config()
