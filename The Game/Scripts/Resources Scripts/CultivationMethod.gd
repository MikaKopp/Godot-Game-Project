

class_name CultivationMethod
extends  Resource


@export var displayName : String = "Unnamed"
@export var icon : Texture2D
@export var methodTraits : Array[MethodTrait]
@export_enum("Main","Mobility","Weapon", "Meditation") var myType : String = "Main"


var sampleData : Dictionary = {
	"MajorRealm1": {
		"Name" : "Realm 1",
		"MajorOrder" : 1,
		"MinorRealm1" : {
			"Name" : "Minor 1",
			"MinorOrder" : 1,
			"XpToLevel" : 1000
		},
		"MinorRealm2" : {
			"Name" : "Minor 2",
			"MinorOrder" : 2,
			"XpToLevel" : 1000
		},
		"MinorRealm3" : {
			"Name" : "Minor 3",
			"MinorOrder" : 3,
			"XpToLevel" : 1000
		},
		"MinorRealm4" : {
			"Name" : "Minor 3",
			"MinorOrder" : 3,
			"XpToLevel" : 1000
		}
	},
	"MajorRealm2": {
		"Name" : "Realm 2",
		"MajorOrder" : 2,
		"MinorRealm1" : {
			"Name" : "Minor 1",
			"MinorOrder" : 1,
			"XpToLevel" : 2000
		},
		"MinorRealm2" : {
			"Name" : "Minor 2",
			"MinorOrder" : 2,
			"XpToLevel" : 2000
		},
		"MinorRealm3" : {
			"Name" : "Minor 3",
			"MinorOrder" : 3,
			"XpToLevel" : 2000
		}
	},
	"MajorRealm3": {
				"Name" : "Realm 3",
		"MajorOrder" : 3,
		"MinorRealm1" : {
			"Name" : "Minor 1",
			"MinorOrder" : 1,
			"XpToLevel" : 3000
		},
		"MinorRealm2" : {
			"Name" : "Minor 2",
			"MinorOrder" : 2,
			"XpToLevel" : 3000
		},
		"MinorRealm3" : {
			"Name" : "Minor 3",
			"MinorOrder" : 3,
			"XpToLevel" : 3000
		}
	},
	"MajorRealm4": {
				"Name" : "Realm 4",
		"MajorOrder" : 4,
		"MinorRealm1" : {
			"Name" : "Minor 1",
			"MinorOrder" : 1,
			"XpToLevel" : 4000
		},
		"MinorRealm2" : {
			"Name" : "Minor 2",
			"MinorOrder" : 2,
			"XpToLevel" : 4000
		},
		"MinorRealm3" : {
			"Name" : "Minor 3",
			"MinorOrder" : 3,
			"XpToLevel" : 4000
		}
	}
} 

var majorRealmAmount : int = 0
var minorRealmAmount : int = 0
#I should considere naming this myMajorRealmsData or something to avoid confusion 
var myMajorRealms : Array[MajorRealm]
var myMajorRealmsData : Array[Dictionary]
var myMajorRealmsByName : Array[String]
var myMinorRealms : Array[Dictionary]

var myCurrentMajorRealm : Dictionary = {}
var myCurrentMinorRealm : Dictionary = {}
var myCurrentMajorPointer : int = 0
var myCurrentMinorPointer : int = 0
var currentMajorName : String = "Unnamed"
var currentMinorName : String = "Unnamed"
var currentXpGoal : int = 6969



#Toistaiseksi käyttämättömät, korvattu resursseilla tai muilla
#@export var myMajorStages : Array[MajorStage]
#
#var myMinorRealms : Array[MinorRealm]
#@export var cultivationRealms : Array[String] = []
#@export var cultivationRealmInfo : Dictionary = {}


func _init():
	setData()

#Sets the variables like majorStageAmount, that relie on export fields 
func setData():
	var dataSize = sampleData.size()
	var x = 1
	var tempDict = {}
	while x <= dataSize:
		myMajorRealmsData.append(sampleData.get("MajorRealm" + str(x)))
		var newMajorRealm = MajorRealm.new()
		newMajorRealm.displayName = "Realm " + str(x)
		myMajorRealms.append(newMajorRealm)
		x += 1
	
	var y = 0
	while y < myMajorRealmsData.size():
		tempDict = myMajorRealmsData[y]
		
		var j = 1
		while true:
			if tempDict.has("MinorRealm" + str(j)):
				myMinorRealms.append(tempDict.get("MinorRealm" + str(j)))
				j += 1
			else: break
		y += 1
	majorRealmAmount = myMajorRealmsData.size()
	minorRealmAmount = myMajorRealmsData.size()
	
	set_realms_by_name()

func set_realms_by_name():
	for realm in myMajorRealmsData:
		myMajorRealmsByName.append(realm["Name"])
	#for realm in myMajorRealmsData:
		#for dict in realm:
			#myMajorRealmsByName.append(dict["Name"])




func startCultivationMethod():
	myCurrentMajorRealm = myMajorRealmsData[0]
	myCurrentMinorRealm = myMinorRealms[0]
#var myCurrentMinorRealm : Dictionary = {}
#var myCurrentMajorPointer : int = 0
#var myCurrentMinorPointer : int = 0
#var currentMajorName : String = "Unnamed"
#var currentMinorName : String = "Unnamed"
#var currentXpGoal : int = 6969
	
	
	pass







func testPrint():
	print(myMajorRealmsData)





#Qi Realm: 
	#Low : 10000xp
	#Medium : 25000xp
	#Peak : 40000xp
#Foundation:
	#Low : 100000xp
	#Medium : 250000xp
	#Peak : 400000xp
#Golden Core:
	#Low : 100000xp
	#Medium : 250000xp
	#Peak : 400000xp
	
