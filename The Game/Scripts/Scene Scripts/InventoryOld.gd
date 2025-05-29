

#class_name Inventory
extends Node

var slots : Array[InventorySlot]
@onready var window : Panel = get_node("InventoryWindow")
@onready var info_text : Label = get_node("InventoryWindow/InfoText")

@export var starter_items : Array[Item]
var player : Player
var amIOpen : bool = false

func _ready():
	toggle_window()
	
	for child in get_node("InventoryWindow/SlotContainer").get_children():
		slots.append(child)
		child.set_item(null)
		child.inventory = self
		
	for item in starter_items:
		add_item(item)
	
	GlobalSignals.toggle_player_inventory.connect(toggle_window)



func _process(delta):
	#if Input.is_action_just_pressed("inventory"):
		#print("Inventory toggle requested")
		#toggle_window()
	pass



func toggle_window():
	window.visible = !window.visible
	amIOpen = window.visible
	print("Inventory toggled")



func on_give_player_item(item : Item, amount : int):
	for i in range(amount):
		add_item(item)



func add_item(item : Item):
	var slot = get_slot_to_add(item)
	
	if slot == null:
		return
	
	if slot.item == null:
		slot.set_item(item)
	elif slot.item == item:
		slot.add_item() 
	



func remove_item(item : Item):
	var slot = get_slot_to_remove(item)
	
	if slot == null or slot.item == item:
		return
	
	slot.remove_item()
	



func get_slot_to_add(item: Item) -> InventorySlot:
	for slot in slots:
		if slot.item == item and slot.quantity < item.maxStackSize:
			return slot
	
	for slot in slots:
		if slot.item == null:
			return slot
	
	return null



func get_slot_to_remove(item : Item) -> InventorySlot:
	for slot in slots:
		if slot.item == item:
			return slot
	
	return null
	



func get_number_of_item(item : Item) -> int:
	var total = 0
	
	for slot in slots:
		if slot.item == item:
			total += slot.quantity
	
	return total
