extends Camera2D

@export var zoom_speed: float = 0.001

func _ready() -> void:
	GameManager.mass_changed.connect(_on_mass_changed)

func _unhandled_input(event: InputEvent) -> void:
	# verifica se o zoom tá ativado
	if GameManager.scroll == true:
		pass
	
	else:
		return
	
	# aplica o zoom
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(0.1, 0.1) # Afasta (número maior = área maior)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(0.1, 0.1) # Aproxima (número menor = área menor)

	# A trava de segurança crucial:
	zoom.x = clamp(zoom.x, 0.2, 3.0)
	zoom.y = clamp(zoom.y, 0.2, 3.0)

func _on_mass_changed(player_mass: float) -> void:
	if player_mass <= 1.0: return
	
	var magnitude = log(player_mass) / log(10)
	
	var zoom_factor = 1.0 - (magnitude * zoom_speed)
	#tween
	zoom = Vector2(zoom_factor, zoom_factor)
