

class_name Inventory
extends Control

var slots : Array[InventorySlot]

#Equipment Variables
var allEquipmentSlots : Dictionary = {}
var freeEquipmentSlots :Dictionary = {} 
var fullEquipmenSlots : Dictionary = {}
var equippedItems

var inventoryItems : Dictionary = {}
@onready var window : Panel = get_node("InventoryWindow")
@onready var info_text : Label = get_node("InventoryWindow/InfoText")
@onready var slotContainer : GridContainer = $HBoxContainer/RightSideOfInventory/InventorySlotWindow/ScrollContainer/SlotContainer
@onready var equipmentContainers : Array[GridContainer] = [%EquipmentGrid1,%EquipmentGrid2,%EquipmentGrid3,%EquipmentGrid4,%EquipmentGrid5]

var inventorySlot : PackedScene = preload("res://Scenes/InventorySlot.tscn")


@export var starter_items : Array[Item]
@export var tooltip_window : Control

var player : Player

#var itemStackSlotArray : Array = []

#Move To PlayerScreen Manager
var amIOpen : bool = false

func _ready():
	#toggle_window()
	
	for item in starter_items:
		add_item(item)
		print("Starter Item was added, item was: " + str(item.displayName))
	
	#Set up for the equipment screen
	set_up_equipment()
	
	#Move To PlayerScreen Manager
	GlobalSignals.toggle_player_inventory.connect(toggle_window)
	GlobalSignals.show_inventory_tooltip.connect(show_inventory_tooltip)
	GlobalSignals.hide_inventory_tooltip.connect(hide_inventory_tooltip)
	
	
	GlobalSignals.equip_item.connect(equip_item)
	



func _process(delta):
	#if Input.is_action_just_pressed("inventory"):
		#print("Inventory toggle requested")
		#toggle_window()
	pass



func create_New_Slot(item:Item):
	var newSlot = inventorySlot.instantiate()
	newSlot.set_data()
	newSlot.set_item(item)
	slots.append(newSlot)
	newSlot.inventory = self
	newSlot.tooltip_node = tooltip_window
	return newSlot



#Move To PlayerScreen Manager
func toggle_window():
	window.visible = !window.visible
	amIOpen = window.visible
	print("Inventory toggled")



func on_give_player_item(item : Item, amount : int):
	for i in range(amount):
		add_item(item)



func add_item(item : Item):
	var itemStackSlotArray : Array = []
	var stackSlot : InventorySlot
	if inventoryItems.has(item):
		print("Item stack detected, updating" + str(item.displayName))
		itemStackSlotArray = inventoryItems[item]
		stackSlot = itemStackSlotArray.back()
		if stackSlot.quantity < item.maxStackSize:
			stackSlot.add_item()
			print("Item stack updated: " + str(item.displayName))
			print("Item stack size" + str(stackSlot.quantity))
		elif stackSlot.quantity == item.maxStackSize:
			stackSlot = create_New_Slot(item)
			itemStackSlotArray.append(stackSlot)
			slotContainer.add_child(stackSlot)
			print("Item stack full, adding new stack of " + str(item.displayName))
			print("Item stack size" + str(stackSlot.quantity))
		else: print("Something went wrong in Inventory add_item")
	
	else:
		print("Item stack not detected creating new: " + str(item.displayName))
		stackSlot = create_New_Slot(item)
		itemStackSlotArray.append(stackSlot)
		inventoryItems[item] = itemStackSlotArray
		slotContainer.add_child(stackSlot)
		print("Item stack size" + str(stackSlot.quantity))



#TODO test remove 
func remove_item(item : Item):
	var itemStackSlotArray : Array = []
	var stackSlot : InventorySlot
	if inventoryItems.has(item):
		itemStackSlotArray = inventoryItems[item]
		stackSlot = itemStackSlotArray.back()
		if stackSlot.quantity == 1:
			itemStackSlotArray.pop_back()
			stackSlot.queue_free()
			if itemStackSlotArray.is_empty():
				inventoryItems.erase(item)
				print("Removing empty slot from inventory items, Done in 1")
			
		elif stackSlot.quantity > 1:
			stackSlot.remove_item()
			if itemStackSlotArray.is_empty():
				inventoryItems.erase(item)
				print("Removing empty slot from inventory items, Done in 2")
	
	else: print("No item found, remove failed")
	#if inventoryItems[item].is_empty():
		#print("Removing empty slot from inventory items, Done in 3")
		#inventoryItems.erase(item)




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


func show_inventory_tooltip(item:Item):
	tooltip_window.show_tooltip_delayed(item, get_global_mouse_position())
	
func hide_inventory_tooltip():
	tooltip_window.hide_tooltip()



#Equipment part _____________________________
#TODO Make 1-2 of each equippable item and test equipping and unequipping
#Makes sure that equipment slots are ready to be used
func set_up_equipment():
	for container in equipmentContainers:
		for slot in container.get_children():
			slot.inventory = self
			allEquipmentSlots[slot.slotType] = slot
			freeEquipmentSlots[slot.slotType] = slot



