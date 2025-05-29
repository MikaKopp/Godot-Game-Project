

class_name Item
extends  Resource

@export_category("Basic Info")
@export var displayName : String = "Unnamed"
@export var icon : Texture2D
@export var maxStackSize : int = 99
@export_multiline var itemDescribtion : String = ""
@export var itemValue : int = 100
@export_enum("Mundane","Common","Uncommon","Rare","Mythical") var itemRarity: String = "Common"













func _on_use () -> bool: 
	print("Not consumable or equippable")
	return false
