extends Button

class_name TraitBtn
var myTrait : CharacterTrait



func _ready():
	if myTrait:
		self.text = myTrait.myDisplayName


func set_trait(value: CharacterTrait):
	myTrait = value
	if myTrait:
		self.text = myTrait.myDisplayName

func _on_toggled(toggled_on):
	if toggled_on:
		print("Button pressed ON!")
	else:
		print("Button pressed OFF!")
