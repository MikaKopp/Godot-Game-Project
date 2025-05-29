extends Control

@onready var nameLbl : Label = $PanelContainer/VBoxContainer/NameLbl
@onready var descLbl : Label = $PanelContainer/VBoxContainer/DescribtionLbl
@onready var valueLbl : Label = $PanelContainer/VBoxContainer/BottomBox/ValueLbl
@onready var rarityLbl : Label = $PanelContainer/VBoxContainer/BottomBox/RarityLbl
@onready var timer : Timer = $Timer
@onready var panel : PanelContainer = $PanelContainer

var currentItem : Item
# Tracks whether the tooltip is visible
var tooltip_visible: bool = false
var show_delay = 0.3
var margin: int = 10  # Distance from screen edge 
var last_mouse_position: Vector2 = Vector2.ZERO





func _ready():
	timer.wait_time = show_delay
	timer.one_shot = true
	timer.timeout.connect(show_tooltip)




func set_data(item:Item):
	nameLbl = $PanelContainer/VBoxContainer/NameLbl
	descLbl = $PanelContainer/VBoxContainer/DescribtionLbl
	valueLbl = $PanelContainer/VBoxContainer/BottomBox/ValueLbl
	rarityLbl = $PanelContainer/VBoxContainer/BottomBox/RarityLbl


func set_name_lbl(name:String):
	nameLbl.text = name


func set_desc_lbl(desc:String):
	descLbl.text = desc


func set_value_lbl(value:String):
	valueLbl.text = value


func set_rarity_lbl(rarity:String):
	rarityLbl.text = rarity



func show_tooltip_delayed(item:Item, position: Vector2):
	if item != null:
		set_name_lbl(item.displayName)
		set_desc_lbl(item.itemDescribtion)
		set_value_lbl(str(item.itemValue))
		set_rarity_lbl(item.itemRarity)
		last_mouse_position = position  # Store mouse position for later use
		timer.start()
		print(item.displayName)
	else:return

# Method to show the tooltip with specific text
func show_tooltip():
	tooltip_visible = true
	# Make the tooltip visible
	await get_tree().process_frame  # Ensure UI updates before getting size
	adjust_position(last_mouse_position)  # Use stored mouse position
	show()


#This makes sure that the tooltip cannot go past screen edge
func adjust_position(mouse_position: Vector2):
	var viewport_size = get_viewport().get_visible_rect().size
	var tooltip_size = panel.size if panel.size != Vector2.ZERO else Vector2(100, 50)  # Use size with fallback
	
	var new_position = mouse_position + Vector2(10, 10)  # Apply offset before clamping

	new_position.x = clamp(new_position.x, margin, viewport_size.x - tooltip_size.x - margin)
	new_position.y = clamp(new_position.y, margin, viewport_size.y - tooltip_size.y - margin)
	global_position = new_position



# Method to hide the tooltip
func hide_tooltip():
	tooltip_visible = false
	timer.stop()
	hide()  # Hide the tooltip

# Ensure the tooltip follows the mouse position
func _process(delta):
	if tooltip_visible:
		adjust_position(get_viewport().get_mouse_position())
