extends Node

signal mass_changed(new_mass)

# sempre que o valor da massa muda, emite o sinal
var total_mass: float = 0.0:
	set(value):
		total_mass = value
		mass_changed.emit(total_mass)

func add_mass(amount: float) -> void:
	total_mass += amount
