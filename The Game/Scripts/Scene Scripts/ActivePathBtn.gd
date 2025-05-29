class_name ActivePathBtn
extends Button

var myMethod : CultivationMethod
var myType : String 
var textureRect : TextureRect
var nameLbl : Label 

func initialize():
	textureRect = $HBoxContainer/MarginContainer2/Icon
	nameLbl = $HBoxContainer/MarginContainer/NameLbl



func set_data(method:CultivationMethod):
	initialize()
	textureRect.texture = method.icon
	nameLbl.text = method.displayName
	myType = method.myType
	myMethod = method


func _on_pressed():
	pass # Replace with function body.
