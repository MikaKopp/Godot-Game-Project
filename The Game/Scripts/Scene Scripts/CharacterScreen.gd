
class_name CharacterScreen
extends Node


@onready var window : Panel = get_node("CharacterWindow")

@onready var cultivation_stage_major_lbl: Label = $CharacterWindow/ScreenSplit/GridContainer/CultivationRealmMajorLbl
@onready var cultivation_stage_minor_lbl: Label = $CharacterWindow/ScreenSplit/GridContainer/CultivationRealmMinorLbl
@onready var cultivation_xp_lbl: Label = $CharacterWindow/ScreenSplit/GridContainer/CultivationXpLbl
@onready var life_span_lbl: Label = $CharacterWindow/ScreenSplit/GridContainer/LifeSpanLbl
var player : Player
var amIOpen : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	toggle_window()
	GlobalSignals.toggle_character_screen.connect(toggle_window)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("characterScreen"):
		#toggle_window()
	pass



func toggle_window():
	window.visible = !window.visible
	amIOpen = window.visible



func update_lifespanlbl(lifespan : int):
	life_span_lbl.text = "Remaining Lifespan: " + str(lifespan)
	print("Lifespan updated")



func update_cultivation_xplbl(xp : int, maximumXp : int):
	cultivation_xp_lbl.text = "Cultivation Progress: " + str(xp) + "/" + str(maximumXp)
	print("Xp updated")
	



func update_cultivation_stagelbl(minor : String, major : String):
	cultivation_stage_major_lbl.text = major
	cultivation_stage_minor_lbl.text = minor
	print("Major Realm updated")
	print("Minor Realm updated")



func update_all():
	cultivation_stage_minor_lbl.text = player.cultivationMinorLevelInStr 
	cultivation_stage_major_lbl.text = player.cultivationMajorLevelInStr 
	cultivation_xp_lbl.text = "Cultivation Progress: " + str(player.currentCultXp) + "/" + str(player.levelXpTarget)
	life_span_lbl.text = "Remaining Lifespan: " + str(player.lifeSpan)
	print("Minor Realm updated")
	print("Major Realm updated")
	print("Xp updated")
	print("Lifespan updated")
