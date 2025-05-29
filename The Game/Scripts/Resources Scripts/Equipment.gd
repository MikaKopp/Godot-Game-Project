extends Item
class_name Equipment

@export var stat_modifiers: Dictionary = {}  # Example: { "strength": 5, "energy": 20 }

@export_enum("Helmet","Body","Arms","Gloves","Legs","Feet","Cape","Face","Body Secondary","Legs Secondary","Belt"
,"Feet Secondary","Neck","Neck Secondary","Bracelet","Trinket","Ring"
) var equipSlot: String = "Trinket One"

func _on_use () -> bool: 
	GlobalSignals.equip_item.emit(self)
	PlayerCharacterData.item_equipped(stat_modifiers)
	print(self.displayName + " was equipped")
	return true
	
