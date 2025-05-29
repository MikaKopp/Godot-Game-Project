
class_name EquipmentSlot
extends Button

@export var slotDefaultIcon : Texture2D
@export_enum("Helmet","Body","Arms","Gloves","Legs","Feet","Cape","Face","Body Secondary","Legs Secondary","Belt"
,"Feet Secondary","Neck","Neck Secondary","Bracelet One","Bracelet Two","Trinket One","Trinket Two", "Trinket Three"
,"Trinket Four","Ring One","Ring Two","Ring Three","Ring Four","Main Weapon", "Off-Hand","Hidden Weapon", "Ranged Weapon"
,"Support Artifact One", "Support Artifact Two","Support Artifact Three","Support Artifact Four"
) var slotType: String = "Trinket"

@onready var slotIcon :TextureRect = get_node("Icon")
var item : Item
var inventory : Inventory
var tooltip_node: Control

func _ready():
	set_data()


func set_data():
	if item == null:
		slotIcon = get_node("Icon")
		slotIcon.texture = slotDefaultIcon
	else:
		slotIcon.texture =  item.icon


func update_data():
	if item == null:
		slotIcon.texture = slotDefaultIcon
	else:
		slotIcon.texture =  item.icon

func equip_item():
	update_data()


func unequip_item():
	inventory.unequip_item(item,self)
	item = null
	update_data()



func _on_mouse_entered() -> void:
	GlobalSignals.show_inventory_tooltip.emit(item)



func _on_mouse_exited() -> void:
	GlobalSignals.hide_inventory_tooltip.emit()



func _on_pressed() -> void:
	unequip_item()




func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_on_left_click()
		
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			_on_right_click()

func _on_left_click():
	print("Left Click Detected!")

func _on_right_click():
	print("Right Click Detected!")
