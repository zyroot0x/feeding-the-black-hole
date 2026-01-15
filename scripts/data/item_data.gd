extends Resource
class_name ItemResource

@export var special_velocity: Vector2 = Vector2(randf_range(100, 500), randf_range(100, 500))
@export var collect_sound: AudioStream = null
@export var sprite_texture: Texture2D = null
@export var fast_item: bool = false
@export var name: String = "Item"
@export var mass: float = 1.0
