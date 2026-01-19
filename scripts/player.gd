extends Node2D

@export_group("Configurações de Crescimento")
@export var growth_factor: float = 0.02
@export var animation_duration: float = 0.3

@export_group("Nós usados")
@export var AccretionDisk: Area2D = null
@export var EventHorizon: Area2D = null

var current_mass: float = 0.0


func _ready():
	GameManager.mass_changed.connect(_on_mass_updated)
	AccretionDisk.area_entered.connect(_on_accretion_disk_area_entered)
	EventHorizon.area_entered.connect(_on_event_horizon_area_entered)

func _process(_delta: float) -> void:
	rotate(0.001)

# sempre que o buraco engole algo
func _on_mass_updated(new_mass: float):
	var new_size = 1.0 + (sqrt(new_mass) * growth_factor)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(new_size, new_size), animation_duration)

# quando algo entra dentro da área
func _on_accretion_disk_area_entered(area: Area2D) -> void:
	if area.has_method("start_pull"): 
		area.start_pull(self)

func _on_event_horizon_area_entered(area: Area2D) -> void:
	if area.is_in_group("Edible"):
		if "mass" in area:
			attempt_eat(area)

func attempt_eat(item_area: Area2D) -> void:
	if GameManager.player_mass >= item_area.mass:
		GameManager.player_mass += item_area.mass
		
		AudioStreamPlayer.playing = true
		
		item_area.be_consumed()
	
	else:
		# mais tarde implementar lógida de dano/ repulsão
		print("Erro: o item é maior que o buraco negro!")
