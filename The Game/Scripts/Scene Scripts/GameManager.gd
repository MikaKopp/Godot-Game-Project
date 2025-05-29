extends Node


@onready var CurrentDate : Array = [1,"January",1000]
var currentMonthInInt : int = 0
var monthNames : Array[String] = ["January", "February", "March", "April","May","June","July","August","Sebtember","October","November","December"]

@export var camera: Camera2D
@export var player : Player
@export var world : Node
@export var playerBase : Node2D
@export var tileManager : Node
@export var tileInfoWindow : Control


var inMenu : bool = false
var menuStatus : Dictionary = {
	"playerbase":false,
	"playerscreen":false,
	"inventory":false,
	"characterscreen":false
} 

func _ready():
	GlobalSignals.gameManager_toggle_my_window.connect(toggleWindows)
	GlobalSignals.game_manager_pass_days_call.connect(passMultipleDays)
	



func _process(delta):
	if Input.is_action_just_pressed("base"):
		GlobalSignals.toggle_base_window.emit()
		GlobalSignals.toggle_world_window.emit()
		menuStatus["playerbase"] = playerBase.amIOpen
		checkCameraToggle()
		
	if Input.is_action_just_pressed("characterScreen"):
		GlobalSignals.toggle_character_screen.emit()
		menuStatus["characterScreen"] = player.character_screen.amIOpen
		print("Character Screen toggle requested")
		checkCameraToggle()
			
	if Input.is_action_just_pressed("inventory"):
		menuStatus["inventory"] = !menuStatus["inventory"]
		print("Inventory toggle requested")
		checkCameraToggle()
		GlobalSignals.toggle_player_screen.emit("Inventory")


func toggleWindows(window:String):
	match window:
		"world" : 
			GlobalSignals.toggle_base_window.emit()
			GlobalSignals.toggle_world_window.emit()
	




func updateCurrentEntireDate(day:int,month:String,year:int):
	CurrentDate[0] = day
	CurrentDate[1] = month
	CurrentDate[2] = year
	update_displayed_calendar()
	print("updateCurrentEntireDate Is in use")
	pass


#doesn't work as is, need fixing, use passMultiplDays
func passOneDay():
	if CurrentDate[0] < 30:
		CurrentDate[0] += 1
	else: CurrentDate[0] = 1
	update_displayed_calendar()

func passMultipleDays(days:int):
	var fullMonths = floor(days / 30)
	var remainingDays = days % 30
	currentMonthInInt = monthNames.find(CurrentDate[1])
	for x in fullMonths:
		add_month()
	add_days_remaining(remainingDays)
	update_displayed_calendar()
	
func add_year():
	CurrentDate[2] += 1
	update_displayed_calendar()

func add_month():
	currentMonthInInt = monthNames.find(CurrentDate[1])
	if currentMonthInInt < 11:
		currentMonthInInt += 1
	else: 
		currentMonthInInt = 0
		add_year()
	CurrentDate[1] = monthNames[currentMonthInInt]
	update_displayed_calendar()

#add days to calendar, but only use this with passMultipleDays func
func add_days_remaining(days:int):
	if days+CurrentDate[0] > 30:
		var remaining = days+CurrentDate[0]-30
		add_month()
		CurrentDate[0] = remaining
	else: CurrentDate[0] += days
	update_displayed_calendar()

func update_displayed_calendar():
	GlobalSignals.update_date_bar.emit(CurrentDate)


func updateMenuStatus():
	menuStatus["playerbase"] = playerBase.amIOpen
	menuStatus["inventory"] = player.inventory.amIOpen
	menuStatus["characterscreen"] = player.character_screen.amIOpen
	

func isAnyMenuOpen():
	var has_true = false
	for value in menuStatus.values():
		if value:
			has_true = true
			break
	
	if has_true:
		inMenu = true
	else:
		inMenu = false



func checkCameraToggle():
	isAnyMenuOpen()
	if !inMenu:
		camera.camera_active = true
	else:
		camera.camera_active = false
