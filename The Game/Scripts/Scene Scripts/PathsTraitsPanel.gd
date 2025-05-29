extends Panel

@onready var traitGridContainer : VBoxContainer = %TraitVBox


@onready var traitsByPathDict : Dictionary = {}

@onready var pathTraitBtn : PackedScene = preload("res://Scenes/Path_Trait_Btn.tscn")
@onready var realmGrid : PackedScene = preload("res://Scenes/Realm_Grid.tscn")
@onready var realmLbl : PackedScene = preload("res://Scenes/Realm_Lbl.tscn")









func display_trait_tree_components(method):
	if !traitsByPathDict.has(method.displayName):
		set_up_trait_tree_components(method)
	for grid in traitsByPathDict[method.displayName + "Grids"]:
		traitGridContainer.add_child(grid.myTitleLbl)
		traitGridContainer.add_child(grid)
		for x in grid.myPathTraitBtns.size():
			grid.add_child(grid.myPathTraitBtns[x])
			


#TODO Luo gridit ja labelit itsestään, kun ensin checkkaa kuinka monta tarvitaan pathiä varten
#Gridit toimivat niin, että jokaisella on oma muuttuja var realm : String = "Realm1" ja sitä verrataan funktiossa traitin omaan realmiin
#Kootaan kaikki gridit samaan dictionaryyn ja key on Realm, grid voi olla myös samassa dictionaryssä liitettynä realm keyhin
func set_up_trait_tree_components(method:CultivationMethod):
	print("Set up trait tree components active")
	if !traitsByPathDict.has(method.displayName):
		print("Inside !traitsByPathDict.has(method.displayName)")
		var traitsArray : Array[PathTraitBtn] = []
		var gridsArray : Array[RealmGrid] = []
		traitsByPathDict[method.displayName] = traitsArray
		for realm in method.myMajorRealms:
			var newGrid = create_new_realm_grid(realm)
			gridsArray.append(newGrid)
			print(realm)
		traitsByPathDict[method.displayName + "Grids"] = gridsArray
		print(traitsByPathDict[method.displayName + "Grids"])
		for methodTrait in method.methodTraits:
			var btn = create_new_path_trait_btn(methodTrait)
			link_button_to_grid(gridsArray,btn)
			traitsArray.append(btn)



func create_new_path_trait_btn(pathTrait:MethodTrait):
	var newBtn = pathTraitBtn.instantiate()
	newBtn.set_data(pathTrait)
	return newBtn

func create_new_realm_grid(realm:MajorRealm):
	var newGrid = realmGrid.instantiate()
	newGrid.myMajorRealm = realm
	newGrid.myTitleLbl = create_new_realm_label(realm.displayName)
	return newGrid

func create_new_realm_label(realmName:String):
	var newLbl = realmLbl.instantiate()
	newLbl.myMajorRealmName = realmName
	newLbl.set_my_text()
	return newLbl

func link_button_to_grid(gridArray:Array,btn:PathTraitBtn):
	for grid in gridArray:
		if btn.myTrait.unlockRealm == grid.myMajorRealm.displayName:
			grid.myPathTraitBtns.append(btn)
			return
	print("link_button_to_grid did not find any grid to add the button to")
	return



func purge_children_from_traits():
	for child in traitGridContainer.get_children():
		child.queue_free()
