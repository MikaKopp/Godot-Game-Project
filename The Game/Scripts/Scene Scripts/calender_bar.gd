extends Node

@onready var dateLbl : Label = get_node("PanelContainer/HBoxContainer/CurrentDateLbl")
@export var gameManager : Node

func _ready() -> void:
	GlobalSignals.update_date_bar.connect(update_date_bar)
	gameManager.update_displayed_calendar()


#day:int, month:String, year:int
func setDateLbl(date:Array):
	var dayAddition : String = "th"
	var day = date[0]
	var month = date[1]
	var year = date[2]
	
	match day:
		1:
			dayAddition = "st"
		2:
			dayAddition = "nd"
		3:
			dayAddition = "rd"
		_:	
			dayAddition = "th"
	
	dateLbl.text = str(day)+ dayAddition + " of " + month + " Year " + str(year)
	print("Date is set in calendar")
	

func update_date_bar(date:Array):
	setDateLbl(date)
	print("Signal to update date recieved")
