extends Control




@export var player : Player

var isVisible : bool = false
var inventoryVisible : bool = false
var characterVisible : bool = false
var cultivationVisible : bool = false
var journalVisible : bool = false

var currentVisibleSubScreen : String
@onready var inventoryScreen =  %InventoryPanel
@onready var cultivationScreen = %CultivationPanel
@onready var journalScreen =  %JournalPanel
@onready var characterScreen =  %CharacterPanel
@onready var inventoryNavBtn =  %InventoryNavBtn
@onready var cultivationNavBtn = %CultivationNavBtn
@onready var journalNavBtn =  %JournalNavBtn
@onready var characterNavBtn =  %CharacterNavBtn

func _ready():
	GlobalSignals.toggle_player_screen.connect(openScreen)
	toggleScreens()

	
	


func setData():
	inventoryScreen.player = player
	cultivationScreen.player = player
	cultivationScreen.playerScreen = self
	cultivationScreen.first_time_setup_method_grids()



#Makes itself visible and the wanted screen, if screen inventory for example then turn inventory visible
func openScreen(screen:String):
	match screen:
		"Character":
			print("openScreen Character is in use")
			if isVisible == false:
				isVisible = true
				currentVisibleSubScreen = "Character"
				characterNavBtn.set_pressed_no_signal(true)
				toggleScreens()
			elif isVisible && !characterVisible:
				currentVisibleSubScreen = "Character"
				toggleScreens()
			else: 
				isVisible = false
				toggleScreens()
		"Inventory":
			print("openScreen Inventory is in use")
			if isVisible == false:
				isVisible = true
				currentVisibleSubScreen = "Inventory"
				inventoryNavBtn.set_pressed_no_signal(true)
				toggleScreens()
			elif isVisible && !inventoryVisible:
				currentVisibleSubScreen = "Inventory"
				inventoryNavBtn.set_pressed_no_signal(true)
				toggleScreens()
			else: 
				isVisible = false
				toggleScreens()
		"Cultivation":
			print("openScreen Cultivation is in use")
			if isVisible == false:
				isVisible = true
				currentVisibleSubScreen = "Cultivation"
				cultivationNavBtn.set_pressed_no_signal(true)
				toggleScreens()
			elif isVisible && !cultivationVisible:
				currentVisibleSubScreen = "Cultivation"
				cultivationNavBtn.set_pressed_no_signal(true)
				toggleScreens()
			else: 
				isVisible = false
				toggleScreens()
		"Journal":
			print("openScreen Journal is in use")
			if isVisible == false:
				isVisible = true
				currentVisibleSubScreen = "Journal"
				journalNavBtn.set_pressed_no_signal(true)
				toggleScreens()
			elif isVisible && !journalVisible:
				currentVisibleSubScreen = "Journal"
				journalNavBtn.set_pressed_no_signal(true)
				toggleScreens()
			else: 
				isVisible = false
				toggleScreens()

#TODO Add every other screen visibility toggle here
func toggleScreens():
	print("toggleScreen is in use")
	toggleCurrentScreenBool()
	inventoryScreen.visible = inventoryVisible
	cultivationScreen.visible = cultivationVisible
	characterScreen.visible = characterVisible
	journalScreen.visible = journalVisible
	print(isVisible)
	visible = isVisible
	print(isVisible)



func toggleCurrentScreenBool():
	print("toggleCurrentScreenBool is in use")
	match currentVisibleSubScreen:
		"Inventory":
			inventoryVisible = true
			characterVisible = false
			cultivationVisible = false
			journalVisible = false
		"Character":
			inventoryVisible = false
			characterVisible = true
			cultivationVisible = false
			journalVisible = false
		"Journal":
			inventoryVisible = false
			characterVisible = false
			cultivationVisible = false
			journalVisible = true
		"Cultivation":
			inventoryVisible = false
			characterVisible = false
			cultivationVisible = true
			journalVisible = false




func _on_character_nav_btn_toggled(toggled_on):
	currentVisibleSubScreen = "Character"
	toggleScreens()
	print("Character is toggled")

func _on_inventory_nav_btn_toggled(toggled_on):
	currentVisibleSubScreen = "Inventory"
	toggleScreens()
	print("Inventory is toggled")

func _on_cultivation_nav_btn_toggled(toggled_on):
	currentVisibleSubScreen = "Cultivation"
	toggleScreens()
	print("Cultivation is toggled")

func _on_journal_nav_btn_toggled(toggled_on):
	currentVisibleSubScreen = "Journal"
	toggleScreens()
	print("Journal is toggled")
