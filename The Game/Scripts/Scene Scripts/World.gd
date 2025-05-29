extends Node


var click_coords : Vector2 = Vector2(0, 0)
var tile : MapTile = null
@export var tileManager : TileManager


@onready var map = $Map
@onready var tileMap = $Map/TileMapLayer

func _ready():
	GlobalSignals.toggle_world_window.connect(toggle_window)
	#Lähettää TileManagerin alaspäin Map:sille
	map.tileManager = tileManager
	
	
	pass



func _process(delta):
	pass
	#if Input.is_action_just_pressed("base"):
		#map.toggle_window(!map.visible)
		#print("Toggling map visibility")



func toggle_window():
	map.visible = !map.visible
	print("Toggling map visibility")


func _unhandled_input(event): 
	if map.visible && !map.player_moving:
		if Input.is_mouse_button_pressed(1):
			#Testausta varten koordinaation tarkastelijan Labeliin
			click_coords = map.get_mouse_tile_coords()
			#$Tarkastelija.set_label(click_coords)
			
			tile = tileManager.get_tile_from_coords(click_coords)
			#Testi printti
			tile.to_string()
			
			tileManager.prep_tile_info_window(tile)
			map.movement_info_to_tile_window(tile)
			print("Press registered")
			