func equip_item(item:Item):
	var slotType = item.equipSlot
	var availableSlot : EquipmentSlot
	match slotType:
		"Ring":
			if freeEquipmentSlots.has("Ring One"):
				availableSlot = freeEquipmentSlots["Ring One"]
				availableSlot.item = item
				availableSlot.equip_item()
				fullEquipmenSlots[availableSlot.slotType] = availableSlot
				freeEquipmentSlots.erase(availableSlot.slotType)
			elif freeEquipmentSlots.has("Ring Two"):
				availableSlot = freeEquipmentSlots["Ring Two"]
				availableSlot.item = item
				availableSlot.equip_item()
				fullEquipmenSlots[availableSlot.slotType] = availableSlot
				freeEquipmentSlots.erase(availableSlot.slotType)
			elif freeEquipmentSlots.has("Ring Three"):
				availableSlot = freeEquipmentSlots["Ring Three"]
				availableSlot.item = item
				availableSlot.equip_item()
				fullEquipmenSlots[availableSlot.slotType] = availableSlot
				freeEquipmentSlots.erase(availableSlot.slotType)
			elif freeEquipmentSlots.has("Ring Four"):
				availableSlot = freeEquipmentSlots["Ring Four"]
				availableSlot.item = item
				availableSlot.equip_item()
				fullEquipmenSlots[availableSlot.slotType] = availableSlot
				freeEquipmentSlots.erase(availableSlot.slotType)
			#TODO Test that swap works properly
			else:
				unequip_item(fullEquipmenSlots["Ring One"].item,fullEquipmenSlots["Ring One"])
				availableSlot = freeEquipmentSlots["Ring One"]
				availableSlot.item = item
				availableSlot.equip_item()
				fullEquipmenSlots[availableSlot.slotType] = availableSlot
				freeEquipmentSlots.erase(availableSlot.slotType)

		"Bracelet":
			if freeEquipmentSlots.has("Bracelet One"):
				availableSlot = freeEquipmentSlots["Bracelet One"]
				availableSlot.item = item
				availableSlot.equip_item()
				fullEquipmenSlots[availableSlot.slotType] = availableSlot
				freeEquipmentSlots.erase(availableSlot.slotType)
			elif freeEquipmentSlots.has("Bracelet Two"):
				availableSlot = freeEquipmentSlots["Bracelet Two"]
				availableSlot.item = item
				availableSlot.equip_item()
				fullEquipmenSlots[availableSlot.slotType] = availableSlot
				freeEquipmentSlots.erase(availableSlot.slotType)
			else:
				unequip_item(fullEquipmenSlots["Bracelet One"].item,fullEquipmenSlots["Bracelet One"])
				availableSlot = freeEquipmentSlots["Bracelet One"]
				availableSlot.item = item
				availableSlot.equip_item()
				fullEquipmenSlots[availableSlot.slotType] = availableSlot
				freeEquipmentSlots.erase(availableSlot.slotType)
				
		"Trinket":
			if freeEquipmentSlots.has("Trinket One"):
				availableSlot = freeEquipmentSlots["Trinket One"]
				availableSlot.item = item
				availableSlot.equip_item()
				fullEquipmenSlots[availableSlot.slotType] = availableSlot
				freeEquipmentSlots.erase(availableSlot.slotType)
			elif freeEquipmentSlots.has("Trinket Two"):
				availableSlot = freeEquipmentSlots["Trinket Two"]
				availableSlot.item = item
				availableSlot.equip_item()
				fullEquipmenSlots[availableSlot.slotType] = availableSlot
				freeEquipmentSlots.erase(availableSlot.slotType)
			elif freeEquipmentSlots.has("Trinket Three"):
				availableSlot = freeEquipmentSlots["Trinket Three"]
				availableSlot.item = item
				availableSlot.equip_item()
				fullEquipmenSlots[availableSlot.slotType] = availableSlot
				freeEquipmentSlots.erase(availableSlot.slotType)
			elif freeEquipmentSlots.has("Trinket Four"):
				availableSlot = freeEquipmentSlots["Trinket Four"]
				availableSlot.item = item
				availableSlot.equip_item()
				fullEquipmenSlots[availableSlot.slotType] = availableSlot
				freeEquipmentSlots.erase(availableSlot.slotType)
			else:
				unequip_item(fullEquipmenSlots["Trinket One"].item,fullEquipmenSlots["Trinket One"])
				availableSlot = freeEquipmentSlots["Trinket One"]
				availableSlot.item = item
				availableSlot.equip_item()
				fullEquipmenSlots[availableSlot.slotType] = availableSlot
				freeEquipmentSlots.erase(availableSlot.slotType)
		_:
			if freeEquipmentSlots.has(slotType):
				availableSlot = freeEquipmentSlots[slotType]
				availableSlot.item = item
				availableSlot.equip_item()
				fullEquipmenSlots[availableSlot.slotType] = availableSlot
				freeEquipmentSlots.erase(availableSlot.slotType)
			else:
				unequip_item(fullEquipmenSlots[slotType].item,fullEquipmenSlots[slotType])
				availableSlot = freeEquipmentSlots[slotType]
				availableSlot.item = item
				availableSlot.equip_item()
				fullEquipmenSlots[availableSlot.slotType] = availableSlot
				freeEquipmentSlots.erase(availableSlot.slotType)



func unequip_item(equipment:Equipment,slot:EquipmentSlot):
	freeEquipmentSlots[slot.slotType] = slot
	fullEquipmenSlots.erase(slot.slotType)
	add_item(equipment)
	PlayerCharacterData.item_unequipped(equipment.stat_modifiers)
