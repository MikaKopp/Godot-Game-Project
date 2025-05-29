extends Control

@onready var sliding_panel = $PanelContainer/Panel/LocationSlidingPanel/ScrollContainer/VBoxContainer
@onready var animation_player = $PanelContainer/AnimationPlayer
@onready var toggle_button = $PanelContainer/Panel/SlideButton
@onready var travel_button = $PanelContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/Panel2/VBoxContainer/TrabelBtn

@onready var nameLabel : Label = $PanelContainer/Panel/VBoxContainer/PanelForName/NameLbl
@onready var travelTimeLbl : Label = $PanelContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/Panel2/VBoxContainer/TravelTimeLbl

@export var locationPanelSlide : PackedScene
#@export var tileManager : TileManager

var tile : MapTile
var locationList : Array = []
var locationSlides : Array[LocationSlide] = []
var travelDays : int = 0

var is_panel_visible = false


func _ready():
	GlobalSignals.get_travel_days_to_window.connect(set_travelTimeLbl)
	visible = false
	# Connect the button press to toggle the sliding panel
	toggle_button.pressed.connect(_on_toggle_button_pressed)

	# Ensure the sliding panel starts hidden and processing is disabled
	sliding_panel.hide()
	sliding_panel.process_mode = Node.ProcessMode.PROCESS_MODE_DISABLED



func _on_toggle_button_pressed():
	if is_panel_visible:
		animation_player.play("LocationInfoPanelSlideIn")  # Play slide-in animation
	else:
		sliding_panel.process_mode = Node.ProcessMode.PROCESS_MODE_INHERIT
		sliding_panel.show()  # Make sure the panel is visible before sliding out
		animation_player.play("LocationInfoPanelSlideOut")  # Slide out animation
	is_panel_visible = !is_panel_visible  # Toggle visibility state


# Callback after animation finishes
func _on_animation_finished(animation_name):
	if animation_name == "LocationInfoPanelSlideIn":
		# After sliding in, hide the panel and disable processing
		sliding_panel.hide()  # Hide the panel after sliding in
		sliding_panel.process_mode = Node.ProcessMode.PROCESS_MODE_DISABLED



func set_data_to_window(selectedTile:MapTile, locationArray:Array):
	
	nameLabel.text = str(selectedTile._my_coords)
	
	tile = selectedTile
	locationList = locationArray
	if locationSlides.size() >= locationList.size():
		for l in locationList.size():
			locationSlides[l].myLocation = locationList[l]
			locationSlides[l].update_data()
			
	elif locationSlides.size() < locationList.size():
		var difference = locationList.size() - locationSlides.size()
		for x in difference:
			var slide = locationPanelSlide.instantiate()
			slide.setOwnData()
			locationSlides.append(slide)
			
		for l in locationList.size():
			locationSlides[l].myLocation = locationList[l]
			locationSlides[l].update_data()
	
	for x in locationList.size():
		sliding_panel.add_child(locationSlides[x])
	



func set_travelTimeLbl(days:int):
	travelTimeLbl.text = "Estimated time: " + str(days) + " days"
	set_travel_time(days)
	pass



func set_travel_time(days:int):
	travelDays = days



func _on_exit_screen_button_pressed():
	print("Click")
	visible = false



func _on_trabel_btn_pressed():
	print("Travel Button Pressed")
	GlobalSignals.travel_btn_pressed.emit()
	GlobalSignals.game_manager_pass_days_call.emit(travelDays)
