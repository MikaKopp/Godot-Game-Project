extends Node




var stats: Stats = Stats.new()

func _ready():
	load_stats()

func modify_stat(stat_name: String, value: int):
	if has_property(stat_name):
		stats.set(stat_name, stats.get(stat_name) + value)
		print("%s changed to %d" % [stat_name, stats.get(stat_name)])
		#save_stats()
	else:
		print("Stat '%s' does not exist!" % stat_name)



func has_property(stat_name) -> bool:
	for prop in stats.get_property_list():
		if prop.name == stat_name:
			return true
	return false



func item_equipped(stat_modifiers:Dictionary):
	for stat in stat_modifiers:
		modify_stat(stat,stat_modifiers[stat])
	

func item_unequipped(stat_modifiers: Dictionary):
	for stat in stat_modifiers:
		var modifier = stat_modifiers[stat]
		if modifier is int or modifier is float:  # Ensure it's a number
			modify_stat(stat, -modifier)  # Negate value 
		else:
			print("Warning: Trying to negate a non-numeric stat:", stat, "Value:", modifier)



func save_stats():
	var file = FileAccess.open("user://player_stats.save", FileAccess.WRITE)
	file.store_var(stats)
	file.close()
	print("Game saved!")

func load_stats():
	if FileAccess.file_exists("user://player_stats.save"):
		var file = FileAccess.open("user://player_stats.save", FileAccess.READ)
		stats = file.get_var()
		file.close()
		print("Game loaded!")
	else:
		print("No save file found. Using default stats.")
