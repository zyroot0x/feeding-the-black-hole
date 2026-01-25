extends Node2D

@export_group("Configurações")
@export var growth_factor: float = 0.1
@export var animation_duration: float = 0.3
@export var gravity_strength: float = 100000.0 # Força da gravidade configurável

@export_group("Nós")
@export var AccretionDisk: Area2D = null # Área grande (inescapável)
@export var EventHorizon: Area2D = null # Área pequena (come)
@export var GravityArea: Area2D = null # Área grande (puxa)

func _ready():
	GameManager.mass_changed.connect(_on_mass_updated)
	EventHorizon.area_entered.connect(_on_event_horizon_entered)

func _physics_process(delta: float) -> void:
	rotate(0.001) # Rotação visual suave
	_apply_gravity(delta, GravityArea)
	_apply_gravity(delta, AccretionDisk)

# Lógica da Gravidade Ativa: O Buraco Negro puxa tudo na área
func _apply_gravity(delta: float, node: Area2D) -> void:
	var items_in_range = node.get_overlapping_areas()
	
	for area in items_in_range:
		# Verifica se é um item puxável
		if area.is_in_group("Item") and area.has_method("apply_pull_force"):
			area.apply_pull_force(global_position, gravity_strength, delta)


func _on_event_horizon_entered(area: Area2D) -> void:
	if area.is_in_group("Item"):
		attempt_eat(area)

func attempt_eat(item_area: Area2D) -> void:
	if GameManager.player_mass >= item_area.mass or GameManager.can_eat_everyone == true:
		# 1. Ganha a massa
		GameManager.add_mass(item_area.mass)
		
		# 2. Manda o item morrer (O item cuida da animação de morte)
		item_area.die()
	else:
		if "player_mass" in GameManager:
			if GameManager.player_mass < item_area.mass:
				print("Item muito grande! Empurrar ou dar dano.")
				# item_area.apply_repulsion(...)
		else:
			print("Erro Crítico: A variável 'player_mass' não existe mais no GameManager!")
		
		if not "can_eat_everyone" in GameManager:
			print("Erro Crítico: A variável 'can_eat_everyone' não existe mais no GameManager!")

func _on_mass_updated(new_mass: float):
	if new_mass <= 0: return
	var magnitude = log(new_mass) / log(10)
	var new_scale = 1.0 + (magnitude * growth_factor)
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(new_scale, new_scale), animation_duration)
