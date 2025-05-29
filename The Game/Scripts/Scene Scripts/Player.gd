class_name Player
extends Node2D


#______Player stats modifiers___________

#Fundamentals stats
var lifeSpan : int = 65
var age : int = 16
var maxHP : int = 100
var maxEnergy : int = 10

#Ability scores
var vitality : int = 10
#Body stats sub category
var strength : int = 10
var endurance : int = 10
var agility : int = 10
var constitution : int = 10
#Mental stats sub category
var mind : int = 10
var intelligence : int = 10
var comprehension : int = 10
var spiritualSense : int = 10
var willpower : int = 10
var soul : int = 10
var perception: int = 10
 
#Social 
var charisma : int = 10
#Growth & Fate
var potential : int = 10
var luck : int = 10


#Currency
var crystals : int = 100
var coins : int = 100


#_________Cultivation variables_____________
var baseCultSpeed : int = 1
var currentCultSpeed : int = 1
var posCultMods : int = 0
var negCultMods : int = 0
var totalModifier : int = 0

var currentCultXp : int = 0

var cultivationMajorLevelInStr : String = "Mortal"
var cultivationMinorLevelInStr : String = "Non-Cultivating"
var cultivationMajorLevelInInt : int = 0
var cultivationMinorLevelInInt  : int = 0

var realmXpGoals : Array[int] = [
	100,
	101,102,103,104,105,106,107,108,109,
	1010,1020,1030,1040,1050,1060,1070,1080,1090,
	10100,10200,10300,10400,10500,10600,10700,10800,10900,
	101000,102000,103000,104000,105000,106000,107000,108000,109000,
	1010000,1020000,1030000,1040000,1050000,1060000,1070000,1080000,1090000,
	10100000,10200000,10300000,10400000,10500000,10600000,10700000,10800000,10900000,
	101000000,102000000,103000000,104000000,105000000,106000000,107000000,108000000,109000000,
	1010000000,1020000000,1030000000,1040000000,1050000000,1060000000,1070000000,1080000000,1090000000,
	10100000000,10200000000,10300000000,10400000000,10500000000,10600000000,10700000000,10800000000,10900000000
	]
var levelXpTarget : int = 69696
var realmXpGoalsPointer : int = 0

var majorRealmNames : Array[String] = [
	"Mortal",
	"Energy Kindling",
	"Foundation Establishing",
	"Order Creation",
	"Inner Core",
	"Soul Forming",
	"Ancient",
	"Ascension",
	"Immortal",
	"Transcended"
]
var minorRealmNames : Array[String] = [
	"Entrance",
	"Introductory",
	"Glimpse",
	"Low",
	"Gathering",
	"Intermediate",
	"High",
	"Late",
	"Peak",
	"Breakthrough"
]

#______________________________________________________________

@onready var character_screen: CharacterScreen = %CharacterScreen
@export var playerScreen: Control

