class_name ShardShield
extends BaseArtifact

var value: int = 5

func _init() -> void:
	name = "Осколочный щит"
	tag = "shard_shield"
	description = "Наносит %d урона при разрушении вашего щита" % value
	GameManager.artifact_manager.on_player_shield_broken.connect(apply)

func apply(player: Player, source: Enemy):
	source.take_damage(player, value)
