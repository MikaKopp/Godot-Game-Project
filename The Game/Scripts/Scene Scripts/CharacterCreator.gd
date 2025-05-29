extends Control




@onready var storyLbl : Label = $CharacterCreatorHbox/CharacterCreatorStoryVbox/StoryPanel/StoryLbl
@onready var traitLbl : Label = $CharacterCreatorHbox/CharacterCreatorStoryVbox/StoryPanel/VBoxContainer/StoryLbl
@onready var pointsLbl : Label = $CharacterCreatorHbox/CharacterCreatorStoryVbox/StoryPanel/VBoxContainer/RemainingPointsLbl
@onready var traitDescriptionLbl : Label = $CharacterCreatorHbox/TraitPickerContainer/TraitInfoContainer/TraitMargin/TraitInfoLbl

@onready var traitBox : HBoxContainer = $CharacterCreatorHbox/TraitPickerContainer/TraitSelectionContainer
@onready var backgroundBox : FlowContainer = $CharacterCreatorHbox/TraitPickerContainer/TraitSelectionContainer/BackgroundPanel/MarginContainer/FlowContainer
@onready var cultivationBox : FlowContainer = $CharacterCreatorHbox/TraitPickerContainer/TraitSelectionContainer/CultivationPhysiquePanel/CultivationPhysiqueMargin/CultivationPhysiqueFlow
@onready var physiqueBox : FlowContainer = $CharacterCreatorHbox/TraitPickerContainer/TraitSelectionContainer/PhysiquePanel/CultivationPhysiqueMargin/CultivationPhysiqueFlow
@onready var encounterBox : FlowContainer = $CharacterCreatorHbox/TraitPickerContainer/TraitSelectionContainer/EncounterPanel/CultivationPhysiqueMargin/CultivationPhysiqueFlow

@onready var nextBtn : Button = $CharacterCreatorHbox/NextScreenBtn
@onready var prevBtn : Button = $CharacterCreatorHbox/PreviousScreenBtn

var maxPageNumber : int = 0
var pageNumber : int = 0

@export var backgroundTraits : Array[CharacterTrait]
@export var cultivationTraits : Array[CharacterTrait]
@export var physiqueTraits : Array[CharacterTrait]
@export var encounterTraits : Array[CharacterTrait]

var trait_button : PackedScene = preload("res://Scenes/Trait_Btn.tscn")

var availableTraitPoints : int = 15


func _ready():
	maxPageNumber = traitBox.get_child_count()
	sort_trait_arrays()
	populate_trait_buttons()
	update_point_lbl()



func sort_trait_arrays():
	backgroundTraits.sort_custom((func(a, b): return a.myCost < b.myCost or a.myDisplayName < b.myDisplayName))
	cultivationTraits.sort_custom((func(a, b): return a.myCost < b.myCost or a.myDisplayName < b.myDisplayName))
	encounterTraits.sort_custom((func(a, b): return a.myCost < b.myCost or a.myDisplayName < b.myDisplayName))
	physiqueTraits.sort_custom((func(a, b): return a.myCost < b.myCost or a.myDisplayName < b.myDisplayName))
	



func populate_trait_buttons():
	for resource in backgroundTraits:
		var tbutton = trait_button.instantiate()
		tbutton.set_trait(resource)
		tbutton.mouse_entered.connect(_on_mouse_entered_trait.bind(tbutton))
		tbutton.toggled.connect(_on_toggled_trait.bind(tbutton))
		backgroundBox.add_child(tbutton)
	for resource in cultivationTraits:
		var tbutton = trait_button.instantiate()
		tbutton.set_trait(resource)
		tbutton.mouse_entered.connect(_on_mouse_entered_trait.bind(tbutton))
		tbutton.toggled.connect(_on_toggled_trait.bind(tbutton))
		cultivationBox.add_child(tbutton)
	for resource in physiqueTraits:
		var tbutton = trait_button.instantiate()
		tbutton.set_trait(resource)
		tbutton.mouse_entered.connect(_on_mouse_entered_trait.bind(tbutton))
		tbutton.toggled.connect(_on_toggled_trait.bind(tbutton))
		physiqueBox.add_child(tbutton)
	for resource in encounterTraits:
		var tbutton = trait_button.instantiate()
		tbutton.set_trait(resource)
		tbutton.mouse_entered.connect(_on_mouse_entered_trait.bind(tbutton))
		tbutton.toggled.connect(_on_toggled_trait.bind(tbutton))
		encounterBox.add_child(tbutton)



func _on_next_screen_btn_pressed():
	if pageNumber < maxPageNumber:
		pageNumber += 1
		if pageNumber == maxPageNumber-1:
			nextBtn.set_disabled(true)
		if pageNumber > 0:
			prevBtn.set_disabled(false)
		traitBox.get_child(pageNumber-1).set_visible(false)
		traitBox.get_child(pageNumber).set_visible(true)



func _on_previous_screen_btn_pressed():
	if pageNumber > 0:
		pageNumber -= 1
		if pageNumber == 0:
			prevBtn.set_disabled(true)
		if pageNumber < maxPageNumber-1:
			nextBtn.set_disabled(false)
		traitBox.get_child(pageNumber+1).set_visible(false)
		traitBox.get_child(pageNumber).set_visible(true)



func _on_mouse_entered_trait(button):
	traitDescriptionLbl.text = button.myTrait.myDescription



func _on_toggled_trait(toggled_on, button):
	if toggled_on:
		availableTraitPoints -= button.myTrait.myCost
		update_point_lbl()
		print("Button pressed ON!")
	else:
		availableTraitPoints += button.myTrait.myCost
		update_point_lbl()
		print("Button pressed OFF!")



func update_point_lbl():
	pointsLbl.text = "Remaining points: " + str(availableTraitPoints)
