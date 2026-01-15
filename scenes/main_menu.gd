extends CanvasLayer

@export var Level: PackedScene = null

@export_group("Nós usados")
@export var sControl: Control = null
@export var aControl: Control = null

@export_subgroup("Action Control")
@export var PlayButton: Button = null
@export var SettingsButton: Button = null
@export var ExitButton: Button = null

@export_subgroup("Setting Control")
@export var SettingsExit: Button = null
@export var Scroll: CheckButton = null

func _ready() -> void:
	# aControl
	PlayButton.button_down.connect(_on_play_pressed)
	SettingsButton.button_down.connect(_on_settings_pressed)
	ExitButton.button_down.connect(_on_exit_pressed)
	
	# sControl
	SettingsExit.button_down.connect(_on_exit_settings_pressed)
	Scroll.toggled.connect(_on_scroll_toggled)
	
	sControl.visible = false

# Action Control

func _on_play_pressed() -> void:
	if Level:
		get_tree().change_scene_to_packed(Level)
	
	else:
		print("Erro: Esqueceu de arrastar a cena do jogo para o Inspector!")

func _on_settings_pressed() -> void:
	aControl.visible = false
	sControl.visible = true

func _on_exit_pressed() -> void:
	get_tree().quit()

# Setting Control

func _on_exit_settings_pressed() -> void:
	aControl.visible = true
	sControl.visible = false

func _on_scroll_toggled(button_toggled: bool) -> void:
	
	if "scroll" in GameManager:
		GameManager.scroll = button_toggled
	else:
		print("Erro Crítico: A variável 'scroll' não existe mais no GameManager!")
