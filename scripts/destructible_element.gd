extends Node2D
class_name DestructibleElement

var health: int = 10
var is_resistant: bool = false

func take_damage(damage: int):
	health -= damage
	if health <= 0: 
		queue_free()
