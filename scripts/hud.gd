extends CanvasLayer

@export_group("Nós usados")
@export var mass_label: Label

func _ready():
	GameManager.mass_changed.connect(_update_mass_display)
	_update_mass_display(GameManager.total_mass)

# atualiza o label sempre que a massa do buraco muda
func _update_mass_display(new_mass: float):
	mass_label.text = "Massa: " + str(snapped(new_mass, 0.1))
	
	# animação
	var tween = create_tween()
	tween.tween_property(mass_label, "scale", Vector2(1.2, 1.2), 0.05)
	tween.tween_property(mass_label, "scale", Vector2(1.0, 1.0), 0.1)
