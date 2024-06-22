extends Player

const char_name: String = "Link"

var attack_damage: int = 8
var is_hard_damage: bool = false

var can_attack: bool = true
var attack_time: float = 0.1
var attack_cooldown_time: float = 0.8

func _ready():
	# deactivate sword damage area
	$AttackZone/AttackArea2D/CollisionShape2D.disabled = true
	can_attack = false

func extended_process(delta):
	print($AttackZone/AttackArea2D/CollisionShape2D.disabled)

func primary_action():
	$AttackZone/AttackArea2D/CollisionShape2D.disabled = false
	$AttackZone/AttackTimer.start(attack_time)

func secondary_action():
	pass

func special_action():
	pass

func _on_attack_timer_timeout():
	$AttackZone/AttackArea2D/CollisionShape2D.disabled = true
	$AttackZone/AttackCooldownTimer.start(attack_cooldown_time)

func _on_attack_cooldown_timer_timeout():
	can_attack = true

func _on_attack_area_2d_body_entered(body):
	if "take_damage" in body:
		body.take_damage(attack_damage, is_hard_damage)
