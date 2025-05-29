extends Node2D


@onready var tilemap = $Grass
@onready var tileManager: TileManager
@export var player : Node2D


#TODO Luo oma juttu joka katsoo jonkin avulla kartan koon jos mahdollisuus muuttaa kartan kokoa
const MAP_SIZE = Vector2(16, 16)

var mouse_pos 
var selected_tile = null

var astar = AStarGrid2D.new()
var current_id_path: Array[Vector2i]
var path_positions = []

var player_moving = false

var road_tiles : Array[Vector2i] = [Vector2i(2,1),Vector2i(2,2),Vector2i(2,3),Vector2i(2,4),Vector2i(2,5),
Vector2i(2,6),Vector2i(2,7),Vector2i(2,8),Vector2i(2,9),Vector2i(2,10),Vector2i(2,11),Vector2i(2,12),
Vector2i(3,4),Vector2i(4,4),Vector2i(5,4),Vector2i(6,4),Vector2i(7,4),Vector2i(8,4),Vector2i(8,3),
Vector2i(3,12),Vector2i(4,12),Vector2i(5,12),Vector2i(5,11),Vector2i(5,10),Vector2i(5,9),Vector2i(6,9),
Vector2i(7,9),Vector2i(8,9),Vector2i(9,9),Vector2i(9,10),Vector2i(10,10),Vector2i(11,10),Vector2i(11,11),
Vector2i(11,12),Vector2i(11,13),Vector2i(11,14),Vector2i(12,14),Vector2i(13,14)
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	#odottaa että World on valmis ennen kuin jatkaa, jotta saa TileManagerin itselleen
	await get_parent().ready 
	generateTiles()
	astar_Setup()
	GlobalSignals.travel_btn_pressed.connect(move_player)

func astar_Setup(): 
	#
	astar.region = tilemap.get_used_rect()
	astar.cell_size = tilemap.tile_set.get_tile_size()
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.HEURISTIC_MANHATTAN
	astar.update()
	
#Setting AStar weights so that pathfinding prefers low cost tiles
	for tile in tileManager.world_tiles:
		var cost = tileManager.world_tiles[tile]._my_travel_cost
		astar.set_point_weight_scale(tile,cost)



func toggle_window(open : bool):
	visible = open

func generateTiles():
	
	var spawn = tilemap.local_to_map(Vector2i(0, 0))
	
	#Apumuuttujia
	var coords : Vector2i
	var tile : MapTile
	var loc_num : int = 0

	#Kaydaan maailma lapi
	for x in MAP_SIZE.x:
		for y in MAP_SIZE.y:
			
			#Tilemap koordinaatit joihin tiilet laitetaan
			#var coords = Vector2i(spawn.x - MAP_SIZE.x / 2 + x, spawn.y - MAP_SIZE.y / 2 + y)
			coords = Vector2i(spawn.x + x, spawn.y + y)
			
			#Luo karttatiili objectin ja lisaa sen dictionaryyn
			tile = MapTile.new(coords)

			tileManager.world_tiles[coords] = tile
			
			#Luodaan jokaiselle tiilelle muutama location
			loc_num = 15
			for l in range(loc_num):
				tileManager.give_random_location(tile)
	
	for v in road_tiles:
		var roadtiles : MapTile = tileManager.world_tiles[v]
		roadtiles._has_roads = true
		roadtiles._my_travel_cost /= 2


func get_mouse_tile_coords():

		mouse_pos = get_global_mouse_position()
		var tile_coords = tilemap.local_to_map(mouse_pos)
		return tile_coords


func movement_info_to_tile_window(tile):
	if !player_moving:
		current_id_path.clear()
		path_positions.clear()
	
	print("Signal from travel receaved"+ str(player.position) + str(tile._my_coords))
	#tilemap.to_local(player.global_position)
	var id_path = astar.get_id_path(
			tilemap.local_to_map(player.position),
			tile._my_coords
			).slice(1)
	print(id_path)
	if id_path.is_empty() == false:
		current_id_path = id_path
			
	#Muutetaan saadut pikseli koordinaatit niin että skaalattu tilemaps voi kauttaa niita
	var cell_position_local
	var cell_position_global
	for cell_coords in current_id_path:
		cell_position_local = tilemap.map_to_local(cell_coords)
		path_positions.append(cell_position_local)
	calculate_travel_days()




func calculate_travel_days():
	var travelTimeInDays : int = 0
	for v in current_id_path:
		var tile : MapTile = tileManager.world_tiles[v]
		travelTimeInDays += tile._my_travel_cost
	GlobalSignals.get_travel_days_to_window.emit(travelTimeInDays)
	


func move_player():
	player_moving = true


func _physics_process(delta):
	if player_moving:
		if current_id_path.is_empty():
			player_moving = false
			path_positions.clear()
			return

		var target_position = path_positions.front()

		#print("I am target_position: ", target_position)
		
		player.position = player.position.move_toward(target_position, 10)
		#print("I am global pos: ", global_position)
		if player.position == target_position:
			path_positions.pop_front()
			current_id_path.pop_front()
			print(path_positions)
			print(current_id_path)
