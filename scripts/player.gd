extends Node2D

@export_group("Configurações de Crescimento")
@export var growth_factor: float = 0.02
@export var animation_duration: float = 0.3

@export_group("Nós usados")
@export var GravityField: Area2D = null

var current_mass: float = 0.0


func _ready():
	GameManager.mass_changed.connect(_on_mass_updated)
	GravityField.area_entered.connect(_on_gravity_field_area_entered)

func _process(_delta: float) -> void:
	rotate(0.001)

# sempre que o buraco engole algo
func _on_mass_updated(new_mass: float):
	var new_size = 1.0 + (sqrt(new_mass) * growth_factor)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(new_size, new_size), animation_duration)

# quando algo entra dentro da área
func _on_gravity_field_area_entered(area: Area2D) -> void:
	if area.has_method("start_pull"): 
		area.start_pull(self)

	# debug
	print("Algo entrou no campo: ", area.name)
