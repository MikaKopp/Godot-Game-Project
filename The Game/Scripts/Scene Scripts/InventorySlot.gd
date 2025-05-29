
class_name InventorySlot
extends Button

var item : Item
var quantity : int
@onready var itemIcon :TextureRect = get_node("Icon")
@onready var quantity_text : Label = get_node("QuantityText")
var inventory : Inventory
var tooltip_node: Control

func set_data():
	itemIcon = get_node("Icon")
	quantity_text = get_node("QuantityText")
	
	
	
func set_item(new_item : Item):
	item = new_item
	quantity = 1
	
	if item == null:
		itemIcon.visible = false
	else:
		itemIcon.texture = item.icon
		itemIcon.visible = true
	
	update_quantity_text()



func add_item():
	quantity += 1
	update_quantity_text()
	print("Slots add item runned, 1 was added, stack now" + str(quantity))



func remove_item():
	quantity -= 1
	update_quantity_text()
	
	if quantity == 0:
		set_item(null)
		



func update_quantity_text():
	if item == null:
		quantity_text.text = ""
	elif item.maxStackSize == 1:
		quantity_text.text = ""
	else: 
		quantity_text.text = str(quantity)
	



func _on_mouse_entered() -> void:
	GlobalSignals.show_inventory_tooltip.emit(item)
	#if tooltip_node:
		#var tooltip = tooltip_node
		#tooltip.show_tooltip_delayed()
		#print("Mouse Entered")



func _on_mouse_exited() -> void:
	GlobalSignals.hide_inventory_tooltip.emit()
	
	#if tooltip_node:
		#var tooltip = tooltip_node
		#tooltip.hide_tooltip()
		#print("Mouse exited")


func _on_pressed() -> void:
	if item == null:
		return
	
	var removeAfterUse = item._on_use()
	
	if removeAfterUse:
		inventory.remove_item(item)
