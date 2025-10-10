extends Node
# Defines rarity types for dice and pool types for generation
enum RarityType {
	COMMON,
	UNCOMMON,
	RARE,
	EPIC,
	LEGENDARY
}

enum PoolType {
	SHOP,
	CHEST,
	ALL
}

enum RunePriorityType{
	UTILITY,
	SHIELD,
	EFFECT,
	SELF_DAMAGE,
	DAMAGE
}

enum EffectPriorityType{
	GOOD,
	BAD
}
