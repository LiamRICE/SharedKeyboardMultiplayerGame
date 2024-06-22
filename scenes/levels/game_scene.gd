extends Node2D

class_name GameScene

@export var PlayerScene: PackedScene = load("res://scenes/characters/link_mp.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var index = 0
	for i in GameManager.players:
		var current_player = PlayerScene.instantiate()
		current_player.name = str(GameManager.players[i].id)
		print(current_player.name)
		$Players.add_child(current_player)
		for spawn in get_tree().get_nodes_in_group("PlayerSpawnPoint"):
			if spawn.name == str(index):
				current_player.global_position = spawn.global_position
		index += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
