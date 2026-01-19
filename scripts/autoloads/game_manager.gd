extends Node

signal mass_changed(new_mass)

# Sempre que o valor da massa muda, emite o sinal
var player_mass: float = 0.0:
	set(value):
		player_mass = value
		mass_changed.emit(player_mass)

func add_mass(amount: float) -> void:
	player_mass += amount

# Debug
var scroll: bool = false:
	set(value):
		scroll = value
		print(scroll)
