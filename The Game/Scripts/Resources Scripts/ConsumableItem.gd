extends Item
class_name ConsumableItem

@export var stat_modifiers: Dictionary = {}  # Example: { "strength": 5, "energy": 20 }

@export var consumeEffects : Array[ConsumableEffect] = []

func _on_use () -> bool: 
		if not stat_modifiers.is_empty():
			for stat in stat_modifiers:
				#print(consumeEffect.displayName + " is in use")
				#GlobalSignals.on_give_player_ceffect.emit(consumeEffect)
				PlayerCharacterData.modify_stat(stat, stat_modifiers[stat])
			return true
		else: 
			print("Consumable item had no consume effects")
			return true
