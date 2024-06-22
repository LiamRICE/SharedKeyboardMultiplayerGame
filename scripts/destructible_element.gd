extends Node2D
class_name DestructibleElement

var health: int = 10
var is_resistant: bool = false

func take_damage(damage: int, is_hard_damage: bool):
	if is_hard_damage or not is_resistant:
		health -= damage
	if health <= 0:
		queue_free()
