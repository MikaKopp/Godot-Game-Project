



class_name MapTile



var _my_coords : Vector2i = Vector2i(0, 0)
var _my_location_amount : int = 0
var _my_terrain : String = ""
var _has_roads : bool = false
var _my_travel_cost : int = 6

var _my_all_location_dic : Dictionary = {}
var _my_visible_location_dic : Dictionary = {}
var _my_explored_location_dic : Dictionary = {}
var _my_theme : String = "Neutral"

var _test_number : int = 0

func _init(coords = Vector2(0, 0)):
	_my_coords = coords

	_test_number = randi()
	



func _to_string():
	print("My coords = ",self.get("_my_coords"))
	print("My location ammount = ",self.get("_my_location_amount"))
	var x = self.get("_my_all_location_dic")
	print("My number of locations = ",x.size())
	var y = self.get("_my_visible_location_dic")
	print("My visible loc number = ",y.size())
	var z = self.get("_my_explored_location_dic")
	print("My number of explored loc = ",z.size())
	print("My theme = ",self.get("_my_theme"))
	
	print(self.get("_test_number"))



func set_my_coords(coords):
	_my_coords = coords



func set_my_location_amount():
	_my_location_amount = _my_all_location_dic.size()



func set_my_theme(theme):
	self._my_theme = theme



func set_my_all_location_dic(id, location):
	self._my_all_location_dic[id] = location
	self.set_my_location_amount()
	



func set_my_visible_location_dic(id, location):
	self._my_visible_location_dic[id] = location



func set_my_explored_location_dic(id, location):
	self._my_explored_location_dic[id] = location



func get_my_visible_location_dic():
	return _my_visible_location_dic
