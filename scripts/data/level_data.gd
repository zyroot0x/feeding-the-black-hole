extends Resource
class_name LevelResource

@export_group("Gatilhos")
@export var level_id: int = 0
@export var mass_required: float = 100.0 # Massa para CHEGAR neste nível

@export_group("Visual da Câmera")
@export var target_zoom: Vector2 = Vector2(1.0, 1.0) # O zoom ideal deste nível
@export var zoom_duration: float = 2.0 # Tempo para transição suave

@export_group("Ambiente")
@export var background_texture: Texture2D
@export var ambient_music: AudioStream 

@export_group("Conteúdo")
@export var spawnable_items: Array[ItemResource] # Só itens desse tamanho