@export var startingCultivationMethod : Array[CultivationMethod] = []
var mainMethods : Array[CultivationMethod] = []
var mobilityMethods : Array[CultivationMethod] = []
var weaponMethods : Array[CultivationMethod] = []
var meditationMethods : Array[CultivationMethod] = []
var allCultivationMethods : Dictionary = {
	"Main":mainMethods ,
	"Mobility":mobilityMethods,
	"Weapon":weaponMethods,
	"Meditation":meditationMethods
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setData()
	playerScreen.setData()
	
	
	GlobalSignals.on_give_player_ceffect.connect(on_give_player_ceffect)
	GlobalSignals.spend_time_cultivating.connect(cultivate_Xp_By_Time)
	

	

	
	#Testeihin materiaali, muutettu nyt niin että CultivationMethod scriptissä on Init functio joka pyöräyttää setData
	#niin ei tarvitse olla täällä
	#startingCultivationMethod = load("res://Resources/Cultivation Methods/Method Res/BasicManual.tres")
	#startingCultivationMethod.setData()



#Sets all the needed data to variables and labels etc, related to player info/datafields
func setData():
	levelXpTarget = realmXpGoals[0]
	
	#Laittaa jokaiselle CanvasLayerin lapselle itsensä pelaajaksi, jotta nämä voivat käyttää juttuja
	for child in get_node("CanvasLayer").get_children():
		child.player = self

#Makes sure that character screen label have the correct starting info
	character_screen.update_lifespanlbl(lifeSpan)
	character_screen.update_cultivation_xplbl(currentCultXp, levelXpTarget)
	character_screen.update_cultivation_stagelbl(cultivationMinorLevelInStr, cultivationMajorLevelInStr)
	
	
	process_starting_cultivation_methods()
	


#Lisää pelaajalle kultivaatio xp kun lisäykseen liittyy aikaelementti
func cultivate_Xp_By_Time(cultTime : int):
	print("Cultivating")
	var newXp = cultTime * currentCultSpeed
	cultivate_Xp_Gained(newXp)




#Lisää pelaajalla kertamäärän kultivaatio xp, negatiivinen luku parametrina poistaa kultivaatio xp
func cultivate_Xp_Gained(gainedXp : int):
	currentCultXp += gainedXp
	if currentCultXp == levelXpTarget:
		print("Cultivation level peak achieved")
		advanceMinorRealm()
	elif currentCultXp > levelXpTarget:
		currentCultXp = levelXpTarget
		print("Cultivation level peak achieved")
		advanceMinorRealm()
	else:
		print("Cultivation xp gained")
		character_screen.update_all()

func setStateReadyToBreakthrough():
	pass


func doBreakthrough(): 
	print("Breakthrough in progress")
	if cultivationMajorLevelInInt < 9:
		cultivationMinorLevelInInt = 0
		realmXpGoalsPointer += 1
		levelXpTarget = realmXpGoals[realmXpGoalsPointer]
		currentCultXp = 0
		cultivationMajorLevelInInt += 1
		cultivationMajorLevelInStr = majorRealmNames[cultivationMajorLevelInInt]
		cultivationMinorLevelInStr = minorRealmNames[cultivationMinorLevelInInt]
	else: print ("Peak of Transcended Achieved, Cannot Breakthrough more")
	
	#Updating Character screen information
	character_screen.update_all()
	
	print("Breakthrough achieved")
	
func advanceMinorRealm():
	if cultivationMinorLevelInInt == 9 or cultivationMajorLevelInInt == 0:
		currentCultXp = levelXpTarget
		setStateReadyToBreakthrough()
	else:
		cultivationMinorLevelInInt += 1
		cultivationMinorLevelInStr = minorRealmNames[cultivationMinorLevelInInt]
		realmXpGoalsPointer += 1
		levelXpTarget = realmXpGoals[realmXpGoalsPointer]
		currentCultXp = 0
	
	#Updating Character screen information
	character_screen.update_all()
	
	


func calc_Total_Modifier():
	totalModifier = posCultMods + negCultMods

func calc_cult_speed():
	currentCultSpeed = baseCultSpeed + totalModifier
	#TODO Tällä hetkellä cultivation menettäminen cultivoidessa ei ole mahdollista mutta se voidaan järjestää
	if currentCultSpeed < 0:
		currentCultSpeed = 0


#_________STATS ADD/MODIFY FUNCTIONS____________________________________

func add_to_age(addedTime : int):
	age += addedTime

	if age >= lifeSpan:
		print("Oh dead you died of old age")



func reduce_age(reducedTime : int):
	age -= reducedTime
	
	if age <= 3:
		print("Oh dear you became too young and died")



func add_lifespan(addedTime : int):
	lifeSpan += addedTime



func reduce_lifespan(reducedTime : int):
	lifeSpan -= reducedTime
	
	if lifeSpan <= age:
		print("Oh dead you died of old age")




#_______________________________________________________________________

#Item joka on consumable lähettää signaalin jotta sen efektit tulevat voimaan pelaajalle
func on_give_player_ceffect(effect : ConsumableEffect):
	
	if effect != null:
		var stat = effect.effectedStat
		var ammount = effect.effectValue
		print(stat)
		print(ammount)
		match stat:
			"CultivationXp":
				cultivate_Xp_Gained(ammount)
			2:
				print("Two are better than one!")
			"test":
				print("Oh snap! It's a string!")
	
	else: print("Effect seems to be null")



#This might now be useless code
func open_Player_Screen(screen:String):
	playerScreen.openScreen(screen)



#_________________Cultivation Method List Functions_________________________________________
#Makes sure that all starting methods are moved to allMethods
func process_starting_cultivation_methods():
	if !startingCultivationMethod.is_empty():
		for method in startingCultivationMethod:
			allCultivationMethods[method.myType].append(method)
		#allCultivationMethods.append(method)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
