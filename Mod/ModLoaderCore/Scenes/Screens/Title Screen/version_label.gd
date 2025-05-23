extends RichTextLabel

const possible_texts: Array[String] = [
	"[wave amp=30.0 freq=5.0 connected=1]%s\n%s[/wave]",
	"[shake rate=10.0 level=1 connected=1]%s\n%s[/shake]",
	"[pulse freq=0.25 color=¤ffffffaa ease=1.0]%s\n%s[/pulse]",
	"[rainbow freq=0.5 sat=0.5 val=1.0 speed=0.7]%s\n%s[/rainbow]",
]

var randomize_timer: Timer
var target_color: Color

func _ready() -> void:
	var mod: Mod = get_node("/root/ModLoader").mod_manager.get_mod("mod_loader")
	text = possible_texts.pick_random() % ["Mod Loader", mod.version()]
	
	randomize_timer = Timer.new()
	randomize_timer.one_shot = true
	randomize_timer.timeout.connect(
		func() -> void:
			target_color = random_color()
			randomize_timer.start(1.0)
	)
	add_child(randomize_timer)
	randomize_timer.start(1.0)
	
	self_modulate = random_color()

func random_color() -> Color:
	return Color.from_hsv(float(randi_range(0, 10)) / 10.0, 0.6, 1.0)

func _process(delta: float) -> void:
	self_modulate = lerp(self_modulate, target_color, delta)
