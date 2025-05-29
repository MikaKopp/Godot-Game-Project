extends Node2D

@export var gameManager : Node
@export var calendarBar : Node
@onready var cultivateWindow : Node = get_node("CanvasLayer/CultivateWindow")
@onready var canvas : CanvasLayer = get_node("CanvasLayer")
var amIOpen : bool = false

func _ready():
	
	GlobalSignals.toggle_base_window.connect(toggle_window)
	toggle_window()



func toggle_window():
	visible = !visible
	canvas.visible = !canvas.visible
	amIOpen = visible
	print("Toggling base visibility")
	
	



func _on_cultivate_btn_pressed():
		cultivateWindow.toggle_window()
		
		



func _on_back_to_world_pressed():

	GlobalSignals.gameManager_toggle_my_window.emit("world")
