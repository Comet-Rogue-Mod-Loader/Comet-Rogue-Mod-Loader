extends Sprite2D

func _process(delta: float) -> void:
	var rot = get_tree().root.get_viewport().get_mouse_position().x / 442 - 0.5
	scale.x = lerpf(scale.x, 0.032 * rot * 8.0, delta * 10.0)
	
	rotation_degrees = (get_tree().root.get_viewport().get_mouse_position().y / 248 - 0.5) * 20 * rot
