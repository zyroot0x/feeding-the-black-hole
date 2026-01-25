extends Node

@export var levels: Array[LevelResource] = []

var current_level_index: int = 0

signal level_changed(new_level_data: LevelResource)

func _ready():
	GameManager.mass_changed.connect(_check_progression)
	# ordena os níveis por massa (garantia de segurança)
	levels.sort_custom(func(a, b): return a.mass_required < b.mass_required)

func _check_progression(current_mass: float):
	# verifica se existe um próximo nível
	if current_level_index + 1 < levels.size():
		var next_level = levels[current_level_index + 1]
		
		if current_mass >= next_level.mass_required:
			_advance_level(current_level_index + 1)

func _advance_level(new_index: int):
	current_level_index = new_index
	var level_data = levels[current_level_index]
	
	print("LEVEL UP! Bem-vindo ao nível: ", level_data.level_id)
	
	# emite o sinal para quem interessar (Camera, Spawner, Background)
	level_changed.emit(level_data)
	
	# pausar jogo e rodar animação
