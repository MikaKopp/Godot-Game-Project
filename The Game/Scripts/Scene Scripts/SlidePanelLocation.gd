extends PanelContainer

class_name LocationSlide


var myLocation : Location
@onready var nameLbl : Label
@onready var infoLbl : Label
@onready var icon : TextureRect

func _ready():
	pass
	


func update_data():
	nameLbl.text = myLocation.displayName
	icon.texture = myLocation.icon

func setOwnData():
	nameLbl = $HBoxContainer/Button/VBoxContainer/NameLbl
	infoLbl = $HBoxContainer/Button/VBoxContainer/InfoLbl
	icon = $HBoxContainer/TextureRect
