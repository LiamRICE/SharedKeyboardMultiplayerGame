extends Player

class_name PlayerMP

func _ready():
	print(str(name).to_int())
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())

func condition():
	return $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id()
