extends Node

@onready var window : Control = get_node("Window")
@onready var daySlider : HSlider = get_node("Window/PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/DaySlider")
@onready var dayLbl : Label = get_node("Window/PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/DayLbl")
@onready var totalDaysCultivated : int = 0

func _ready():
	dayLbl.text = "0"
	toggle_window()



func toggle_window():
	var open = !window.visible
	window.visible = open
	
	

func updateDayLvl():
	
	pass


func _on_day_slider_value_changed(value):
	dayLbl.text = str(value)


func _on_back_btn_pressed():
	daySlider.value = 0
	toggle_window()


func _on_confirm_btn_pressed():
	totalDaysCultivated = daySlider.value
	GlobalSignals.spend_time_cultivating.emit(totalDaysCultivated)
	GlobalSignals.game_manager_pass_days_call.emit(totalDaysCultivated)
