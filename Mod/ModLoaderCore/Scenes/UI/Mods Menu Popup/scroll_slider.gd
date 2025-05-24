extends VSlider

@export var scroll_container: ScrollContainer
@export var content: Control

func _ready() -> void:
	value_changed.connect(
		func(new_value: float):
			scroll_container.scroll_vertical = (100.0 - value) / 100.0 * (content.size.y - scroll_container.size.y)
	)

func _process(_delta: float) -> void:
	visible = content.size.y > scroll_container.size.y
	value = 100.0 - scroll_container.scroll_vertical / (content.size.y - scroll_container.size.y) * 100.0
	
