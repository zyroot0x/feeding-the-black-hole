extends CanvasLayer

@export var Level: PackedScene = null

@export_group("Nós usados")
@export var actControl: Control = null
@export var setControl: Control = null

@export_subgroup("Action Control")
@export var PlayButton: Button = null
@export var SettingsButton: Button = null
@export var ExitButton: Button = null

@export_subgroup("Setting Control")
@export var SettingsExit: Button = null
@export var Scroll: CheckButton = null
@export var Devourer: CheckButton = null
@export var Asteroids: CheckButton = null

func _ready() -> void:
	# Action Control
	PlayButton.button_down.connect(_on_play_pressed)
	SettingsButton.button_down.connect(_on_settings_pressed)
	ExitButton.button_down.connect(_on_exit_pressed)
	
	# Setting Control
	SettingsExit.button_down.connect(_on_exit_settings_pressed)
	Scroll.toggled.connect(_on_scroll_toggled)
	Devourer.toggled.connect(_on_devourer_toggled)
	Asteroids.toggled.connect(_on_asterois_toggled)
	
	actControl.visible = true
	setControl.visible = false

# Action Control

func _on_play_pressed() -> void:
	if Level:
		get_tree().change_scene_to_packed(Level)
	
	else:
		print("Erro: Esqueceu de arrastar a cena do jogo para o Inspector!")

func _on_settings_pressed() -> void:
	actControl.visible = false
	setControl.visible = true

func _on_exit_pressed() -> void:
	get_tree().quit()

# Setting Control

func _on_exit_settings_pressed() -> void:
	actControl.visible = true
	setControl.visible = false

func _on_scroll_toggled(button_toggled: bool) -> void:
	
	if "scroll" in GameManager:
		GameManager.scroll = button_toggled
	else:
		print("Erro Crítico: A variável 'scroll' não existe mais no GameManager!")

func _on_devourer_toggled(button_toggled: bool) -> void:
	if "can_eat_everyone" in GameManager:
		GameManager.can_eat_everyone = button_toggled
	else:
		print("Erro Crítico: A variável 'can_eat_everyone' não existe mais no GameManager!")

func _on_asterois_toggled(button_toggled: bool) -> void:
	if "asteroids" in GameManager:
		GameManager.asteroids = button_toggled
	else:
		print("Erro crítico: A variável'asteroids' não existe mais no GameManager!")
