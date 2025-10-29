extends Node

var player: Player = Player.new()

var artifact_manager: ArtifactManager = ArtifactManager.new()
var drag_manager: DragManager = DragManager.new()

func _ready():
	add_default_dice()
	
func add_default_dice():
	var attack_die = Die.new(6, [DamageRune1.new(), DamageRune1.new(), DamageRune1.new(), DamageRune1.new(), DamageRune1.new(), DamageRune1.new()])
	var shield_die = Die.new(4, [ShieldRune1.new(), ShieldRune1.new(), ShieldRune1.new(), ShieldRune1.new()])
	var poison_die = Die.new(4, [PoisonRune.new(), PoisonRune.new(), PoisonRune.new(), PoisonRune.new()])
	var fire_die = Die.new(4, [BurnRune.new(), BurnRune.new(), BurnRune.new(), BurnRune.new()])
	player.add_die(attack_die)
	player.add_die(shield_die)
	player.add_die(poison_die)
	player.add_die(fire_die)
