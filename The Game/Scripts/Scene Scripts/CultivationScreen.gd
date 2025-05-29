extends PanelContainer

var player : Player
var playerScreen : Control
@onready var pathTraitPanel : Panel = %PathsTraitsPanel

@onready var mainArtsContainer : GridContainer = %MainArtsGrid
@onready var meditationArtsContainer : GridContainer = %MeditationArtsGrid
@onready var mobilityArtsContainer : GridContainer = %MobilityArtsGrid
@onready var weaponArtsContainer : GridContainer = %WeaponArtsGrid

var activePathBtn : PackedScene = preload("res://Scenes/Active_Path_Btn.tscn")
var allPathBtns : Array[ActivePathBtn] = []

var selectedCultivationMethod : CultivationMethod



func first_time_setup_method_grids():
	var methodDict = player.allCultivationMethods
	for methodArrayKey in methodDict:
		var methodArray = methodDict[methodArrayKey]
		for x in methodArray.size():
			var pathBtn = create_new_active_path_btn(methodArray[x])
			addBtnToGrid(methodArrayKey,pathBtn)

func create_new_active_path_btn(method:CultivationMethod):
	var newBtn = activePathBtn.instantiate()
	newBtn.set_data(method)
	allPathBtns.append(newBtn)
	newBtn.pressed.connect(path_btn_pressed.bind(newBtn))
	return newBtn

func addBtnToGrid(key:String,btn:ActivePathBtn):
	match key:
		"Main":
			mainArtsContainer.add_child(btn)
		"Meditation":
			meditationArtsContainer.add_child(btn)
		"Mobility":
			mobilityArtsContainer.add_child(btn)
		"Weapon":
			weaponArtsContainer.add_child(btn)



func path_btn_pressed(pathBtn):
	pathTraitPanel.display_trait_tree_components(pathBtn.myMethod)


#func create_New_Slot(item:Item):
	#var newSlot = inventorySlot.instantiate()
	#newSlot.set_data()
	#newSlot.set_item(item)
	#slots.append(newSlot)
	#newSlot.inventory = self
	#newSlot.tooltip_node = tooltip_window
	#return newSlot
