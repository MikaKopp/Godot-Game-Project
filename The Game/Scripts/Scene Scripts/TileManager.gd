

class_name TileManager
extends Node

#static dictionary kaikista kartan tiilista
var world_tiles : Dictionary = {}
var loc_id_count : int = 0
var world_locations : Dictionary = {}

var tile : MapTile = null

@export var locationPool : Array[Location] = []

@export var locationPanelSlide : PackedScene
@export var tileInfoWindow : Control

#static funktio joka lisaa uuden tiilen tiililistaan
func new_tile_to_dict(coords, tile):
	world_tiles[Vector2i(coords)] = tile
	
#TODO Palauttaa tiilen annetusta koordinaatista jos sellainen on olemassa
#lisaa toiminta jos ei tiilta koordinaateissa, atm palauttaa tiilen asemassa 0,0



func get_tile_from_coords (coords:Vector2i):
	if world_tiles.has(coords):
		tile = world_tiles.get(coords)
		return tile
	else: 
		print("Olet else haarassa")
		return world_tiles.get(Vector2i(1, 1))



func create_new_location(location) -> Location:

	var newLocation = location.duplicate(true)
	return newLocation



#TODO Vain alkutestaukseen
#Antaa karttatiilelle satunnaisen locationin 
func give_random_location(tile):
	var randomLocation = locationPool.pick_random()
	var locationToAdd = create_new_location(randomLocation)
	if !world_locations.has(tile):
		world_locations[tile] = []
		world_locations[tile].append(locationToAdd)
	else:
		world_locations[tile].append(locationToAdd)
	

func prep_tile_info_window(tile:MapTile):
	var locations : Array = []
	if world_locations[tile] != null:
		locations = world_locations[tile]
	else: print("Locations in selected tile seem to be null")
	
	tileInfoWindow.set_data_to_window(tile, locations)
	tileInfoWindow.visible = true








# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
